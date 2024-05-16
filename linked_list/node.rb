class Node
    attr_reader :value, :next

    def initialize(value, next_node=nil)
        @value = value
        @next = next_node
    end

    def set_next(node)
        @next = node
    end
end