class OpusLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :opus

  scope :date_period, -> (start_date, end_date){ 
    where('DATE(opuses_logs.created_at) >= ? AND DATE(opuses_logs.created_at) <= ?', 
      start_date.gsub('/', '-').split('-').reverse.join('-'), 
      end_date.gsub('/', '-').split('-').reverse.join('-')
    ) 
  }
end
