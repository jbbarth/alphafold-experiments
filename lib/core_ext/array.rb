class Array
  # https://stackoverflow.com/a/30430066
  def diff(other)
    h = other.each_with_object(Hash.new(0)) { |e,h| h[e] += 1 }
    reject { |e| h[e] > 0 && h[e] -= 1 }
  end

  def full_diff(other)
    {
      added: self.diff(other),
      removed: other.diff(self),
    }
  end

  def frequency
    self.group_by(&:itself).transform_values(&:count)
  end
end
