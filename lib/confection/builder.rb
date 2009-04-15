class Confection::Builder
  attr_reader :output
  
  def initialize
    @output = ""
  end
  
  def element(name, options = {}, &block)
    @output += "<#{name}#{" #{options.collect{|key, val| "#{key}=\"#{val.is_a?(Array) ? val.join(" ") : val}\""}.join(" ")}" if options.size > 0}>"
    yield block if block
    @output += "</#{name}>"
  end
  
  def text(value)
    @output += value
  end
  
  def method_missing(method, *args, &block)    
    if(args.size == 0)
      element(method.to_s)
    elsif(args.size == 1)
      element(method.to_s, args[0], &block)
    end
  end
end