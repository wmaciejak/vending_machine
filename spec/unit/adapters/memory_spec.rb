# frozen_string_literal: true

require_relative "../../spec_helper"

RSpec.describe Adapters::Memory do
  subject(:adapter) { described_class.instance }

  describe "#add" do
    let(:type) { :Item }
    let(:params) do
      {
        name: "Name",
        price: 1,
        quantity: 1
      }
    end

    it "adding new object to current state" do
      expect { adapter.add(type: type, params: params) }
        .to change { adapter.state.length }
        .by(1)
    end
  end

  describe "#remove" do
    context "when object exist" do
      let!(:id) { adapter.add(type: :Item, params: { name: "Name", price: 1, quantity: 1 }).id }

      it "remove new object to current state" do
        expect { adapter.remove(id: id) }
          .to change { adapter.state.length }
          .by(-1)
      end
    end

    context "when object does not exist" do
      let(:id) { "test" }

      it "raise error" do
        expect { adapter.remove(id: id) }.to raise_error StandardError
      end
    end
  end

  describe "#fetch" do
    context "when object exist" do
      let!(:object) { adapter.add(type: :Item, params: { name: "Name", price: 1, quantity: 1 }) }

      it "return object" do
        expect(adapter.fetch(id: object.id)).to eq(object)
      end
    end

    context "when object does not exist" do
      let(:id) { "test" }

      it "raise error" do
        expect(adapter.fetch(id: id)).to be_nil
      end
    end
  end
end
