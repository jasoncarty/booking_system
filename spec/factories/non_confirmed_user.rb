FactoryGirl.define do
  factory :non_confirmed_user, class: User do
    name 'Jason Carty'
    password 'password'
    email 'jason@jcartydesign.com'
    admin false
  end
end