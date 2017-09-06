class PayplugConfig
  def self.config_url
    Rails.env.production? ? 'https://www.payplug.fr/portal/ecommerce/autoconfig' : 'https://www.payplug.fr/portal/test/ecommerce/autoconfig'
  end

  # Get config from PayPlug API
  # Write it down
  def self.get_configuration
    credentials = YAML.load_file(Rails.root.join('config', 'payplug_credentials.yml'))
    body = open(config_url, http_basic_authentication: [credentials['login'], credentials['password']]).read
    config = JSON.parse(body)
    p config.inspect
    yaml_data = { Rails.env.to_s => config }.to_yaml
    full_path = Rails.root.join('config', 'payplug_config.yml')
    File.open(full_path, 'w'){|f| f.write yaml_data}
  end

  def initialize
    @config = YAML.load_file(Rails.root.join('config', 'payplug_config.yml'))[Rails.env]
  end

  def private_key
    @config['yourPrivateKey']
  end

  def payment_url
    @config['url']
  end

  def public_key
    @config['payplugPublicKey']
  end
end