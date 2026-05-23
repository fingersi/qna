class DailyDigestJob < ApplicationJob

  def perform
    SendDigest.new.send_digest
  end
end
