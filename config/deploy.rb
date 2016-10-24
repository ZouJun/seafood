require 'bundler/capistrano'
require 'rvm/capistrano'


set :rvm_type, :user
set :repository, 'git@winwemedia.com:/opt/repos/projects/masterkong.git'
set :scm, :git

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :use_sudo, false
# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :port, 22
# Default value for :scm is :git
# set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, %w(.git)
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :keep_releases, 5
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
task :production do
  set :user, 'deploy'
  role :app, *%w[admin.o2o.masterkong.com.cn]
  role :db, 'admin.o2o.masterkong.com.cn', primary: true

  config_deploy

  role :whenever, 'admin.o2o.masterkong.com.cn'
  set :whenever_roles, 'whenever'
  deploy_whenever
end
# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
def config_deploy(application: 'appointment', rails_env: 'production', branch: 'master', use_unicorn: true, releases: 5)
  set :keep_releases, releases
  set :application, application
  set :rails_env, rails_env
  set :deploy_env, rails_env
  set :branch, branch
  set :deploy_to, "/opt/apps/#{application}"

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