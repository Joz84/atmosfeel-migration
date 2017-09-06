class BankDetail < ActiveRecord::Base
  belongs_to :user

  after_initialize :defaults

  private

  def defaults
    self.owner_firstname ||= user.firstname
    self.owner_lastname ||= user.lastname
    self.owner_address ||= user.address
  end
end
