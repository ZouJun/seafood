namespace :dev do
  desc 'created accounts'
  task :create_accounts => :environment do
    puts 'Starting create accounts ******'
    account = Account.where(name: 'biaotu').first_or_create(login: 'admin', password: 111111, password_confirmation: 111111, mobile: 13899998888, email: 'foo@bar.com')
    puts "created account: #{account.name}"
  end
end