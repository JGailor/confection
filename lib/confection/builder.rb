class Confection
  module Builder    
    def element(name, options = {}, &block)
      @output += "<#{name}#{" #{options.collect{|key, val| "#{key}=\"#{val.is_a?(Array) ? val.join(" ") : val}\""}.join(" ")}" if options.size > 0}>"
      yield block if block
      @output += "</#{name}>"
    end
  
    def text(value)
      @output += value
    end
    
    def p(*args, &block)
      method_missing(:p, *args, &block)
    end
    
    def widget(type, instance_vars = {})
      @output += type.new.render(instance_vars)
    end
  
    def method_missing(method, *args, &block)    
      if(args.size == 0)
        element(method.to_s, &block)
      elsif(args.size == 1)
        args.first.is_a?(String) ? element(method.to_s) {text args.first} : element(method.to_s, args.first, &block)
      elsif(args.size == 2 && args.first.is_a?(String) && args.last.is_a?(Hash) && !block_given?)
        element(method.to_s, args.last) {text args.first}
      end
    end
  end
end