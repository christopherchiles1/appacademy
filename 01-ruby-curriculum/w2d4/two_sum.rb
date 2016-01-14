# O(n^2)
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |val, start_idx|
    (0..arr.length - start_idx).times do |delta|
      sum = val + arr[start_idx + delta]
      return true if sum == target_sum
    end
  end
  false
end

# O(nln(n))
def okay_two_sum?(arr, target_sum)
  search_arr = arr.map { |el| target_sum - el }
  search_arr.any? do |val|
    arr.bsearch { |x| val == x}
  end
end

# O(n)
def pair_sum(arr, target_sum)
  hash = Hash.new { |hash, key| hash[key] = false }
  arr.map do |el|
    hash[el] = true
    return true if hash[target_sum - el]
  end
  false
end

arr = [0, 1, 5, 7]
p two_sum?(arr, 6) # => should be true
p two_sum?(arr, 10) # => should be false
