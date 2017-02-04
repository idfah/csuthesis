%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colorado State University LaTeX Thesis Document Class
%
% by
%   Elliott Forney
%   2017/01/20
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
\ProvidesClass{thesis}[2017/01/20 Colorado State University Thesis]

% provide classoption for dense, single-spaced layout
% this is useful for printing, proofreading and distribution
% notdense by default
\newif\ifCLASSOPTIONdense
\newif\ifCLASSOPTIONnotdense
\DeclareOption{dense}{\CLASSOPTIONdensetrue \CLASSOPTIONnotdensefalse}
\DeclareOption{notdense}{\CLASSOPTIONdensefalse \CLASSOPTIONnotdensetrue}

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
\ExecuteOptions{notdense,master}

% process options
\ProcessOptions\relax

% book class is used as a base
\LoadClass{book}

% Formatting and style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{times}
%\RequirePackage{mathptmx}

% configure page size and margins
\RequirePackage{geometry}
\ifCLASSOPTIONnotdense
    \geometry{verbose,
              letterpaper, % letter paper
              includefoot, % room for footers
              lmargin=1in, rmargin=1in, % 1in margins
              tmargin=1in, bmargin=1in}

% smaller margins for dense layout
\else
    \geometry{verbose,
              letterpaper, % letter paper
              includefoot, % room for footers
              lmargin=0.75in, rmargin=0.75in,
              tmargin=0.75in, bmargin=0.75in}
\fi

% use plain page style with page number at bottom
\pagestyle{plain}

% this makes the typesetting rules less strict
% helps prevent hbox overflow and such
%\sloppy

% use double spacing unless using dense layout
\ifCLASSOPTIONdense
    \RequirePackage{setspace}
\else
    \RequirePackage[doublespacing]{setspace}
\fi

% hook to center all floats, e.g, tables and figures
\g@addto@macro\@floatboxreset\centering

% titlesec is used to modify chapter and section headings
\RequirePackage{titlesec}

% set up fonts and spacing around the chapter headings
\titleformat{\chapter}[display]
    {\normalfont\bfseries\Huge}
    {\chaptertitlename\ \ \thechapter}{0em}{\bfseries\Huge}
    %{\chaptertitlename\ \ \thechapter}{0em}{\bfseries}
    %{\chaptertitlename\ \ \thechapter:}{1em}{\bfseries\Large}
    %{\MakeUppercase{\chaptertitlename}\ \ \thechapter:}{1em}{\bfseries\uppercase}
\titlespacing*{\chapter}{0em}{-2.5em}{1.5em}
%\titlespacing*{\chapter}{0em}{0em}{0.5em}

%%\ifCLASSOPTIONnotdense
%%    % set up fonts and spacing around the section headings
%%    %%\titleformat{\section}
%%    %%    {\normalfont\bfseries}
%%    %%    {\thesection}{1em}{\bfseries}
%%    %\titlespacing*{\section}{0em}{0em}{\baselineskip}
%%    \titlespacing*{\section}{0em}{\baselineskip}{0em}
%%
%%    % set up fonts and spacing around the subsection headings
%%    %%\titleformat{\subsection}
%%    %%    {\normalfont\bfseries}
%%    %%    {\thesection}{1em}{\bfseries}
%%    \titlespacing*{\subsection}{0em}{\baselineskip}{0em}
%%
%%    % set up fonts and spacing around the subsubsection headings
%%    %%\titleformat{\subsubsection}
%%    %%    {\normalfont\bfseries}
%%    %%    {\thesection}{1em}{\bfseries}
%%    \titlespacing*{\subsubsection}{0em}{\baselineskip}{0em}
%%\fi

% captions
%\RequirePackage{caption}
%\captionsetup{font=small,labelfont=bf} % makes captions use small font with bold label
%\captionsetup{font=small} % makes captions use small font

% discourage single lines from being at top or bottom
% widows are slightly worse than orphans here
%\clubpenalty=9996 % penalty for breaking after first line of a paragraph
%\widowpenalty=9999 % penalty for breaking before last line of a paragraph

% internal command used to suppress indentation
\newcommand{\@zeroindent}{\setlength{\parindent}{0in}}

% Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% command to set department name
\def\@department{Department of Computer Science}
\newcommand{\department}[1]{\def\@department{#1}}

% command to set author's email
\def\@email{youremail@colostate.edu}
\newcommand{\email}[1]{\def\@email{#1}}

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

% title page for notdense layout
\ifCLASSOPTIONnotdense
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

% title page for dense layout
\else
    \renewcommand{\maketitle}{%
        \begin{center}
            {\large \@zeroindent
                % title in all caps
                {\LARGE \@title \par}

                \vspace{0.5in}

                % for honor, master or doctor
                \ifCLASSOPTIONhonor
                    Honor's Thesis
                \fi
                \ifCLASSOPTIONmaster
                    Master's Thesis
                \fi
                \ifCLASSOPTIONdoctor
                    Dissertation
                \fi

                \vspace{0.5in}
                \noindent \@semester
                \vspace{0.5in}

                \@author \\
                Colorado State University \\
                \@department \\
                \@email

                \vspace{0.5in}
            }
        \end{center}

        \thispagestyle{empty} % no page number here
        \newpage % start new page
    }
\fi

% Copyright
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default copyright
\def\@mycopyright{Copyright by \@author \\ All Rights reserved}

% command to set copyright
\newcommand{\mycopyright}[1]{\def\@mycopyright{#1}}

% copyright page
\newcommand{\makemycopyright}{%
    % add copyright page to table of contents
    \phantomsection
    \addcontentsline{toc}{chapter}{Copyright}

    \begin{center}
        \vspace*{\fill}
        {\@zeroindent \@mycopyright}
        \vspace*{\fill}
    \end{center}

    % \thispagestyle{empty} % no page number here
    \newpage
}

% Abstract
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% default abstract
\def\@abstract{Abstract goes here.}

% command to set abstract
\newcommand{\abstract}[1]{\def\@abstract{#1}}

% abstract page for notdense layout
\ifCLASSOPTIONnotdense
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

        \noindent \@abstract \par

        \newpage
    }

% abstract page for dense layout
\else
    \newcommand{\makeabstract}{%
        \def\sep{0.75\baselineskip}
        {\@zeroindent \setlength{\parskip}{\sep}
            \vspace{\sep}
            \centerline{\large{ABSTRACT}}
            \vspace{\sep}
            \hrule

            \@abstract \par
            
            \vspace{\sep}
            \hrule
        }

        \newpage
    }
\fi

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

    \noindent \@acknowledgements \par

    \newpage
}

% Table of Contents
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% customize table of contents in notdense layout
\ifCLASSOPTIONnotdense
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

    % spacing between lines
    %\setlength{\cftbeforechapskip}{0em}

    %%% don't leave space above or below title
    %%\setlength{\cftbeforetoctitleskip}{0em}
    %%\setlength{\cftaftertoctitleskip}{0em}

    %%% set name of toc
    %%% \renewcommand\contentsname{\centering\normalsize\normalfont TABLE OF CONTENTS}% \vspace{3em}}


    % command to create table of contents page
    \renewcommand{\tableofcontents}{%
        { \singlespace
            \centerline{TABLE OF CONTENTS}

            \vspace{3em}

            % insert table of contents here
            % using internal starttoc command
            \@starttoc{toc}

            % could use \@tableofcontents instead of above
            % but have to rely on tocloft to make title too
            % \@tableofcontents
        }

        \newpage
    }
\fi

% List of Tables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% customize list of table for notdense layout
\ifCLASSOPTIONnotdense
    \renewcommand{\listoftables}{%
        % add list of tables to table of contents
        %\phantomsection
        %\addcontentsline{toc}{chapter}{List Of Tables}

        { \singlespace
            \centerline{LIST OF TABLES}

            \vspace{3em}

            %%\let\origaddvspace\addvspace hack to get rid of chapter spaces XXX
            %%\renewcommand{\addvspace}[1]{}

            % insert list of tables from internal starttoc command
            \@starttoc{lot}
            %\renewcommand{\addvspace}[1]{\origaddvspace{#1}}
            %%\let\addvspace\origaddvspace
        }

        \newpage
    }
\fi

% List of Figures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% customize list of figures for notdense layout
\ifCLASSOPTIONnotdense
    \renewcommand{\listoffigures}{%
        % add to table of contents
        %\phantomsection
        %\addcontentsline{toc}{chapter}{List Of Figures}

        { \singlespace

            \centerline{LIST OF FIGURES}

            \vspace{3em}

            % insert list of figures from internal starttoc command
            \@starttoc{lof}
        }

        \newpage
    }
\fi

% Body
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\renewcommand{\frontmatter}{%
%    \@mainmatterfalse
%    \pagenumbering{roman}
%}
%
%\renewcommand{\mainmatter}{%
%    \@mainmattertrue
%    %\setcounter{page}{1}
%    \pagenumbering{arabic}
%}
%
%\renewcommand{\backmatter}{%
%    \@mainmatterfalse
%    \clearpage
%}

% Referencing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define custom commands for creating references
\RequirePackage{cite}
\newcommand{\eref}[1]{\eqref{#1}}       % cite equation
\newcommand{\fref}[1]{Figure~\ref{#1}}  % cite figure
\newcommand{\cref}[1]{Chapter~\ref{#1}} % cite chapter
\newcommand{\sref}[1]{Section~\ref{#1}} % cite section/sub(sub)section
\newcommand{\tref}[1]{Table~\ref{#1}}   % cite table
