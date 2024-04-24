class Config
    attr_reader :max_num_repeat, :colours, :shuffle_answer

    def initialize(max_num_repeat, num_colours, shuffle_answer)
        @max_num_repeat = max_num_repeat
        @colours = AVAILABLE_COLOURS[0, num_colours]
        @shuffle_answer = shuffle_answer
    end

    def update_config(max_num_repeat, num_colours, shuffle_answer)
        is_config_valid, errors = config_valid?(max_num_repeat, num_colours, shuffle_answer)
        if is_config_valid
            @max_num_repeat = max_num_repeat
            @colours = AVAILABLE_COLOURS[0, num_colours]
            @shuffle_answer = shuffle_answer
        else
            puts "Configuration could not be updated because the provided configuration is invalid: "
            errors.each { |error| puts "\t - #{error}" }
        end
    end

    private 
    
    AVAILABLE_COLOURS = ["red", "yellow", "green", "blue", "purple", "orange"]

    def config_valid?(max_num_repeat, num_colours, shuffle_answer)
        is_config_valid = true
        errors = []
        if max_num_repeat < 1 or max_num_repeat > 4
            errors.push("Max number of times a colour can be repeated must be between 1 and 4")
            is_config_valid = false
        end
        if num_colours < 4 or num_colours > 6
            errors.push("Possible number of colours must be between 4 and 6")
            is_config_valid = false
        end
        if ![true, false].include?(shuffle_answer)
            errors.push("Whether to shuffle answer must be either true or false")
            is_config_valid = false
        end
        return is_config_valid, errors
    end
end