require File.join(File.dirname(__FILE__), "..", "spec_helper")

class ConfectionSampleA < Confection
  def content
    a "Hello"
    p "What's up"
    h1 do 
      text "This is a title"
    end
  end
end

describe ConfectionSampleA do
  it "should render the correct html" do
    ConfectionSampleA.new.render.should == "<html><head></head><body><a>Hello</a><p>What's up</p><h1>This is a title</h1></body></html>"
  end
end

class ConfectionSampleB < Confection
  def page_head
    title "Confection Sample"
  end
  
  def content
    a do
      text "Hello"
    end
    p do
      text "What's up"
    end
    h1 do 
      text "This is a title"
    end
  end
end

describe ConfectionSampleB do
  it "should render the correct html" do
    ConfectionSampleB.new.render.should == "<html><head><title>Confection Sample</title></head><body><a>Hello</a><p>What's up</p><h1>This is a title</h1></body></html>"    
  end
end

class ConfectionSampleC < Confection
  def page_head
    title "Gorgeous Georges Candy Heaven"
  end
  
  def content
    a "Linkage", :href => "http://www.google.com/"
    a :href => "http://www.yahoo.com/", :class => "old_link" do
      text "Dinosaur"
    end
  end
end

describe ConfectionSampleC do
  it "should render the correct html" do
    ConfectionSampleC.new.render.should == "<html><head><title>Gorgeous Georges Candy Heaven</title></head><body><a href=\"http://www.google.com/\">Linkage</a><a class=\"old_link\" href=\"http://www.yahoo.com/\">Dinosaur</a></body></html>"
  end
end