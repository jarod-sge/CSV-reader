class Area

  # not sure when accessors are required??
  attr_accessor :zipcode, :estimated_population, :city, :state

  # added method to get attributes from Hash
  # did not realize values would default to strings??
  def initialize(hash)
    @zipcode = hash[:zipcode].to_i || 0
    @estimated_population = hash[:estimated_population].to_i || 0
    @city = hash[:city] || "n/a"
    @state = hash[:state] || "n/a"
  end

  def to_s
    "#{@city}, #{@state}, #{@zipcode}, has #{@estimated_population} people."
  end
end