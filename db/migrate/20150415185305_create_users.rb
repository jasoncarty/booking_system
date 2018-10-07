class CreateUsers < ActiveRecord::Migration[5.2]
  
  def change
    create_table :users do |t|
      t.string    :name 
      t.string    :email
      t.string    :password_digest
      t.boolean   :confirmed
      t.datetime  :confirmed_at
      t.string    :verification_token
      t.datetime  :verification_sent_at
      t.string    :password_reset_token
      t.datetime  :password_reset_token_sent_at
      t.string    :role, default: 'user'

      t.timestamps null: false
    end
  end
  
end
