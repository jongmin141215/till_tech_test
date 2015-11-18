require 'json'
class Order

  attr_reader :orders, :menu
  def initialize(menu = Menu.new)
    @menu = menu.display
    @orders = []
    @discount = false
    file = File.read('hipstercoffee.json')
    data = JSON.parse(file)
    @shop = data[0]['shopName']
    @address = data[0]['address']
    @phone = data[0]['phone']
  end

  def place_order(ordered_item, quantities)
    order = {}
    order[:order] = ordered_item
    order[:quantities] = quantities
    order[:price] = menu[order[:order]]
    orders << order
  end

  def print_receipt(customer)
    receipt = Time.now.strftime("%Y.%m.%d %T") + "\n"
    receipt += @shop + "\n\n"
    receipt += @address + "\n"
    receipt += "Phone: +" + @phone + "\n.\n"
    receipt += "#{customer.name}\n"
    width = 30
    orders.each do |order|
      receipt += " #{order[:order]}".ljust(width/2)
      receipt += "#{order[:quantities]} x #{sprintf("%.2f", order[:price])}\n".rjust(width/2)
    end
    if @discount
      receipt += "Disc:".ljust(width/2) + "5% from $#{sprintf("%.2f", self.total)}\n".rjust(width/2)
    end
    receipt += "Tax:".ljust(width/2) + "$#{sprintf("%.2f", self.calculate_taxes)}\n".rjust(width/2)
    receipt += "Total:".ljust(width/2) + "$#{sprintf("%.2f", self.total)}\n".rjust(width/2)
    receipt += "Cash:".ljust(width/2) + "#{sprintf("%.2f", @price)}\n".rjust(width/2)
    receipt += "Change:".ljust(width/2) + "$#{sprintf("%.2f", @change)}\n".rjust(width/2)
  end

  def calculate_taxes
    (self.sum * 0.0864).round(2)
  end

  def total
    total = 0
    orders.each do |order|
      total += order[:quantities] * menu[order[:order]]
    end
    if total > 50.0
      @discount = true
      (total * 0.95).round(2)
    else
      total.round(2)
    end
  end

  def sum
    total = 0
    orders.each do |order|
      total += order[:quantities] * menu[order[:order]]
    end
    total.round(2)
  end

  def accept_payment(price)
    @price = price.round(2)
    orders.each do |order|
      order[:paid] = true
      order[:paid_at] = Time.now.strftime("%Y.%m.%d %T")
    end
    @change = (price - self.total).round(2)
  end
end
