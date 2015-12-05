require_relative 'file_io'
require_relative 'wallet'
require 'fileutils'

class ClarkeCoin
  def initialize
    @wallet = Wallet.new
  end

  def run
    puts wallet
  end
end
