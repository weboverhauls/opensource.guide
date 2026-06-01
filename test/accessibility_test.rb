require_relative "./helper"
require "nokogiri"

describe "accessibility" do
  it "renders a level-one heading for /getting-paid/" do
    getting_paid = site.collections["articles"].docs.find { |doc| doc.relative_path == "_articles/getting-paid.md" }
    output = Jekyll::Renderer.new(site, getting_paid).run
    heading = Nokogiri::HTML(output).at_css("h1")

    refute_nil heading
    refute_empty heading.text.strip
  end
end
