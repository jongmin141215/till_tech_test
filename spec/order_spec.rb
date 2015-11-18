describe Order do
  subject(:order) { described_class.new }
  let(:customer) { double :customer, name: 'Jongmin'}
  context '#place_order' do
    it 'takes customer\'s name order and quantities' do
      placed_order = order.place_order('Cafe Latte', 3)
      expect(order.orders).to eq([{ order: 'Cafe Latte', quantities: 3, price: 4.75}])
    end

    it 'can add multiple orders from one customer' do
      order.place_order('Cafe Latte', 3)
      order.place_order('Flat White', 2)
      expect(order.orders).to eq([{ order: 'Cafe Latte', quantities: 3, price: 4.75 },
                                  { order: 'Flat White', quantities: 2, price: 4.75 }])
    end
  end

  context '#calculate_taxes' do
    it 'calcuates taxes' do
      order.place_order('Cafe Latte', 3)
      order.place_order('Flat White', 2)
      expect(order.calculate_taxes).to eq(2.05)
    end
  end

  context '#total' do
    it 'cacluates the total amount' do
      order.place_order('Cafe Latte', 3)
      order.place_order('Flat White', 2)
      expect(order.total).to eq(23.75)
    end

    # it 'cacluates the total amount' do
    #   order.place_order('Choc Mudcake', 4)
    #   order.place_order('Affogato', 2)
    #   order.place_order('Muffin Of The Day', 1)
    #   expect(order.total).to eq(59.75)
    # end

    it 'offers 5% of discount when purchase is over $50' do
      order.place_order('Cafe Latte', 11)
      expect(order.total).to eq(49.64)
    end
  end

  context '#accept_payment' do
    before do
      order.place_order('Cafe Latte', 3)
      order.place_order('Flat White', 1)
    end
    it 'accepts payment' do
      order.accept_payment(20)
      expect(order.orders[0][:paid]).to eq(true)
      expect(order.orders[1][:paid]).to eq(true)
    end

    it 'knows the time when the cost was paid' do
      order.accept_payment(20)
      expect(order.orders[0][:paid_at]).to eq(Time.now.strftime("%Y.%m.%d %T"))
      expect(order.orders[1][:paid_at]).to eq(Time.now.strftime("%Y.%m.%d %T"))
    end

    # it 'returns the change' do
    #   expect(order.accept_payment(20)).to eq(2.64)
    # end

  end

  context '#print_receipt' do
    it 'prints receipt for one order from one person' do
      width = 30
      order.place_order('Cafe Latte', 3)
      order.accept_payment(20)
      expect(order.print_receipt(customer)).to eq(Time.now.strftime("%Y.%m.%d %T") +
                                        "\nThe Coffee Connection\n\n" +
                                        "123 Lakeside Way\n" +
                                        "Phone: +16503600708\n.\n" +
                                        "Jongmin\n" + " Cafe Latte".ljust(width/2) + "3 x 4.75\n".rjust(width/2) +
                                        "Tax:".ljust(width/2) + "$1.23\n".rjust(width/2) +
                                        "Total:".ljust(width/2) + "$14.25\n".rjust(width/2) +
                                        "Cash:".ljust(width/2) + "20.00\n".rjust(width/2) +
                                        "Change:".ljust(width/2) + "$5.75\n".rjust(width/2))
    end


    it 'prints receipt for more than one order from one person' do
      width = 30
      order.place_order('Cafe Latte', 10)
      order.place_order('Flat White', 1)
      order.accept_payment(50)
      expect(order.print_receipt(customer)).to eq(Time.now.strftime("%Y.%m.%d %T") +
                                        "\nThe Coffee Connection\n\n" +
                                        "123 Lakeside Way\n" +
                                        "Phone: +16503600708\n.\n" +
                                        "Jongmin\n" +" Cafe Latte".ljust(width/2) + "10 x 4.75\n".rjust(width/2) +
                                        " Flat White".ljust(width/2) + "1 x 4.75\n".rjust(width/2) +
                                        "Disc:".ljust(width/2) + "5% from $49.64\n".rjust(width/2) +
                                        "Tax:".ljust(width/2) + "$4.51\n".rjust(width/2) +
                                        "Total:".ljust(width/2) + "$49.64\n".rjust(width/2) +
                                        "Cash:".ljust(width/2) + "50.00\n".rjust(width/2) +
                                        "Change:".ljust(width/2) + "$0.36\n".rjust(width/2))
    end
  end

end
