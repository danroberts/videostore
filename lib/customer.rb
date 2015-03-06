class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def html_statement
    result = "<html><body>"
    result += "<h1>#{statement_title}</h1>"
    result += "<ul>"

    for rental in @rentals
      result += "<li>#{movie_title(rental)}&nbsp;&nbsp;&nbsp;&nbsp;#{rental.calculate_price}</li>"
    end

    result += "</ul>"
    result += "<p>#{amount_owed_message}<p>"
    result += "<p>#{frequent_renter_points_message}</p>"
    result += "</body></html>"

    results
  end

  def statement
    result = statement_title + "\n"

    for rental in @rentals
      result += "\t#{movie_title(rental)}\t#{rental.calculate_price}\n"
    end

    result += amount_owed_message + "\n"
    result += frequent_renter_points_message 
    result
  end

  def statement_title
    "Rental record for #{@name}"
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
