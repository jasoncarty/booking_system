require 'spec_helper'

describe ApplicationHelper do
  let(:user) { FactoryGirl.create(:user) }

  describe '#avatar_url' do
    it 'returns the gravatar url of the users email' do
      user
      helper.avatar_url(user).should == "http://gravatar.com/avatar/cc5bf4b0a112d21214f50aa502dc247b.png?s=48&d=wavatar"
    end
  end


  describe '#active_link?' do
    it 'returns string active if the current page url matches the url' do
      allow(helper.request).to receive(:original_url).and_return('http://localhost/admin/events')
      helper.active_link?('http://localhost/admin/events').should == 'active'
    end
  end

end