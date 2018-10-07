FactoryBot.define do
  factory :event, class: Event do
    name {'Test event'}
    starts_at {'2015-11-01 10:00'}
    description {'Test event desciption'}
    maximum_event_attendees {6}
  end
end

