require_relative "./helper"

describe "accessibility" do
  it "renders /getting-paid/ with a non-empty html lang attribute" do
    getting_paid = site.collections["articles"].docs.find { |doc| doc.relative_path == "_articles/getting-paid.md" }
    refute_nil getting_paid

    html = Jekyll::Renderer.new(site, getting_paid).run
    html_tag = html[/<html\b[^>]*>/i]

    refute_nil html_tag
    assert_match(/\blang\s*=\s*["'][^"']+["']/, html_tag)
  end
end
