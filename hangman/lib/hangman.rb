require 'json'

SAVE_FILE_NAME = ".hangman_save"
HANGMAN = ["head", "neck", "left arm", "torso", "right arm", "left leg", "right leg"]

def load_words()
    dict = File.readlines("google-10000-english-no-swears.txt", chomp: true)
    return dict.select { |word| word.length >= 5 && word.length <= 12 }
end

def display_current_guess(guess)
    puts guess.join(" ")
end

def display_hangman(remaining_tries)
    if remaining_tries < HANGMAN.length
        puts "Hangman:"
        HANGMAN[0..(HANGMAN.length - remaining_tries - 1)].each { |part| puts "\t#{part}" }
    end
end

def update_guess(word, guess, letter)
    word.chars.each_index do |index|
        if word[index] == letter
            guess[index] = letter
        end
    end
end

def valid_choice?(choice)
    return choice.match?(/^[a-z]{1}$/)
end

def save_game(word, guess, remaining_tries)
    content_to_save = JSON.dump({
        :word => word,
        :guess => guess,
        :remaining_tries => remaining_tries
    })
    File.write(SAVE_FILE_NAME, content_to_save)
end

def read_save_file()
    file = File.read(SAVE_FILE_NAME)
    data = JSON.parse(file)
    File.write(SAVE_FILE_NAME, "")
    return data["word"], data["guess"], data["remaining_tries"]
end

def play_game(word, guess, remaining_tries = HANGMAN.length)
    puts "Secret word has been selected:"
    display_current_guess(guess)

    while remaining_tries > 0
        puts "Guess a letter!"
        puts "(You can enter 'save' to save the current game or 'quit' to exit the current game.)"
        choice = gets.chomp.downcase
        if choice == "save"
            save_game(word, guess, remaining_tries)
            puts "Your game has been successfully saved."
        elsif choice == "quit"
            puts "Are you sure you want to quit the current game? (y/n)"
            ans = gets.chomp.downcase
            if ans == "y"
                break
            end
        elsif valid_choice?(choice)
            if word.include?(choice)
                update_guess(word, guess, choice)
            else
                remaining_tries -= 1
            end
            if !guess.include?("_")
                puts "You guessed the word! It's #{word}."
                break
            end
        end
        display_current_guess(guess)
        display_hangman(remaining_tries)
    end

    if remaining_tries == 0
        puts "No more tries left!"
        puts "The word was: #{word}"
    end
end

dict = load_words()

while true
    puts "Enter 'play' to start a new game, 'resume' to load a previously saved game and 'quit' to stop playing."
    choice = gets.chomp.downcase
    case choice
    when "play"
        word = dict.sample.downcase
        guess = ["_"] * word.length
        play_game(word, guess)
    when "resume"
        if File.exist?(SAVE_FILE_NAME) && !File.empty?(SAVE_FILE_NAME)
            word, guess, remaining_tries = read_save_file()
            play_game(word, guess, remaining_tries)
        else
            puts "Save file not found. Please start a new game."
        end
    when "quit"
        puts "Thanks for playing!"
        break
    end
end