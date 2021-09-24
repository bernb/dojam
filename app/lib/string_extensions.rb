module StringExtensions
  # Original signature of the method:
  # humanize(capitalize: true, keep_id_suffix: false)
  def humanize(capitalize: false, keep_id_suffix: false)
    super(capitalize: capitalize, keep_id_suffix: keep_id_suffix)
  end

  # Add a downcase parameter, as we want downcase most of the time even for titles
  def titleize(keep_id_suffix: false, downcase: true)
    result = super(keep_id_suffix: keep_id_suffix)
    if downcase
      result.downcase
    else
      result
    end
  end
end

class String
    prepend StringExtensions
end