class Analytics

  # setter/getter for options
  attr_accessor :options

  def initialize(areas)
    # requires instance variable of @areas and set_options method
    @areas = areas
    set_options
  end
  # creates instance options array and adds menu items hashes to array
  def set_options
    @options = []
    @options << { menu_id: 1, menu_title: 'Areas count', method: :how_many }
    @options << { menu_id: 2, menu_title: 'Smallest Population (non 0)', method: :smallest_pop }
    @options << { menu_id: 3, menu_title: 'Largest Population', method: :largest_pop }
    @options << { menu_id: 4, menu_title: 'How many zips in California?', method: :california_zip }
    @options << { menu_id: 5, menu_title: 'Information for a given zip', method: :zip_info }
    @options << { menu_id: 6, menu_title: 'Exit', method: :exit }
  end

  # takes choice and checks to see if it equals a menu option
  # if opt does not equal a choice prints 'invalid..'
  # I'm not sure how the last 2 branches function
  # I think the elsif will run any option that is not exit
  # and the last else will always be exit
  def run(choice)

    opt = @options.select {|o| o[:menu_id] == choice }.first
    if opt.nil?
      print "Invalid choice"
    elsif opt[:method] != :exit
      self.send opt[:method]
      :done
    else
      opt[:method]
    end
  end

  # prints the areas instance with the length method
  def how_many
    print "There are #{@areas.length} areas"
  end
  # sorts areas from smallest to largest dropping any areas of 0
  # then prints the smallest
  def smallest_pop
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    print "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}."
  end

  # sorts areas from smallest to largest dropping any areas == 0
  # reverses sort printing the first which is the largest
  def largest_pop
    sorted = @areas.sort do |x,y|
      x.estimated_population <=> y.estimated_population
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0}.first
    print "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}."
  end

  # prints all zip codes where their state == "CA"
  def california_zips
    c = @areas.count { |a| a.state == "CA" }
    print "There are #{c} zip code matches in California"
  end

  # gets zip from user, strips leading/trailing whitespace, turns it to an 
  # integer. the prints all info assigned to the area that has the user entered zip
  def zip_info
    print "Enter zip: "
    zip = gets.strip.to_i
    zips = @areas.select { |a| a.zipcode == zip }
    unless zips.empty?
      print ""
      zips.each { |z| print z }
    else
      print "Zip not found"
    end
  end
