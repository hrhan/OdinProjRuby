require_relative "game"

def print_menu()
    puts "Please enter \'play\' to start the game and enter \'quit\' or \'exit\' to stop playing."
    puts "Enter \'scores\' to see the current scoreboard."
end

scores = { :X => 0, :O => 0 }

while true
    print_menu()
    selected = gets.chomp
    if selected == "play"
        game = Game.new
        winner = game.start_game()
        if winner
            scores[winner] += 1
        end
    elsif selected == "scores"
        puts "**SCOREBOARD**"
        scores.each { |player, score| puts "#{player}: #{score}" }
        puts "\n"
    elsif selected == "quit" || selected == "exit"
        break
    end
end



