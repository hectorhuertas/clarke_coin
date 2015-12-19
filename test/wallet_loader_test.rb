require 'minitest'
require 'wallet_loader'
require_relative 'default_keys'
require 'file_io'

class WalletLoaderTest < Minitest::Test
  def test_initializes_with_keys_array
    public_key  = OpenSSL::PKey.read(Default_keys.public)
    private_key = OpenSSL::PKey.read(Default_keys.private)
    options = { keys: { public: public_key, private: private_key } }

    w_loader = WalletLoader.new(options)

    assert_equal Default_keys.public,  w_loader.public_key.to_s
    assert_equal Default_keys.private, w_loader.private_key.to_s
  end

  def test_retrieve_keys_from_wallet
    w_loader = WalletLoader.new(location: './test/data/')

    assert_equal Default_keys.public,  w_loader.public_key.to_pem
    assert_equal Default_keys.private, w_loader.private_key.to_pem
  end

  def test_creates_and_stores_new_keys
    FileUtils.rm_rf('./test/temp')

    w_loader = WalletLoader.new(location: './test/temp/')

    assert_equal '-----BEGIN PUBLIC KEY-----',      w_loader.public_key.to_s.split("\n").first
    assert_equal '-----BEGIN RSA PRIVATE KEY-----', w_loader.private_key.to_s.split("\n").first

    FileUtils.rm_rf('./test/temp')
  end
end
