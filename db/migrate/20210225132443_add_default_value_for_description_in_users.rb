class AddDefaultValueForDescriptionInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :description, :string, default: "Voisin lambda"
  end
end
