# the requires make sense but I don't remember seeing these implemented
require_relative 'csv_reader'
require_relative 'area'

class Setup

  attr_accessor :areas

  def initialize
    
    # assigns read of csv file to instance of CSVReader
    csv = CSVReader.new("./free-zipcode-database.csv")
    
    # creates emtpy array then assigns items of CSV to array
    @areas = []
    csv.read do |item|
      @areas << Area.new(item)
    end

    # returns self
    self
  end


end
