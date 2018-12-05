require "spec_helper"

describe Admin::UsersController do

  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    it 'redirect non logged in users to log in' do
      get :index
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      get :index
      response.should redirect_to(:root)
    end

    it 'admin gets to see the user index page' do
      login_user(admin)
      get :index
      response.should be_successful
    end
  end

  describe 'GET #new' do
    it 'redirects non logged in users to log in' do
      get :new
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      get :new
      response.should redirect_to(:root)
    end

    it 'admin gets to see the new user page' do
      login_user(admin)
      get :new
      response.should be_successful
    end
  end

  describe 'POST #create' do
    it 'redirects non logged in users to log in' do
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          email: 'test@test.com',
          admin: false
        }
      }
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          email: 'test@test.com',
          admin: false
        }
      }
      response.should redirect_to(:root)
    end

    it 'admin can create a new user' do
      login_user(admin)
      count = User.all.count
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          email: 'test@test.com',
          admin: false
        }
      }
      response.should redirect_to(admin_users_url)
      User.all.reload.count.should == count + 1
    end

    it 'saves a confirmation token to the user' do
      login_user(admin)
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          email: 'test@test.com',
          admin: false
        }
      }
      User.last.name.should == 'Test Testsson'
      User.last.verification_token.should_not be nil
    end

    it 'sends a confirmation email to user after creation' do
      login_user(admin)
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          email: 'test@test.com',
          admin: false
        }
      }
      email = ActionMailer::Base.deliveries.last
      email.subject.should include 'Welcome to the'
      email.to.should == ['test@test.com']
    end

    it 'renders new template if user not valid' do
      login_user(admin)
      post :create,
      params: {
        user: {
          name: 'Test Testsson',
          admin: false
        }
      }
      response.should render_template(:new)
    end
  end

  describe 'GET #resend_confirmation' do
    it 'should send a confirmation email' do
      login_user(admin)
      get :resend_confirmation,
      params: {id: user.id}
      email = ActionMailer::Base.deliveries.last
      email.subject.should include 'Welcome to the'
      email.to.should == [user.email]
    end
  end

  describe 'GET #edit' do
    it 'redirects non logged in users to log in' do
      get :edit, params: {id: user}
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      get :edit, params: {id: user}
      response.should redirect_to(:root)
    end

    it 'admin gets to see the edit user page' do
      login_user(admin)
      get :edit, params: {id: user}
      response.should be_successful
    end
  end

  describe 'POST #update' do
    it 'redirects non logged in users to log in' do
      post :update,
      params: {
        id: user,
        user: {
          name: 'Test Johnsson'
        }
      }
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      post :update,
      params: {
        id: user,
        user: {
          name: 'Test Johnsson'
        }
      }
      response.should redirect_to(:root)
    end

    it 'admin can update user' do
      login_user(admin)
      post :update,
      params: {
        id: user,
        user: {
          name: 'Test Johnsson'
        }
      }
      response.should redirect_to(admin_users_url)
      user.reload.name.should == 'Test Johnsson'
    end

    it 'renders new template if user not valid' do
      login_user(admin)
      post :update,
      params: {
        id: user,
        user: {
          name: 'Test Testsson',
          email: '',
          admin: false
        }
      }
      response.should render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects non logged in users to log in' do
      delete :destroy, xhr: true,
      params: {id: user}
      response.should redirect_to(login_path)
    end

    it 'redirects non admin to public root' do
      login_user(user)
      delete :destroy, xhr: true,
      params: {id: user}
      response.should redirect_to(:root)
    end

    it 'admin gets can delete a user' do
      login_user(admin)
      user
      count = User.all.count
      delete :destroy, xhr: true,
      params: {id: user}
      User.all.reload.count.should == count - 1
    end
  end


end
