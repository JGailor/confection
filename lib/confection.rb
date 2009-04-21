require File.join(File.dirname(__FILE__), "confection", "builder")

class Confection
  include Confection::Builder
  
  def initialize
    @output = ""
  end
  
  def render
    page
  end
  
  protected
    def page
      html do
        head do
          page_head
        end
        page_body
      end
    end
    
    def page_head
    end
    
    def page_body
      body do
        content
      end
    end
  
    def content
      # This needs to be over-ridden with the content of the page
    end
end