require 'json'
require_relative '../modules/mechanize_utils.rb'


module BuscaCep
    module App
        class BuscaCepRequests
            include BuscaCep::Modules::MechanizeUtils

            def search_cep(cep)

                url = 'https://buscacepinter.correios.com.br/app/cep/carrega-cep.php'

                params = {
                    'mensagem_alerta'   => '',
                    'cep'             => cep,
                    'cepaux'          => ''
        
                }
                page = mechanize.post(url, params)
                page = JSON.parse(page.body)
            end

            def search_city_weather_json(location)

                url = 'https://www.climatempo.com.br/json/busca-por-nome'

                params = {
                    'name' => location
                }

                options = {
                    'referer' => 'https://www.climatempo.com.br/'
                }
                page = mechanize.post(url, params, options)
                page = JSON.parse(page.body)
            end

            def city_weather_condition_page(city_code, city_formated, state)

                url = "https://www.climatempo.com.br/previsao-do-tempo/agora/cidade/#{city_code}/#{city_formated.downcase}-#{state.downcase}"
                page = mechanize.get(url)

            end

        end
    end
end