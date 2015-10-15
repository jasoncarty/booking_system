require 'spec_helper'

describe Admin::EventsController do

  describe "GET #index" do
    it "redirects to login if user not logged in" do
      get :index
      response.should redirect_to(login_path)
    end
  end

end