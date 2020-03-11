# frozen_string_literal: true

require_relative "../constants"

module Services
  class MoneyChange
    def call(amount)
      result = prefilled_result

      Constants::ALLOWED_COINS.reverse.each do |coin|
        count = amount / coin
        amount %= coin
        result[coin] = count
        return result if amount.zero?
      end

      result
    end

    private

    def prefilled_result
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
