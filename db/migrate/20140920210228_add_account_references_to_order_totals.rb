class AddAccountReferencesToOrderTotals < ActiveRecord::Migration
  def change
    add_reference :order_totals, :account, index: true
  end
end
