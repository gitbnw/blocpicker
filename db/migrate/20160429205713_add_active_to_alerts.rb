class AddActiveToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :active, :boolean, :default => true
    add_column :alerts, :position_initial, :string
    add_column :alerts, :fired, :datetime
  end
end
