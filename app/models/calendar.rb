class Calendar < ActiveRecord::Base

  #model associations
  has_many :events
end