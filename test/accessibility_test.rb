require_relative "./helper"
require "nokogiri"
require "tmpdir"

describe "accessibility landmarks" do
  it "keeps /getting-paid/ paragraphs inside landmarks" do
    Dir.mktmpdir do |destination|
      site = Jekyll::Site.new(config.merge("destination" => destination))
      site.process

      document = Nokogiri::HTML(File.read(File.join(destination, "getting-paid", "index.html")))
      body = document.at_css("body")

      assert_equal %w[nav main footer], body.element_children.reject { |element| element.name == "script" }.map(&:name)

      orphaned_paragraphs = document.css("body p").reject do |paragraph|
        paragraph.ancestors.any? { |ancestor| %w[nav main footer].include?(ancestor.name) }
      end

      assert_empty orphaned_paragraphs
    end
  end
end
