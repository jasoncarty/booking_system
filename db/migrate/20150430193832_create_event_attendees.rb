class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :event_attendees, :event_id
    add_index :event_attendees, :user_id
  end
end
