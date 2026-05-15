module Auth0
  class CreateUser
    def initialize(email:, password:, name:)
      @email = email
      @password = password
      @name = name
    end

    def call
      client = Auth0::Client.new.connection

      response = client.post("users") do |req|
        req.body = {
          email: email,
          password: password,
          name: name,
          connection: AUTH0_CONFIG[:auth0_connection],
          email_verified: false
        }.to_json
      end

      body = JSON.parse(response.body)

      raise body["message"] if response.status >= 400

      body
    end

    private

    attr_reader :email, :password, :name
  end
end
