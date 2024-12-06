require 'factory_bot_rails'

create(:product, name: "Product 1", description: "Description for product 1", price: 9.99, stock_quantity: 100)
create(:product, name: "Product 2", description: "Description for product 2", price: 19.99, stock_quantity: 50)
create(:product, name: "Product 3", description: "Description for product 3", price: 29.99, stock_quantity: 25)
