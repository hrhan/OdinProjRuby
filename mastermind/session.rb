class Session
    def initialize(config, mastermind)
        @config = config
        @mastermind = mastermind
    end

    def start_session()
        @mastermind.select_secret_code

        for turn in 1..12
            guess = []
            for i in 1..4
                puts "guess color #{i}"
                guess << gets.chomp
                if !valid_option?(guess)
                    puts "invalid opton"
                end
            end
            if @mastermind.correct_guess?(guess)
                puts "you got it!"
                return
            else
                answer = @mastermind.compare_code(guess)
                puts answer
            end
        end
        puts "you didn't get it"
        @mastermind.reveal_secret_code
    end

    private

    def valid_option?(colour)
        return @config.colours.include?(colour.downcase)
    end
end