class CreateUserGoals < ActiveRecord::Migration
  def change
    create_table :user_goals do |t|
      t.integer :user_id
      t.integer :number_of_words
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
