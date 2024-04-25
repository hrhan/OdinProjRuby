class Session
    def initialize(config, mastermind, num_turns: 12)
        @config = config
        @mastermind = mastermind
        @num_turns = num_turns
    end

    def start_session()
        puts "\nColours that can appear in this round: #{@config.colours.map { |colour| colour.capitalize }.join(" ")}"

        @mastermind.select_secret_code
        puts "\nMastermind has decided the secret code.. Think you can crack it in #{@num_turns} turns?"

        for turn in 1..@num_turns
            puts "\nTurn ##{turn}"

            guess = get_player_guess()
            if @mastermind.correct_guess?(guess)
                puts "\n**You guessed correctly!**"
                return
            else
                answer = @mastermind.compare_code(guess)
                puts "\nMastermind says: #{answer.join(",")}"
            end
        end
        puts "\n--Sorry, you didn't crack the secret code in #{@num_turns} turns--\n"
        @mastermind.reveal_secret_code
    end

    private

    def valid_option?(colour)
        return @config.colours.include?(colour)
    end

    def get_player_guess()
        guess = []
        while guess.length < 4
            puts "Please select colour ##{guess.length + 1}"
            colour = gets.chomp.downcase
            if !valid_option?(colour)
                puts "Please select one of: #{@config.colours.map { |colour| colour.capitalize }.join(" ")}"
            else
                guess << colour
            end
        end
        return guess
    end
end