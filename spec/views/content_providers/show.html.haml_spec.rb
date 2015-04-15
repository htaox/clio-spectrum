require 'spec_helper'

describe "content_providers/show" do
  before(:each) do
    @content_provider = assign(:content_provider, stub_model(ContentProvider,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
