# require 'json'
class Order

  attr_reader :orders, :menu
  def initialize(menu = Menu.new)
    @menu = menu.display
    @orders = []
  end

  def place_order(ordered_item, quantities, customer_name)
    order = {}
    order[:customer] = customer_name
    order[:order] = ordered_item
    order[:quantities] = quantities
    order[:price] = menu[order[:order]]
    orders << order
  end

  def total
    total = 0
    orders.each do |order|
      total += order[:quantities] * menu[order[:order]]
    end
    (total * 0.9136).round(2)
  end

  def print_receipt
    receipt = ''
    orders.each do |order|
      receipt += "#{order[:customer]}\n #{order[:order]}\t #{order[:quantities]} x #{order[:price]}\nTotal:\t #{self.total}"
    end
    receipt
  end

end
