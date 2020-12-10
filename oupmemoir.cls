% oupmemoir class
% ==================
% A LaTeX class for producing an OUP book.
%
% Richard Zach
%
% Distributed under the terms of the MIT License
% https://opensource.org/licenses/MIT

\ProvidesClass{oupmemoir}[2020/12/07
  OUP Memoir Class]

\NeedsTeXFormat{LaTeX2e}

% class option print -- typeset for camera-ready printing

\DeclareOption{print}{%
  % Show trim marks
  \PassOptionsToClass{twoside,showtrims,letterpaper}{memoir}
  \AtEndOfClass{\quarkmarks}}

% class option ebook -- typeset for screen reading
% even/odd margins, no trimmarks, pagesize = stocksize

\DeclareOption{ebook}{%
  % Show trim marks
  \PassOptionsToClass{oneside,msmallroyalvopaper}{memoir}
}

% pass any other options to memoir
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

% default options for memoir
\PassOptionsToClass{openany}{memoir}

\ProcessOptions

% now load memoir

\LoadClass{memoir}

\AtEndOfClass{%
  \pagemsmallroyalvo % 234 by 156 mm page size
  \setpagecc{\paperheight}{\paperwidth}{*} % center on stock

  \settypeblocksize{19cm}{12.5cm}{*}
  \@ifclasswith{memoir}{twoside}{
    \setlrmargins{*}{18mm}{*}}{
    \setlrmargins{*}{*}{*}}
  \setulmargins{22mm}{*}{*}
  \checkandfixthelayout
}

% make a pagestyle for OUP

\makepagestyle{oup}

% running heads:
% folio outside, chapter title without number in small caps

\makeevenhead{oup}{\thepage\quad{\scshape\leftmark}}{}{}
\makeoddhead{oup}{}{}{{\scshape\leftmark}\quad\thepage}
\makepsmarks{oup}{%
\createmark{chapter}{both}{nonumber}{}{}
\createplainmark{toc}{both}{\contentsname}
\createplainmark{lof}{both}{\listfigurename}
\createplainmark{lot}{both}{\listtablename}
\createplainmark{bib}{both}{\bibname}
\createplainmark{index}{both}{\indexname}
\createplainmark{glossary}{both}{\glossaryname}
\let\memUChead\MakeTextLowercase
}

% set the chapter style

\makechapterstyle{oup}{%
\setlength{\chapindent}{3em}
% don't print "Chapter"
\renewcommand*{\printchaptername}{}
\renewcommand*{\chapternamenum}{}
% font for chapter # 
\renewcommand*{\chapnumfont}{\normalfont\Huge\bfseries} 
\renewcommand*{\printchapternum}{\hskip\chapindent\chapnumfont\thechapter}
\renewcommand*{\afterchapternum}{\par\nobreak\vskip .5em}
% font for chapter title
\renewcommand*{\chaptitlefont}{\normalfont\huge}
\renewcommand*{\printchaptertitle}[1]{%
    \begin{adjustwidth}{\chapindent}{}
      \raggedright \chaptitlefont ##1\par\nobreak
    \end{adjustwidth}}}

% set chapter style
\chapterstyle{oup}

% set section and subsection style
% indented, not bold

\setsecindent{3em}
\setsecheadstyle{\normalfont\Large}
\setbeforesecskip{-3ex plus -1ex minus -1ex}
\setbeforesubsecskip{-3ex plus -1ex minus -1ex}

\setsubsecheadstyle{\normalfont\large\itshape}

% redefine quote and quotations -- small type, not indented

\renewenvironment{quotation}%
  {%
    \list{}{\listparindent 1.5em%
          \itemindent    \listparindent
          \rightmargin\z@   \leftmargin\z@
          \parsep        \z@ \@plus\p@}%
    \item[]}%
  {\endlist}

\renewenvironment{quote}%
  {\list{}{\rightmargin\z@   \leftmargin\z@\small}
   \item[]}%
  {\endlist}

% TOC adjustments

% call it "Contents"

\renewcommand{\contentsname}{Contents}

\setlength{\cftbeforechapterskip}{3pt plus 0pt}
\renewcommand{\cftchapterleader}{\normalfont\cftdotfill{\cftsectiondotsep}}

