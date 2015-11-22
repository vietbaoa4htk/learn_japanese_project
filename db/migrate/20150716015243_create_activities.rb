class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :target_id
      t.string :type_of_activity

      t.timestamps null: false
    end
  end
end
