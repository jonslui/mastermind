class Game
    attr_accessor :secret_code

    def initialize
        @colors = ["red", "blue", "green", "white"]
        @turn = 0
    end

    def start_player_game
        @secret_code = []
        4.times { secret_code << @colors[rand(0..3)] }
    end

    def start_computer_game
        @secret_code = []
        puts "Input your secret code."
        while @secret_code.length < 4
                print "#{@secret_code.length}: "
                choice = gets.downcase.chomp
                if choice == ("red") || choice == ("blue") || choice == ("green") || choice == ("white")
                    @secret_code << choice
                else
                    puts "Choose red, blue, green, or white."
                end 
        end
    end

    def convert_to_hash(array)
        hash = {}
        array.each_with_index do |color, index| 
            if hash[color] == nil
                hash[color] = []
                hash[color] << index
            else
                hash[color] << index
            end
        end
        hash
    end

    def check_for_correct_location_or_color(players_guesses, current_games_secret_code)
        guesses_hash = convert_to_hash(players_guesses)
        code_hash = convert_to_hash(current_games_secret_code)

        correct_location = 0
        correct_color = 0

        code_hash.each do |key, value| 
            if guesses_hash.has_key?(key) == true
                correct_location_count_for_current_key = 0
                correct_color_count_for_current_key = 0
                guesses_hash[key].length.times do |number|
                    if code_hash[key].include?(guesses_hash[key][number])
                        correct_location_count_for_current_key +=1                    
                    else
                        correct_color_count_for_current_key +=1
                    end
                end
    
                if correct_location_count_for_current_key + correct_color_count_for_current_key > code_hash[key].length 
                    correct_color_count_for_current_key = code_hash[key].length - correct_location_count_for_current_key
                end
                correct_location += correct_location_count_for_current_key
                correct_color += correct_color_count_for_current_key
            end
        end

        puts "#{correct_location} in the correct location"
        puts "#{correct_color} of the correct color but wrong location"
        puts " "

    end

    def check_for_win(players_guesses, current_games_secret_code)
        if players_guesses == current_games_secret_code
            puts "Great job! You won!"
            return true
        else
            check_for_correct_location_or_color(players_guesses, current_games_secret_code)
            return false
        end
    end

end


class Player
    attr_accessor :guesses

    def initialize
        @guesses = []
    end

    def choose
        @guesses = []
        while @guesses.length < 4
            print "#{@guesses.length + 1}: " 
            choice = gets.downcase.chomp
            if choice == ("red") || choice == ("blue") || choice == ("green") || choice == ("white")
                @guesses << choice
            else
                puts "Choose red, blue, green, or white."
            end
        end
    end


    def guess_number(current_game)
        guess_number = 0
        correct_guess = false
        while guess_number < 12 && correct_guess == false
            puts "Guess # #{guess_number + 1}"
            self.choose
            correct_guess = current_game.check_for_win(@guesses, current_game.secret_code)
            guess_number += 1
        end

        if correct_guess == false
            puts "Better luck next time!"
            puts "The correct answer was:"
            puts current_game.secret_code
        end
    end
end


class Computer < Player
    def initialize
        @colors = ["red", "blue", "green", "white"]
    end

    def choose
        @guesses = []
        4.times do
           @guesses << @colors[rand(0..3)]
        end
        puts @guesses
    end
end



play_again = true
while play_again == true

    puts "Do you want to guess, or do you want to create the code?"
    check = ""

    until check == "guess" || check == "create"
        print "Choose guess or create: "
        check = gets.downcase.chomp
    end

    if check == "guess"
        current_game = Game.new
        testplayer = Player.new
        current_game.start_player_game
        testplayer.guess_number(current_game)
    else
        current_game = Game.new
        testcomputer = Computer.new
        current_game.start_computer_game
        testcomputer.guess_number(current_game)
    end


    until check == "Y" || check == "N"
        print "Play again? Y/N: "
        check = gets.upcase.chomp
    end

    if check == "Y"
        play_again = true
    else 
        play_again = false
    end

end
