%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colorado State University LaTeX Thesis Document Class
%
% by
%   Elliott Forney
%   2017
%
% This is free and unencumbered software released into the public domain.
% 
% Anyone is free to copy, modify, publish, use, compile, sell, or
% distribute this software, either in source code form or as a compiled
% binary, for any purpose, commercial or non-commercial, and by any
% means.
% 
% In jurisdictions that recognize copyright laws, the author or authors
% of this software dedicate any and all copyright interest in the
% software to the public domain. We make this dedication for the benefit
% of the public at large and to the detriment of our heirs and
% successors. We intend this dedication to be an overt act of
% relinquishment in perpetuity of all present and future rights to this
% software under copyright law.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
% IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
% OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
% ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
% OTHER DEALINGS IN THE SOFTWARE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Document class definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% provide a new LaTeX2e document class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2017/06/13 Colorado State University Thesis]

% provide classoption to specify if this is an bachelor, master or
% doctor thesis/dissertation
\newif\ifCLASSOPTIONbachelor
\newif\ifCLASSOPTIONmaster
\newif\ifCLASSOPTIONdoctor
\DeclareOption{bachelor}{\CLASSOPTIONbachelortrue \CLASSOPTIONmasterfalse \CLASSOPTIONdoctorfalse}
\DeclareOption{master}{\CLASSOPTIONbachelorfalse  \CLASSOPTIONmastertrue  \CLASSOPTIONdoctorfalse}
\DeclareOption{doctor}{\CLASSOPTIONbachelorfalse  \CLASSOPTIONmasterfalse \CLASSOPTIONdoctortrue}

% show frame around margins
\newif\ifCLASSOPTIONshowframe \CLASSOPTIONshowframefalse
\DeclareOption{showframe}{\CLASSOPTIONshowframetrue}

% disable features that are specific to pdf output
\newif\ifCLASSOPTIONpdf \CLASSOPTIONpdftrue
\DeclareOption{nopdf}{\CLASSOPTIONpdffalse}

% provide classoption for subfigure compatibility
% note that the subfig package should generally be used instead
% of subfigure, so this option shouldn't be necessary unless you insist
\newif\ifCLASSOPTIONsubfigure \CLASSOPTIONsubfigurefalse
\DeclareOption{subfigure}{\CLASSOPTIONsubfiguretrue}

% some default options for the book class
% note that we assume letter paper and 12pt font
\PassOptionsToClass{oneside,openany,letterpaper,12pt}{book}

% pass remaining options to book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% execute default options
\ExecuteOptions{master}

% process options
\ProcessOptions\relax

% book class is used as a base
\LoadClass{book}

% Fonts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% use times font by default
\RequirePackage[T1]{fontenc}
\RequirePackage{times}

% Page formatting and layout
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% configure page size and margins
\RequirePackage{geometry}
\geometry{verbose, letterpaper, heightrounded,
          lmargin=1in, rmargin=1in, % 1in margins
          tmargin=1in, bmargin=1in, footskip=0.5in}

% show frame around page margins if requested
\ifCLASSOPTIONshowframe
    \geometry{showframe}
\fi

% use double spacing by default
\RequirePackage[doublespacing]{setspace}

% reduce topskip to ensure text is flush with top margin
% assumes 12pt font
\topskip=9pt

% provide an environment for creating landscape pages
% for big tables and figures
% this is kind of a hack for now but gets the job done
% any ideas for a better solution?
\ifCLASSOPTIONpdf
    \RequirePackage{pdflscape}
\else
    \RequirePackage{lscape}
\fi
\newenvironment{sidewayspage}{%
    \newgeometry{lmargin=1in, rmargin=0.45in,
                 tmargin=1in, bmargin=1in}%
    \begin{landscape}%
        \thispagestyle{empty}%
}{%
        \null%
        \vfill%
        \centerline{\normalsize\thepage}%
    \end{landscape}%
    \restoregeometry%
}

% Typesetting rules
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% discourage single lines of a paragraph from landing at the
% bottom or top of page, a.k.a, widows and orphans
% this configuration should prevent orphans and widows in all
% but the most pathological cases
\clubpenalty=10000      % penalty for breaking after first line of a paragraph
\widowpenalty=10000     % penalty for breaking before last line of a paragraph
\predisplaypenalty=500  % discourage single line before equations
\raggedbottom           % be flexible with bottom margin

