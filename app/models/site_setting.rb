# == Schema Information
#
# Table name: site_settings
#
#  id                      :integer          not null, primary key
#  site_name               :string
#  maximum_event_attendees :integer          default(0)
#  created_at              :datetime
#  updated_at              :datetime
#

class SiteSetting < ActiveRecord::Base


end
