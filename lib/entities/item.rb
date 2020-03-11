# frozen_string_literal: true

require "securerandom"

# Class which represents items from vending machine
class Item
  def initialize(name:, price:, quantity:)
    @id = SecureRandom.uuid
    @name = name
    @price = price
    @quantity = quantity
  end

  attr_accessor :id, :name, :price, :quantity
end
