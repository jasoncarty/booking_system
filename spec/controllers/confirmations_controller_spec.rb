require 'spec_helper'

describe ConfirmationsController do

  let(:non_confirmed_user) { FactoryGirl.create(:non_confirmed_user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "POST #create" do

    it 'sends a confirmation email to new user' do
      post :create, email: non_confirmed_user.email
      email = ActionMailer::Base.deliveries.last
      email.subject.should include 'Welcome to the'
      email.to.should == ["jason@email.com"]
    end

    it 'redirects to root if account is already confirmed' do
      post :create, email: admin.email
      flash[:notice].should be_present
      flash[:notice].should == "Your account has already been confirmed!"
    end
  end

  describe "GET #new" do
    it 'lets the non confirmed user confirm account' do
      non_confirmed_user.verification_sent_at = Time.now - 9.days
      non_confirmed_user.save
      get :new, user: non_confirmed_user
      response.should be_success
    end

  end
end