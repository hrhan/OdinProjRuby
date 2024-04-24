class Mastermind
    CODE_LENGTH = 4

    def initialize(config)
        @config = config
    end

    def select_secret_code()
        colour_options = @config.colours * @config.max_num_repeat
        @secret_code = colour_options.sample(CODE_LENGTH)
    end

    def reveal_secret_code()
        puts "The secret code was: #{@secret_code.map { |colour| colour.capitalize }.join(" ")}"
    end

    def correct_guess?(guess)
        return @secret_code == guess
    end

    def compare_code(guess)
        answer = []
        guess.each_index { |index| 
            if guess[index] == @secret_code[index]
                answer.push("B")
            elsif @secret_code.include?(guess[index])
                answer.push("W")
            else
                answer.push(" ")
            end
        }
        return @config.shuffle_answer ? answer.shuffle() : answer
    end
end