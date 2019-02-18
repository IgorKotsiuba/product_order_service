%w(Food Computers&Accessories Sport).each do |name|
  Category.create(name: name)
end

%w(Rice Milk Cheese Flour).each do |name|
  category = Category.find_by(name: 'Food')
  category.products.create(name: name, price: 9.99, details: { color: 'white' })
end

%w(Keyboard Mouse Laptop Headphone Speakers HardDisk FlashDrive).each do |name|
  category = Category.find_by(name: 'Computers&Accessories')
  category.products.create(name: name, price: 10.00, details: { color: 'white' })
end