% indent first paragraphs
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue

% redefine raggedright command so that it doesn't
% break paragraph indentation
% modified from latex.ltx
\renewcommand{\raggedright}{%
    \let\\\@centercr\@rightskip\@flushglue \rightskip\@rightskip%
    \leftskip\z@skip}

% command to suppress indentation
\newcommand{\zeroindent}{\setlength{\parindent}{0in}}

% command to create centered environment with no
% indentation and without extra space above or below
\newenvironment{flatcenter}{\centering \zeroindent}{\par}

% Footnotes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% remove rule above footnote and places further down page
\RequirePackage[bottom]{footmisc}

% space between footnotes if there are multiple on one page
\setlength{\footnotesep}{1.5em}

% setup hrule above footnotes with little space between text
\def\footnoterule{\hrule \@width 2in}

% prevents footnote counter from resetting at new chapter
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}

% Page numbers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% use plain page style with page number at bottom
\pagestyle{plain}

% Float (figures, tables, etc) formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hook to add \centering to all float environments,
% e.g, tables and figures
\g@addto@macro\@floatboxreset\centering

% adjust spacing above and below floats
\setlength{\intextsep}{2em}         % with text above and below
\setlength{\textfloatsep}{2em}      % top/bottom of page with text above/below
\setlength{\floatsep}{1em}          % between consecutive floats
\setlength{\@fptop}{0pt}            % top of float only pages
\setlength{\@fpsep}{1em}            % between on float only pages
\setlength{\@fpbot}{0em plus 1fil}  % bottom of float only pages

% make captions use small font with bold label
\RequirePackage{caption}
\captionsetup{font=small,labelfont=bf}

% Table of contents formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% use tocloft to customize table of contents, list of figures, etc
\ifCLASSOPTIONsubfigure
    % needed subfigure for compatibility
    % note that subfig should generally be used instead of subfigure
    \RequirePackage[subfigure,titles]{tocloft}
\else
    \RequirePackage[titles]{tocloft} % use tocloft package to modify toc
\fi

% indentation before chapters or sections
\setlength{\cftchapindent}{0in}
\setlength{\cftsecindent}{0.18in}
\setlength{\cftsubsecindent}{0.36in}
\setlength{\cftsubsubsecindent}{0.54in}

% space between margin and chap/sec titles
\setlength{\cftchapnumwidth}{1in}
\setlength{\cftsecnumwidth}{1in}
\setlength{\cftsubsecnumwidth}{1in}
\setlength{\cftsubsubsecnumwidth}{1in}

% chapter name in toc is "Chapter N"
\renewcommand{\cftchappresnum}{\chaptername\space}

% appendix name in toc is "Appendix A"
\g@addto@macro\appendix{%
  \addtocontents{toc}{%
    \protect\renewcommand{\protect\cftchappresnum}{\appendixname\space}%
  }%
}

% dots same for chapters and sections
\renewcommand{\cftchapdotsep}{\cftdotsep}

% dots not bold
\renewcommand{\cftchapleader}{\cftdotfill{\cftsecdotsep}}

% use normal fonts, not bold
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapfont}{\normalfont}

% don't indent list of figures/tables
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}

% create a table-of-contents entry for a new preliminary page
% we call it an unnumbered section so they aren't spaced and
% reverse the indent using hspace then make uppercase
\newcommand{\prelimtocentry}[1]{%
    \phantomsection%
    \addcontentsline{toc}{section}{\hspace{-\cftsecindent}\uppercase{#1}}%
}

% Chapter and section headings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% adjust spacing around chapter/section headings
\def\@abovechap{-36pt}  % above chapter headings
\def\@belowchap{12pt}  % below chapter headings
\def\@abovesec{12pt}     % above section headings
\def\@belowsec{2pt}   % below section headings
% note: abovesec does not affect section headings at top of page!

% font sizes for chapter, section and subsection headings
\newcommand{\@chapsize}{\LARGE}
\newcommand{\@secsize}{\Large}
\newcommand{\@subsecsize}{\large}
\newcommand{\@subsubsecsize}{\normalsize}

% remove space above chapter headings
% i would prefer to do this using the titlesec package
% but titlesec is a little loose with the top margins
% this code is modified from book.cls
\def\@makechapterhead#1{%
  \vspace*{\@abovechap}
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        \@chapsize\bfseries \@chapapp\space \thechapter
        \par\nobreak
      \else
        \@chapsize\bfseries \@chapapp\space \thechapter
      \fi
    \fi
    \interlinepenalty\@M
    \@chapsize\bfseries #1\par\nobreak
    \vskip \@belowchap
  }}

