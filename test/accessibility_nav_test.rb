require_relative "./helper"

describe "nav accessibility" do
  it "gives home links a discernible label in nav include" do
    nav_template = File.read(File.join(source, "_includes", "nav.html"))

    assert_match(%r{<a href="/\{\{ page\.lang \}\}/" class="text-gray" aria-label="\{\{ site\.title \}\}">\{\{ site\.title \}\}</a>}, nav_template)
    assert_match(%r{<a href="/" class="text-gray" aria-label="\{\{ site\.title \}\}">\{\{ site\.title \}\}</a>}, nav_template)
  end
end
