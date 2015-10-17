# == Schema Information
#
# Table name: users
#
#  id                           :integer          not null, primary key
#  name                         :string
#  email                        :string
#  password_digest              :string
#  confirmed                    :boolean
#  confirmed_at                 :datetime
#  verification_token           :string
#  verification_sent_at         :datetime
#  password_reset_token         :string
#  password_reset_token_sent_at :datetime
#  role                         :string           default("user")
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class User < ActiveRecord::Base

  attr_accessor :validate_password

  # model associations
  has_many :event_attendees
  has_many :events, through: :event_attendees, dependent: :destroy

  # Initiate Bcrypt secure password
  has_secure_password validations: false

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :verification_token, :password_reset_token, uniqueness: true, allow_blank: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, presence: true, length: {minimum: 6}, if: :validate_password?
  validates :password, confirmation: true, on: :update, if: :validate_password?

  # Model scopes
  scope :not_attending, -> (attendees) { where("users.id NOT IN (#{attendees})") }

  # Callbacks
  before_create :add_verify_token

  def validate_password?
    if validate_password.nil?
      return true
    end
  end

  def add_verify_token
    self.verification_token = generate_token
    self.verification_sent_at = Time.now
  end

  def add_password_token
    self.password_reset_token = generate_token
    self.password_reset_token_sent_at = Time.now
  end

  def generate_token
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end


end
