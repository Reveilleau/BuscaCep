require_relative 'buscaCep_request'
require 'step_machine'
require 'pry'
include  StepMachine

busca_cep_requests = BuscaCep::App::BuscaCepRequests.new

    ZIP_CODE_TYPE = {
        '1' => 'Esta cidade possui CEP unico',
        '2' => 'Esta cidade possui CEP por logradouro'
    }

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
        @zip_code = gets.chomp.to_s
    end.validate do |step|
        @zip_code.insert(5,'-') if !@zip_code.include?('-')
        step.errors << 'The zip code must contain 8 digits' if @zip_code.length != 9 
        #step.errors << "the #{@zip_code} is a Invalid input!" if step.result.match(/[0-9]{5}-[0-9]{3}/).nil?
    end


    step(:zip_code_search) do
        @result = busca_cep_requests.search_cep(@zip_code)
    end.validate do |step|
        step.errors << "CEP #{@zip_code} NÃO ENCONTRAO" if !step.result['dados'].first['logradouroDNEC'].match(/O CEP [0-9]{5}-[0-9]{3} NAO FOI ENCONTRADO/).nil?
        unless step.result['dados'].first['logradouroDNEC'].match(/CEP [0-9]{5}-[0-9]{3} DESMEMBRADO/).nil?
            @zip_code_data = step.result['dados'][1]
        else
            @zip_code_data = step.result['dados'][0]
        end 
        
        @place = @zip_code_data['logradouroDNEC'].include?('até') ? @zip_code_data['logradouroDNEC'].gsub(/-.até.?*/,'') : @zip_code_data['logradouroDNEC']

    end.success do |step|
        @city          = @zip_code_data['localidade']
        @zip_code_type = @zip_code_data['tipoCep']
        @neighborhood  = @zip_code_data['bairro']
        @state         = @zip_code_data['uf']
    end

    step(:collect_weather_data) do
        binding.pry
        busca_cep_requests.collect_local_weather
    end

    step(:result) do
        puts "=====RESULT====="
        puts "\nCidade: #{@city}"
        puts "Estado: #{STATES[@state]}"
        if @zip_code_type.eql?('2')
            puts "Logradouro: #{@place}"
            puts "Bairro: #{@neighborhood}"
        end

        puts "\nObservação: #{ZIP_CODE_TYPE[@zip_code_type]}"

        puts "\n================"
    end

    on_step_failure do |f|
        #binding.pry unless f.step.errors.empty?
        unless f.step.errors.empty?
            puts "======ERROR======"
            puts "The following error occurred during zip code search: #{f.step.errors.join}"
            f.go_to :insert_zip_code
        end
    end

    run_steps

