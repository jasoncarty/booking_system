class AddReserveToEventAttendees < ActiveRecord::Migration
  def change
    add_column :event_attendees, :reserve, :boolean, default: :false
  end
end
