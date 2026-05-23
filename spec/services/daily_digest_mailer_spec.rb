require "rails_helper"

RSpec.describe SendDigest, type: :mailer do
  let!(:users) { create_list(:user, 3) }
  
  it 'sends digest letter to user' do
    users.each { |user| expect(DailyDigestMailer).to receive(:digest).with(user).and_call_original }
    subject.send_digest
  end

end
