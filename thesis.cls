%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colorado State University LaTeX Thesis Document Class
%
% by
%   Elliott Forney
%   elliott.forney@gmail.com
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

% provide a new document class
\ProvidesClass{thesis}[2017/02/17 Colorado State University Thesis]

% provide classoption to specify if this is an honor, master or
% doctor thesis/dissertation
\newif\ifCLASSOPTIONhonor
\newif\ifCLASSOPTIONmaster
\newif\ifCLASSOPTIONdoctor
\DeclareOption{honor}{\CLASSOPTIONhonortrue \CLASSOPTIONmasterfalse \CLASSOPTIONdoctorfalse}
\DeclareOption{master}{\CLASSOPTIONhonorfalse \CLASSOPTIONmastertrue \CLASSOPTIONdoctorfalse}
\DeclareOption{doctor}{\CLASSOPTIONhonorfalse \CLASSOPTIONmasterfalse \CLASSOPTIONdoctortrue}

% provide classoption for subfigure compatibility
% note that the subfig package should generally be used instead
% of subfigure, so this option shouldn't be necessary unless you insist
\newif\ifCLASSOPTIONsubfigure \CLASSOPTIONsubfigurefalse
\DeclareOption{subfigure}{\CLASSOPTIONsubfiguretrue}

% some default options for the book class
\PassOptionsToClass{oneside,openany,letterpaper,12pt}{book}

% pass remaining options to book class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% execute default options
\ExecuteOptions{master}

% process options
\ProcessOptions\relax

% book class is used as a base
\LoadClass{book}

% Formatting and style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{times}
%\RequirePackage{fourier}
%\RequirePackage{mathptmx}

% configure page size and margins
\RequirePackage{geometry}
\geometry{verbose, letterpaper, heightrounded,
          lmargin=1in, rmargin=1in, % 1in margins
          tmargin=1in, bmargin=1in, footskip=0.5in}

% remove rule above footnote and places further down page
\RequirePackage[norule,bottom]{footmisc}

% space between footnotes if there are multiple on one page
\setlength{\footnotesep}{1.5em}

% prevents footnote counter from resetting at new chapter
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}

% use plain page style with page number at bottom
\pagestyle{plain}

% use double spacing by default
\RequirePackage[doublespacing]{setspace}

% hook to add \centering to all float environments,
% e.g, tables and figures
\g@addto@macro\@floatboxreset\centering

% adjust spacing above and below floats
\setlength{\intextsep}{2em}         % with text above and below
\setlength{\textfloatsep}{2em}      % top/bottom of page with text above/below
\setlength{\floatsep}{1em}          % between consecutive floats
\setlength{\@fptop}{0em}            % top of float only pages
\setlength{\@fpsep}{1em}            % between on float only pages
\setlength{\@fpbot}{0em plus 1fil}  % bottom of float only pages

% titlesec is used to modify chapter and section headings
\RequirePackage{titlesec}

% adjust spacing around chapter/section headings
\def\@abovechap{-30pt}              % above chapter headings
\def\@belowchap{1em plus \lineskip} % below chapter headings
\def\@abovesec{1em plus \lineskip}  % above section headings
\def\@belowsec{\lineskip}           % below section headings

% font sizes for chapter, section and subsection headings
\newcommand{\@chapsize}{\LARGE}
\newcommand{\@secsize}{\Large}
\newcommand{\@subsecsize}{\Large}
\newcommand{\@subsubsecsize}{\Large}

% set up fonts and spacing around the chapter headings
\titleformat{\chapter}[display] % display argument yields two-line heading
    {\normalfont\bfseries\@chapsize}
    {\chaptertitlename\ \ \thechapter}{0em}{\bfseries\@chapsize}
    % this could be used for one-line heading
    %{\chaptertitlename\ \ \thechapter:}{1em}{\bfseries\@chapsize}
\titlespacing*{\chapter}{0em}{\@abovechap}{\@belowchap}

% set up fonts and spacing around the section headings
\titleformat{\section}
    {\normalfont\bfseries\@secsize}
    {\thesection}{1em}{\bfseries\@secsize}
\titlespacing*{\section}{0em}{\@abovesec}{\@belowsec}

