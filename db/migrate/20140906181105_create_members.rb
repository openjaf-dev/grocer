class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :account, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
