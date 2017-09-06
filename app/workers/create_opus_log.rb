class CreateOpusLog
  include Sidekiq::Worker

  def perform(opus_id, user_id)
    OpusLog.create(user_id: user_id, opus_id: opus_id)
  end
end