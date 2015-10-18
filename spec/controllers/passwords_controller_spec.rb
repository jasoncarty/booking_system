require "spec_helper"

describe PasswordsController do

let(:user) { FactoryGirl.create(:user) }
let(:non_confirmed_user) { FactoryGirl.create(:non_confirmed_user) }

  describe 'POST #create' do
    it 'sends new password email to user' do
      @request.env['HTTP_REFERER'] = password_create_url
      user
      post :create,  email: user.email
      email = ActionMailer::Base.deliveries.last
      email.subject.should include 'Password reset'
      email.to.should == ["jason@jcartydesign.com"]
    end

    it 'creates a password reset token for user' do
      @request.env['HTTP_REFERER'] = password_create_url
      user
      post :create,  email: user.email
      user.reload.password_reset_token.should_not == nil
    end

    it 'redirects to sign in and does not create a password reset token if user not found' do
      user
      @request.env['HTTP_REFERER'] = password_create_url
      post :create,  email: 'someone@email.com'
      user.reload.password_reset_token.should == nil
      response.should redirect_to(:back)
    end

    it 'redirects to login path if account has not been confirmed' do
      non_confirmed_user
      @request.env['HTTP_REFERER'] = password_create_url
      post :create, email: non_confirmed_user.email
      response.should redirect_to(login_path)
    end

  end

  describe 'POST #update' do
    it 'redirects to login page if all went well' do
      user.password_reset_token = generate_token
      user.save
      @request.env['HTTP_REFERER'] = password_reset_url(user: user.id, password_reset_token: user.password_reset_token)
      post :update,
        password: 'password',
        password_confirmation: 'password',
        password_reset_token: user.password_reset_token
      response.should redirect_to(:back)
    end

    it 'redirects to login page if the reset token is not right' do
      user.password_reset_token = generate_token
      user.save
      @request.env['HTTP_REFERER'] = password_reset_url(user: user.id, password_reset_token: user.password_reset_token)
      post :update,
        password: 'password',
        password_confirmation: 'password',
        password_reset_token: generate_token
      response.should redirect_to(login_path)
    end

    it 'redirects back if the password does not match the password confirmation' do
      user.password_reset_token = generate_token
      user.save
      @request.env['HTTP_REFERER'] = password_reset_url(user: user.id, password_reset_token: user.password_reset_token)
      post :update,
        password: 'password',
        password_confirmation: 'password1',
        password_reset_token: user.password_reset_token
      response.should redirect_to(:back)
    end
  end
end