% we need toc, lof, lot to begin on a new page

\def\tocheadstart{\clearpage}
\def\lofheadstart{\clearpage}
\def\lotheadstart{\clearpage}

% number chapters, sections, subsections

\setsecnumdepth{subsection}

% footnotes

\footmarkstyle{\textsuperscript{#1}\ }
\renewcommand{\footnoterule}{}
\setfootins{3em}{\bigskipamount}

% commands to provide title, etc., for \maketitle

% \title sets the title
% \subtitle sets the subtitle

\newcommand{\oup@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\oup@subtitle}{#1}}

% \pubyear sets the publication year

\newcommand{\oup@year}{20\textsc{xx}}
\newcommand{\pubyear}[1]{\renewcommand{\oup@year}{#1}}

% \impression sets the impression, default: 1

\newcommand{\oup@impression}{1}
\newcommand{\impression}[1]{\renewcommand{\oup@impression}{#1}}

% typesetter sets the typesetter

\newcommand{\oup@typesetter}{}
\newcommand{\typesetter}[1]{\renewcommand{\oup@typesetter}{#1}}

% \printer sets the printer

\newcommand{\printer}[1]{\renewcommand{\oup@printer}{#1}}

% \isbn sets the ISBN

\newcommand\oup@isbn{000--00--000--00}
\newcommand\isbn[1]{\renewcommand\oup@isbn{#1}}

% \dedication sets a dedication

\newcommand\dedication[1]{\renewcommand\oup@dedication{#1}}

% \logo sets the logo (filename of logo graphics)
\newcommand{\oup@logo}{oup-logo}
\newcommand{\logo}[1]{\renewcommand\oup@logo{#1}}

% Redefine \maketitle to produce 
% (i)   a half-title page, 
% (ii)  the real title page,  
% (iii) the title verso page, and
% (iv)  a dedicatory page, if wanted.

\renewcommand{\maketitle}{%
% start the front matter
\frontmatter%

% half title

\pagestyle{empty}

\vspace*{2.5cm}

\begin{raggedright}
\LARGE\@title
\end{raggedright}
% clear two pages to recto even if onesided
\newpage\ \newpage

% true title page

\let\and\par

\begin{raggedright}
  \Huge\@title

  \ifdefined\oup@subtitle
    {\vskip 1em\huge\itshape\oup@subtitle}
  \else
    \relax
  \fi

  \vskip 3em
  \LARGE\@author\par
\end{raggedright}

\vfill
\includegraphics[height=1cm]{\oup@logo}
\cleartoverso

% title verso

\def\and{, }

\begin{center}\small%
  \setlength{\parindent}{0pt}
  \setlength{\parskip}{\smallskipamount}
  \includegraphics[height=.7cm]{\oup@logo}

  Great Clarendon Street, Oxford OX2 6DP,\\
  United Kingdom

  Oxford University Press is a department of the University of Oxford.
  It furthers the University's objective of excellence in research,
  scholarship, and education by publishing worldwide. Oxford is a
  registered trademark of Oxford University Press in the UK and in
  certain other countries.

  \textcopyright~\@author\ \oup@year

  The moral rights of the authors have been asserted

  First edition published in \oup@year\\
  Impression: \texttlf{\oup@impression}

  All rights reserved. No part of this publication may be reproduced,
  stored in a retrieval system, or transmitted, in any form or by any
  means, without the prior permission in writing of Oxford University
  Press, or as expressly permitted by law, or under terms agreed with
  the appropriate reprographics rights organization. Enquiries
  concerning reproduction outside the scope of the above should be
  sent to the Rights Department, Oxford University Press, at the
  address above.

  You must not circulate this book in any other form\\
  and you must impose the same condition on any acquirer.

  Published in the United States of America by Oxford University
  Press\\
  \texttlf{198} Madison Avenue, New York, NY \texttlf{10016}, United
  States of America

  British Library Cataloguing in Publication Data\\
  Data available

  Library of Congress Cataloging in Publication Data\\
  Data available

  \ifdefined\oup@typesetter
    Typeset by \\\oup@typesetter
  \fi

  Printed in Great Britain
  \ifdefined\oup@printer
    by\\\oup@printer
  \fi

  ISBN \texttlf{\oup@isbn}

  Links to third party websites are provided by Oxford in good faith
  and for information only. Oxford disclaims any responsibility for
  the materials contained in any third party website referenced in
  this work.
\end{center}

\cleartorecto

\setcounter{footnote}{0}%
\ifdefined\oup@dedication
  \vspace*{2cm}
  \begin{raggedright}
    \Large\itshape\oup@dedication
  \end{raggedright}
  \cleartorecto
\fi

% switch on OUP pagestyle
\pagestyle{oup}
}

% Load a few packages

\usepackage[usenames,dvipsnames]{xcolor}
\usepackage[pdftex]{graphicx}

\usepackage[T1]{fontenc}
% Use utf-8 encoding for foreign characters
\usepackage[utf8]{inputenc}
\usepackage{textcomp}

% Use PDF/A standard for ebook, PDF/X for print.

\@ifclasswith{oupmemoir}{ebook}{
  \usepackage[a-1b]{pdfx}}{
  \usepackage[x-5]{pdfx}}

\catcode30=12 % fixes a bug in biblatex

\usepackage[numbered]{bookmark}

% Set up links: colored if ebook, o/w black

\definecolor{OxfordBlue}{RGB}{0, 33, 71}
\@ifclasswith{oupmemoir}{print}{
  \hypersetup{hidelinks}}{
  \hypersetup{colorlinks=true,allcolors=OxfordBlue}}
\hypersetup{breaklinks}

\renewcommand\UrlFont{\ttfamily\small}
\usepackage{csquotes}

% Indexing -- turn it off in the preface (in the frontmatter)

\let\@oupindex\index
\newcommand*{\indexoff}{\let\@oupindex\index\let\index\@gobble}
\newcommand*{\indexon}{\let\index\@oupindex}

% Set up BibLaTeX for bibliography management

% Bibliography for philosophy
\usepackage[indexing=cite,maxnames=3,minnames=2,publocformat=loccolonpub,style=philosophy-classic]{biblatex}
\uspunctuation

% journal issues in parens after volume
\renewcommand*{\volnumpunct}{}
\DeclareFieldFormat[article]{number}{(#1)}

% Make article titles sentence case but keep journal titles

\DeclareFieldFormat[article,incollection,inproceedings]{titlecase}{\MakeSentenceCase*{#1}}

\renewbibmacro*{journal}{%
  \iffieldundef{journaltitle}
    {}
    {\printtext[journaltitle]{%
       \printfield{journaltitle}%
       \setunit{\subtitlepunct}%
       \printfield{journalsubtitle}}}}

\DeclareFieldFormat{journaltitle}{\textit{#1}}
\DeclareFieldFormat{booktitle}{\textit{#1}}

% Soandso, ed.,
\renewcommand*{\editorstrgdelim}{\addcomma\space}
\DeclareFieldFormat{editortype}{#1}% no parentheses

\DefineBibliographyExtras{english}{%
  \protected\def\bibrangedash{%
    \textendash\penalty\hyphenpenalty}%
  \protected\def\bibdaterangesep{\bibrangedash}}%

\NewBibliographyString{editedas,publishedas}

\DefineBibliographyStrings{english}{%
  editedas = {ed. as},
  publishedas = {publ. as},
  reprintas = {publ. as},
  translationas = {trans. as}
}

\DeclareGraphicsExtensions{.pdf, .jpg, .tif}

% select Palatino as typeface (actually TeX Gyre Pagella)

\usepackage[osf]{newpxtext}
\usepackage[slantedGreek]{newpxmath}
\linespread{1.05}

% Add cited author names to index 
\DeclareCiteCommand{\citetitle}
  {\boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}
  {\ifciteindex
     {\indexnames{labelname}}
     {}%
   \printfield[citetitle]{labeltitle}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\DeclareCiteCommand*{\citetitle}
  {\boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}
  {\ifciteindex
     {\indexnames{labelname}}
     {}%
   \printfield[citetitle]{title}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

\renewbibmacro*{citeindex}{\indexnames{labelname}{}}
