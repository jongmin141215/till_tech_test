describe Menu do
  subject(:menu) { described_class.new }
  it 'contains Blueberry Muffin' do
    expect(menu.display).to eq({"Cafe Latte"=>4.75, "Flat White"=>4.75,
                                "Cappucino"=>3.85, "Single Espresso"=>2.05,
                                "Double Espresso"=>3.75, "Americano"=>3.75,
                                "Cortado"=>4.55, "Tea"=>3.65, "Choc Mudcake"=>6.4,
                                "Choc Mousse"=>8.2, "Affogato"=>14.8, "Tiramisu"=>11.4,
                                "Blueberry Muffin"=>4.05, "Chocolate Chip Muffin"=>4.05,
                                "Muffin Of The Day"=>4.55})
  end
end
