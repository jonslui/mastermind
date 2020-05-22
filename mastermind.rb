class Game

    attr_accessor :secret_code

    def initialize
        @colors = ["red", "blue", "green", "white"]
        @turn = 0
    end

    def start_player_game
        # for a user game, randomly choose a value from @colors 4 times
        @secret_code = []
        4.times { secret_code << @colors[rand(0..3)] }
    end

    def start_computer_game

        # user chooses colors for the secret code for the computer to guess, which is added to an array
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

        # turn guesses/secret_code into hash in order to compare them based on their keys and index numbers

        guesses_hash = convert_to_hash(players_guesses)
        code_hash = convert_to_hash(current_games_secret_code)

        correct_location = 0
        correct_color = 0

        #records # of places that colors are the same in both guesses and secret_code, and the # of colors that are present in the wrong location
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
    
                # makes sure for each color that correct_location and correct_color are not more than the total number of each color in secret_code
                if correct_location_count_for_current_key + correct_color_count_for_current_key > code_hash[key].length 
                    correct_color_count_for_current_key = code_hash[key].length - correct_location_count_for_current_key
                end

                correct_location += correct_location_count_for_current_key
                correct_color += correct_color_count_for_current_key
            end
        end

        puts "Correct location: #{correct_location}"
        puts "Correct color, wrong location: #{correct_color} "
        puts " "

    end

    def check_for_win(players_guesses, current_games_secret_code)
        if players_guesses == current_games_secret_code
            puts "Great job! You won!"
            return true
        else
            # check and return results of user choices
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
        
        # make sure guess is valid and add it to the guesses array
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
        # continue guess loop for 12 turns
        while guess_number < 12 && correct_guess == false
            puts "Guess # #{guess_number + 1}"
            self.choose
            # automatically check for a win
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





# game_loop
play_again = true

while play_again == true

    puts "Do you want to guess, or do you want to create the code?"
    check = ""

    until check == "guess" || check == "create"
        print "Choose guess or create: "
        check = gets.downcase.chomp
    end


    if check == "guess"
        # begins a game where the user guesses the computer generated code
        current_game = Game.new
        testplayer = Player.new
        current_game.start_player_game
        testplayer.guess_number(current_game)
    else
        # begins a game where the computer guesses your inputted code
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
