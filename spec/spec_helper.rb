# frozen_string_literal: true

require "bundler/setup"

require "vending_machine"
require "pry"

RSpec.configure do |config|
  config.around do |example|
    Repositories::Coin.new.list.each do |coin|
      Repositories::Coin.new.remove_by_denomination(coin.denomination)
    end
    Constants::COIN_STATE.each { |item| Repositories::Coin.new.create(**item) }
    example.run
  end
end
