# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"
require "capistrano/rails"

set :application, "books_app"
set :repo_url, "git@github.com:NMP300/Ruby_on_Rails_practice.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/"#{fetch :application}"
set :deploy_to, "/home/kohei/nmpbooksapp.work/books_app"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
#
set :rbenv_ruby, "2.6.3"
set :rbenv_ruby_version, "2.6.3"
set :rbenv_path, "/home/kohei/.rbenv"
set :bundle_path, "./vendor/bundle"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} #{fetch(:rbenv_path)}/bin/rbenv exec"

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

desc "Initial Deploy"
task :initial do
  on roles(:app) do
    before 'deploy:restart', 'puma:start'
    invoke 'deploy'
  end
end

desc "Restart Application"
task :restart do
  on roles(:app), in: :sequence, wait: 5 do
    invoke 'puma:restart'
  end
end
