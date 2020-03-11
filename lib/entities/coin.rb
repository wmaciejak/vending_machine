# frozen_string_literal: true

require "securerandom"

# Class which represents coins from vending machine
class Coin
  def initialize(denomination:, quantity:)
    @id = SecureRandom.uuid
    @denomination = denomination
    @quantity = quantity
  end

  attr_accessor :id, :denomination, :quantity
end
