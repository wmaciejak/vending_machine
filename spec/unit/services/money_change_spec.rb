# frozen_string_literal: true

require_relative "../../spec_helper"

# Test cases from
# https://gist.github.com/nelsonic/4570556
describe Services::MoneyChange do
  subject(:service) { described_class.new }

  it "returns valid result for 1" do
    result = {
      1 => 1,
      2 => 0,
      5 => 0,
      10 => 0,
      20 => 0,
      50 => 0,
      100 => 0,
      200 => 0
    }

    expect(service.call(1)).to eq result
  end

  it "returns valid result for 4" do
    result = {
      1 => 0,
      2 => 2,
      5 => 0,
      10 => 0,
      20 => 0,
      50 => 0,
      100 => 0,
      200 => 0
    }

    expect(service.call(4)).to eq result
  end

  it "returns valid result for 6" do
    result = {
      1 => 1,
      2 => 0,
      5 => 1,
      10 => 0,
      20 => 0,
      50 => 0,
      100 => 0,
      200 => 0
    }

    expect(service.call(6)).to eq result
  end

  it "returns valid result for 48" do
    result = {
      1 => 1,
      2 => 1,
      5 => 1,
      10 => 0,
      20 => 2,
      50 => 0,
      100 => 0,
      200 => 0
    }

    expect(service.call(48)).to eq result
  end

  it "returns valid result for 142" do
    result = {
      1 => 0,
      2 => 1,
      5 => 0,
      10 => 0,
      20 => 2,
      50 => 0,
      100 => 1,
      200 => 0
    }

    expect(service.call(142)).to eq result
  end

  it "returns valid result for 286" do
    result = {
      1 => 1,
      2 => 0,
      5 => 1,
      10 => 1,
      20 => 1,
      50 => 1,
      100 => 0,
      200 => 1
    }

    expect(service.call(286)).to eq result
  end
end
