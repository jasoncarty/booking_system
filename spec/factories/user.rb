FactoryBot.define do
	factory :user do
		name {'Jason Carty'}
		password {'password'}
		email {'jason@jcartydesign.com'}
		role {'user'}
		confirmed_at {'2013-01-01'}
	end
end
