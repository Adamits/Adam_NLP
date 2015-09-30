require '../tokens/tokenizer.rb'

class Ngram
  def initialize(phrase)
    @phrase = phrase
  end

  def grams(n)
    @ngrams = tokenize.each_cons(n).to_a
  end

  def bigram_probabilities
    bigram_and_probability = {}
    bigrams = grams(2)
    bigrams.each do |bigram|
      bigram_and_probability[bigram] = (bigram_and_probability[bigram] ||= 0.0) + 1.0/bigrams.length
    end
    bigram_and_probability
  end

  private

  def tokenize
    Tokenizer.punctuation(@phrase, true)
  end
end
