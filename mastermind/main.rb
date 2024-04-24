require_relative "config"
require_relative "mastermind"
require_relative "session"

def print_menu()
    puts "Please enter \'play\' to start the game and enter \'quit\' or \'exit\' to stop playing."
end

def select_mode()
    puts "Please select one of the following modes"
    puts "1) easy: 4 possible colours, each colour appears only once, answer is not shuffled"
    puts "2) normal: 4 possible colours, each colour can appear 0-2 times, answer is shuffled"
    puts "3) hard: 6 possible colours, each colour can appear 0-4 times, answer is shuffled"

    mode = -1

    while !valid_mode?(mode)
        mode = gets.chomp.to_i
    end
    
    return mode
end

def valid_mode?(mode)
    return mode > 0 && mode < 4
end

mode = select_mode()

config = Config.new
mastermind = Mastermind.new(config)

while true
    print_menu()
    selected = gets.chomp
    if selected == "play"
        session = Session.new(config)
        session.start_session(mastermind)
    elsif selected == "quit" || selected == "exit"
        break
    end
end



