module LocalUpload
  extend ActiveSupport::Concern

  included do 
    attr_reader :local_file
  end

  def local_file=(path)
    return true if path.nil?
    full_path = Rails.root.join('public', path.gsub(/^\//, ''))
    self.carrierwave_attr = File.new(full_path)
  end
end