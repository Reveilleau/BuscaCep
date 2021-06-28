# Game get_number
# Made by: Antonio Carrilho
# Date: 27/06/2021 


# get user name and make a greeting...
puts 'Bem vindo ao adivinhe o numero...'
print 'Qual o seu nome? '
input_name = gets.chomp
print "Seja bem vindo #{input_name}! "

# Generate a random number between 1 - 100 and put it into a variable
puts 'Eu tenho um numero entre 1 e 100'
puts 'Voce consegue advinhar qual é?'
target = rand(100) + 1

#show how many guesses user have 
num_guesses = 0
restart = false

while num_guesses <= 10 || restart == true  

    puts "Voce tem #{10 - num_guesses} tentativas restantes.\n"
    print 'Faça uma tentativa '
    number = gets.to_i
    if number < target
        puts "O numero #{number} esta abaixo do numero correto..."
    elsif number > target
        puts "O numero #{number} esta acima do numero correto..."
    elsif number == target
        puts "Parabéns #{input_name} voce acertou o numero correto em #{num_guesses} tentativas!"
    end
    
    if num_guesses == 10 && number != target
        puts "Desculpa voce nao acertou meu numero! o numero correto era #{target}"
    end
    
    num_guesses += 1 
    
    if num_guesses == 10 || number == target
        puts "#{input_name} gostaria de reiniciar? s/n"
        reiniciar = gets.chomp.to_s
        if reiniciar == 's' || reiniciar == 'S'
            puts "Vamos nessa #{input_name}, Boa sorte :)"
            target = rand(100) + 1
            restart = true
            num_guesses = 0
        elsif reiniciar == 'n' || reiniciar == 'N'
            puts "#{input_name} até a proxima! :) Obrigado por jogar"
            restart = false
        end
        
    end

end




