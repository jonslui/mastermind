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


    def check_for_win(players_guesses, current_games_secret_code)
        if players_guesses == current_games_secret_code
            puts "Great job! You won!"
            return true
        else
            correct_location = 0
            correct_color = 0

            4.times do |x|
                if current_games_secret_code[x] == players_guesses[x]
                    correct_location += 1
                elsif current_games_secret_code.include?(players_guesses[x])
                    correct_color += 1
                end
            end
            puts "#{correct_location} in the correct spot"
            puts "#{correct_color} of correct color but wrong location"
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




# add method that recognizes response and acts according to it
# fix correct color but wrong location section, might already be correct
# have it say which is the right color/wrong location directly where it is from?