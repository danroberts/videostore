class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end

  def price(days_rented)
    price = 0
    case @price_code
      when Movie::REGULAR
        price += 2
        if days_rented > 2
          price += (days_rented - 2) * 1.5
        end
      when Movie::NEW_RELEASE
        price += NewReleaseMovie.new(@title, @price_code).price(days_rented)
      when Movie::CHILDRENS
        price += ChildrensMovie.new(@title, @price_code).price(days_rented)
      else
        # do nothing for a while
    end

    return price
  end


  def frequent_rental_points(days_rented)
    points = 0
    if @price_code == Movie::NEW_RELEASE && days_rented > 1
      return 2
    else
      return 1
    end
  end
end

class NewReleaseMovie < Movie
  def price(days_rented)
    price = days_rented * 3
  end
end

class ChildrensMovie < Movie
  def price(days_rented)
    price = 1.5
    if days_rented > 3
      price += (days_rented - 3) * 1.5
    end
    price
  end
end
