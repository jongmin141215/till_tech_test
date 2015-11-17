describe Order do
  subject(:order) { described_class.new }
  context '#place_order' do
    it 'takes customer\'s name order and quantities' do
      placed_order = order.place_order('Cafe Latte', 3, 'Jongmin')
      expect(order.orders).to eq([{customer: 'Jongmin', order: 'Cafe Latte', quantities: 3, price: 4.75}])
    end

    it 'can add customers\' orders' do
      order.place_order('Cafe Latte', 3, 'Jongmin')
      order.place_order('Flat White', 2, 'Jorg')
      expect(order.orders).to eq([{customer: 'Jongmin', order: 'Cafe Latte', quantities: 3, price: 4.75},
                                  {customer: 'Jorg', order: 'Flat White', quantities: 2, price: 4.75}])
    end
  end

  context '#total' do
    it 'cacluates the total amount' do
      order.place_order('Cafe Latte', 3, 'Jongmin')
      order.place_order('Flat White', 2, 'Jorg')
      expect(order.total).to eq(21.70)
    end

    it 'cacluates the total amount' do
      order.place_order('Choc Mudcake', 4, 'Jongmin')
      order.place_order('Affogato', 2, 'Jorg')
      order.place_order('Muffin Of The Day', 1, 'Alice')
      expect(order.total).to eq(54.59)
    end
  end

  context '#print_receipt' do
    it 'prints receipt for one person' do
      order.place_order('Cafe Latte', 3, 'Jongmin')
      expect(order.print_receipt).to eq("Jongmin\nCafe Latte\t 3 x 4.75\nTotal:\t 13.02")
    end
  end


end
