def first_anagram(str1, str2)
  anagrams(str1).include?(str2)
end

def anagrams(str)
  return [str] if str.length == 1
  prev_anagrams = anagrams(str[0...-1])

  list = []
  prev_anagrams.each do |anagram|
    (anagram.length + 1).times do |idx|
      word = anagram.dup
      list << word.insert(idx, str[-1])
    end
  end
  list.uniq
end

# puts "Anagram phase 2 n^3 "
def second_anagram(str1, str2)
 str1.chars.each do |char1|
   str2.chars.each do |char2|
     if char1 == char2
       str1.sub!(char1, "")
       str2.sub!(char1, "")
     end
   end
 end
 str1.empty? && str2.empty?
end

def second_anagram(str1, str2) # O(n ** 2)
 str1.chars.each do |char1|
   idx = str2.find_index(char1)
   str2.delete_at(idx)
  #  str2.chars.each do |char2|
  #    if char1 == char2
  #      str1.sub!(char1, "")
  #      str2.sub!(char1, "")
  #    end
  #  end
 end
 str2.chars.each do |char1|
   idx = str1.find_index(char1)
   str1.delete_at(idx)
  #  str2.chars.each do |char2|
  #    if char1 == char2
  #      str1.sub!(char1, "")
  #      str2.sub!(char1, "")
  #    end
  #  end
 end
 str1.empty? && str2.empty?
end

# nlog(n)
def third_anagram(str1, str2)
  sorted1 = str1.chars.sort
  sorted2 = str2.chars.sort
  sorted1 == sorted2
end

def fourth_anagram(str1, str2) #O n
  hash = Hash.new { |hash, key| hash[key] = 0 }
  str1.chars.each_with_index do |char1, idx|
    hash[char1] += 1
    hash[str2[idx]] -= 1
  end
  hash.values.all?(&:zero?)
end

p fourth_anagram("elvis", "lives")
p fourth_anagram("cat", "tax")
