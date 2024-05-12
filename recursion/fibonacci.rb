class Fibonacci
    def self.fibs(num)
        result = [0, 1]
        while result.length < num do
            i = result.length
            result << result[i-2] + result[i-1]
        end
        return result[0, num]
    end

    def self.fibs_rec(num)
        result = [0, 1]
        self.fibs_rec_helper(num, result)
        return result[0, num]
    end

    def self.fibs_rec_helper(num, arr)
        if num < 2
            return arr[num]
        else
            res = self.fibs_rec_helper(num-2, arr) + self.fibs_rec_helper(num-1, arr)
            if arr.length < num + 1
                arr << res
            end
            return res
        end
    end
end