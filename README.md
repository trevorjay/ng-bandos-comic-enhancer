![Bando's Comic Enhancer](bando_comic_enhancer_slim_github.png "Bando's Comic Enhancer")

# Bando's Comic Enhancer

Bando's Comic Enhancer is a simple bookmarklet that adds page preloading to the comic viewer on [Newgrounds](https://www.newgrounds.com/art/view/kittyhawkmontrose/download-first-bando-s-comic-enhancer).

## Install

### Desktop

Installing on desktop is usually as easy as dragging and dropping, follow the instructions [here](https://raw.githack.com/trevorjay/ng-bandos-comic-enhancer/main/install.html).

### Mobile

Bando's Comic Enhancer should be compatible with most mobile browsers. However, most mobile browsers restrict bookmarklet creation. The easiest way to circumvent this is to bookmark another site and then edit the title and URL. You can copy the needed URL from [here](https://raw.githubusercontent.com/trevorjay/ng-bandos-comic-enhancer/main/bce.txt) and watch a [GIF of this being done on ios](https://raw.githack.com/trevorjay/ng-bandos-comic-enhancer/main/ios.gif).

## Usage

1) Visit the comic on NG.
2) Click your "BCE" bookmark.
3) Embedded post in the "gallery" format can be browsed as is, other formats require first launching the full page viewer to enable preloading.
5) Enjoy!

### Status Glossary

Once activated, Bando's Comic Enhancer will communicate its status by prefixing the page title with an emoji. In some browsers, you may need more than one page open before page titles are visible.

⏳ - The enhancer is initializing

🔎 - The page format is not supported for embedded viewing, please enter the full page viewer

✨ - The next page has been loaded


## Features
* Preloads the next two pages to be read
* Works completely passively in parallel with [PsychoGoldfish](https://psychogoldfish.newgrounds.com/)'s official viewer and should not interfere with other viewer features
* Lightweight (less than 4k)
* Uses the MutationObserver API to minimize CPU overhead

## Limitations
* Doesn't accelerate the loading of the first page when transitioning to the full page view, so the initial page load may still be slow.
* Does not force previously read pages to remain cached
* Purposely does not alter the loading of either "infinite scroll" embedded format