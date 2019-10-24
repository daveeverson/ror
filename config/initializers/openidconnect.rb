# config/initializers/openidconnect.rb
require 'openid_connect'
OpenIDConnect.debug! if Rails.env.development?

keys = %w(host redirect_uri client_id secret)
config_file = Rails.root.join("config", "openidconnect.yml")
yaml = {}
begin
  yaml = YAML.load(IO.read(config_file))
  unless keys.all? { |k| yaml.key?(k) && yaml[k].present? }
    raise "Openidconnect configuration error. Missing required keys: #{keys}, found: #{yaml.keys}"
  end
rescue Errno::ENOENT
  raise "YAML configuration file couldn't be found: #{config_file}"
rescue Psych::SyntaxError
  raise 'YAML configuration file contains invalid syntax.'
end

#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :openid_connect, {
#    name: :extranet,
#    scope: [:openid, :profile, :email],
#    response_type: :code,
#    discovery: true,
#    issuer: "https://#{yaml['host']}",
#    client_options: {
#      host: yaml['host'],
#      identifier: yaml['client_id'],
#      secret: yaml['secret'],
#      redirect_uri: yaml['redirect_uri'] 
#    },
#  }
#end