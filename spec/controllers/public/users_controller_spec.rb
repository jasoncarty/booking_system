require "spec_helper"

describe Public::UsersController do

  let(:user) { FactoryBot.create(:user) }
  let(:non_confirmed_user) { FactoryBot.create(:non_confirmed_user) }

  describe 'GET #edit' do
    it 'does not show the user edit page if user is not logged in' do
      get :edit, params: { id:  user }
      response.should redirect_to(login_path)
    end

    it 'shows the user edit page to logged in users' do
      login_user(user)
      get :edit, params: { id: user }
      response.should be_successful
    end
  end

  describe 'POST #update' do
    it 'allows logged in users to update the account details' do
      login_user(user)
      post :update, params: { id: user, user: {name: 'Jason Test'}}
      user.reload.name.should == 'Jason Test'
    end

    it 'does not allow non logged in users to update' do
      post :update, params: {id: user, user: {name: 'Jason Test'}}
      response.should redirect_to(login_path)
    end

    it 'renders the edit template if user is not valid' do
      login_user(user)
      post :update, params: {id: user, user: {name: 'Jason Test', email: ''}}
      response.should render_template(:edit)
    end
  end

  describe 'GET #verify' do
    it 'sets the session[:user_id] to nil' do
      get :verify, params: {token: non_confirmed_user.verification_token}
      request.session[:user_id].should == nil
    end
  end

  describe "POST #verification" do

    it 'renders verify template if verify token is invalid' do
      post :verification, params: {
        verification_token: '098327405nc8nshflkshdfp9834',
        user: {
          email: non_confirmed_user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
      response.should render_template(:verify)
    end

    it 'redirects back if email is not filled in' do
      post :verification, params: {
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: '',
          password: 'password',
          password_confirmation: 'password'
        }
      }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects back if password is not filled in' do
      post :verification, params: {
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password_confirmation: 'password'
        }
      }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects back if password confirmation is not filled in' do
      post :verification, params: {
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password: 'password',
          password_confirmation: ''
        }
      }
      non_confirmed_user.reload.confirmed_at.should == nil
    end

    it 'redirects to root if everything is filled in and correct' do
      post :verification, params: {
        verification_token: non_confirmed_user.verification_token,
        user: {
          email: non_confirmed_user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
      response.should redirect_to(root_path)
    end

    it 'redirects back if user.confirmed_at is not nil' do
      post :verification, params: {
        verification_token: user.verification_token,
        user: {
          email: user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
      response.should redirect_to(root_path)
      user.reload.confirmed.should == true
      flash[:notice].should == 'Your account has already been verified'
    end

    it 'sets user.confirmed to true' do
      post :verification, params: {
        verification_token: user.verification_token,
        user: {
          email: user.email,
          password: 'password',
          password_confirmation: 'password'
        }
      }
      user.reload.confirmed.should == true
    end
  end

end
