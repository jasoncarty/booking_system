require 'spec_helper'

describe Event do
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:event) { FactoryBot.create(:event) }

  it 'adds a user' do
    count = event.event_attendees.size
    event.add_user(user)
    event.reload.event_attendees.size.should == count + 1
  end

  it 'adds a user and sets reserve to true' do
    new_user = User.create(name: 'Test Testsson', email: 'test@testsson.com', password: 'password', confirmed_at: Time.now )
    event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
    event.maximum_event_attendees = 1
    event.save
    event.add_user(new_user)
    event.event_attendees.where(user_id: new_user.id, event_id: event.id).first.reserve.should == true
  end

  it 'removes a user' do
    new_user = User.create(name: 'Test Testsson', email: 'test@testsson.com', password: 'password', confirmed_at: Time.now )
    event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
    event.event_attendees.create(user_id: new_user.id, event_id: event.id, reserve: true)
    event.save
    count = event.reload.event_attendees.size
    event.remove_user user
    event.reload.event_attendees.size.should == count - 1
    event.event_attendees.where(event_id: event.id, user_id: new_user.id).first.reserve.should == false
  end

  it 'does not throw error when removing a user' do
    event.remove_user(user).should == nil
  end

  it 'sets the first reserve to false if a no reserve is removed' do
    new_user = User.create(name: 'Test Testsson', email: 'test@testsson.com', password: 'password', confirmed_at: Time.now )
    event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
    event.event_attendees.create(user_id: new_user.id, event_id: event.id, reserve: true)
    event.save
    event.rearrange_users
    event.event_attendees.where(event_id: event.id, user_id: new_user.id).first.reserve.should == false
  end

  it 'saves the event and returns json object including attendees and users' do
    new_user = User.create(name: 'Test Testsson', email: 'test@testsson.com', password: 'password', confirmed_at: Time.now )
    event.event_attendees.create(user_id: user.id, event_id: event.id, reserve: false)
    event.event_attendees.create(user_id: new_user.id, event_id: event.id, reserve: true)
    event.save
    event.save_users.should == event.reload.to_json(
        {:include => { :reserves => { :include => :user }, :attendees => { :include => :user } }}
      )
  end

end
