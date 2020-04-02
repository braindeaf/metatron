module Metatron
  class Builder
    def assign(hash = {})
      hash.each do |k, v|
        send("#{k}=", v)
      end
      self
    end

    def to_h
      Hash[instance_variables.map { |name| [name, instance_variable_get(name)] } ]
    end

    def method_missing(method, *args)
      if method[-1] == '=' && args.size == 1
        return instance_variable_set("@#{method[0..-2]}", args[0])
      end
      if args.size == 0
        if r = instance_variable_get("@#{method}")
          return r
        else
          t = I18n.t("meta.#{method}", default: '')
          return t.present? ? t : nil
        end
      end
      super
    end
  end
end
