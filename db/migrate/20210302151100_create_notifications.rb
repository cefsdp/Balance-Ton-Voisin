class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.string "notification_type", null: false
      t.jsonb "params"
      t.datetime "read_at"
      t.timestamps
    end
  end
end
