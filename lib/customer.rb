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
    total_amount = 0
    frequent_renter_points = 0
    result = "Rental record for #{@name}\n"
    for rental in @rentals
      this_amount = calculate_price(rental) 
      frequent_renter_points += 1
      if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1
        frequent_renter_points += 1
      end

      result += "\t#{rental.movie.title}\t#{this_amount}\n"
      total_amount += this_amount
    end

    result += "Amount owed is $#{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
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
