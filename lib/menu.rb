require 'json'
class Menu
  def display
    file = File.read('hipstercoffee.json')
    data = JSON.parse(file)
    menu = data[0]['prices'][0]
  end
end
