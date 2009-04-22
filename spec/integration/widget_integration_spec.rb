require File.join(File.dirname(__FILE__), "..", "spec_helper")

class WidgetIntegrationSpec
  class WelcomeWidget < Confection::Widget
    def content
      p "Welcome to the show"
    end
  end

  class ConfectionSampleA < Confection
    def content
      widget WelcomeWidget
      widget WelcomeWidget
    end
  end
  
  class FooterWidget < Confection::Widget
    def content
      p @message
    end
  end

  class ConfectionSampleB < Confection
    def content
      widget FooterWidget, :message => "This is a footer"
    end
  end
end

describe WidgetIntegrationSpec::ConfectionSampleA do
  it "should render the html correctly by including the widget into the html stream" do
    WidgetIntegrationSpec::ConfectionSampleA.new.render.should == "<html><head></head><body><p>Welcome to the show</p><p>Welcome to the show</p></body></html>"
  end
end

describe WidgetIntegrationSpec::ConfectionSampleB do
  it "should render the html correctly by including the widget and setting its instance variables" do
    WidgetIntegrationSpec::ConfectionSampleB.new.render.should == "<html><head></head><body><p>This is a footer</p></body></html>"
  end
end