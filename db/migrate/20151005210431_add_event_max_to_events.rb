class AddEventMaxToEvents < ActiveRecord::Migration
  def change
    add_column :events, :maximum_event_attendees, :integer, default: 0
  end
end
