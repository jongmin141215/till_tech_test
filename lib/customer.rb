class Customer
  attr_reader :order, :name
  def initialize(name, order = Order.new)
    @name = name
    @order = order
  end
end
