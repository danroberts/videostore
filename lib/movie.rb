class Movie
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def price(days_rented)
    price = 2
    if days_rented > 2
      price += (days_rented - 2) * 1.5
    end

    return price
  end


  def frequent_rental_points(days_rented)
    return 1
  end
end

class NewReleaseMovie < Movie
  def price(days_rented)
    price = days_rented * 3
  end

  def frequent_rental_points(days_rented)
    if days_rented > 1
      return 2
    else
      return 1
    end
  end
end

class ChildrensMovie < Movie
  def price(days_rented)
    price = 1.5
    if days_rented > 3
      price += (days_rented - 3) * 1.5
    end
    return price
  end
end
