def caesar_cipher(string, shift)
    chars = string.split("")
    return chars.map{ |char| caesar_cipher_char(char, shift).chr }.join("")
end

def caesar_cipher_char(char, shift)
    if char.ord >= 'a'.ord && char.ord <= 'z'.ord
        return ((char.ord - 'a'.ord + shift) % 26) + 'a'.ord
    elsif char.ord >= 'A'.ord && char.ord <= "Z".ord
        return ((char.ord - 'A'.ord + shift) % 26) + 'A'.ord
    else
        return char
    end
end