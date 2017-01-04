=begin
Created (Andrew Fox 2016-09-14): This module is used to patch the String class to have an is_nn? method. This allows for input validation
when the user selects an option in the text interface of the program.
=end
#Updated (Cole Albers, 9/20): Standardized Documentation.
module CoreExtensions
  module String

    #Created (Andrew Fox 2016-09-14): String method for checking if a number is a natural number or not.
    #Returns true if is a nn or false if is not a nn
    def is_nn?
      self.match(/\A[+]?\d+?\Z/) == nil ? false : true
    end
  end
end
