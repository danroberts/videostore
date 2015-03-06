class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    result = "Rental record for #{@name}\n"
    for rental in @rentals

      result += "\t#{rental.movie.title}\t#{calculate_price(rental)}\n"
    end

    result += "Amount owed is $#{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
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
