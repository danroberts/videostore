class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def calculate_price
    price = 0
    case @movie.price_code
      when Movie::REGULAR
        price += 2
        if @days_rented > 2
          price += (@days_rented - 2) * 1.5
        end
      when Movie::NEW_RELEASE
        price += @days_rented * 3
      when Movie::CHILDRENS
        price += 1.5
        if @days_rented > 3
          price += (@days_rented - 3) * 1.5
        end
      else
        # do nothing for a while
    end

    return price
  end

  def calculate_frequent_rental_points
    points = 0
    points += 1
    if @movie.price_code == Movie::NEW_RELEASE && @days_rented > 1
      points += 1
    end
    return points
  end
end
