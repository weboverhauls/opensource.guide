require_relative "./helper"
require "nokogiri"

describe "accessibility test" do
  describe "landmark uniqueness" do
    # Test the built HTML files in _site
    Dir.glob("_site/**/*.html").each do |html_path|
      describe html_path do
        before do
          @doc = Nokogiri::HTML(File.read(html_path))
        end
        
        it "has aria-labels on nav landmarks when there are multiple nav elements" do
          nav_elements = @doc.css('nav')
          
          # If there are multiple nav elements, they should have aria-labels for uniqueness
          if nav_elements.length > 1
            aria_labels = nav_elements.map { |nav| nav['aria-label'] }
            
            # All nav elements should have aria-labels when there are multiple
            assert_equal nav_elements.length, aria_labels.compact.length,
              "All nav elements should have aria-labels when there are multiple nav landmarks. Found #{nav_elements.length} nav elements but only #{aria_labels.compact.length} aria-labels in #{html_path}"
            
            # All aria-labels should be non-empty
            assert aria_labels.all? { |label| label && !label.empty? },
              "All nav elements should have non-empty aria-labels in #{html_path}"
          end
        end
      end
    end
  end
end
