# This is the public object that should be used in the website.
#
# Takes two params:
#
# document- the document to extract tags from.
# collection- the corpus of other documents to compare it to.
include TfIdf
class TfIdf::WeightedTags

	def initialize(collection, document)
		@terms_and_tf_idf_scores = get_weighted_tags(collection, document)
	end

	def all
		@terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse.to_h
	end

	def first(n = 1)
		@terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse[0...n].to_h
	end

	def tags(n = nil)
		n ? @terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse[0...n].to_h.keys : @terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse.to_h.keys
	end

	def weighted_scores(n = nil)
		n ? @terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse[0...n].to_h.values : @terms_and_tf_idf_scores.sort_by {|key, value| value}.reverse.to_h.values
	end

	private

	def get_weighted_tags(collection, document)
		tf_idf_hash = Hash.new(0.0)
		term_doc = TfIdf::Document.new(document)
		@tf_hash = term_doc.terms_and_tf_scores
		collection = TfIdf::Collection.new(collection, @tf_hash)
		@idf_hash = collection.idf_hash
		# Loop through all terms to finish calculations
		# On tf and idf, and finally get the tf_idf score
		doc_size = term_doc.size.to_f
		collection_size = collection.size.to_f
		@tf_hash.each do |term, tf_score|
			@idf_hash[term] = 1 if @idf_hash[term] == 0
			tf_score = tf_score / doc_size
			idf_score = Math.log(collection_size / @idf_hash[term])
			tf_idf_hash[term] = tf_score * idf_score
		end
		return tf_idf_hash
	end
end
