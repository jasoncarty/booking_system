require 'spec_helper'

describe Admin::SiteSettingsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let (:site_setting) { FactoryGirl.create(:site_setting) }

  describe 'GET #edit' do
    it 'redirects to login if user is not logged in' do
      get :edit
      response.should redirect_to(login_path)
    end

    it 'redirects to root if logged in user is not admin' do
      login_user(user)
      get :edit
      response.should redirect_to(root_path)
    end

    it 'allows admins to view the page' do
      login_user(admin)
      get :edit
      response.status.should be(200)
    end
  end

  describe '#POST update' do
    it 'redirects to login if user is not logged in' do
      post :update, site_setting: {
        site_name: 'Test site',
        maximum_event_attendees: 8
      }
      response.should redirect_to(login_path)
    end

    it 'redirects to root if logged in user is not admin' do
      login_user(user)
      post :update, site_setting: {
        site_name: 'Test site',
        maximum_event_attendees: 8
      }
      response.should redirect_to(root_path)
    end

    it 'allows admins to view the page' do
      login_user(admin)
      post :update, site_setting: {
        site_name: 'Test site',
        maximum_event_attendees: 8
      }
      response.should redirect_to(admin_events_path)
    end

    it 'renders edit template if something is wrong' do
      login_user(admin)
      post :update, site_setting: {
        site_name: 'Test site',
        maximum_event_attendees: 'eight'
      }
      response.should render_template(:edit)
    end
  end

end