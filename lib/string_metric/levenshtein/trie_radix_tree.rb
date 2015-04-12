# coding: utf-8

module StringMetric
  module Levenshtein
    class TrieRadixTree
      def self.distance(from, node, options = {})

        @max_distance      = options[:max_distance]      || 0
        @insertion_cost    = options[:insertion_cost]    || 1
        @deletion_cost     = options[:deletion_cost]     || 1
        @substitution_cost = options[:substitution_cost] || 1

        results = []
        word = from.codepoints
        currentRow = (0..word.length).to_a

        node.children.keys.each do |letter|
          searchRecursive(node.children[letter], letter, word, currentRow, results)
        end

        results
      end

      def self.searchRecursive(node, letter, word, previousRow, results)
        columns = word.length + 1
        currentRow = [previousRow[0] + 1]

        (1...columns).each do |column|
          insertCost = currentRow[column - 1] + @insertion_cost
          deleteCost = previousRow[column] + @deletion_cost
          cost = (word[column - 1] == letter) ? 0 : @substitution_cost
          replaceCost = previousRow[column - 1] + cost

          currentRow << [insertCost, deleteCost, replaceCost].min
        end

        if currentRow.last <= @max_distance && !node.word.nil?
          results << [node.word, currentRow.last]
        end

        if currentRow.min <= @max_distance
          node.children.keys.each do |letter|
            searchRecursive(node.children[letter], letter, word, currentRow, results)
          end
        end
      end
    end
  end
end
