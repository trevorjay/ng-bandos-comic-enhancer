# Bando's Comic Enhancer

Bando's Comic Enhancer is a simple bookmarklet that adds page preloading to the comic viewer on [Newgrounds](https://www.newgrounds.com/).

## Install

To install, follow the instructions [here](https://raw.githack.com/trevorjay/ng-bandos-comic-enhancer/feature-001/install.html).

## Usage

1) Visit the comic on NG.
2) Emedded post in the "gallery" format can be browsed as is, other formats require first launching the full page viewer.
3) Click your "BCE" bookmark.
4) Enjoy!

### Status Glossary

Once activated, Bando's Comic Enhancer will communicate its status by prefixing the page title with an emoji. In some browsers, you may need more than one page open before page titles are visible.

⏳ - The enhancer is initializing

🔎 - The page format is not supported for embedded viewing, please enter the full page viewer

✨ - The next page has been load


## Features
* Preloads the next two pages to be read
* Works completely passively in parallel with [PsychoGoldfish](https://psychogoldfish.newgrounds.com/)'s official viewer and should not interfere with other viewer features
* Lightweight (less than 4k)
* Uses the MutationObserver API to minimize CPU overhead