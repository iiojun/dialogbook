module Auth0
  class SendPasswordResetEmail
    def initialize(email:)
      @email = email
    end

    def call
      response = Faraday.post(
        "https://#{AUTH0_CONFIG[:auth0_domain]}/dbconnections/change_password",
        {
          client_id: AUTH0_CONFIG[:auth0_client_id],
          email: email,
          connection: AUTH0_CONFIG[:auth0_connection]
        }.to_json,
        {
          "Content-Type" => "application/json"
        }
      )

      raise response.body if response.status >= 400

      response.body
    end

    private

    attr_reader :email
  end
end
