# frozen_string_literal: true

require_relative "repositories/item"
require_relative "repositories/coin"
require_relative "constants"
require_relative "services/money_change"
require_relative "services/interface"
require_relative "services/store"

# Main class
class VendingMachine
  def initialize(stock_state:, coins_state:)
    fulfill_machine(stock_state, coins_state)
  end

  def self.prepare_prefilled_machine
    new(stock_state: Constants::STOCK_STATE, coins_state: Constants::COIN_STATE)
  end

  def call
    Services::Interface.show_main_menu
  end

  private

  def fulfill_machine(stock_state, coins_state)
    stock_state.each { |item| item_repository.create(**item) }
    coins_state.each { |item| coin_repository.create(**item) }
  end

  def item_repository
    @item_repository ||= Repositories::Item.new
  end

  def coin_repository
    @coin_repository ||= Repositories::Coin.new
  end
end
