require_relative "node"

class LinkedList
    def initialize()
        @head = nil
        @tail = nil
        @size = 0
    end

    def append(value)
        new_node = Node.new(value)
        if @tail != nil
            self.tail.set_next(new_node)
        else
            @head = new_node
        end
        @tail = new_node
        @size += 1
    end

    def prepend(value)
        new_node = Node.new(value)
        if @head != nil
            new_node.set_next(@head)
        else
            @tail = new_node
        end
        @head = new_node
        @size += 1
    end

    def size()
        return @size
    end

    def head()
        return @head
    end

    def tail()
        return @tail
    end

    def at(index)
        curr = @head
        while index > 0 && curr != nil
            curr = curr.next
            index -= 1
        end
        return curr
    end

    def pop()
        if @head != nil
            old_tail = @tail
            new_tail = @head

            while new_tail.next != nil && new_tail.next != @tail
                new_tail = new_tail.next
            end

            if new_tail == old_tail
                @head = nil
                @tail = nil
                @size = 0
            else
                @tail = new_tail
                new_tail.set_next(nil)
                @size -= 1
            end
            
            return old_tail
        end
    end

    def find(value)
        curr = @head
        while curr != nil
            if curr.value == value
                break
            end
            curr = curr.next
        end
        return curr
    end

    def contains?(value)
        node = self.find(value)
        return node != nil
    end

    def to_s()
        values = []
        curr = @head
        while curr != nil
            values.append("( #{curr.value} )")
            curr = curr.next
        end
        values.append("nil")
        puts values.join(" -> ")
    end

    def insert_at(value, index)
        if index > @size
            throw "index cannot be larger than the size of the linked list"
        elsif index == 0
            self.prepend(value)
        elsif index == @size
            self.append(value)
        else
            new_node = Node.new(value)
            curr = @head
            while index > 1
                curr = curr.next
                index -= 1
            end
            new_node.set_next(curr.next)
            curr.set_next(new_node)
            @size += 1
        end
    end

    def remove_at(index)
        if index > @size
            throw "index cannot be larger than the size of the linked list"
        elsif index == 0
            if @head == @tail
                @tail = @tail.next
            end
            @head = @head.next
        else
            prev = @head
            while index > 1
                prev = prev.next
                index -= 1
            end
            prev.next = prev.next.next
            if prev.next.next == nil
                @tail = prev.next
            end
        end
        @size -= 1
    end
end