require_relative "./helper"

describe "accessibility test" do
  describe "navigation landmarks" do
    it "main navigation has aria-label attribute" do
      nav_content = File.read(File.join(source, "_includes", "nav.html"))
      assert nav_content.include?('aria-label="{{ t.nav.main_navigation }}"'), 
        "Main navigation should have aria-label attribute for accessibility"
    end

    it "table of contents navigation has aria-label attribute in article layout" do
      article_content = File.read(File.join(source, "_layouts", "article.html"))
      assert article_content.include?('aria-label="{{ t.nav.table_of_contents_navigation }}"'),
        "Table of contents navigation should have aria-label attribute for accessibility"
    end

    it "all locales have navigation label keys" do
      locales_dir = File.join(source, "_data", "locales")
      Dir.glob(File.join(locales_dir, "*.yml")).each do |locale_file|
        locale_data = SafeYAML.load_file(locale_file)
        locale_name = File.basename(locale_file, ".yml")
        
        assert locale_data[locale_name]["nav"].key?("main_navigation"),
          "#{locale_file} should have 'main_navigation' key"
        
        assert locale_data[locale_name]["nav"].key?("table_of_contents_navigation"),
          "#{locale_file} should have 'table_of_contents_navigation' key"
      end
    end
  end
end
