# frozen_string_literal: true

require_relative "../adapters/memory"

# Repository pattern for having one source of true in terms
# of state modification
module Repositories
  class Item
    TooLowQuantity = Class.new(StandardError)

    def initialize(adapter: Adapters::Memory.instance)
      @adapter = adapter
    end

    attr_reader :adapter

    def create(name:, price:, quantity:)
      adapter.add(
        type: :Item,
        params: {
          name: name,
          price: price,
          quantity: quantity
        }
      )
    end

    def pop(id)
      object = adapter.fetch(id: id)
      raise TooLowQuantity if object.quantity < 1

      object.quantity -= 1
    end

    def remove_by_name(name)
      object = find_by_name(name)
      adapter.remove(id: object.id)
    end

    def find_by_name(name)
      list.find { |record| record.name.downcase == name.downcase }
    end

    def list
      adapter.state.select { |record| record.class.to_s == "Item" }
    end
  end
end
