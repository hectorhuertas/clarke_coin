require_relative 'wallet_loader'
require 'openssl'
class Wallet
  attr_reader :public_key,
              :private_key

  def initialize(options = {})
    if options[:keys]
      @public_key   = options[:public_key]
      @private_key  = options[:private_key]
    else
      wallet_loader = WalletLoader.new(options)
      @public_key   = wallet_loader.public_key
      @private_key  = wallet_loader.private_key
    end
  end
end
