module PaymentsUrls
  module ClassMethods
    def [](key)
      unless @config
        #@config = YAML.load_file(Rails.root.join('config', config_file))[Rails.env]
        @config = YAML.load(ERB.new(File.read(Rails.root.join('config', config_file))).result)[Rails.env]
      end
      @config[key.to_s]
    end

    def config_file
      "#{name.underscore}.yml.erb"
    end
  end

  extend ClassMethods

  def self.included(other)
    other.extend(ClassMethods)
  end
end

# Allows accessing config variables from paypal_urls.yml like so:
# PaypalUrls[:wtf] => wtf
module PaypalUrls
  include PaymentsUrls
end

module PayplugUrls
  include PaymentsUrls
end