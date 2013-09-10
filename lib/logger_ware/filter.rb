module LoggerWare
  module Filter
    REPLACE_WITH = '[FILTERED]'

    def match?(param, f)
      if f.is_a?(Regexp)
        !!(param.to_s =~ f)
      else
        param.to_s == f.to_s
      end
    end

    def filter?(param, filters)
      filters.each { |f| return true if match?(param, f) }
      false
    end

    def filter(params, filters, replace_with = REPLACE_WITH)
      params.each_with_object({}) do |(k,v), res|
        v = filter(v, filters, replace_with) if v.is_a?(Hash)
        res[k] = filter?(k, filters) ? replace_with : v
      end
    end
  end
end
