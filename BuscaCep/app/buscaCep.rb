require_relative 'buscaCep_request'
require 'step_machine'

busca_cep_requests = BuscaCep::App::BuscaCepRequests.new

    puts busca_cep_requests.search_cep(85601000)