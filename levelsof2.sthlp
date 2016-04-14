{smcl}
{* *! version 0.0.1 13apr2016}{...}
{vieweralsosee "[P] levelsof" "mansection P levelsof"}{...}

{hline}
Accessing distinct values of a variable in the order the values appear in the data.
{hline}

{title:help for levelsof2}

{p 4 4 4}{hi:levelsof2 {hline 2}} is an alternative implementation to the 
{manlink P levelsof} command that provides a way to access the values in the 
order in which they occur in the dataset.{p_end}

{title:Syntax}

{p 4 4 4}{cmd:levelsof2} {varname} {ifin} [{cmd:,} {it:options} ]{p_end}

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

{marker options}{...}
{title:Options}


{p 4 4 8}{cmd:local} will attempt to place the list of values in a local macro 
named with the argument passed to this parameter.  In cases where the length of 
the list is greater than the maximum allowable size of a macro, it will attempt 
to create a series of macros with the name and numeric indices indicating the 
order of the segments.  Regardless of the size, the results can be accessed in 
a scalar named levels that contains all of the elements.{p_end}

{p 4 4 8}{cmd:separate} used to specify a token delimiter for the list elements. 
This can be used to create comma delimited lists that can be passed to functions 
such as {help inlist) in subsequent commands. {p_end}

{p 4 4 8}{cmd:clean} encloses string elements that contain any quotation mark 
characters (e.g., left/right tick or quotation marks) in compound double quotes 
or encloses the string elements in double quotation marks.  This will also trigger 
the full list of results to be wrapped in compound double quotes.  This option 
{hi:does not} affect the results from numeric variables.{p_end}

{p 4 4 8}{cmd:missing} specifies that missing values of {varname}
should be included in the calculation.  The default is to exclude them. {p_end}

{p 4 4 8}{cmd:sorted} will return the results in sorted order.  This is nearly 
identical to the behavior of {help levelsof} with the exception of the placement 
of missing values.  {it:Missing numeric values will appear first with this option}.{p_end}

{p 4 4 8}{cmd:compile} is an option used to compile the underlying Mata code into 
an object file.  If the option is specified it will overwrite an existing copy of 
the compiled object file.  If the option is not specified the program will check 
to see if the object file exists or will first run the Mata source.{p_end}

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
{synopt:{cmd:r(distinct)}}number of distinct values{p_end}
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

