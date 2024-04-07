def stock_picker(prices)
    min_price_index = 0
    max_price_index = 0
    max_profit = 0
    ans = [0, 0]
    prices.each_with_index do | price, index |
        profit = price - prices[min_price_index]
        if price < prices[min_price_index]
            min_price_index = index
        elsif profit > max_profit
            max_price_index = index
            max_profit = profit
            ans = [min_price_index, max_price_index]
        end
    end

    return ans
end