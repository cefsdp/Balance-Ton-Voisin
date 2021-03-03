class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :clash, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :party

      t.timestamps
    end
  end
end
