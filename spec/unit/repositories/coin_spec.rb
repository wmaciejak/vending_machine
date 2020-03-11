# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec.describe Repositories::Coin do
  subject(:repository) { described_class.new }

  describe "#create" do
    let(:params) do
      {
        denomination: denomination,
        quantity: 1
      }
    end

    context "when denomination already exist" do
      let(:denomination) { 100 }

      it "create new object to repository" do
        expect { repository.create(**params) }.not_to(change { repository.list.length })
      end

      it "incrementing quantity" do
        expect { repository.create(**params) }
          .to change { repository.find_by_denomination(denomination).quantity }
          .by(1)
      end
    end

    context "when denomination doesn't exist yet" do
      let(:denomination) { 500 }

      it "create new object to repository" do
        expect { repository.create(**params) }
          .to change { repository.list.length }
          .by(1)
      end
    end
  end

  describe "#add" do
    let(:params) do
      {
        denomination: 5,
        quantity: 1
      }
    end

    it "incrementing quantity" do
      expect { repository.add(**params) }
        .to change { repository.find_by_denomination(params[:denomination]).quantity }
        .by(1)
    end
  end

  describe "#pop" do
    before { repository.add(**params) }

    let(:params) do
      {
        denomination: 5,
        quantity: 1
      }
    end

    it "decrementing quantity" do
      expect { repository.pop(**params) }
        .to change { repository.find_by_denomination(params[:denomination]).quantity }
        .by(-1)
    end
  end
end
