require 'bundler/capistrano'
require 'rvm/capistrano'
# require 'capistrano/sidekiq'

set :rvm_ruby_string, '2.1.5' # Change to your ruby version
set :rvm_type, :user # :user if RVM installed in $HOME

set :repository, 'git@github.com:ZouJun/appointment.git'
set :scm, :git
# set :admin_runner, 'root'
set :use_sudo, false
# set :group_writable, false
set :port, 22

# deployt_via: remote_cache, chechout, export or copy
set :deploy_via, :remote_cache
set :copy_exclude, %w(.git)
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 5

# 主站的程序部署在 web1.winwemedia.com、 web2.winwemedia.com 上
task :production do
  set :user, 'deploy'
  role :app, *%w[xzou.club]
  role :db, 'xzou.club', primary: true

  config_deploy

  # role :whenever, 'seafood.socp.com.cn'
  # set :whenever_roles, 'whenever'
  # deploy_whenever
end

# task :staging do
#   set :user, 'deploy'

#   require 'rvm/capistrano'
#   server 'seafood.dajiaxiao.cn', :app, :web, :db, primary: true
#   config_deploy application: 'seafood', rails_env: 'staging', branch: 'master'

#   role :whenever, 'seafood.dajiaxiao.cn'
#   set :whenever_roles, 'whenever'
#   deploy_whenever
# end


after 'deploy:restart', 'deploy:cleanup'
after "deploy:update", 'deploy:migrate'
after 'deploy:finalize_update', 'deploy:custom_symlinks'

namespace :deploy do

  task :start, roles: :app, except: { no_release: true } do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} BUNDLE_GEMFILE=#{deploy_to}/current/Gemfile bundle exec unicorn_rails -c #{unicorn_config} -D"
  end

  task :stop, roles: :app, except: { no_release: true } do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  task :restart, roles: :app, except: { no_release: true } do
    # 用USR2信号来实现无缝部署重启，每隔10秒挨个重启Rails Server
    find_servers.each do |server|
      run "if [ -f #{unicorn_pid} ]; then kill -n USR2 `cat #{unicorn_pid}`; fi", hosts: server.host
      sleep 10
    end
  end

  task :custom_symlinks, roles: :app do
    app_dir = rails_env == 'production' ? 'opt/apps' : 'opt/apps'

    run "ln -nfs /#{app_dir}/shared/seafood/assets/seafood #{release_path}/public/assets"

    run "ln -nfs /#{app_dir}/shared/seafood/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs /#{app_dir}/shared/seafood/uploads #{release_path}/public/uploads"
    run "ln -nfs /#{app_dir}/shared/seafood/logs #{release_path}/public/logs"

    run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
    run "ln -nfs /#{app_dir}/shared/seafood/config/unicorn.rb #{release_path}/config/unicorn.rb"
  end

end

desc 'Precompile assets locally and then rsync to app servers'
task :precompile do
  if %w[seafood].include?(application)
    assets_suffix = application
    tmp_assets_dir = "__assets_#{assets_suffix}"
    app_dir = rails_env == 'production' ? 'opt/apps' : 'opt/apps'
    shared_assets_dir = "/#{app_dir}/shared/seafood/assets/#{assets_suffix}/"

    run_locally "mkdir -p public/#{tmp_assets_dir}; mv public/#{tmp_assets_dir} public/assets;"
    run_locally 'bundle exec rake assets:clean_expired; RAILS_ENV=production bundle exec rake assets:precompile;'

    run "mkdir -p #{shared_assets_dir}"
    # run_locally %Q(rsync -avz -e "ssh -p #{port}" ./public/assets/ deployer@#{find_servers.first}:#{shared_assets_dir};)
    run_locally %Q(rsync -avz ./public/assets/ deploy@#{find_servers.first}:#{shared_assets_dir};)
    run_locally "mv public/assets public/#{tmp_assets_dir}"
  else
    puts '****** Nothing'
  end
end

def config_deploy(application: 'seafood', rails_env: 'production', branch: 'master', use_unicorn: true, releases: 5)
  set :keep_releases, releases
  set :application, application
  set :rails_env, rails_env
  set :deploy_env, rails_env
  set :branch, branch
  set :deploy_to, "/#{rails_env == 'production' ? 'opt/apps' : 'opt/apps'}/#{application}"

  if use_unicorn
    set :unicorn_config, "#{current_path}/config/unicorn.rb"
    set :unicorn_pid, -> { "#{current_path}/tmp/pids/unicorn.pid" }
  end
end

def deploy_whenever
  set :whenever_command, 'bundle exec whenever'
  set :whenever_environment, defer { deploy_env }
  set :whenever_identifier, defer { "#{application}_#{deploy_env}" }
  require 'whenever/capistrano'
end