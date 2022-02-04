require_relative '../utils/mechanize_utils.rb'

class BuscaCepRequests
    include Utils::MechanizeUtils

        def search_cep(cep)

        url = 'https://buscacepinter.correios.com.br/app/cep/carrega-cep.php'

        params = {
            'mensagem_alerta'   => '',
            'cep'             => cep,
            'cepaux'          => ''

        }

        JSON.parse(mechanize.post(url, params).body)
    end

    def search_city_weather_json(location)

        url = 'https://www.climatempo.com.br/json/busca-por-nome'

        params = {
            'name' => location
        }

        options = {
            'referer' => 'https://www.climatempo.com.br/'
        }

        JSON.parse(mechanize.post(url, params, options).body)
    end

    def city_weather_condition_page(city_code, city_formated, state)

        url = "https://www.climatempo.com.br/previsao-do-tempo/agora/cidade/#{city_code}/#{city_formated.downcase}-#{state.downcase}"
        mechanize.get(url)

    end


end