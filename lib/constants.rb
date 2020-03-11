# frozen_string_literal: true

class Constants
  STOCK_STATE = [
    { name: "Cola", price: 90, quantity: 5 },
    { name: "Fanta", price: 50, quantity: 1 },
    { name: "Pepsi", price: 70, quantity: 2 }
  ].freeze

  COIN_STATE = [
    { denomination: 200, quantity: 5 },
    { denomination: 100, quantity: 5 },
    { denomination: 50, quantity: 10 },
    { denomination: 20, quantity: 10 },
    { denomination: 10, quantity: 10 },
    { denomination: 5, quantity: 20 },
    { denomination: 2, quantity: 50 },
    { denomination: 1, quantity: 100 }
  ].freeze

  ALLOWED_COINS = [
    1,
    2,
    5,
    10,
    20,
    50,
    100,
    200
  ].freeze
end
