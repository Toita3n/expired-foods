require 'puma/daemon'
# アプリケーションディレクトリ
app_dir = '/var/www/expired-foods'
# ソケット通信を図る為bindでURI指定
bind "unix://#{app_dir}/tmp/sockets/puma.sock"

environment 'production'
# PIDファイル所在(プロセスID)
pidfile "#{app_dir}/tmp/pids/puma.pid"
# stateファイルはpumactlコマンドでサーバーを操作する。その所在。
state_path "#{app_dir}/tmp/pids/puma.state"
# 標準出力/標準エラーを出力するファイルの所在。
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count
# port       ENV.fetch("PORT") { 3000 }
workers 2

plugin :tmp_restart
daemonize
