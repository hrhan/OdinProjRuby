class Config
    attr_reader :max_num_repeat, :colours, :shuffle_answer

    def initialize(max_num_repeat, num_colours, shuffle_answer)
        self.update_config(max_num_repeat, num_colours, shuffle_answer)
    end

    def update_config(max_num_repeat, num_colours, shuffle_answer)
        @max_num_repeat = max_num_repeat
        @colours = AVAILABLE_COLOURS[0, num_colours]
        @shuffle_answer = shuffle_answer
    end

    private 
    AVAILABLE_COLOURS = ["red", "yellow", "green", "blue", "purple", "orange"]
end