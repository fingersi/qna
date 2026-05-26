# config valid for current version and patch releases of Capistrano
lock "~> 3.20.1"

set :application, "qna"
set :repo_url, "git@github.com:fingersi/qna.git"
set :branch, "capistrano" 

set :deploy_to, "/home/deploy/qna"
set :deploy_user, 'deploy'

set :rvm_ruby_version, "2.7.2"


set :bundle_jobs, 4

append :linked_files, 'config/database.yml', 'config/master.key', 'config/storage.yml'

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets",
                     "public/system", "vendor", "storage", "node_modules",
                     "public/packs"
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
