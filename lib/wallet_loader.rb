require 'openssl'
require_relative 'file_io'
require 'pry-byebug'
class WalletLoader
  attr_reader :private_key,
              :public_key,
              :file,
              :location

  def initialize(options = {})
    @file        = FileIO.new
    @location    = options[:location] || "#{ENV["HOME"]}/.wallet/"
    @public_key,
    @private_key = initialize_keys(options)
  end

  def initialize_keys(options)
     set_keys(options) || retrieve_keys || create_keys
  end

  def set_keys(options)
      [options[:keys][:public], options[:keys][:private]] if options[:keys]
  end

  def retrieve_keys
    begin
      [retrieve('public_key'), retrieve('private_key')]
    rescue
      false
    end
  end

  def retrieve(key_type)
    pem = file.read("#{location}#{key_type}.pem")
    OpenSSL::PKey.read(pem)
  end

  def create_keys
    private_key = OpenSSL::PKey::RSA.generate(2048)
    public_key  = private_key.public_key

    FileUtils.mkdir_p File.expand_path("#{location}")
    file.write("#{location}private_key.pem", private_key)
    file.write("#{location}public_key.pem",  public_key)

    [public_key,private_key]
  end
end
