require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name= options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers
    (name, funds)
    VALUES
    ($1,$2)
    RETURNING id"
    values = [@name, @funds]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update
    sql = "UPDATE customers SET (name,funds) = ($1,$2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films
    sql = "SELECT * FROM films
    INNER JOIN tickets
    on tickets.film_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|film_data| Film.new(film_data)}
  end

  def ticket_count
    return films.count
  end

  def buy_ticket(film)
    @funds -= film.price
    update()
    Ticket.new({'customer_id' => @id, 'film_id' => film.id}).save()
  end

  def self.all
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    return results.map {|customer| Customer.new(customer)}
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end
