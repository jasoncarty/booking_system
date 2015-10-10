# == Schema Information
#
# Table name: events
#
#  id                      :integer          not null, primary key
#  name                    :string
#  description             :text
#  url                     :string
#  starts_at               :datetime
#  ends_at                 :datetime
#  title                   :string
#  preview                 :string
#  calendar_id             :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  maximum_event_attendees :integer          default(0)
#

class Event < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar

  # model associations
  belongs_to :calendar, dependent: :destroy
  has_many :event_attendees

  has_many :reserves, -> { reserves }, class_name: 'EventAttendee'
  has_many :attendees, -> { attendees }, class_name: 'EventAttendee'


  has_many :users, through: :event_attendees

  validates :name, presence: true
  validates :starts_at, presence: true


  def remove_attendees
    self.event_attendees.each { |e| e.destroy }
  end

  # Save attendees to event
  # attendees = params[:attendees] => {attendees: [], reserves: []}
  def save_attendees attendees
    users = []
    if attendees[:attendees].present?
      users << add_attendees_to_array(attendees[:attendees], false)
    end
    if attendees[:reserves].present?
      users << add_attendees_to_array(attendees[:reserves], true)
    end
    if users.size > 0
      self.event_attendees.create(users)
      self.save
    end
  end

  def add_user user
    max = self.maximum_event_attendees
    if self.event_attendees.size >= max
      self.event_attendees.create(user_id: user.id, event_id: self.id, reserve: true)
    else
      self.event_attendees.create(user_id: user.id, event_id: self.id, reserve: false)
    end
    self.save_users
  end

  def remove_user user
    max = self.maximum_event_attendees
    attendee = self.event_attendees.where(user_id: user.id).first

    if !attendee.reserve and self.reserves.size > 0
      self.rearrange_users
    end
    attendee.destroy
    self.save_users
  end

  def save_users
    if self.save
      self.reload.to_json({:include => { :reserves => { :include => :user }, :attendees => { :include => :user } }})

    else
      self.errors.messages.to_json
    end
  end

  def rearrange_users
    self.reserves.last.update_attribute(:reserve, false)
  end

  def current_user_attending current_user
    EventAttendee.where(event_id: self.id, user_id: current_user.id).first
  end

  def add_attendees_to_array attendees, reserve
    users = []
    attendees.each do |user_id|
      user = { event_id: self.id, user_id: user_id, reserve: reserve }
      users << user
    end
    users
  end

end
