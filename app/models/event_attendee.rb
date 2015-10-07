# == Schema Information
#
# Table name: event_attendees
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  reserve    :boolean          default(FALSE)
#

class EventAttendee < ActiveRecord::Base

  belongs_to :user
  belongs_to :event

  # Model validations
  validates :user_id, presence: true, uniqueness: { scope: :event_id }

end
