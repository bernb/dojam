class EnvironmentChecker
  def self.is_staging?
    ENV['DOJAM_STAGING'] == 'true'
  end
end
