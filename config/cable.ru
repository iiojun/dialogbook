require_relative "../config/environment"

Rails.application.initialize!

run ActionCable.server
