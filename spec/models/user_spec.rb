require 'spec_helper'

describe User do
  let(:user) { FactoryBot.create(:user) }

  describe 'valiadte_password?' do
    it 'returns truthy' do
      user.validate_password = nil
      user.validate_password?.should == true
    end

    it 'return falsey' do
      user.validate_password = true
      user.validate_password?.should == nil
    end

    it 'return falsey' do
      user.validate_password = false
      user.validate_password?.should == nil
    end
  end

  describe 'confirm' do
    it 'returns nil' do
      user.confirmed = true
      user.validate_password = false
      user.save!
      user.reload.confirm.should == nil
    end

    it 'updates user and sets confirmed and confirmed_at' do
      user.confirmed_at = nil
      user.validate_password = false
      user.save!
      user.confirm
      user.reload
      user.confirmed_at.should_not == nil
      user.confirmed.should == true
    end
  end

  describe 'add_verify_token' do
    it 'adds a verification token' do
      user.add_verify_token
      user.verification_token.should_not == nil
      user.verification_sent_at.should_not == nil
    end
  end

  describe 'add_password_token' do
    it 'adds a password token' do
      user.add_password_token
      user.password_reset_token.should_not == nil
      user.password_reset_token_sent_at.should_not == nil
    end
  end

  describe 'generate_token' do
    it 'returns a token' do
      generate_token.class.should == String
    end
  end

end