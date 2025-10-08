require_relative "./helper"

describe "accessibility test" do
  describe "article body links" do
    it "should have text-decoration underline for accessibility" do
      css_file_path = File.join(source, "assets", "css", "custom.scss")
      css_file = File.read(css_file_path)
      
      # Check that article body contains link styling with text-decoration
      assert css_file.match?(/\.article-body.*?a\s*\{.*?text-decoration:\s*underline/m),
        "Links in .article-body should have text-decoration: underline to be distinguishable without relying on color alone (WCAG 2.1)"
    end
  end
end
