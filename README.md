### Algorithm of new order

1) Initialize new object("basket") which responsible for collection of added/removed items for a new order.

```
basket = OrderItemsBuilder.new
basket.items => []
basket.total_price => 0.0
```

2) Select product and it quantiy (assume from the view we get product_id and qauntity).
3) Add/remove product and it quantiy to/from the basket.
```
basket.add_product(product_id: 1, quantity: 2)
basket.remove_product(product_id: 2)
```
In the end, after all desired items have been added, the result of items would look like:
```
  basket.items => [OrderItem.new(product_id: 1, quantity: 2, price: product.price),...]
  basket.total_price => # return total price of all order items multiplied by quantity
```
4) Create order based on basket data
```
OrderCreator.new(customer_email: 'test@example.com', items_basket: basket, note: #optional).call => order object
```
As a result Order object and associated with it Order Items will be created. In case of validation error nothing is saved to DB.

5) Apply discounts to certain order.
```
Order.last.total.to_f => 109.9
ds =DiscountService.new(Order.last, Strategies::FoodAfterSixPm.new)
ds.total_discount => 0.0 # Strategy was not applied yet
ds.discount # Execute discount method from Strategies::FoodAfterSixPm.new class
ds.total_discount.to_f => 4.99
ds.strategy = Strategies::TenWhiteColorItems.new # Switch to a new strategy
ds.discount
ds.total_discount.to_f => 6.094 (Sum of two discounts)
....
```
6) After applying all discounts we can update field `discount` with appropriate value from Step 5
