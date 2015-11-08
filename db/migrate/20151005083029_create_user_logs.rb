class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.string :log_data
      t.string :data_type

      t.timestamps null: false
    end
  end
end
