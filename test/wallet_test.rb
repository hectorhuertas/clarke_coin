require 'minitest'
require 'wallet'
require_relative 'default_keys'

class WalletTest < Minitest::Test
  attr_reader :wallet

  def setup
    public_key  = OpenSSL::PKey.read(Default_keys.public)
    private_key = OpenSSL::PKey.read(Default_keys.private)
    @wallet     = Wallet.new(keys: { private: private_key, public: public_key })
  end

  def test_it_initializes
    new_wallet = Wallet.new(location: 'test/data/')
    assert_equal Default_keys.public, new_wallet.public_key.to_pem
    assert_equal Default_keys.private, new_wallet.private_key.to_pem
  end
end
