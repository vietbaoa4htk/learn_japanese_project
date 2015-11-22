class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
