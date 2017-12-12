namespace :db do
  desc "Set admin"
  task :set_admin_in_users, [:email] => :environment do |t,args|
    User.where(email: args[:email]).each do |user|
      user.update_columns role: 'admin'
    end
  end
end
