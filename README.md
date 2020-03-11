# VendingMachine

## Functional requirements

* Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product
* It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted
* The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2
* There should be a way of reloading either products or change at a later point
* The machine should keep track of the products and change that it contains

## Technical requirements

* Be written in ruby
* Have tests
* Include a readme - think of it like the description you write on a github PR. Consider: explaining any decisions you made, telling us how to run it if it’s not obvious, signposting the best entry point for reviewing it, etc...

## Description

* Due to lack of sensful ideas regarding usage - class Interface looks a little bit messy, but it's functional.
* Application is sliced to smaller parts like services, entities, adapters mainy cause wanted to show "my way" of solving problem. It might be overkill in situations like this.
* Money are stored in pounds due to easier managements and operations.
* Heart of app is inside services, but it's wort to try go through whole app.
* Point of start of app - `start` file. Just run `./start` in CLI.

