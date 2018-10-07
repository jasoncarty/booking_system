require "spec_helper"

describe SessionsController do

  let(:user) { FactoryBot.create(:user) }

  describe '#POST create' do
    it 'does not create new session if password is invalid' do
      user
      post :create, params: {email: user.email, password: 'something'}
      response.should redirect_to(login_path)
    end

    it 'does not create new session if email is invalid' do
      user
      post :create, params: {email: 'test@test.com', password: user.password}
      response.should redirect_to(login_path)
    end

    it 'creates new session if password and email is valid' do
      user
      post :create, params: {email: user.email, password: user.password}
      session[:user_id].should == user.id
      response.should redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'allows logged in users to log out' do
      login_user(user)
      delete :destroy, params: {id: user}
      response.should redirect_to(login_path)
    end
  end

end
