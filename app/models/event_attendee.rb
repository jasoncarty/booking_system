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

class EventAttendee < ApplicationRecord

  belongs_to :attendee_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :reserve_user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :user
  belongs_to :event

  # Model validations
  #validates :user_id, presence: true, uniqueness: { scope: :event_id }

  # Scopes
  default_scope -> { order(id: :asc ) }
  scope :reserves, -> { where reserve: true }
  scope :attendees, -> { where reserve: false }

end
