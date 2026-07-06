# Action Cable専用サーバ
port ENV.fetch("CABLE_PORT", 28080)

environment ENV.fetch("RAILS_ENV", "development")

# Railsアプリそのものを読み込む
require_relative "../config/environment"

# Action CableサーバをRackとしてそのまま使う
run ActionCable.server
