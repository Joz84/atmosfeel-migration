class OpusLogger
  def self.log(opus_id, user_id)
    new.log(opus_id, user_id)
  end

  def log(opus_id, user_id)
    CreateOpusLog.perform_async(opus_id, user_id)
  end
end