# == Schema Information
#
# Table name: calendars
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Calendar < ApplicationRecord

  #model associations
  has_many :events
end
