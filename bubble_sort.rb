def bubble_sort(nums)
    n = nums.length
    loop do
        swapped = false
        for i in 1..n-1
            if nums[i-1] > nums[i]
                nums[i-1], nums[i] = nums[i], nums[i-1]
                swapped = true
            end
        end
        n = n-1
        if !swapped
            break
        end
    end
    return nums
end