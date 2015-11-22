class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.string :log_type
      t.integer :target
      t.string :log_data
      t.integer :number_of_word

      t.timestamps null: false
    end
  end
end
