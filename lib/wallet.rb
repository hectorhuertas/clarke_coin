require 'openssl'
class Wallet
  attr_reader :private_key,
              :public_key,
              :file

  def initialize
    @file = FileIO.new
    initialize_keys
  end

  def initialize_keys
     retrieve_keys || create_keys
  end

  def retrieve_keys
    begin
      @private_key = retrieve_key(File.expand_path('~/.wallet/private_key.pem'))
      @public_key  = retrieve_key(File.expand_path('~/.wallet/public_key.pem'))
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
    FileUtils.mkdir_p File.expand_path('~/.wallet/')

    file.write(File.expand_path('~/.wallet/private_key.pem'), private_key)
    file.write(File.expand_path('~/.wallet/public_key.pem'),  public_key)
  end
end
