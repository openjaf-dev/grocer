class AddAccountReferencesToAddresses < ActiveRecord::Migration
  def change
    add_reference :addresses, :account, index: true
  end
end
