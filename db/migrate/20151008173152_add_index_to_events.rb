class AddIndexToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :starts_at
  end
end
