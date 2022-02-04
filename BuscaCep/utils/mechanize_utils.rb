require 'mechanize'
require 'json'

class Utils
    module MechanizeUtils
        @mechanize = nil

        def mechanize
            @mechanize = Mechanize.new if @mechanize.nil?

            @mechanize
        end
    end

end
