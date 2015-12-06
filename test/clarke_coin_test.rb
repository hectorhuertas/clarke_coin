require 'clarke_coin'
require 'minitest'
require 'pry'

class ClarkeCoinTest < Minitest::Test
  def test_it_runs
    assert ClarkeCoin.new.run
  end
end
