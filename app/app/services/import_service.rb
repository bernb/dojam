class ImportService
  def initialize(typename:, files:)
    @typename = typename
    @files = files
  end

  def import
    @files.each do |file|
      next unless valid?(file)
      write(file)
    end
  end

  private
  def valid?(file)
    return correct_type?(file) && correct_format?(file)
  end

  def correct_type?(file)

  end

  def correct_format?(file)

  end

  def write(file)

  end
end