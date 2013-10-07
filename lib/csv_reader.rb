class CSVReader

  attr_accessor :fname, :headers

  def initialize(filename)
  
    @fname = filename

  end

  # the instructions list this as 'headers=' but when called the = is missing so I defined it w/o the =
  def headers(str)
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

  # creates a read-only instance of file from @fname
  def read
    f = File.new(@fname, 'r')

    # I'm not quite sure what is going on here. 
    # how does a message get sent to self while
    # being assigned the result of f.readline.
    # also it appears readline is not a File method. 
    # How are we to use it on a File instance?
    self.headers = f.readline

    # I'm not understanding how 'next_line = f.readline'
    # is a conditional.
    # or what block is passed for yield.
    while(!f.eof? && next_line = f.readline)
      values = next_line.split(',')
      hash = create_hash(values)
      yield(hash)
    end
  end

  def 
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