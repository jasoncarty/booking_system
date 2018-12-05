class CreateSiteSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :site_settings do |t|
      t.string :site_name
      t.integer :maximum_event_attendees, default: 0

      t.timestamps
    end
  end
end
