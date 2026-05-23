require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:service) { double 'SendDigest'}

  before do 
    allow(SendDigest).to receive(:new).and_return(service)
  end

  it 'call SendDigest#sent_digest' do
    expect(service).to receive(:send_digest)
    DailyDigestJob.perform_now
  end
end
