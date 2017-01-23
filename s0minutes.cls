% s0minutes.cls
% Stratum 0 CI -- meeting minutes
% 2016-Dec-15 Roland Hieber <rohieb+stratum0-latex-qua1aiMe@rohieb.name>
% 
% Heavily inspired by Jim Hefferon's "Minutes in Less Than Hours":
% http://tutex.tug.org/pracjourn/2005-4/hefferon/hefferon.pdf

% --- Class structure: identification part
% ---
\ProvidesClass{s0minutes}[2016/12/15 version 1.00 Stratum 0 Corporate Identity -- Meeting Minutes]
\NeedsTeXFormat{LaTeX2e}

% --- Class structure: declaration of options part
% ---
% This class extends the article class
% Read all the documentclass options; pass them to article,
% unless the file "<currentoption>.s0c" exists, then it is loaded
\DeclareOption*{\InputIfFileExists{\CurrentOption.s0c}{}{%
\PassOptionsToClass{\CurrentOption}{s0artcl}}}

% --- Class structure: execution of options part
% ---
\ProcessOptions \relax

% --- Class structure: declaration of options part
% ---
\LoadClass{s0artcl}

% -- Helper packages
% --
%\RequirePackage{ifthen}
\RequirePackage{framed}  % leftbar environment etc.
\RequirePackage{dingbat}  % \leftthumbsup etc.
\RequirePackage[svgnames,table]{xcolor}

% -- Tweak section numbering
% set table of contents number field to max width of section numbers
\let\theoldsection\thesection
\renewcommand*{\thesection}{TOP \theoldsection}
\setcounter{section}{-1} % Real hackers start counting at 0
\settowidth{\cftsecnumwidth}{TOP 10 }
\settowidth{\cftsubsecnumwidth}{TOP 1.10 }

% -- User Commands and Environments
% --

% Meeting information, to be used in the preamble:
% 1. Type of the meeting (e.g., board meeting, general meeting, etc.)
% 2. Date of the meeting
% 3. Starting time,
% 4. Place of the meeting
% 5. (List of) attending people
% 6. (List of) absent people, if any
% 7. Name of minute taker
\makeatletter
\newcommand*{\meetingminutes}[7]{%
	\def\sn@typeofmeeting{#1}%
	\def\sn@date{#2}%
	\def\sn@startingtime{#3}%
	\def\sn@place{#4}%
	\def\sn@attendants{#5}%
	\def\sn@absentees{#6}%
	\def\sn@minutetaker{#7}%
	\AtBeginDocument{%
		\title{\sn@typeofmeeting{} \sn@date}%
		\date{}
		\subject{Stratum~0~e.\,V.}
	}%
}
\def\boardmeeting{Vorstandssitzung}
\def\generalassembly{Mitgliederversammlung}
\newcommand*{\sn@meetinginfo}{%
\begin{tabular}{rl}
	Ort: & \sn@place \\
	Zeit: & \sn@date, \sn@startingtime \\
	Anwesend: & \sn@attendants \\
\ifx\sn@absentees\empty
	\empty
\else
	Abwesend: & \sn@absentees \\
\fi
	Protokoll: & \sn@minutetaker \\
\end{tabular}
}
\def\@author{\sn@meetinginfo} %% This is just a dirty hack to get it into \maketitle
\newcommand{\meetingpreamble}{\sn@meetinginfo}

% Signals the end of the meeting.
% 1. Closing time of the meeting
\newcommand*{\meetingend}[1]{%
\begin{description}
	\item[Ende:] #1
\end{description}
\clearpage
\sn@signatures
}

\newcommand*{\sn@signatures}{%
\section*{Unterschriften}
\vspace{0.7cm}
\noindent Protokollführer: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Vorstandsvorsitzender: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Stellv. Vorsitzender: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Schatzmeister: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Beisitzer: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Beisitzerin: \hrulefill\hfill\phantom{c}\par
\vspace{0.7cm}
\noindent Beisitzer: \hrulefill\hfill\phantom{c}\par
}

% Resolutions
% 1. Reference number,
% 2. Vote information, use \vote, \consensus
% 3. Short text of the resolution,
% 4. Allocated money, if any (optional)
% 5. (only in resolution environment) Additional text
\newcommand*{\sn@resolution}[4]{%
\textbf{#1: #3}\ifthenelse{\equal{#4}{}}{}{ (#4)}
\hfill% when breaking, prevent stretching the line to be justified
\penalty100%
%\allowbreak% prefer breaking here 
%\addtolength{\textwidth}{3em}
\hspace*{.1em} \hfill \mbox{#2}%\penalty-100 % keep this together. when breaking, fill to flush-right
}
% our own little frame environment for resolutions
\def\sn@flushleftbarwidth{5pt}
\def\sn@flushleftbarspace{10pt}
\def\sn@resolutioncolor{gray!15}
\newlength{\sn@titlelength}
\newenvironment{sn@flushleftbar}{%
\def\FrameCommand{%
\hskip-\sn@flushleftbarwidth \hskip-\sn@flushleftbarspace%
\textcolor{\sn@resolutioncolor}{\vrule width \sn@flushleftbarwidth \hspace{\sn@flushleftbarspace}}}
\MakeFramed{\advance\hsize-\width \FrameRestore}}%
{\endMakeFramed}
%\newcommand*{\shortresolution}[4]{%
	%\addtolength{\textwidth}{3em}
	%\raggedright
	%\sn@resolution{#1}{#2}{#3}{#4}
	%\addtolength{\textwidth}{-3em}
%}
\colorlet{shadecolor}{\sn@resolutioncolor}%
\newenvironment{resolution}[4]{%
%\settowidth{\sn@titlelength}{#1}
%\vspace{-\parskip}%
\vspace{-\FrameSep}%
\vspace{\ifdim\FrameSep<\parskip\parskip\else\FrameSep\fi}
%\ifdim\FrameSep<\parskip\vspace{\parskip}\else\vspace{\FrameSep}\fi}
\begin{shaded}
\sn@resolution{#1}{#2}{#3}{#4}%
%\textcolor{\sn@resolutioncolor}{\hrule depth \sn@flushleftbarwidth width \sn@titlelength}%
%\textcolor{\sn@resolutioncolor}{\rule{10em}{\sn@flushleftbarwidth}}%
%\hbox{\vrule width \sn@flushleftbarwidth depth\baselineskip}%
%\vspace{-\sn@flushleftbarwidth}
%\vskip-4cm%
%\begin{sn@flushleftbar}
\par
}{%
%\end{sn@flushleftbar}
\setlength{\FrameSep}{0pt}%
\vspace{-.2\baselineskip}% colorbox bottom margin ends up a bit too much
\end{shaded}%
\vspace{-\parskip}%
\vspace{-\FrameSep}%
\vspace{\ifdim\FrameSep<\parskip\parskip\else\FrameSep\fi}
%\ifdim\FrameSep<\parskip\vspace{\parskip}\else\vspace{\FrameSep}\fi}
}

% Adoption, rejection, votes, consensus
\newcommand{\adopted}{Angenommen \leftthumbsup}
\newcommand{\rejected}{Abgelehnt \rightthumbsdown}
\newcommand{\vote}[4]{(#2/#3/#4) #1}
\newcommand{\consensus}[1]{#1 (Konsens)}

% Break of a specified time (first parameter)
\newcommand{\meetingbreak}[1]{
\begin{center}
	\emph{(Pause #1)}
\end{center}
}

\makeatother
% vim: set tw=100 noet sw=2 ts=2 sts=2:
