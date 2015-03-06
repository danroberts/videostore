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
        price += days_rented * 3
      when Movie::CHILDRENS
        price += 1.5
        if days_rented > 3
          price += (days_rented - 3) * 1.5
        end
      else
        # do nothing for a while
    end

    return price

  end
end
