# oupmemoir
A LaTeX class for Oxford University Press philosophy books, based on memoir

It uses the [`memoir`](https://ctan.org/pkg/memoir) package to do the
heavy lifting.  Basically,

    \documentclass[print]{oupmemoir}

just calls `memoir` with some options, then sets the page size to
Royal Quarto, adjusts the size of the typeblock, defines how chapter
and section headings etc. are printed. It has two class options:

- `print` for delivering a camera-ready PDF for printing in
PDF/X format
- `ebook` for producing a tighter PDF for screen reading in PDF/A format
with links and bookmarks.

The content produced is
otherwise the same.

It also provides some commands that
let you easily make the front matter of the book. Those are:

- `\author` sets the author
- `\title` sets the title
- `\subtitle` sets the subtitle
- `\pubyear` sets the publication year
- `\impression` sets the impression (default: 1)
- `\isbn` sets the ISBN
- `\typesetter` sets the typesetter
- `\printer` sets the printer

The last four things are only used on the copyright page.

The `\maketitle` command, which should be the first command after
`\begin{document}`, produces title and copyright pages.  Other things
are explained/suggested in `oupsample.tex`.

For the bibliography, you can use either the `oupbiblatex` style if
you want to use [`biblatex`](https://ctan.org/pkg/biblatex) or the
BibTeX style `oupnatbib` for use with the
[`natbib`](https://ctan.org/pkg/natbib) package.

The PDF metadata is taken from `oupsample.xmpdata`.