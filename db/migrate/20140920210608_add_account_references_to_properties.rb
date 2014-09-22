class AddAccountReferencesToProperties < ActiveRecord::Migration
  def change
    add_reference :properties, :account, index: true
  end
end
