# Dialogbook

Dialogbook is a simple e-portfolio system for intercultural communication education, which is mainly targeted to high-school and university students.

Currently, we are developing this app under the following conditions:
```console
$ bin/rails --version
Rails 8.0.3
$ ruby --version
ruby 3.4.2 (2025-02-15 revision d2930f8e7a) +PRISM [arm64-darwin24]
```
And prepare PostgreSQL, which is configured with its connection info appropriately.

## How to deploy the app
### clone the code and bundle the appropriate gems
Run the following commands
```console
$ gh repo clone iiojun/dialogbook
  ...
$ cd dialogbook
$ bundle install
  ...
```

### edit your credentials
Set your client ID and Client Secret provided by Auth0 (suppose that the Auth0 application settings have already been done).

Edit your credentials by `EDITOR=vi rails credentials:edit`, put your domain, client_id, and client_secret information provided by Auth0.
```yaml
auth0:
  domain: ******.**.auth0.com
  client_id: ********
  client_secret: ****************
```

### add your host info
Add the following code to config/environments/{development,production}.rb
```ruby
config_hosts << "YOUR_HOST_NAME_WRITTEN_IN_FQDN"
```

### application setting
Run the following commands to prepare the database tables.
```console
$ bin/rails db:create db:migrate
```
That's all. Start the server and have fun!
