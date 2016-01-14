class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    map.with_index do |el, idx|
      el.hash ** (idx + 1)
    end.inject(:^).hash
  end
end

class String
  def hash
    chars.map do |char|
      char.ord
    end.hash
  end
end

class Hash
  def hash
    keys.inject([]) do |acc, key|
      acc << [key.to_s, self[key]]
    end.sort.flatten.hash
  end
end
