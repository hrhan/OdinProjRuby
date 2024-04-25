require_relative "config"
require_relative "mastermind"
require_relative "session"

def print_menu()
    puts "\nPlease enter \'play\' to start the game and \'quit\' or \'exit\' to stop playing."
    puts "To change the game config, please enter \'config\'"
end

def select_mode()
    puts "\nPlease select one of the following modes:"
    puts "1) easy       4 possible colours, each colour appears only once, answer is not shuffled"
    puts "2) normal     4 possible colours, each colour can appear 0-2 times, answer is shuffled"
    puts "3) hard       6 possible colours, each colour can appear 0-4 times, answer is shuffled"
    puts "4) custom     custom settings"

    choice = gets.chomp.downcase
    while true
        case choice
        when "1", "easy"
            puts "Easy mode selected"
            return {
            max_num_repeat: 1,
            num_colours: 4,
            shuffle_answer: false
            }
        when "2", "normal"
            puts "Normal mode selected"
            return {
                max_num_repeat: 2,
                num_colours: 4,
                shuffle_answer: true
            }
        when "3", "hard"
            puts "Hard mode selected"
            return {
                max_num_repeat: 4,
                num_colours: 6,
                shuffle_answer: true
            }
        when "4", "custom"
            puts "Custom mode selected"
            return select_custom_mode()
        else
            puts "Invalid mode selected. Please choose one of the 4 available modes."
            choice = gets.chomp.downcase
        end
    end
end

def select_custom_mode()
    puts "Select number of colours to use (min 4, max 6):"
    num_colours = gets.chomp.to_i
    while num_colours < 4 || num_colours > 6
        puts "Invalid number provided. Please select a number between 4 and 6"
        num_colours = gets.chomp.to_i
    end

    puts "Select max number of times a colour can repeat (min 1, max 4):"
    max_num_repeat = gets.chomp.to_i
    while max_num_repeat < 1 || max_num_repeat > 4
        puts "Invalid number provided. Please select a number between 1 and 4"
        max_num_repeat = gets.chomp.to_i
    end

    puts "Select if the mastermind should shuffle the answer (y/n):"
    shuffle_answer = gets.chomp
    while !["y", "n"].include?(shuffle_answer)
        puts "Invalid answer provided. Please select y or n"
        shuffle_answer = gets.chomp
    end

    return {
        max_num_repeat: max_num_repeat,
        num_colours: num_colours,
        shuffle_answer: shuffle_answer == "y"
    }
end

def change_config(config)
    mode = select_mode()
    config.update_config(mode[:max_num_repeat], mode[:num_colours], mode[:shuffle_answer])
end

## Start game script
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
        change_config(config)
    elsif selected == "quit" || selected == "exit"
        puts "Thanks for playing!"
        break
    end
end



