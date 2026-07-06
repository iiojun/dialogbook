# config/initializers/action_cable.rb

# 通常3秒のPing間隔を1秒に設定
ActionCable::Server::Base.config.ping_interval = 1
