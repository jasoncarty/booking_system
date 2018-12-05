class AddReserveToEventAttendees < ActiveRecord::Migration[5.2]
  def change
    add_column :event_attendees, :reserve, :boolean, default: :false
  end
end
