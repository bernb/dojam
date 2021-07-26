module StringExtensions
  def humanize(capitalize: false, keep_id_suffix: false)
    super(capitalize: capitalize, keep_id_suffix: keep_id_suffix)
  end

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