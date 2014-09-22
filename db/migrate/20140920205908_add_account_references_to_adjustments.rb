class AddAccountReferencesToAdjustments < ActiveRecord::Migration
  def change
    add_reference :adjustments, :account, index: true
  end
end
