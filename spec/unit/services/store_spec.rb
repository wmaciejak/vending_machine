# frozen_string_literal: true

require_relative "../../spec_helper"

describe Services::Store do
  subject(:service) { described_class.new.buy_product(name: name, coins: coins) }

  let!(:name) do
    Adapters::Memory
      .instance
      .add(type: :Item, params: { name: "Name", price: 30, quantity: 1 })
      .name
  end
  let(:coins) { [0, 0, 0, 1, 2, 0, 0, 0] }
  let(:result) do
    {
      1 => 0,
      2 => 2,
      5 => 1,
      10 => 0,
      20 => 2,
      50 => 0,
      100 => 0,
      200 => 0
    }
  end

  it "return valid number of calculated coins" do
    expect(service).to match result
  end
end
