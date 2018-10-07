class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string      :name
      t.text        :description
      t.string      :url
      t.datetime    :starts_at
      t.datetime    :ends_at
      t.string      :title
      t.string      :preview
      t.integer     :calendar_id

      t.timestamps null: false
    end

    add_index :events, :calendar_id
  end
end
