# Accessibility Fix: PQuote Landmark Issue

## Issue
The `<aside class="pquote">` elements were nested within the `<article>` landmark in the article layout, creating a complementary landmark (aside) contained within another landmark (article). This violated WCAG 2.1 guidelines and the axe rule `landmark-complementary-is-top-level`.

Reference: https://dequeuniversity.com/rules/axe/4.10/landmark-complementary-is-top-level

## Solution
All `<aside markdown="1" class="pquote">` and `<aside markdown = "1" class = "pquote">` elements across all article files were replaced with `<div>` tags:

- `<aside markdown="1" class="pquote">` → `<div markdown="1" class="pquote">`
- `<aside markdown = "1" class = "pquote">` → `<div markdown = "1" class = "pquote">` (Russian files)
- `</aside>` → `</div>`

This maintains the same visual styling (via the `.pquote` CSS class) while fixing the semantic HTML structure.

## Files Changed
286 markdown files in the `_articles/` directory were updated.

## Prevention
To prevent regression:
1. Never use `<aside>` tags for pquote blocks
2. Always use `<div markdown="1" class="pquote">` for quote blocks
3. The CSS styling is applied via the `.pquote` class, not the HTML tag, so using `<div>` instead of `<aside>` has no visual impact

## Testing
Manual verification:
- Built site contains no `<aside class="pquote">` elements
- All pquote blocks now use `<div class="pquote">`
- Visual appearance remains unchanged
- All existing tests pass

To verify the fix in the future, check that no pquote blocks use aside tags:
```bash
# Should return 0
grep -r '<aside.*class.*pquote' _articles/ | wc -l

# Should match the number of pquote blocks
grep -r '<div.*class.*pquote' _articles/ | wc -l
```
