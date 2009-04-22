require File.join(File.dirname(__FILE__), "..", "confection")

class Confection::Widget < Confection
  def render(instance_vars = {})
    set_instance_variables(instance_vars)
    content
  end
end