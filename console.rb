require('pry')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()

film1 = Film.new({'title' => '1917', 'price' => 10})
film1.save
film2 = Film.new({'title' => 'Knives Out', 'price' => 5})
film2.save
film3 = Film.new({'title' => 'Magnolia', 'price' => 3})
film3.save

customer1 = Customer.new({'name' => 'Gareth', 'funds' => 40})
customer1.save()
customer2 = Customer.new({'name' => 'Noel', 'funds' => 50})
customer2.save()
customer3 = Customer.new({'name' => 'Fraser', 'funds' => 30})
customer3.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4.save

binding.pry
nil
