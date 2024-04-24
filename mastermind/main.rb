require_relative "config"
require_relative "mastermind"
require_relative "session"

def print_menu()
    puts "\nPlease enter \'play\' to start the game and enter \'quit\' or \'exit\' to stop playing."
    puts "To change the game config, please enter \'config\'"
end

def select_mode()
    puts "\nPlease select one of the following modes in numbers"
    puts "1) easy: 4 possible colours, each colour appears only once, answer is not shuffled"
    puts "2) normal: 4 possible colours, each colour can appear 0-2 times, answer is shuffled"
    puts "3) hard: 6 possible colours, each colour can appear 0-4 times, answer is shuffled"

    choice = -1

    while !valid_mode?(choice)
        choice = gets.chomp.to_i
    end

    modes = {
        1: {
            max_num_repeat: 1,
            num_colours: 4,
            shuffle_answer: false
        },
        2: {
            max_num_repeat: 2,
            num_colours: 4,
            shuffle_answer: true
        },
        3: {
            max_num_repeat: 4,
            num_colours: 6,
            shuffle_answer: true
        }
    }
    
    return modes[choice]
end

def valid_mode?(mode)
    return mode > 0 && mode < 4
end

mode = select_mode()

config = Config.new(mode[:max_num_repeat], mode[:num_colours], mode[:shuffle_answer])
mastermind = Mastermind.new(config)

while true
    print_menu()
    selected = gets.chomp.downcase
    if selected == "play"
        session = Session.new(config, mastermind)
        session.start_session
    elsif selected == "config"
        #config.update_config()
    elsif selected == "quit" || selected == "exit"
        break
    end
end



