class Tokenizer

  def self.text(text, lower=false)
    tokens = text.gsub(/[^a-zA-Z0-9 - ' _]/, "")
    tokens.downcase! if lower
    return tokens.split(' ')
  end

  def self.punctuation(text, lower=false)
    # '.' represents all full stops
    tokens = text.gsub(/[^a-zA-Z0-9 - . ! ? ' _]/, "").gsub(/\!|\?/, ".")
    tokens.downcase! if lower
    return tokens.split(' ')
  end

end
