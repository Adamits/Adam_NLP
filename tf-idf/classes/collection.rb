include TfIdf
class TfIdf::Collection
	# @idf_hash - A hash of terms and their idf scores
	#
	# Loop through all the terms from the tf_hash to calculace document frequency.
	# The rest of the idf calculation is done in a seperate loop so that
	# the Math does not need to run collection.quantity * terms_doc.quantity times.

	attr_reader :idf_hash

	def initialize(collection, tf_hash)
		@idf_hash = Hash.new(0.0)
		@collection = collection
		@size = @collection.length
		@tf_hash = tf_hash
	end

	# Loop through terms from tf_hash
	# And find the document frequency of each term
	def idf_hash
		sub_docs = tokenize_documents
		@tf_hash.each do |term, tf|
			sub_docs.each do |doc|
				if doc.include?(term)
					# Increment document frequency.
					@idf_hash[term] += 1.0
				end
			end
		end
		@idf_hash
	end

	def size
		@size
	end

	private
	# Returns a 2D array of all documents in the collection
	# And all tokens of the documents
	def tokenize_documents
		documents = []
		@collection.each do |document|
			document = TfIdf::Document.new(document)
			documents.push(document.tokens)
		end
		return documents
	end
end
