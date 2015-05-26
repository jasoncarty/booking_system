class Event < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar

  # model associations
  belongs_to :calendar, dependent: :destroy
  has_many :event_attendees
  has_many :users, through: :event_attendees

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :url, presence: true

  before_save :prefix_url

  def prefix_url
    self.url.prepend '/e/' if self.new_record?
  end

  def add_new_user user_ids
    event = self
    user_ids.each do |user_id|
      EventAttendee.create(event_id: event.id, user_id: user_id)
    end
  end


end