// Drop the program from memory if previously loaded
cap prog drop levelsof2

// Defines r-class program
prog def levelsof2, rclass

	// Requires version 13 or later
	version 13
	
	// Use same syntax as levelsof with exception of a sort option
	syntax varname [if] [in] [, Local(string asis) Separate(string asis) 	 ///   
	Clean MISSing SOrted COMPile]
	
	// Gets maximum length for a macro
	loc maxlen = `c(macrolen)'
	
	// Check compile option
	if `"`compile'"' != "" {
	
		// Find the file with the mata source
		cap: findfile levelsof2.mata
		
		// Run the do file to define the mata function
		if _rc == 0 qui: do `"`r(fn)'"'
		
		// Throw error for file not found 
		else err 601
		
		// Save the mata object file
		qui: mata: mata mosave levelsof2(), dir(`"`c(sysdir_personal)'"') replace
		
	} // End IF Block for compile option
	
	// If compile option not specified
	else {
			
		// Check for .mo file
		cap: findfile levelsof2.mo
		
		// If file not found
		if _rc != 0 {
		
			// Make sure function not already defined
			cap: mata: mata drop levelsof2()
		
			// Find the source code file
			cap: findfile levelsof2.mata
			
			// If Found execute it
			if _rc == 0 qui: do `"`r(fn)'"'
			
			// Or throw an error
			else err 601
			
		} // End IF BLOCK when mata object file not found
	
	} // End ELSE Block for compilation option
	
	// Generates a temporary variable used to index the relevant records
	tempvar levelsof2var
	
	// Defines local used to include missing values
	if `"`missing'"' != "" loc nvl "novarlist"
		
	// Marks the sample that will be used by the command	
	marksample touse, strok `nvl'
	
	// Create the observation index
	qui: g `levelsof2var' = _n if `touse'
	
	// Call to mata function that does all the leg work
	qui: mata: levelsof2("`varlist'", "`levelsof2var'", "`separate'", "`clean'", "`sorted'")

	// If the scalar can fit inside a macro
	if (length(levels) <= `maxlen') {
	
		// Stores results in a local defined by the user
		if `"`local'"' != "" c_local `local' `"`= levels'"'
		
		// Returns the results in the macro r(mylevels)
		ret loc levels levels

	} // End IF Block for small enough local
	
	// If too large to fit in a macro
	else {
		
		// Set a series of local macros 
		forv i = 1/ceil(length(levels) <= `maxlen') {
		
			// Sets the initial iterator
			if `i' == 1 loc minindex = 1
			
			// Moves the end of the chunk the maximum number of characters for 
			// a local macro
			loc maxindex = `maxlen' * `i'
			
			// Returns the string to the user
			ret loc levels`i' `"`: di substr(levels, `minindex', `maxindex')'"'
		
			// Increments the minimum index 1 past the current maximum
			loc minindex = `maxindex' + 1
		
		} // End Loop over the chunks to return
		
	} // End ELSE Block when string is too large for a macro	
		
	// Displays the results
	di as res levels

// End of program	
end	
			
