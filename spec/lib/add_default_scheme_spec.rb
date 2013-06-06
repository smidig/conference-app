require 'spec_helper'

describe AddDefaultScheme do
  describe "add_default_scheme" do
    it "should create setters setting a default scheme when none is present" do
      Sponsor.send(:add_default_scheme, :url)

      sponsor = FactoryGirl.build(:sponsor)
      sponsor.url = "url-without-a-scheme.com"
      sponsor.url.should eq("http://url-without-a-scheme.com")
    end

    it "should set a specific scheme if specified" do
      Sponsor.send(:add_default_scheme, :url, :default_scheme => "https")

      sponsor = FactoryGirl.build(:sponsor)
      sponsor.url = "url-without-a-scheme.com"
      sponsor.url.should eq("https://url-without-a-scheme.com")
    end

    it "should allow for multiple uri fields being specified at once" do
      Sponsor.send(:add_default_scheme, :url, :imageUrl)

      sponsor = FactoryGirl.build(:sponsor)
      sponsor.imageUrl = "url-without-a-scheme.com"
      sponsor.imageUrl.should eq("http://url-without-a-scheme.com")
    end

    it "should not do anything when provided with a specified scheme" do
      Sponsor.send(:add_default_scheme, :url)

      sponsor = FactoryGirl.build(:sponsor)
      sponsor.url = "ftp://url-with-a-scheme.com"
      sponsor.url.should eq("ftp://url-with-a-scheme.com")
    end

    it "should not do anything when provided an invalid URI" do
      Sponsor.send(:add_default_scheme, :url)

      sponsor = FactoryGirl.build(:sponsor)
      sponsor.url = "invalid uri"
      sponsor.url.should eq("invalid uri")
    end
  end
end
