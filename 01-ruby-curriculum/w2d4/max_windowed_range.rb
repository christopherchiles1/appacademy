#O n^2
def windowed_max_range(arr, window)
  current_max_range = nil
  num_windows = arr.length - window + 1
  num_windows.times do |start_idx|
    range = arr[start_idx...start_idx + window]
    current_range = range.max - range.min
    if current_max_range.nil? || (current_range > current_max_range)
      current_max_range = current_range
    end
  end
  p current_max_range
end

def optimized_max_range(arr, window)

end
#
# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
