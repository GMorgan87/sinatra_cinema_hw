require_relative('../db/sql_runner')

class Film

attr_reader :id
attr_accessor :title, :price

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @price = options['price'].to_i
end

def save
  sql = "INSERT INTO films
  (title, price)
  VALUES
  ($1,$2)
  RETURNING id"
  values = [@title, @price]
  results = SqlRunner.run(sql, values)
  @id = results[0]['id'].to_i
end

def update
  sql = "UPDATE films SET (title,price) = ($1,$2) WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def delete
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def viewers
  sql = "SELECT * FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  WHERE film_id = $1"
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map {|customer_data| Customer.new(customer_data)}
end

def viewer_count
  return viewers.count
end

def self.find_by_id(id)
  sql = "SELECT * FROM films WHERE id = $1"
  values = [id]
  film_data = SqlRunner.run(sql, values)[0]
  return Film.new(film_data)
end

def self.all
  sql = "SELECT * FROM films"
  results = SqlRunner.run(sql)
  return results.map {|film| Film.new(film)}
end

def self.delete_all
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

end
