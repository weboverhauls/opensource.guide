require_relative "./helper"
require "nokogiri"

describe "getting-paid accessibility" do
  def getting_paid_document
    html = File.read(File.join(source, "_site/getting-paid/index.html"))
    Nokogiri::HTML(html)
  end

  it "marks pull-quote avatars as decorative" do
    avatars = getting_paid_document.css("img.pquote-avatar")

    refute_empty avatars

    avatars.each do |avatar|
      assert_equal "", avatar["alt"]
      assert_equal "presentation", avatar["role"]
    end
  end

  it "provides text alternatives or presentational semantics for images" do
    getting_paid_document.css("img").each do |image|
      has_alt = image.key?("alt")
      has_aria_label = image["aria-label"] && !image["aria-label"].empty?
      has_aria_labelledby = image["aria-labelledby"] && !image["aria-labelledby"].empty?
      has_title = image["title"] && !image["title"].empty?
      is_presentational = %w[none presentation].include?(image["role"])

      assert(
        has_alt || has_aria_label || has_aria_labelledby || has_title || is_presentational,
        "#{image.to_html} is missing an accessible text alternative"
      )
    end
  end
end