% set up fonts and spacing around the subsection headings
\titleformat{\subsection}
    {\normalfont\bfseries\@subsecsize}
    {\thesection}{1em}{\bfseries\@subsecsize}
\titlespacing*{\subsection}{0em}{\@abovesec}{\@belowsec}

% set up fonts and spacing around the subsubsection headings
\titleformat{\subsubsection}
    {\normalfont\bfseries\@subsubsecsize}
    {\thesection}{1em}{\bfseries\@subsubsecsize}
\titlespacing*{\subsubsection}{0em}{\@abovesec}{\@belowsec}

% make captions use small font with bold label
\RequirePackage{caption}
\captionsetup{font=small,labelfont=bf}

% discourage single lines of a paragraph from landing at the
% bottom or top of page, a.k.a, widows and orphans
% this configuration should prevent orphans and widows in all
% but the most pathological cases
\clubpenalty=10000      % penalty for breaking after first line of a paragraph
\widowpenalty=10000     % penalty for breaking before last line of a paragraph
\predisplaypenalty=500  % discourage single line before equations
\raggedbottom           % be flexible with bottom margin

% this makes the typesetting rules less strict
% helps prevent hbox overflow and such but leads
% to weird looking, overly wide spacing in places
%\sloppy

% indent first paragraphs
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue

% internal command used to suppress indentation
\newcommand{\@zeroindent}{\setlength{\parindent}{0in}}

% Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to the document title
\def\@title{Colorado State University \LaTeX{} Thesis Template}
\renewcommand{\title}[1]{\def\@title{#1}}

% command to set author's name
\def\@author{John M. Doe}
\renewcommand{\author}[1]{\def\@author{#1}}

% command to set author's email
\def\@email{youremail@colostate.edu}
\newcommand{\email}[1]{\def\@email{#1}}

% command to set department name
\def\@department{Department of Computer Science}
\newcommand{\department}[1]{\def\@department{#1}}

% command to set defense semester
\def\@semester{Fall 20\_\_}
\newcommand{\semester}[1]{\def\@semester{#1}}

% command to set advisor's name
\def\@advisor{Advisor's Name}
\newcommand{\advisor}[1]{\def\@advisor{#1}}

% command to set (optional) co-advisor's name
\newcommand{\coadvisor}[1]{\def\@coadvisor{#1}}

% command to add committee members
% this tacks new members onto current value of \@committee
\def\@committee{}
\newcommand{\committee}[1]{\edef\@committee{%
    \unexpanded\expandafter{\@committee} \noexpand\hspace{0.25in} #1 \par}}

% command to make title page
\renewcommand{\maketitle}{%
    {\@zeroindent
        \begin{center}
            % doctorate is dissertation, otherwise its a thesis
            \ifCLASSOPTIONdoctor
                DISSERTATION
            \else
                THESIS
            \fi

            \vspace{0.25in}

            % title in all caps
            {\MakeUppercase{\@title} \par}

            \vspace*{\fill}

            Submitted by

            \@author

            \@department

            \vspace*{\fill}

            In partial fulfillment of the requirements

            % for honor, master or doctor
            \ifCLASSOPTIONhonor
                for the Degree of Bachelor of Science with Honors
            \fi
            \ifCLASSOPTIONmaster
                for the Degree of Master of Science
            \fi
            \ifCLASSOPTIONdoctor
                for the Degree of Doctor of Philosophy
            \fi

            Colorado State University

            Fort Collins, Colorado

            \@semester

            \vspace*{\fill}
        \end{center}

        {\singlespace \@zeroindent
            \ifCLASSOPTIONhonor
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
                \hspace{0.25in} Co-Advisor: \@coadvisor
            \fi
            \vspace{1em}

            \@committee
        }
    }

    \thispagestyle{empty} % no page number here
    \newpage % start new page
}

% Copyright
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default copyright
\def\@mycopyright{Copyright by \@author \\ All Rights reserved}

% command to set copyright
\newcommand{\mycopyright}[1]{\def\@mycopyright{#1}}

% command to make copyright page
\newcommand{\makemycopyright}{%
    % add copyright page to table of contents
    %\phantomsection
    %\addcontentsline{toc}{chapter}{Copyright}

    \begin{center}
        \vspace*{\fill}
        {\@zeroindent \@mycopyright}
        \vspace*{\fill}
    \end{center}

    \thispagestyle{empty} % no page number here
    \addtocounter{page}{-1} % and don't count this in page numbering
    \newpage
}

% Abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default abstract
\def\@abstract{Abstract goes here.}

% command to set abstract
\newcommand{\abstract}[1]{\def\@abstract{#1}}

% command to make abstract page
\newcommand{\makeabstract}{%
    % add to table of contents
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}

    \begin{center}
        ABSTRACT

        \vspace{3em}

        {\MakeUppercase{\@title} \par}
    \end{center}

    \vspace{3em}

    \@abstract \par

    \newpage
}

% Acknowledgements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default acknowledgements
\def\@acknowledgements{Acknowledgements go here.}

% command to set acknowledgements
\newcommand{\acknowledgements}[1]{\def\@acknowledgements{#1}}

% acknowledgements page
\newcommand{\makeacknowledgements}{%
    % add to table of contents
    \phantomsection
    \addcontentsline{toc}{chapter}{Acknowledgements}

    \centerline{ACKNOWLEDGEMENTS}

    \vspace{3em}

    \@acknowledgements \par

    \newpage
}

% Table of Contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% use tocloft to customize table of contents, et cetra
\ifCLASSOPTIONsubfigure
    % needed subfigure for compatibility
    % note that subfig should generally be used instead of subfigure
    \RequirePackage[subfigure,titles]{tocloft}
\else
    \RequirePackage[titles]{tocloft} % use tocloft package to modify toc
\fi

% don't indent before chapters or sections
\setlength{\cftchapindent}{0in}
\setlength{\cftsecindent}{0in}
\setlength{\cftsubsecindent}{0in}
\setlength{\cftsubsubsecindent}{0in}

% same spaces between section numbers and names
\setlength{\cftchapnumwidth}{4em}
\setlength{\cftsecnumwidth}{4em}
\setlength{\cftsubsecnumwidth}{4em}
\setlength{\cftsubsubsecnumwidth}{4em}

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

% command to create table of contents
\renewcommand{\tableofcontents}{%
    {\singlespace
        \centerline{TABLE OF CONTENTS}

        \vspace{3em}

        % insert table of contents
        \@starttoc{toc}
    }

    \newpage
}

% List of Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to make list of tables
\renewcommand{\listoftables}{%
    {\singlespace
        \centerline{LIST OF TABLES}

        \vspace{3em}

        % insert list of tables
        \@starttoc{lot}
    }

    \newpage
}

% List of Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to make list of figures
\renewcommand{\listoffigures}{%
    {\singlespace

        \centerline{LIST OF FIGURES}

        \vspace{3em}

        % insert list of figures
        \@starttoc{lof}
    }

    \newpage
}

% Body
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \frontmatter \mainmatter \backmatter and \appendix commands come 
% from the book class, not real need to override anything yet

% Referencing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% left-align bibliography entries by filling right of the label number
\renewcommand{\@biblabel}[1]{[#1]\hfill}

% bibliography environment
% tweaked from environment in book.cls
\renewenvironment{thebibliography}[1]{%
    % set up unnumbered chapter and add to table of contents
    \chapter*{\bibname}%
    \phantomsection%
    \addcontentsline{toc}{chapter}{\bibname}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%

    % create list of bibliography entries
    \list{\@biblabel{\@arabic\c@enumiv}}%
         {\settowidth\labelwidth{\@biblabel{#1}}%
          \leftmargin\labelwidth
          \advance\leftmargin\labelsep
          \@openbib@code
          \usecounter{enumiv}%
          \let\p@enumiv\@empty
          \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sfcode`\.\@m%
}
{\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
\endlist}

% define custom commands for creating references
% for tables, figures, equations and such
\RequirePackage{cite}
\newcommand{\eref}[1]{\eqref{#1}}       % cite equation
\newcommand{\fref}[1]{Figure~\ref{#1}}  % cite figure
\newcommand{\cref}[1]{Chapter~\ref{#1}} % cite chapter
\newcommand{\sref}[1]{Section~\ref{#1}} % cite section/sub(sub)section
\newcommand{\tref}[1]{Table~\ref{#1}}   % cite table
