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

class Event < ApplicationRecord
  extend SimpleCalendar
  has_calendar

  # model associations
  belongs_to :calendar, dependent: :destroy
  has_many :event_attendees

  has_many :reserves, -> { reserves }, class_name: 'EventAttendee'
  has_many :attendees, -> { attendees }, class_name: 'EventAttendee'

  has_many :reserve_users, through: :reserves, class_name: 'User'
  has_many :attendee_users, through: :attendees, class_name: 'User'

  accepts_nested_attributes_for :reserve_users
  accepts_nested_attributes_for :attendee_users

  has_many :users, through: :event_attendees

  validates :name, presence: true
  validates :starts_at, presence: true

  def add_user user
    max = self.maximum_event_attendees
    if self.event_attendees.size >= max
      self.event_attendees.create(user_id: user.id, event_id: self.id, reserve: true)
    else
      self.event_attendees.create(user_id: user.id, event_id: self.id, reserve: false)
    end
    self.save_users
    self.event_attendees.as_json(:include => :user)
  end

  def remove_user user
    max = self.maximum_event_attendees
    attendee = self.event_attendees.where(user_id: user.id).first

    if !attendee.reserve and self.reserves.size > 0
      self.rearrange_users
    end
    attendee.destroy
    self.save_users
    self.event_attendees.as_json(:include => :user)
  end

  def rearrange_users
    self.reserves.order(id: :asc).first.update_attribute(:reserve, false)
  end

  def save_users
    if self.save
      self.reload.to_json({:include => { :reserves => { :include => :user }, :attendees => { :include => :user } }})
    else
      self.errors.messages.to_json
    end
  end

end
