# Clear existing data
Category.destroy_all
Product.destroy_all
CategoryProduct.destroy_all

# Create hierarchical categories
electronics = Category.create!(name: "Electronics", description: "Devices and gadgets")
smartphones = Category.create!(name: "Smartphones", description: "Mobile phones", parent_category: electronics)
laptops = Category.create!(name: "Laptops", description: "Portable computers", parent_category: electronics)

clothing = Category.create!(name: "Clothing", description: "Apparel and accessories")
mens_wear = Category.create!(name: "Men's Wear", description: "Clothing for men", parent_category: clothing)
womens_wear = Category.create!(name: "Women's Wear", description: "Clothing for women", parent_category: clothing)

# Create products
products = []
10.times do
  products << Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock_quantity: Faker::Number.between(from: 1, to: 50)
  )
end

# Associate products with categories
products.each do |product|
  CategoryProduct.create!(category: [electronics, smartphones, clothing, mens_wear, womens_wear].sample, product: product)
end