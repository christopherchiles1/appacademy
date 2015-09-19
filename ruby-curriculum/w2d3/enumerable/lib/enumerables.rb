class Array
  def my_uniq
    uniques = []
    self.each do |el|
      uniques << el unless uniques.include?(el)
    end
    uniques
  end

  def two_sum
    two_sums = []
    each.with_index do |el, i|
      (i...length).each do |j|
        two_sums << [i, j] if el + self[j] == 0
      end
    end
    two_sums
  end
end
