# frozen_string_literal: true

require "pry"
module Services
  class Interface
    class << self
      def show_items_list
        puts "\nList of available items:\n"
        item_repository.list.each do |record|
          puts "   Name: #{record.name}   |   Price: #{record.price}\n"
        end
      end

      def show_coins_list
        puts "\nList of available coins:\n"
        coin_repository.list.each do |record|
          puts "   Coin: #{record.denomination}   |   Quantity: #{record.quantity}\n"
        end
      end

      def show_main_menu
        puts "\nSelect option:\n1. Buy product\n2. Run service menu\n"
        case gets.chomp
        when "1"
          buy_product.tap { show_main_menu }
        when "2"
          service_menu.tap { show_main_menu }
        else
          puts "\nInvalid option\n"
        end
      end

      def buy_product
        show_items_list
        puts "\nProvide product name\n"
        name = gets.chomp
        puts "\nProvide how much coins inserted according to the formula 1p,2p,5p,10p,20p,50p,£1,£2"
        coins = gets.chomp.split(",").map(&:to_i)
        coins_to_return = Services::Store.new.buy_product(name: name, coins: coins)
        puts "Product delivered, coins changed: #{coins_to_return}"
      rescue Services::Store::InsufficientFunds
        puts "Insufficient funds provided, try again"
      rescue Repositories::Coin::TooLowQuantity
        puts "Insufficient funds in machine, try again later. Money returned"
      rescue Repositories::Item::TooLowQuantity
        puts "Machine is empty, try again later. Money returned"
      end

      def service_menu
        puts "\nSelect option:\n1. Add product\n2. Remove product\n"
        case gets.chomp
        when "1"
          show_items_list
          puts "\nProvide details according to the formula 'name,price,quantity'\n"
          data = gets.chomp.split(",").map(&:to_i)
          item_repository.create(name: data[0], price: data[1], quantity: [2])
          puts "\nDone! #{data[0]} product added to machine\n"
        when "2"
          puts "\nProvide name\n"
          name = gets.chomp
          item_repository.remove_by_name(name)
          puts "\nDone! #{name} product ejected from machine\n"
        else
          puts "\nInvalid option\n"
        end
      end

      private

      def item_repository
        @item_repository ||= Repositories::Item.new
      end

      def coin_repository
        @coin_repository ||= Repositories::Coin.new
      end
    end
  end
end
