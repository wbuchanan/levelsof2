{smcl}
{* *! version 0.0.1 13apr2016}{...}
{vieweralsosee "[P] levelsof" "mansection P levelsof"}{...}
{viewerjumpto "Syntax" "levelsof##syntax"}{...}
{viewerjumpto "Description" "levelsof##description"}{...}
{viewerjumpto "Options" "levelsof##options"}{...}
{viewerjumpto "Remarks" "levelsof##remarks"}{...}
{viewerjumpto "Examples" "levelsof##examples"}{...}
{viewerjumpto "Stored results" "levelsof##results"}{...}
{viewerjumpto "References" "levelsof##references"}{...}
{title:Title}

{p2colset 5 21 23 2}{...}
{p2col :{manlink P levelsof} {hline 2}}Levels of variable{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:levelsof}
{varname}
{ifin}
[{cmd:,} {it:options}]

{synoptset 21}{...}
{synopthdr}
{synoptline}
{synopt:{opt l:ocal(macname)}}insert the list of values in the local macro {it:macname}{p_end}
{synopt:{opt s:eparate(separator)}}separator to serve as punctuation for the values of returned list; default is a space{p_end}
{synopt:{opt c:lean}}display string values without compound double quotes{p_end}
{synopt:{opt miss:ing}}include missing values of {varname} in calculation{p_end}
{synopt:{opt so:rted}}returns sorted results{p_end}
{synopt:{opt comp:ile}}used to compile the mata source into an object file; the program checks for the existence of the object file and will not run the mata source if the compiled object file already exists.  This should help with speed/performance in some cases.{p_end}

{synoptline}
{p2colreset}{...}


{marker description}{...}
{title:Description}

{pstd}
{cmd:levelsof2} displays and returns a list of the unique values of {varname} in 
the order it appears in the dataset, or optionally in sorted order.



{marker options}{...}
{title:Options}

{p 4 4 4}{hi:Material below is filler from levelsof will be altered soon}{p_end}

{phang}
{cmd:local(}{it:macname}{cmd:)} inserts the list of values in
local macro {it:macname} within the calling program's space.  Hence,
that macro will be accessible after {cmd:levelsof} has finished.
This is helpful for subsequent use, especially with {helpb foreach}.

{phang}
{cmd:separate(}{it:separator}{cmd:)} specifies a separator
to serve as punctuation for the values of the returned list.
The default is a space.  A useful alternative is a comma.

{phang}
{cmd:clean} displays string values without compound double quotes.
By default, each distinct string value is displayed within compound double
quotes, as these are the most general delimiters.  If you know that the
string values in {varname} do not include embedded spaces or embedded
quotes, this is an appropriate option.  {cmd:clean} 
does not affect the display of values from numeric variables.

{phang}
{cmd:missing} specifies that missing values of {varname}
should be included in the calculation.  The default is to exclude them.

{phang}
{cmd:sorted}

{phang}
{cmd:compile}

{marker remarks}{...}
{title:Remarks}

{pstd}
{cmd:levelsof2} serves as an alternative to {help levelsof} for cases where you 
would like the unique values of {it:varname} returned in the order in which they 
occur in the data set.  Additionally, the results are automatically stored in a 
scalar {hi:levels} that can be used in subsequent commands to iterate over the 
values.  If the length of the returned scalar is small enough, it is also placed 
in the returned macro {hi:r(levels)}, but if it is too large the program will 
split the strings based on the maximum length of local macros on the system and 
place the results in returned macros {hi:r(levels#)} where the # supplies an index 
value indicating the order in which the contents were extracted.  This should 
help to avoid the existing limitations based on macro length that are imposed by 
the native {help levelsof} command.

{marker examples}{...}
{title:Examples}

{p 8 8 12}{stata sysuse auto}

{p 8 8 12}{stata levelsof2 rep78}{p_end}

{p 8 8 12}{stata levelsof2 rep78, miss local(mylevs)}{p_end}
{p 8 8 12}{stata display "`mylevs'"}

{p 8 8 12}{stata levelsof2 rep78, sep(,)}{p_end}

{marker results}{...}
{title:Stored results}

{pstd}
{cmd:levelsof2} stores the following in {cmd:r()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Macros}{p_end}
{synopt:{cmd:r(levels)}}list of distinct values{p_end}
{p2colreset}{...}

{pstd}
{cmd:levelsof2} also stores the results in a globally accessible scalar:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt:{cmd:levels}}list of distinct values{p_end}
{p2colreset}{...}

{marker author}{...}
{title:Author}{break}
{p 4 4 8}William R. Buchanan, Ph.D.{p_end}
{p 4 4 8}Data Scientist{p_end}
{p 4 4 8}{browse "http://mpls.k12.mn.us":Minneapolis Public Schools}{p_end}
{p 4 4 8}William.Buchanan at mpls [dot] k12 [dot] mn [dot] us{p_end}

