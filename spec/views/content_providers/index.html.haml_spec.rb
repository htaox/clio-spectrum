require 'spec_helper'

describe "content_providers/index" do
  before(:each) do
    assign(:content_providers, [
      stub_model(ContentProvider,
        :name => "Name"
      ),
      stub_model(ContentProvider,
        :name => "Name"
      )
    ])
  end

  it "renders a list of content_providers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
