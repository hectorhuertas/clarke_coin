require 'openssl'
class WalletLoader
  attr_reader :private_key,
              :public_key,
              :file,
              :location

  def initialize(options = {})
    @file     = FileIO.new
    @location = options[:location] || "~/.wallet/"
    initialize_keys(options)
  end

  def initialize_keys(options)
     set_keys(options) || retrieve_keys || create_keys
     confirm_load
  end

  def set_keys(options)
    if options[:keys]
      @private_key = OpenSSL::PKey.read(options[:keys][:private])
      @public_key  = OpenSSL::PKey.read(options[:keys][:public])
    end
  end

  def retrieve_keys
    begin
      @private_key = retrieve_key(File.expand_path("#{location}private_key.pem"))
      @public_key  = retrieve_key(File.expand_path("#{location}public_key.pem"))
    rescue
      false
    end
  end

  def retrieve_key(location)
    pem = file.read(location)
    OpenSSL::PKey.read(pem)
  end

  def create_keys
    generate_keys
    store_keys
  end

  def generate_keys
    @private_key = OpenSSL::PKey::RSA.generate(2048)
    @public_key  = private_key.public_key
  end

  def store_keys
    FileUtils.mkdir_p File.expand_path("#{location}")

    file.write(File.expand_path("#{location}private_key.pem"), private_key)
    file.write(File.expand_path("#{location}public_key.pem"),  public_key)
  end

  def confirm_load
    # puts "Loaded RSA keys:\n\n #{public_key}\n"
  end
end
