class AddSlugToEventTypes < ActiveRecord::Migration[7.0]
  def change
    add_column :event_types, :slug, :string, null: false, unique: true
    add_index :event_types, :slug
  end
end
