require 'mechanize'

module BuscaCep
    module Modules
        module MechanizeUtils
            @mechanize = nil

            def mechanize                
                @mechanize = Mechanize.new if @mechanize.nil?

                @mechanize
            end

        end
    end
end