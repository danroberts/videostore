class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def calculate_price
    @movie.price(@days_rented)
  end

  def calculate_frequent_rental_points
    @movie.frequent_rental_points(@days_rented)
  end
end
