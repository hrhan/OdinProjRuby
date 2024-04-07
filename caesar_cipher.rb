def caesar_cipher(string, shift)
    chars = string.split("")
    return chars.map{ |char| caesar_cipher_char(char, shift) }.join("")
end

def caesar_cipher_char(char, shift)
    char_ord = char.ord
    if char_ord >= 'a'.ord && char_ord <= 'z'.ord
        char_ord = ((char_ord - 'a'.ord + shift) % 26) + 'a'.ord
    elsif char_ord >= 'A'.ord && char_ord <= "Z".ord
        char_ord = ((char_ord - 'A'.ord + shift) % 26) + 'A'.ord
    end
    return char_ord.chr
end

puts caesar_cipher("What a string!", 5)