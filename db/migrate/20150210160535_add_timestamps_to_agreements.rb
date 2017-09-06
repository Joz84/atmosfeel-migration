class AddTimestampsToAgreements < ActiveRecord::Migration
  def change
    add_column(:agreements, :created_at, :datetime)
    add_column(:agreements, :updated_at, :datetime)
    add_column(:agreements, :end_at, :datetime)
  end
end
