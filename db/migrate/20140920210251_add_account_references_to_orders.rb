class AddAccountReferencesToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :account, index: true
  end
end
