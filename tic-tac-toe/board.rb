class Board
    def initialize()
        @board = Array.new(3) { Array.new(3) }
    end

    def valid_move?(row, col)
        return !@board[row][col]
    end

    def place_move(symbol, row, col)
        @board[row][col] = symbol
        self.print_board()
    end

    def player_won?(symbol, row, col)
        won = @board[row].all? { |cell| cell == symbol } || @board.all? { |row| row[col] == symbol }
        if !won and (row == 1 and col == 1)
            won = (@board[0][0] == symbol and @board[2][2] == symbol) || (@board[0][2] == symbol and @board[2][0] == symbol)
        end
        return won
    end

    private

    def print_board()
        @board.each { |row| puts "| #{row.map { |cell| cell || " " }.join(" | ")} |" }
    end
end