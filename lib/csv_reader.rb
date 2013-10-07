class CSVReader

  attr_accessor :fname, :headers

  def initialize(filename)
  
    @fname = filename

  end

  def headers=(str)
    # turns string into array of words
    @headers = str.split(',')

    @headers.map! do |h|
      # removes double quotes and leading/trailing whitespace
      h.gsub!('"', '')
      h.strip!

      # converts to snakecase and symbolizes
      h.underscore.to_sym
    end
  end

  def create_hash(arr)
    hash = {}
    # removes quotes and leading/trailing whitespace
    # and assigns values to hash
    @headers.each_with_index do |header,index|
      value = arr[index].strip.gsub('"', '')
      hash[header] = value unless value.empty?
    end
    hash
    
  end


end

class String
  # underscore method from ActiveRecord
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

end