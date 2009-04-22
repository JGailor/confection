require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Confection do
  describe "#render" do
    it "should call #page and return a string" do
      html_result = "<html><head><title>Test</title></head><body></body></html>"
      confection = Confection.new
      confection.stub!(:page).and_return(html_result)
      confection.should_receive(:page).and_return(html_result)
      confection.render
    end
    
    it "should allow a hash to be passed which creates instance variables from the keys set to the corresponding values" do
      confection = Confection.new
      confection.render(:var1 => 1, :var2 => 2)
      confection.instance_variable_get(:@var1).should == 1
      confection.instance_variable_get(:@var2).should == 2
    end
  end
  
  describe "#page" do
    it "should call #page_head and #page_body and return a string" do
      confection = Confection.new
      confection.stub!(:page_head)
      confection.stub!(:page_body)
      confection.should_receive(:page_head)
      confection.should_receive(:page_body)
      confection.send(:page)
    end
  end
  
  describe "#page_body" do
    it "should call #content" do
      confection = Confection.new
      confection.stub!(:content)     
      confection.should_receive(:content)
      confection.send(:page_body)
    end
  end
  
  describe "#content" do
    it "should respond to #content" do
      lambda{Confection.new.content}.should_not raise_error
    end
  end
  
  describe "Confection::Builder" do
    it "should mix-in Confection::Builder" do
      Confection.ancestors.should include(Confection::Builder)
    end
    
    it "should add the widget method" do
      Confection.new.methods.should include("widget")
    end
  end
end