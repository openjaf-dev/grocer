class AddAccountReferencesToVariants < ActiveRecord::Migration
  def change
    add_reference :variants, :account, index: true
  end
end
