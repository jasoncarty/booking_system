FactoryBot.define do
  factory :non_confirmed_user, class: User do
    name {'Jason Carty'}
    password {'password'}
    email {'jason@email.com'}
    role {'user'}
    verification_token { generate_token }
  end
end
