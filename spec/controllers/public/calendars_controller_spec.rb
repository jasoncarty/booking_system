require 'spec_helper'

describe Public::CalendarsController do

  let(:user) { FactoryBot.create(:user) }

  describe 'GET #my_calendar' do
    it 'does not show the user edit page if user is not logged in' do
      get :my_calendar
      response.should redirect_to(login_path)
    end

    it 'shows the user edit page to logged in users' do
      login_user(user)
      get :my_calendar
      response.should be_successful
    end
  end

end
