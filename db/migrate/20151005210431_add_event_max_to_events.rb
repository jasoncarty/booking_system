class AddEventMaxToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :maximum_event_attendees, :integer, default: 0
  end
end
