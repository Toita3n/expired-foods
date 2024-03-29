# config valid only for current version of Capistrano
# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.18.0'

# Capistranoのログの表示に利用する
set :application, 'expired-foods'
set :deploy_to, '/var/www/expired-foods'
set :branch, 'main'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url, 'git@github.com:Toita3n/expired-foods.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '3.0.2'

append :linked_files, "config/master.key"

# プロセス番号を記載したファイルの場所
set :puma_pid, -> { "#{shared_path}/tmp/pids/puma.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/puma.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'puma:restart'
  end
end
