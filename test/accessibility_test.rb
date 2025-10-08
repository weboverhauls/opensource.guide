require_relative "./helper"
require "nokogiri"

describe "accessibility test" do
  describe "nav landmarks" do
    # Build the site once for all tests
    before do
      config_test = YAML.load_file("test/_config.yml")
      @config_combined = config.merge(config_test)
      @site = Jekyll::Site.new(@config_combined)
      @site.reset
      @site.read
      @site.render
      @site.write
    end

    # Test article pages that have table of contents
    it "should have unique aria-labels for nav landmarks on article pages" do
      # Find an article page (not the index)
      article_pages = @site.collections["articles"].docs.select do |doc|
        doc.data["layout"] == "article" rescue false
      end

      refute_empty article_pages, "No article pages found to test"

      article_pages.each do |doc|
        # Get the rendered output
        html_content = doc.output
        next if html_content.nil? || html_content.empty?

        # Parse HTML
        html = Nokogiri::HTML(html_content)
        nav_elements = html.css("nav")

        # If there are multiple nav elements, they should have unique aria-labels
        if nav_elements.length > 1
          aria_labels = nav_elements.map { |nav| nav["aria-label"] }.compact
          
          # Check that aria-labels exist for all nav elements
          assert_equal nav_elements.length, aria_labels.length,
            "Not all nav elements in #{doc.relative_path} have aria-label attributes"
          
          # Check that aria-labels are unique
          assert_equal aria_labels.uniq.length, aria_labels.length,
            "Nav elements in #{doc.relative_path} do not have unique aria-labels. Found: #{aria_labels.inspect}"
        end
      end
    end
  end
end
