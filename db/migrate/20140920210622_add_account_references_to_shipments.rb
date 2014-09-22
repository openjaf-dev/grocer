class AddAccountReferencesToShipments < ActiveRecord::Migration
  def change
    add_reference :shipments, :account, index: true
  end
end
