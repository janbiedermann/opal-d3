module D3
  class OrdinalScale
    include D3::Native

    def call(t)
      @native.call(t)
    end
    attributes_d3 %i[domain range]
    alias_native_new :copy

    # D3 is trying to reinvent Ruby symbols here
    def unknown(new_value=nil)
      if new_value == nil
        v = @native.JS.unknown
        if `JSON.stringify(v) === '{"name":"implicit"}'`
          :implicit
        else
          v
        end
      else
        if new_value == :implicit
          new_value = `window.d3.scaleImplicit`
        end
        @native.JS.unknown(new_value)
        self
      end
    end
  end

  class << self
    def scale_ordinal(*args)
      D3::OrdinalScale.new @d3.JS.scaleOrdinal(*args)
    end

    def scale_implicit
      :implicit
    end
  end
end
