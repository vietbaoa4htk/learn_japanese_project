class ImplementPolimophic < ActiveRecord::Migration
  def change
    rename_column :activities, :target_id, :targetable_id
    add_column :activities, :targetable_type, :string
  end
end
