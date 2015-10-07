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
  has_many :event_attendees, dependent: :destroy
  has_many :users, through: :event_attendees

  validates :name, presence: true
  validates :starts_at, presence: true

  # Save attendees to event
  # attendees = params[:attendees] => {attendees: [], reserves: []}
  def remove_attendees
    self.event_attendees.each { |e| e.destroy }
  end

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

  def current_user_playing current_user
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
