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
                    # 'pagina'          => '/app/endereco/index.php',
                    # 'cepaux'          => '',
                    # 'mensagem_alerta' => '',
                    # 'endereco'        => cep,
                    # 'tipoCEP'         => 'LOG',
                }
                page = mechanize.post(url, params)
                page = JSON.parse(page.body)
            end

        end
    end
end