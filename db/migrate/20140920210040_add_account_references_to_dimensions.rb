class AddAccountReferencesToDimensions < ActiveRecord::Migration
  def change
    add_reference :dimensions, :account, index: true
  end
end
