port ENV.fetch("CABLE_PORT", 28080)

environment ENV.fetch("RAILS_ENV", "development")

threads 1, 5

app do |env|
  ActionCable.server.call(env)
end
