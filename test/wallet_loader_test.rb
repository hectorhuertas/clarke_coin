require 'minitest'
require 'wallet_loader'
require_relative 'default_keys'

class WalletLoaderTest < Minitest::Test
  def test_initializes_with_keys_array
    options = { keys: { private: Default_keys.private, public: Default_keys.public } }

    wallet = WalletLoader.new(options)

    assert_equal Default_keys.public,  wallet.public_key.to_pem
    assert_equal Default_keys.private, wallet.private_key.to_pem
  end

  def test_creates_and_stores_new_keys
    FileUtils.rm_rf('test/temp')
    wallet = WalletLoader.new(location: 'test/temp/')

    public_key  = File.read('test/temp/public_key.pem')
    private_key = File.read('test/temp/private_key.pem')
    assert_equal '-----BEGIN PUBLIC KEY-----',      public_key.split("\n").first
    assert_equal '-----BEGIN RSA PRIVATE KEY-----', private_key.split("\n").first

    FileUtils.rm_rf('test/temp')
  end

  def test_retrieve_keys_from_wallet
    wallet = WalletLoader.new(location: 'test/data/')

    assert_equal Default_keys.public,  wallet.public_key.to_pem
    assert_equal Default_keys.private, wallet.private_key.to_pem
  end
end
