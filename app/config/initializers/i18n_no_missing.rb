module I18n
  class ExceptionHandler
    def call(exception, _locale, _key, _options)
      if exception.is_a?(MissingTranslation)
        _key
      else
        raise exception
      end
    end
  end
end