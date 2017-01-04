#Created (Andrew Fox, 9/14): Module used to help create test cases.
#Updated (Cole Albers, 9/20): Standardized Documentation.
module TestUtils

  #Created (Andrew Fox, 9/14): Allows for capturing the stdout printed by a method.
  def self.get_standard_output(&block)
    stream = $stdout
    $stdout = mock = StringIO.new
    #Allow @block to run and get the string put into STDOUT
    yield
    mock.string
  ensure
    #set $stdout back to original stream
    $stdout = stream
  end

end
