require_relative 'buscaCep_request'
require 'step_machine'
require 'pry'
include  StepMachine

busca_cep_requests = BuscaCep::App::BuscaCepRequests.new


    STATES = {
        'AC' => 'Acre',
        'AL' => 'Alagoas',
        'AP' => 'Amapá',
        'AM' => 'Amazonas',
        'BA' => 'Bahia',
        'CE' => 'Ceará',
        'DF' => 'Distrito Federal',
        'ES' => 'Espírito Santo',
        'GO' => 'Goías',
        'MA' => 'Maranhão',
        'MT' => 'Mato Grosso',
        'MS' => 'Mato Grosso o Sul',
        'MG' => 'Minas Gerais',
        'PA' => 'Pará',
        'PB' => 'Paraíba',
        'PR' => 'Paraná',
        'PE' => 'Pernambuco',
        'PI' => 'Piauí',
        'RJ' => 'Rio de Janeiro',
        'RN' => 'Rio Grande do Norte',
        'RS' => 'Rio Grande do Sul',
        'RO' => 'Rondônia',
        'RR' => 'Roráima',
        'SC' => 'Santa Catarina',
        'SP' => 'São Paulo',
        'SE' => 'Sergipe',
        'TO' => 'Tocantins',
    }

    step(:insert_zip_code) do
        puts "====INSERT CEP===="
        print 'CEP:'
        @cep = gets.chomp.to_s
    end.validate do |step|
        step.errors << "the #{@cep} is a Invalid input!" if step.result.match(/[0-9]{8}/).nil?
        @cep.insert(5,'-') if @cep[5] != '-'
    end


    step(:zip_code_search) do
        @result = busca_cep_requests.search_cep(@cep)
    end.validate do |step|
        step.errors << "CEP #{@cep} NÃO ENCONTRAO" if !step.result['dados'].first['logradouroDNEC'].match(/O CEP [0-9]{5}-[0-9]{3} NAO FOI ENCONTRADO/).nil?
        unless step.result['dados'].first['logradouroDNEC'].match(/CEP [0-9]{5}-[0-9]{3} DESMEMBRADO/).nil?
            @zip_code_data = step.result['dados'][1]
        else
            @zip_code_data = step.result['dados'].first
        end
    end.success do |step|
        @city         = @zip_code_data['localidade']
        @place        = @zip_code_data['logradouroDNEC']
        @neighborhood = @zip_code_data['bairro']
        @state        = @zip_code_data['uf']
    end

    step(:result) do
        puts '=====RESULT====='
        puts "Cidade: #{@city}"
        puts "Logradouro: #{@place}"
        puts "Bairro: #{@neighborhood}"
        puts "Estado: #{STATES[@state]}"
        puts "================"
    end

    on_step_failure do |f|
        #binding.pry unless f.step.errors.empty?
        unless f.step.errors.empty?
            puts "======ERROR======"
            puts "The following error occurred during zip code search: #{f.step.errors.join}"
        end
    end

    run_steps

