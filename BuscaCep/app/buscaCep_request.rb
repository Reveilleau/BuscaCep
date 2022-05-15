require_relative '../utils/requests'

module BuscaCepRequests
    include UtilsRequest

    dynamic_request(:search_cep) do
        {
            url: 'https://buscacepinter.correios.com.br/app/cep/carrega-cep.php',
            params: {
                'mensagem_alerta'   => '',
                'cep'               => 85601000,
                'cepaux'            => ''
            }
        }
    end

    dynamic_request(:search_city_weather) do
        {
            url: 'https://www.climatempo.com.br/json/busca-por-nome',
            params: {
                'name' => 'Francisco Beltrao'
            },
            options: {
                'referer' => 'https://www.climatempo.com.br/'
            }
        }
    end

    dynamic_request(:city_weather_condition_page) do
        {
            url: "https://www.climatempo.com.br/previsao-do-tempo/agora/cidade/#{city_code}/#{city_formated.downcase}-#{state.downcase}"
        }
    end

end