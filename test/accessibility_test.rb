require_relative "./helper"
require "nokogiri"

describe "page accessibility" do
  it "/getting-paid/ has exactly one top-level main landmark" do
    site.render

    page = site.collections["articles"].docs.find { |doc| doc.url == "/getting-paid/" }
    refute_nil page

    document = Nokogiri::HTML(page.output)
    assert_equal 1, document.css("main, [role='main']").length
    refute_nil document.at_css("body > main, body > [role='main']")
  end
end
