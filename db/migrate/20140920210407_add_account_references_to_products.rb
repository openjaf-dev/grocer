class AddAccountReferencesToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :account, index: true
  end
end
