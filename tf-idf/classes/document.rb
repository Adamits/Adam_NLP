# @tokens - All tokens of the document
# terms_and_tf_scores - returns a hash of term => term_frequency_score for each token

include TfIdf
class TfIdf::Document < TfIdf::Collection

	attr_reader :tokens

	def initialize(document)
		@document = document
		@tokens = tokenize
		@size = @tokens.length
	end

	def terms_and_tf_scores
		@tf_hash = Hash.new(0.0)
		# The amount of times a term appears
		# In the document divided by the total
		# Amount of tokens in the document.
		@tokens.each do |term|
			@tf_hash[term] += 1.0
		end
		@tf_hash
	end

	def size
		@size
	end

	private

	def tokenize
		tokens = @document.gsub(/[^a-zA-Z0-9 - ' _]/, "").downcase
		tokens.split(' ')
	end
end
