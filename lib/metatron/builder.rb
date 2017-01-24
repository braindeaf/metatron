module Metatron
  class Builder
    attr_accessor :title, :description

    def assign(hash = {})
      hash.each do |k, v|
        send("#{k}=", v)
      end
      self
    end
  end
end