class RemoveDescrptionToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :descrption
  end
end
