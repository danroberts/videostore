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
      result += "<li>#{movie_title(rental)}&nbsp;&nbsp;&nbsp;&nbsp;#{calculate_price(rental)}</li>"
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
      result += "\t#{movie_title(rental)}\t#{calculate_price(rental)}\n"
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
    frequent_renter_points = 0
    for rental in @rentals
      frequent_renter_points += calculate_frequent_rental_points(rental)
    end
    frequent_renter_points
  end

  def total_amount
    total_amount = 0
    for rental in @rentals
      total_amount += calculate_price(rental)
    end
    total_amount
  end

  def calculate_frequent_rental_points(rental)
    points = 0
    points += 1
    if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1
      points += 1
    end
    return points
  end
    
  def calculate_price(rental)
    price = 0
    case rental.movie.price_code
      when Movie::REGULAR
        price += 2
        if rental.days_rented > 2
          price += (rental.days_rented - 2) * 1.5
        end
      when Movie::NEW_RELEASE
        price += rental.days_rented * 3
      when Movie::CHILDRENS
        price += 1.5
        if rental.days_rented > 3
          price += (rental.days_rented - 3) * 1.5
        end
      else
        # do nothing for a while
    end

    return price
  end
end
