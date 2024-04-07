def stock_picker(prices)
    min_price_indexes = [0]
    max_price_index = 0
    max_profit = 0
    prices.each_with_index do | price, index |
        min_price_index = min_price_indexes[-1]
        profit = price - prices[min_price_index]
        if price < prices[min_price_index]
            min_price_indexes.push(index)
        elsif profit > max_profit
            max_price_index = index
            max_profit = profit
        end
    end

    while !min_price_indexes.empty? && min_price_indexes[-1] > max_price_index do
        min_price_indexes.pop()
    end

    return [min_price_indexes[-1], max_price_index]
end