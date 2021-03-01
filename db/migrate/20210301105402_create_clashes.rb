class CreateClashes < ActiveRecord::Migration[6.0]
  def change
    create_table :clashes do |t|
      t.integer :contender_votes, default: 0
      t.integer :publisher_votes, default: 0
      t.references :clash_request
      t.datetime :countdown_end, default: DateTime.now + 1.day
      t.timestamps
    end
  end
end
