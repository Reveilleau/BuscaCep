require_relative 'buscaCep_request'
require 'step_machine'
require 'pry'
include  StepMachine

busca_cep_requests = BuscaCep::App::BuscaCepRequests.new

    step(:insert_data_for_search) do
        @cep = gets.chomp.insert()
    end

    step(:search_location) do
        @result = busca_cep_requests.search_cep(85601000)
    end.validate do |step|
        step.errors << step.result['mensagem'] if step.result['dados'].count.eql?(0)
    end

    run_steps

