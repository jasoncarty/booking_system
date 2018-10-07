require 'spec_helper'

describe ConfirmationsController do

  let(:non_confirmed_user) { FactoryBot.create(:non_confirmed_user) }
  let(:admin) { FactoryBot.create(:admin) }

  describe "POST #create" do

    it 'sends a confirmation email to new user' do
      post :create, params: {email: non_confirmed_user.email}
      email = ActionMailer::Base.deliveries.last
      email.subject.should include 'Welcome to the'
      email.to.should == ["jason@email.com"]
    end

    it 'saves a confirmation token to the user' do
      verification_token = non_confirmed_user.verification_token
      post :create, params: {email: non_confirmed_user.email}
      non_confirmed_user.reload.verification_token.should_not == verification_token
    end

    it 'redirects to confirmation_new_path if account is already confirmed' do
      post :create, params: {email: admin.email}
      flash[:notice].should be_present
      flash[:notice].should == "Your account has already been confirmed!"
      response.should redirect_to(confirmation_new_path)
    end

    it 'redirects to confirmation_new_path if email not found' do
      post :create, params: {email: 'unknown@email.com'}
      flash[:alert].should == "Email not found in system"
      response.should redirect_to(confirmation_new_path)
    end
  end

  describe "GET #new" do
    it 'lets the non confirmed user confirm account' do
      non_confirmed_user.verification_sent_at = Time.now - 9.days
      non_confirmed_user.save
      get :new, params: {user: non_confirmed_user}
      response.should be_successful
    end
  end
end
