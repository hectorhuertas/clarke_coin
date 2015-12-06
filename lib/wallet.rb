require_relative 'wallet_loader'
require 'openssl'
require 'json'
class Wallet
  attr_reader :public_key,
              :private_key

  def initialize(options = {})
    if options[:keys]
      @public_key   = options[:keys][:public]
      @private_key  = options[:keys][:private]
    else
      wallet_loader = WalletLoader.new(options)
      @public_key   = wallet_loader.public_key
      @private_key  = wallet_loader.private_key
    end
  end

  def available
    [[],[5,public_key.to_pem]]
  end

  def send(amount,receiver)

  end

  def sign(source_input = nil)
    t_outputs = available.last
    outputs_json = t_outputs.to_json
    signature = private_key.sign(OpenSSL::Digest::SHA256.new, outputs_json)
  end

  def verify
    # NOT WORKING????
    binding.pry
    public_key.verify(OpenSSL::Digest::SHA256.new, sign, public_key.to_pem)
  end

end
