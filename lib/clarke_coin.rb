require_relative 'file_io'
require_relative 'wallet'
require 'fileutils'

class ClarkeCoin
  attr_reader :wallet
  def initialize
    @wallet = Wallet.new
  end

  def run
    p wallet
  end
end
