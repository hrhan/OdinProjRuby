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
        if !won && (row + col) % 2 == 0
            diag1 = true
            diag2 = true
            for i in 0..2
                diag1 &&= @board[i][i] == symbol
                diag2 &&= @board[i][2-i] == symbol
            end
            won = diag1 || diag2
        end
        return won
    end

    private

    def print_board()
        @board.each { |row| puts "| #{row.map { |cell| cell || " " }.join(" | ")} |" }
    end
end