# frozen_string_literal: true

require_relative "../entities/item"
require_relative "../entities/coin"
require "singleton"

module Adapters
  # Adapter pattern provided due to extensibility of solution. We can easily
  # provide another adapter like psql-adapter, redis-adapter or anything other.
  class Memory
    include Singleton

    RecordNotExist = Class.new(StandardError)

    def initialize
      @state = []
    end

    attr_reader :state

    def add(type:, params:)
      # Constantaize provided entity
      Kernel.const_get(type).new(**params).tap do |object|
        state << object
      end
    end

    def remove(id:)
      raise RecordNotExist if fetch(id: id).nil?

      state.delete_if { |record| record.id == id }
    end

    def fetch(id:)
      state.find { |record| record.id == id }
    end
  end
end
