require "spec_helper"

describe Public::UsersController do

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #edit' do
    it 'does not show the user edit page if user is not logged in' do
      get :edit, id: user
      response.should redirect_to(login_path)
    end

    it 'shows the user edit page to logged in users' do
      login_user(user)
      get :edit, id: user
      response.should be_success
    end
  end

  describe 'POST #update' do
    it 'allows logged in users to update the account details' do
      login_user(user)
      post :update, id: user, user: {name: 'Jason Test'}
      user.reload.name.should == 'Jason Test'
    end

    it 'does not allow non logged in users to update' do
      post :update, id: user, user: {name: 'Jason Test'}
      response.should redirect_to(login_path)
    end
  end
end
