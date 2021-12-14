require 'json'
require_relative '../modules/mechanize_utils.rb'

module BuscaCep
    module App
        class BuscaCepRequests
            include BuscaCep::Modules::MechanizeUtils

            def search_cep(cep)

                url = 'https://buscacepinter.correios.com.br/app/endereco/carrega-cep-endereco.php'

                params = {
                    'pagina'         => '/app/endereco/index.php',
                    'cepaux'          => '',
                    'mensagem_alerta' => '',
                    'endereco'        => cep.to_s,
                    'tipoCEP'         => 'ALL',
                }
                
                page = mechanize.post(url, params)
                page = JSON.parse(page.body)

            end

        end
    end
end