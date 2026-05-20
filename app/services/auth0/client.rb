require "faraday"
require "json"

module Auth0
  class Client
    def management_token
      Rails.cache.fetch("auth0_management_token", expires_in: 23.hours) do
        response = Faraday.post(
          "https://#{AUTH0_CONFIG[:auth0_domain]}/oauth/token",
          {
            client_id: AUTH0_CONFIG[:auth0_client_id],
            client_secret: AUTH0_CONFIG[:auth0_client_secret],
            audience: "https://#{AUTH0_CONFIG[:auth0_domain]}/api/v2/",
            grant_type: "client_credentials"
          }.to_json,
          { "Content-Type" => "application/json" }
        )

        JSON.parse(response.body)["access_token"]
      end
    end

    def connection
      Faraday.new(
        url: "https://#{AUTH0_CONFIG[:auth0_domain]}/api/v2",
        headers: {
          "Authorization" => "Bearer #{management_token}",
          "Content-Type" => "application/json"
        }
      )
    end
  end
end
