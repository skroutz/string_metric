# coding: utf-8

module StringMetric
  module Levenshtein
    class TrieNode
      attr_accessor :word, :children

      def initialize
        @word = nil
        @children = {}
      end

      def insert(word)
        node = self
        word.codepoints.each do |char|
          node.children[char] = TrieNode.new unless node.children.key?(char)
          node = node.children[char]
        end
        node.word = word
      end
    end
  end
end
