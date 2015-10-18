FactoryGirl.define do
  factory :site_setting, class: SiteSetting do
    site_name 'The Awesome app'
    maximum_event_attendees 8
  end
end