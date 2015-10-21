require 'json'
file = File.read(Rails.root.join('lib', 'tasks', 'users.json'))
users = JSON.parse(file)

namespace :old_users do
  desc "Migrates old users"
  task migrate: :environment do
    other_users = User.where.not(email: 'jason@jcartydesign.com')
    other_users.each { |u| u.destroy }

    users['RECORDS'].each do |user|
      new_user = User.new({
        name: user['name'],
        email: user['email'],
        confirmed_at: user['confirmed_at'],
        role: user['admin'] == 't' ? 'admin' : 'user',
        created_at: user['created_at'],
        updated_at: user['updated_at'],
        verification_token: user['confirmation_token'],
        password_reset_token: user['reset_password_token'],
        password_reset_token_sent_at: user['reset_password_token'],
        password_digest: user['encrypted_password']
      })
      new_user.validate_password = false
      new_user.save
    end
  end
end

