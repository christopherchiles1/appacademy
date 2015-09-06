require "set"

class WordChainer
  def initialize(dictionary_file_name)
    words = File.readlines(dictionary_file_name).map!(&:chomp)
    @dictionary = Set.new(words)
  end

  def adjacent_words(current_word)
    @dictionary.select { |word| is_close?(current_word, word) }
  end

  def is_close?(word1, word2)
    if word1.length != word2.length
      return false
    end
    chars1, chars2 = word1.chars, word2.chars
    pairs = chars1.zip(chars2)

    my_count = 0
    pairs.each do |pair|
      my_count += 1 if pair.first != pair.last
    end

    my_count == 1
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}

    until @current_words.empty? || @all_seen_words.include?(target)
      new_current_words = explore_current_words
      @current_words = new_current_words
    end
    puts "-----------------"
    puts build_path(target)
  end

  def explore_current_words
    new_current_words = []
    @current_words.each do |word|
      adjacent_words = adjacent_words(word)
      new_adjacent_words = adjacent_words.select do |close_word|
        !@all_seen_words.include?(close_word)
      end
      new_current_words += new_adjacent_words
      new_adjacent_words.each do |adjacent_word|
        @all_seen_words[adjacent_word] = word
      end
    end
    new_current_words.each do |new_word|
      puts "#{new_word}, #{@all_seen_words[new_word]}"
    end
  end

  def build_path(target)
    path = []
    if @all_seen_words.include?(target)
      path << target
      previous_word = target
      until @all_seen_words[previous_word].nil?
        previous_word = @all_seen_words[previous_word]
        path << previous_word
      end
    end
    path
  end

end

if __FILE__ == $PROGRAM_NAME
  WordChainer.new("dictionary.txt").run("ruby", "duck")

end
