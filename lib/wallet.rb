require_relative 'wallet_loader'
require 'openssl'
require 'json'
require 'base64'
class Wallet
  attr_reader :public_key,
              :private_key

  def initialize(options = {})
      wallet_loader = WalletLoader.new(options)
      @public_key   = wallet_loader.public_key
      @private_key  = wallet_loader.private_key
  end

  # def available
  #   [[],[5,public_key.to_pem]]
  # end
  #
  # def send(amount,receiver)
  #
  # end

  # def sign(source_input = nil)
  #   t_outputs = available.last
  #   @outputs_json = t_outputs.to_json
  #   signature = private_key.sign(OpenSSL::Digest::SHA256.new, @outputs_json)
  # end

  def sign(t_outputs)
    # binding.pry
    Base64.encode64(private_key.sign(OpenSSL::Digest::SHA256.new, t_outputs.to_json))
  end

  def verify(signature,message)
    public_key.verify(OpenSSL::Digest::SHA256.new, signature, message)
  end

  def verify_tx(tx)
    # check all inputs belong to its owners
    #check inputs = outputs
    # check that inputs are still available for spending(how????)

  end

end
