class Game
    attr_accessor :secret_code

    def initialize
        @colors = ["red", "blue", "green", "white"]
        @turn = 0
    end

    def start_game
        @secret_code = []
        4.times { secret_code << @colors[rand(0..3)] }
    end

    def check_for_win(players_guesses, current_games_secret_code)
        if players_guesses == current_games_secret_code
            return true
        else
            return false
        end
    end

    def hints

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
    end

end



current_game = Game.new
testplayer = Player.new
current_game.start_game
puts current_game.secret_code
testplayer.guess_number(current_game)



# calling @secret_code message from testplayer who is a child of class Game, value is different than testgames'