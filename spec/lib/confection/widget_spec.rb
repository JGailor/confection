require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

describe Confection::Widget do
  it "should inherit from Confection" do
    Confection::Widget.ancestors.should include(Confection)
  end
  
  describe "render" do
    it "should call #content and return the html built in the object" do
      widget = Confection::Widget.new
      widget.stub!(:content).and_return("<p>Hello Sucka!</p>")
      widget.should_receive(:content)
      widget.render.should == "<p>Hello Sucka!</p>"
    end
  end
end