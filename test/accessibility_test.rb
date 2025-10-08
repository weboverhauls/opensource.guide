require_relative "./helper"

describe "accessibility test" do
  pages.each do |page|
    next unless page["path"].match?(/\.md$/)
    next unless page["path"].start_with?("_articles/")

    describe page["path"] do
      it "should not use aside elements that create landmark violations" do
        content = File.read(page["path"])
        
        # Check for <aside> tags which would create complementary landmarks
        # These should not be nested within the article landmark
        refute_match(/<aside\s/, content, 
          "Found <aside> element in #{page['path']}. Use <div> instead to avoid nested landmark violations. " \
          "See https://dequeuniversity.com/rules/axe/4.10/landmark-complementary-is-top-level")
      end
    end
  end
end
