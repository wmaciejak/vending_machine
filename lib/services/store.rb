# frozen_string_literal: true

require "pry"
module Services
  class Store
    InsufficientFunds = Class.new(StandardError)

    def buy_product(name:, coins:)
      # find item
      item = item_repository.find_by_name(name)

      # preprocess provided coins
      coins = Hash[
        coins.each_with_index.collect do |coin, index|
          [default_coins.keys[index], coin]
        end
      ]
      amount = coins.sum { |k, v| k * v }

      # raise error if funds are not sufficient
      raise InsufficientFunds, "Insufficient funds" if item.price > amount

      # take item from stock
      item_repository.pop(item.id)

      # add coins to system
      manipulate_coins_in_system(coins: coins, action: :add)

      # change money and provide changes to system
      Services::MoneyChange.new.call(amount - item.price).tap do |coins_to_return|
        coin_repository.list.each do |coin|
          validate_available_coins(coin, coins_to_return)
        end
        manipulate_coins_in_system(coins: coins_to_return, action: :pop)
      end
    end

    private

    def validate_available_coins(coin, coins_to_return)
      raise Repositories::Coin::TooLowQuantity if coins_to_return[coin.denomination] > coin.quantity
    end

    def manipulate_coins_in_system(coins:, action:)
      coins.each do |denomination, quantity|
        coin_repository.send(action, denomination: denomination, quantity: quantity)
      end
    end

    def item_repository
      @item_repository ||= Repositories::Item.new
    end

    def coin_repository
      @coin_repository ||= Repositories::Coin.new
    end

    def default_coins
      {
        1 => 0,
        2 => 0,
        5 => 0,
        10 => 0,
        20 => 0,
        50 => 0,
        100 => 0,
        200 => 0
      }
    end
  end
end
