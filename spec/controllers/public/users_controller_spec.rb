require "spec_helper"

describe Public::UsersController do

  let(:user) { FactoryGirl.create(:user) }
  let(:non_confirmed_user) { FactoryGirl.create(:non_confirmed_user) }

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

  describe "POST #verification" do

    it 'redirects back if email is not filled in' do
      post :verification,
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: '',
          password: 'password',
          password_confirmation: 'password'
        }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects back if password is not filled in' do
      post :verification,
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password_confirmation: 'password'
        }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects back if password confirmation is not filled in' do
      post :verification,
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password: 'password',
          password_confirmation: ''
        }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects to root if everything is filled in and correct' do
      post :verification,
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      response.should redirect_to(root_path)
    end
  end

end
