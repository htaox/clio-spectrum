require 'spec_helper'

describe "content_providers/new" do
  before(:each) do
    assign(:content_provider, stub_model(ContentProvider,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new content_provider form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", content_providers_path, "post" do
      assert_select "input#content_provider_name[name=?]", "content_provider[name]"
    end
  end
end
