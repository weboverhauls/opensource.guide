require "minitest/autorun"

class AccessibilityTest < Minitest::Test
  # Test to ensure aside elements are not used for pquotes
  # This prevents WCAG 2.1 violation where complementary landmarks (aside)
  # should not be nested inside other landmarks (article)
  # See: https://dequeuniversity.com/rules/axe/4.10/landmark-complementary-is-top-level
  def test_no_aside_pquote_elements
    # Change to parent directory to find _articles
    Dir.chdir(File.expand_path('..', __dir__)) do
      article_files = Dir.glob('_articles/**/*.md')
      violations = []

      article_files.each do |file|
        content = File.read(file)
        
        # Check for <aside> tags with pquote class
        # Pattern matches 'pquote' as a word boundary within the class attribute
        # Handles cases with or without spaces around = and multiple classes
        if content.match?(/<aside[^>]*class\s*=\s*["'][^"']*\bpquote\b[^"']*["']/)
          violations << file
        end
      end

      assert_equal [], violations,
        "Found <aside class=\"pquote\"> elements in #{violations.length} files. " \
        "These should use <div> instead to avoid nesting complementary landmarks inside article landmarks. " \
        "Files with violations: #{violations.join(', ')}"
    end
  end
end
