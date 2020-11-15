module I18nHelper
  def translate(key, options={})
    if key == ""
      return ""
    end
    super(key, options.merge(raise: true))
  rescue I18n::MissingTranslationData
    key
  end
  alias :t :translate
end