# coding: utf-8

require_relative 'trie_radix_tree_ext.so'

module StringMetric
  module Levenshtein
    class TrieRadixTreeExt
      def self.distance(from, trieNode, options = {})

        max_distance      = options[:max_distance]      || 0
        insertion_cost    = options[:insertion_cost]    || 1
        deletion_cost     = options[:deletion_cost]     || 1
        substitution_cost = options[:substitution_cost] || 1

        trie_ext(from.codepoints, from.length, trieNode, max_distance,
                 insertion_cost, deletion_cost, substitution_cost)
      end
    end
  end
end
