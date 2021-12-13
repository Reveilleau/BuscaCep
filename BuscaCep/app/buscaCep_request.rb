require_relative '../modules/mechanize_utils'

module BuscaCep
    module App
        class BuscaCepRequests
            include BuscaCep::Modules::MechanizeUtils

            def buscar_alguma_coisa
                puts mechanize.get('https://www.google.com')
            end
        end
    end
end