\def\@makeschapterhead#1{%
  \vspace*{\@abovechap}
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \@chapsize\bfseries  #1 \par\nobreak
    \vskip \@belowchap
  }}
% end modified from book class

% redefine section commands to change size and spacing
% could be done with titlesec but that would break margins
\renewcommand\section{\@startsection {section}{1}{0pt}%
            {\@abovesec}{\@belowsec}{\normalfont\@secsize\bfseries}}

\renewcommand\subsection{\@startsection{subsection}{2}{0pt}%
            {\@abovesec}{\@belowsec}{\normalfont\@subsecsize\bfseries}}

\renewcommand\subsubsection{\@startsection{subsubsection}{3}{0pt}%
            {\@abovesec}{\@belowsec}{\normalfont\@subsubsecsize\bfseries}}

% Citation and reference formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define custom commands for creating references
% for tables, figures, equations and such
\RequirePackage{cite}
\newcommand{\eref}[1]{\eqref{#1}}        % cite equation
\newcommand{\fref}[1]{Figure~\ref{#1}}   % cite figure
\newcommand{\cref}[1]{Chapter~\ref{#1}}  % cite chapter
\newcommand{\sref}[1]{Section~\ref{#1}}  % cite section/sub(sub)section
\newcommand{\aref}[1]{Appendix~\ref{#1}} % cite appendix
\newcommand{\tref}[1]{Table~\ref{#1}}    % cite table

% Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to the document title
\def\@title{Colorado State University \LaTeX{} Thesis Template}
\renewcommand{\title}[1]{\protected@edef\@title{#1}}

% command to set author's name
\def\@author{John M. Doe}
\renewcommand{\author}[1]{\protected@edef\@author{#1}}

% command to set author's email
\def\@email{youremail@colostate.edu}
\newcommand{\email}[1]{\protected@edef\@email{#1}}

% command to set department name
\def\@department{Department of Computer Science}
\newcommand{\department}[1]{\protected@edef\@department{#1}}

% command to set defense semester
\def\@semester{Fall 20\_\_}
\newcommand{\semester}[1]{\protected@edef\@semester{#1}}

% command to set advisor's name
\def\@advisor{Advisor's Name}
\newcommand{\advisor}[1]{\protected@edef\@advisor{#1}}

% command to set (optional) co-advisor's name
\newcommand{\coadvisor}[1]{\protected@edef\@coadvisor{#1}}

% command to add committee members
% this tacks new members onto current value of \@committee
\def\@committee{}
\newcommand{\committee}[1]{\protected@edef\@committee{%
    \unexpanded\expandafter{\@committee}{\noexpand\hspace{0.25in} #1 \par}}}

% command to make title page
\renewcommand{\maketitle}{%
    \begin{flatcenter}
            % doctorate is dissertation, otherwise its a thesis
            \ifCLASSOPTIONdoctor
                DISSERTATION
            \else
                THESIS
            \fi

            \vspace{0.25in}

            % title in all caps
            {\MakeUppercase{\@title} \par}

            \vspace{\fill}

            Submitted by

            \@author

            \@department

            \vspace{\fill}

            In partial fulfillment of the requirements

            % for bachelor, master or doctor
            \ifCLASSOPTIONbachelor
                For the Degree of Bachelor of Science
            \fi
            \ifCLASSOPTIONmaster
                For the Degree of Master of Science
            \fi
            \ifCLASSOPTIONdoctor
                For the Degree of Doctor of Philosophy
            \fi

            Colorado State University

            Fort Collins, Colorado

            \@semester
    \end{flatcenter}

    \vspace{\fill}

    {\singlespace \zeroindent
        \ifCLASSOPTIONbachelor
          Committee:
        \fi
        \ifCLASSOPTIONmaster
          Master's Committee:
        \fi
        \ifCLASSOPTIONdoctor
          Doctoral Committee:
        \fi

        \vspace{1em}
        \hspace{0.25in} Advisor: \@advisor \par

        % unpack committee members
        \ifx\@coadvisor\undefined \else
            \hspace{0.25in} Co-Advisor: \@coadvisor \par
        \fi
        \vspace{1em}

        \@committee
    }

    \thispagestyle{empty} % no page number here
    \newpage % start new page
}

% Copyright
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default copyright
\def\@mycopyright{Copyright by \@author \\ All Rights Reserved}

% command to set copyright
\newcommand{\mycopyright}[1]{\protected@edef\@mycopyright{#1}}

% command to make copyright page
\newcommand{\makemycopyright}{%
    \vspace*{\fill}
    \begin{flatcenter}
        \@mycopyright
    \end{flatcenter}
    \vspace{\fill}

    % copyright page has no page number...
    % literally, no page number at all, SMH
    \newcounter{@temppage} % store page counter so we can reset it later
    \setcounter{@temppage}{\value{page}}
    \thispagestyle{empty} % disable page number display
    \pagenumbering{gobble} % disable page number counter
    \newpage % start next page
    \pagenumbering{roman} % reset page numbering to roman
    \setcounter{page}{\value{@temppage}} % reset page number counter
}

% Abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default abstract
\def\@abstract{Abstract goes here.}

% command to set abstract
\newcommand{\abstract}[1]{\protected@edef\@abstract{#1}}

% command to make abstract page
\newcommand{\makeabstract}{%
    % add to table of contents
    \prelimtocentry{Abstract}

    \begin{flatcenter}
        ABSTRACT

        \vspace{3em}

        \MakeUppercase{\@title}

        \vspace{3em}
    \end{flatcenter}

    \@abstract \par

    \newpage
}

% Acknowledgements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default acknowledgements
\def\@acknowledgements{Acknowledgements go here.}

% command to set acknowledgements
\newcommand{\acknowledgements}[1]{\protected@edef\@acknowledgements{#1}}

% acknowledgements page
\newcommand{\makeacknowledgements}{%
    % add to table of contents
    \prelimtocentry{Acknowledgements}

    \begin{flatcenter}
        ACKNOWLEDGEMENTS

        \vspace{3em}
    \end{flatcenter}

    \@acknowledgements \par

    \newpage
}

% Table of Contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to create table of contents
\renewcommand{\tableofcontents}{%
    \begin{flatcenter}
        TABLE OF CONTENTS

        \vspace{3em}
    \end{flatcenter}

    % insert table of contents
    {\singlespace \@starttoc{toc}}

    \newpage
}

% List of Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to make list of tables
\renewcommand{\listoftables}{%
    % add to table of contents
    \prelimtocentry{List of Tables}

    \begin{flatcenter}
        LIST OF TABLES

        \vspace{3em}
    \end{flatcenter}

    \vspace{-26pt}

    % insert list of tables
    {\singlespace \@starttoc{lot}}

    \newpage
}

% List of Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to make list of figures
\renewcommand{\listoffigures}{%
    % add to table of contents
    \prelimtocentry{List of Figures}

    \begin{flatcenter}
        LIST OF FIGURES

        \vspace{3em}
    \end{flatcenter}

    \vspace{-26pt}

    % insert list of figures
    {\singlespace \@starttoc{lof}}

    \newpage
}

% Body
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \frontmatter \mainmatter \backmatter and \appendix commands come from the book class

% hack to allow appendix after the bibliography by resetting to mainmatter
% yuck but the guidelines insist the appendix comes after bibliography
\g@addto@macro\appendix\@mainmattertrue

% Bibliography
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% left-align bibliography entries by filling right of the label number
\renewcommand{\@biblabel}[1]{[#1]\hfill}

% bibliography environment with flush left margin,
% appropriate toc entry, and our penalty values
% modified from book.cls
\renewenvironment{thebibliography}[1]{%
    % set up unnumbered chapter and add to table of contents
    \chapter*{\bibname}%
    \phantomsection%
    \addcontentsline{toc}{chapter}{\bibname}%
    \@mkboth{\MakeUppercase{\bibname}}{\MakeUppercase{\bibname}}%

    % create list of bibliography entries
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
          \leftmargin\labelwidth
          \advance\leftmargin\labelsep
          \@openbib@code
          \usecounter{enumiv}%
          \let\p@enumiv\@empty
          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy % :revents hbox overfull but looks nicer without it
    \sfcode`\.\@m%
}
{\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
\endlist}
% end modified from book.cls
