require 'spec_helper'

describe AddDefaultScheme do
  class DummySuperClass
    attr_accessor :url, :imageUrl
  end

  class DummyClass < DummySuperClass
    extend AddDefaultScheme
  end

  describe "add_default_scheme" do
    it "should create setters setting a default scheme when none is present" do
      DummyClass.send(:add_default_scheme, :url)

      dumb = DummyClass.new
      dumb.url = "url-without-a-scheme.com"
      dumb.url.should eq("http://url-without-a-scheme.com")
    end

    it "should set a specific scheme if specified" do
      DummyClass.send(:add_default_scheme, :url, :default_scheme => "https")

      dumb = DummyClass.new
      dumb.url = "url-without-a-scheme.com"
      dumb.url.should eq("https://url-without-a-scheme.com")
    end

    it "should allow for multiple uri fields being specified at once" do
      DummyClass.send(:add_default_scheme, :url, :imageUrl)

      dumb = DummyClass.new
      dumb.imageUrl = "url-without-a-scheme.com"
      dumb.imageUrl.should eq("http://url-without-a-scheme.com")
    end

    it "should not do anything when provided with a specified scheme" do
      DummyClass.send(:add_default_scheme, :url)

      dumb = DummyClass.new
      dumb.url = "ftp://url-with-a-scheme.com"
      dumb.url.should eq("ftp://url-with-a-scheme.com")
    end

    it "should not do anything when provided an invalid URI" do
      DummyClass.send(:add_default_scheme, :url)

      dumb = DummyClass.new
      dumb.url = "invalid uri"
      dumb.url.should eq("invalid uri")
    end
  end
end
