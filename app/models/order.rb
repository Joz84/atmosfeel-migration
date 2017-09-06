class Order < ActiveRecord::Base
  include TotalMath

  belongs_to :user
  has_many :items, as: :itemable
  has_many :opuses, through: :items, source: :opus

  after_initialize :defaults

  scope :validated, -> { where(status: 'validated')}
  scope :date_period, -> (start_date, end_date){ where('DATE(created_at) >= ? AND DATE(created_at) <= ?', start_date.gsub('/', '-').split('-').reverse.join('-'), end_date.gsub('/', '-').split('-').reverse.join('-')).where(status: 'validated') }

  def add_items(transfered_items)
    items << transfered_items
  end

  def payment_url
    payment_solution = PayplugPayment.new(user, self)
    payment_solution.redirect_url
  end

  def end
    default_feellist = user.default_feellist
    items.each_with_object([]) do |item, a|
      default_feellist.library_entries.build(opus_id: item.opus_id)
    end
    default_feellist.save  
    self.status = 'validated'
    save
  end

  private

  def defaults
    self.status ||= 'pending_validation'
  end
end
