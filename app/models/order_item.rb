class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    quantity * price
  end

  def fulfill
    update(fulfilled: true)
    item.update(inventory: item.inventory - quantity)
  end

  def fulfillable?
    item.inventory >= quantity
  end

  def add_discount(discount)
    discount_percentage = (discount / 100).to_f
    amount_to_discount = (price * discount_percentage).round(2)
    update(price: price - amount_to_discount)
  end
end
