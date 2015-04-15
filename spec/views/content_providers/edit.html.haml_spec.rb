require 'spec_helper'

describe "content_providers/edit" do
  before(:each) do
    @content_provider = assign(:content_provider, stub_model(ContentProvider,
      :name => "MyString"
    ))
  end

  it "renders the edit content_provider form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_provider_path(@content_provider), "post" do
      assert_select "input#content_provider_name[name=?]", "content_provider[name]"
    end
  end
end
