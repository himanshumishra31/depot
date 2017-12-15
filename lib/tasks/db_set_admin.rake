namespace :db do
  desc "Set admin"
  task :set_admin_in_users, [:email] => :environment do |t,args|
    User.where(email: args[:email]).each do |user|
      user.update_columns role: 'admin'
    end
  end

  desc "Send consolidate email"
  task :set_consolidate_email => :environment do
    User.all.each do |user|
      UserMailer.consolidate_mail(user).deliver_now
    end
  end

end
