require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

class Confection::Builder::TestHelper
  def initialize
    @output = ""
  end
  
  include Confection::Builder
end

describe Confection::Builder do
  before(:each) do
    @builder = Confection::Builder::TestHelper.new
  end
  
  describe "element" do
    it "should build a self closing html element given the element name" do
      @builder.element("a").should == "<a></a>"
    end
    
    describe "building attributes from the options" do
      it "should work for a single option" do
        @builder.element("a", {:id => "home_page_link"}).should =~ /id="home_page_link"/
      end
      
      it "should work for two options" do
        html = @builder.element("a", {:id => "home_page_link", :class => "highlighted"})
        html.should =~ /id="home_page_link"/
        html.should =~ /class="highlighted"/
      end
      
      it "should unwrap an array for an option into a space delimited string" do
        @builder.element("p", {:class => ["a", "b", "c"]}).should =~ /class="a b c"/
      end
    end
    
    describe "block form" do
      describe "sub elements" do
        it "should build an html tree structure with the outer element wrapping the inner (1-level)" do
          @builder.element("a") do
            @builder.element("p")
          end.should == "<a><p></p></a>"
        end
        
        it "should build an html tree structure with the outer element wrapping the inner elements recursively (2-level)" do
          @builder.element("a") do
            @builder.element("p") do
              @builder.element("span")
            end
          end.should == "<a><p><span></span></p></a>"
        end
        
        it "should build an html tree structure with the outer element wrapping the inner elements recursively (n-level)" do
          @builder.element("a") do
            @builder.element("p") do
              @builder.element("span") do
                @builder.element("ul") do
                  @builder.element("li") do
                   @builder.element("span")
                  end
                end
              end
            end
          end.should == "<a><p><span><ul><li><span></span></li></ul></span></p></a>"
        end
      end
      
      describe "internal content" do
        it "should create a tag with internal text" do
          @builder.element("a") do
            @builder.text "This is some text"
          end.should == "<a>This is some text</a>"
        end
        
        it "should create a tag with internal text and a sub-element" do
          @builder.element("a") do
            @builder.text "This is some text"
            @builder.element("span")
          end.should == "<a>This is some text<span></span></a>"
        end
      end
    end
  end
  
  describe "#method_missing" do
    it "should create the element when method missing is triggered" do
      @builder.a.should == "<a></a>"
    end
    
    it "should create the element with the proper options when method missing is triggered" do
      output = @builder.a(:id => "test", :class => ["a", "b", "c"])
      output.should =~ /id="test"/
      output.should =~ /class="a b c"/
    end
    
    it "should create the element with the proper options and sub-elements when the method missing is triggered" do
      @builder.a(:id => "test") do
        @builder.p
      end.should == "<a id=\"test\"><p></p></a>"
    end
  end
end