class CreateClashRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :clash_requests do |t|
      t.string :status, default: "pending"
      t.references :user
      t.references :publication
      t.text :content

      t.timestamps
    end
  end
end
