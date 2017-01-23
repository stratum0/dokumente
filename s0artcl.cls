% s0artcl.cls
% Stratum 0 CI -- article class
% 2016-Dec-07 Roland Hieber <rohieb+stratum0-latex-qua1aiMe@rohieb.name>
% 
% Heavily inspired by Jim Hefferon's "Minutes in Less Than Hours":
% http://tutex.tug.org/pracjourn/2005-4/hefferon/hefferon.pdf

% --- Class structure: identification part
% ---
\ProvidesClass{s0artcl}[2016/12/07 version 1.00 Stratum 0 Corporate Identity -- Article]
\NeedsTeXFormat{LaTeX2e}

% --- Class structure: declaration of options part
% ---
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.s0c" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{\CurrentOption.s0c}{}{%
\PassOptionsToClass{\CurrentOption}{scrartcl}}}

% --- Class structure: execution of options part
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options part
% ---
\LoadClass{scrartcl}

% --- Helper packages
% ---
\RequirePackage{xpatch}
\RequirePackage{hyperref}
\hypersetup{colorlinks=false,pdfborder=0 0 0}
\urlstyle{sf}

% --- Page Layout
% ---
\RequirePackage[left=2.5cm,right=2.5cm,top=2cm,bottom=2.5cm]{geometry}

% -- Optimize vertical spacing
% --
\RedeclareSectionCommand[afterskip=0.5em]{section}
%\RedeclareSectionCommand[beforeskip=1em, afterskip=0.5em]{section}
%\RedeclareSectionCommand[beforeskip=1em, afterskip=0.1em]{subsection}
%\RedeclareSectionCommand[beforeskip=1em, afterskip=0.1em]{subsubsection}
\RedeclareSectionCommand[beforeskip=.5\parskip, afterskip=-1em]{paragraph}
%\setparsizes{0pt}{.5em}{0pt plus 1fil}
%\setlength{\parskip}{0.5em plus 0.1em minus 0.3em}
\setlength{\parindent}{0em}
%\setlength{\parsep}{0pt}
%\setlength{\headsep}{24pt}
%\setlength{\topskip}{0pt}
%\setlength{\topsep}{0pt}
%\setlength{\partopsep}{0pt}
%\setlength{\footskip}{32pt}
\RequirePackage{enumitem}
\setlist{nosep}

% list bullets, section prefix
%\renewcommand{\labelenumi}{(\arabic{enumi})}
%\renewcommand{\labelitemi}{--}

\RequirePackage{tocloft}
\setlength{\cftbeforesecskip}{0.3\baselineskip}
% tocloft renders the table of contents header in serif font...
\renewcommand{\cfttoctitlefont}{\usekomafont{section}}

% --- Default Fonts
% ---

% Yanone Kaffeesatz ZeroHack for titles etc.
\RequirePackage{yanonekaffeesatzzerohack}
\setkomafont{title}{\usefont{LY1}{YanoneKaffeesatzZeroHack}{b}{n}}
\setkomafont{subtitle}{\usefont{LY1}{YanoneKaffeesatzZeroHack}{l}{n}\Large}
\setkomafont{subject}{\normalfont\large}
\setkomafont{author}{\normalfont\large}
\setkomafont{date}{\normalfont\large}
% FIXME: adjust tracking for footnotesize
%\setkomafont{footnote}{\footnotesize\lsstyle}
%\RequirePackage[tracking=footnotesize]{microtype}  % for letterspacing
%\microtypesetup{tracking=footnotesize}
%\UseMicrotypeSet[tracking]{footnotesize}
%\SetTracking{footnotesize}{50}
% koma-script has an explicit \usekomafont{title}{\huge \@title}...
% see http://tex.stackexchange.com/a/82851
\makeatletter
\xpatchcmd{\maketitle}{\huge}{\Huge}{}{}
\xpatchcmd{\@maketitle}{\huge}{\Huge}{}{}
\makeatother
\setkomafont{section}{\usefont{LY1}{YanoneKaffeesatzZeroHack}{b}{n}\huge}
\setkomafont{subsection}{\usefont{LY1}{YanoneKaffeesatzZeroHack}{l}{n}\LARGE}
% yanonekaffeesatzzerohack really needs a [nodefault] option...
\renewcommand*{\encodingdefault}{T1}

% Droid for all the rest
\RequirePackage[default]{droidsans}
\RequirePackage[defaultmono]{droidmono}

% vim: set tw=100 noet sw=2 ts=2 sts=2:
