require 'spec_helper'

describe Admin::EventsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "GET #index" do
    it "redirects to login if user not logged in" do
      get :index
      response.should redirect_to(login_path)
    end

    it "Does not let logged in users view the page" do
      login_user(user)
      get :index
      response.status.should be(302)
      response.should redirect_to(root_path)
    end

    it "lets logged in admins view the page" do
      login_user(admin)
      get :index
      response.status.should be(200)
    end
  end

end