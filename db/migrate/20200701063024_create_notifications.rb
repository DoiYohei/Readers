class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, nil: false
      t.integer :visited_id, nil: false
      t.integer :topic_id
      t.string :action, default: '', nil: false
      t.boolean :checked, default: false, nil: false

      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :topic_id
  end
end
