class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement(params={})
    if params[:html] == true
      statement = HTMLStatement.new(@name, @rentals)
    else
      statement = Statement.new(@name, @rentals)
    end
      
    statement.generate_statement
  end
end

class Statement
  def initialize(customer_name, rentals)
    @customer_name = customer_name
    @rentals = rentals
  end

  def generate_statement
    result = generate_title +
      generate_statement_rentals +
      generate_amount_owed + 
      frequent_renter_points_message
  end

  def generate_title
    statement_title + "\n"
  end

  def generate_statement_line(rental)
    "\t#{movie_title(rental)}\t#{rental.calculate_price}\n"
  end

  def generate_amount_owed
    amount_owed_message + "\n"
  end

  def generate_statement_rentals
    result = ''
    for rental in @rentals
      result += generate_statement_line(rental)
    end
    return result
  end

  def statement_title
    "Rental record for #{@customer_name}"
  end

  def movie_title(rental)
    rental.movie.title
  end

  def amount_owed_message
    "Amount owed is $#{total_amount}"
  end

  def frequent_renter_points_message
    "You earned #{frequent_renter_points} frequent renter points"
  end

  def frequent_renter_points
    @rentals.reduce(0) { |points, rental| points += rental.calculate_frequent_rental_points}
  end

  def total_amount
    @rentals.reduce(0) { |price, rental| price += rental.calculate_price}
  end

end

class HTMLStatement < Statement
  def generate_title
    "<html><body><h1>#{statement_title}</h1>"
  end

  def generate_statement_line(rental)
    "<li>#{movie_title(rental)}&nbsp;&nbsp;&nbsp;&nbsp;#{rental.calculate_price}</li>"

  end

  def frequent_renter_points_message
    "<p>You earned #{frequent_renter_points} frequent renter points</p>"
  end

  def generate_amount_owed
    "<p>#{amount_owed_message}</p>"
  end

  def generate_statement_rentals
    return '' unless @rentals.length > 0
    result = '<ul>'
    for rental in @rentals
      result += generate_statement_line(rental)
    end
    result += '</ul>'
    return result
  end
end
