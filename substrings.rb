def substrings(str, dict)
    res = Hash.new(0)
    str_dc = str.downcase
    dict.each do | word |
        word_dc = word.downcase
        if str_dc.include? word_dc
            res[word_dc] = str_dc.scan(word_dc).length
        end
    end
    return res
end