class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string      :name
      t.string      :description
      t.string      :url

      t.timestamps null: false
    end
  end
end
