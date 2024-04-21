require_relative "board"

class Game
    def initialize()
        @board = Board.new
        @player1 = :X
        @player2 = :O
    end

    def start_game()
        for turn in 0..8 do
            if turn % 2 == 0
                player = @player1
            else
                player = @player2
            end
            puts "\n#{player}\'s turn"

            valid_move = false
            while !valid_move
                row, col = self.get_next_move()
                valid_move = @board.valid_move?(row, col)
                if !valid_move
                    puts "Selected tile is already occupied. Please select a different tile."
                end
            end
           
            @board.place_move(player, row, col)
            if @board.player_won?(player, row, col)
                puts "***#{player} won!***\n\n"
                return player
            end
        end

        puts "***It's a draw!***\n\n"
    end

    private

    def get_next_move()
        row = -1
        col = -1
        while row < 1 or row > 3
            puts "Please select a row number between 1 and 3"
            row = gets.chomp.to_i
        end
        while col < 1 or col > 3
            puts "Please select a column number between 1 and 3"
            col = gets.chomp.to_i
        end
        return row - 1, col - 1
    end
end