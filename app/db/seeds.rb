require "#{Rails.root}/db/seeds/general.rb"
require "#{Rails.root}/db/seeds/material.rb"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?