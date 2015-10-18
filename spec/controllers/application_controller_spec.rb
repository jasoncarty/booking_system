require 'spec_helper'

describe ApplicationController do

  let (:site_setting) { FactoryGirl.create(:site_setting) }
  let (:user) { FactoryGirl.create(:user) }

  describe '#default_maximum_event_attendees' do
    it 'returns the default_maximum_event_attendees' do
      site_setting
      :default_maximum_event_attendees
      controller.default_maximum_event_attendees.should == site_setting.maximum_event_attendees
    end
  end

  describe '#sitename' do
    it 'returns the settings sitename' do
      site_setting
      :sitename
      controller.sitename.should == site_setting.site_name
    end

    it 'returns string Booking System if setting sitename is not initialized' do
      :sitename
      controller.sitename.should == "Booking System"
    end
  end

  describe '#current_user' do
    it 'returns the current user if someone is logged in' do
      login_user(user)
      :current_user
      controller.current_user.should == user
    end

    it 'returns nil if no-one is logged in' do
      :current_user
      controller.current_user.should == nil
    end
  end

  describe '#admin?' do
    it 'returns true if current_user is admin' do
      login_user(user)
      :current_user
      controller.admin?.should == false
    end
  end
end

