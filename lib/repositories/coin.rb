# frozen_string_literal: true

require_relative "../adapters/memory"
require "pry"
# Repository pattern for having one source of true in terms
# of state modification
module Repositories
  class Coin
    TooLowQuantity = Class.new(StandardError)

    def initialize(adapter: Adapters::Memory.instance)
      @adapter = adapter
    end

    attr_reader :adapter

    def create(denomination:, quantity:)
      if find_by_denomination(denomination)
        return add(denomination: denomination, quantity: quantity)
      end

      adapter.add(
        type: :Coin,
        params: {
          denomination: denomination,
          quantity: quantity
        }
      )
    end

    def add(denomination:, quantity:)
      object = find_by_denomination(denomination)
      object.quantity += quantity
    end

    def pop(denomination:, quantity:)
      object = find_by_denomination(denomination)
      raise TooLowQuantity if object.quantity < 1

      object.quantity -= quantity
    end

    def remove_by_denomination(denomination)
      object = find_by_denomination(denomination)
      adapter.remove(id: object.id)
    end

    def find_by_denomination(denomination)
      list.find { |record| record.denomination == denomination }
    end

    def list
      adapter.state.select { |record| record.class.to_s == "Coin" }
    end
  end
end
