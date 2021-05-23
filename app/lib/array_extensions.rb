class Array
  def sort_termlist
    self.sort do |a, b|
      if a == 'undetermined'
        1
      elsif b == 'undetermined'
        -1
      else
        a <=> b
      end
    end
  end
end