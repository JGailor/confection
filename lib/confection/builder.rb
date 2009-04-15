class Confection::Builder
  def element(name, options = {}, &block)
    html = ["<#{name}#{" #{options.collect{|key, val| "#{key}=\"#{val.is_a?(Array) ? val.join(" ") : val}\""}.join(" ")}" if options.size > 0}>"]
    html << (yield block) if block
    html << "</#{name}>"
    html.join("")
  end
end