require 'string_metric'
require 'benchmark'
require 'pp'

Benchmark.bmbm(7) do |x|
  options = {}
  max_distance = 2

  dict = []
  trie = StringMetric::Levenshtein::TrieNode.new
  File.open('/usr/share/dict/words', 'r').each_line do |line|
    word = line.chomp
    trie.insert(word)
    dict << word
  end

  randomWords = []
  File.open('spec/fixtures/dictionary_input.txt', 'r').each_line do |word|
    randomWords << word.chomp
  end

  matrixResults = []
  x.report("two_matrix_rows_v2 implementation") do
    randomWords.each do |from|
      dict.each do |to|
        matrixResults << to if StringMetric::Levenshtein::IterativeWithTwoMatrixRowsOptimized.distance(from, to, options) <= max_distance
      end
    end
  end

  trieResults = []
  x.report("trie_radix_tree implementation") do
    randomWords.each do |from|
      trieResults << StringMetric::Levenshtein::TrieRadixTree.distance(from, trie, max_distance: max_distance)
    end
  end

  trieResultsExt = []
  x.report("trie_radix_tree_ext implementation") do
    randomWords.each do |from|
      trieResultsExt << StringMetric::Levenshtein::TrieRadixTreeExt.distance(from, trie, max_distance: max_distance)
    end
  end
end
