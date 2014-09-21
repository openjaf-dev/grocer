class AddAccountReferencesToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :account, index: true
  end
end
