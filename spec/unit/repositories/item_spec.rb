# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec.describe Repositories::Item do
  subject(:repository) { described_class.new }

  describe "#create" do
    let(:params) do
      {
        name: "Name",
        price: 1,
        quantity: 1
      }
    end

    it "create new object to repository" do
      expect { repository.create(**params) }
        .to change { repository.list.length }
        .by(1)
    end
  end
end
