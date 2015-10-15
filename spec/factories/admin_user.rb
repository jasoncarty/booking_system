FactoryGirl.define do
	factory :admin, class: User do
		name 'Jason Admin'
		email 'jason@admin.com'
		password 'password'
		role 'admin'
		confirmed_at '2013-01-01'
	end
end