// Start Mata interpreter/session
mata:

/** 
 * Defines the Mata function levof which provides the functionality used by 
 * the levelsof2 command.  
 * @param var The name of the variable from which the values are to be retrieved
 * @param idx The name of the observation index variable created by levelsof2
 * @param sep An optional parameter used to place a character string between 
 *				elements of the values returned by the function
 * @param clean Attempt cleaning up returned values 
 * @param sorted
*/
void levelsof2(	string scalar var, string scalar idx, |  string scalar sep,  ///   
				string scalar clean, string scalar sorted) {
	
	// Matrix used to store the observation index created by levelsof2
	// Also declares the matrix used to store the observation index where each 
	// unique value first occurs in the data
	real matrix indices, minindices
	
	// Matrix used to store the values of interest from the variable defined 
	// 		by {@param var}.
	// uvals stores the unique values from {@param var}
	// retvals stores the values that will be returned prior to inserting any 
	// 		of the values that may be specified in {@param sep}.
	transmorphic matrix variableValues, uvals, retvals
	
	// i is a scalar used for iteration by the for loop below
	// isnum stores an indicator of whether or not the variable specified in 
	//		{@param var} is numeric or string
	real scalar i, isnum
	
	// Stores the quotation mark ASCII code used to enclose elements in 
	// 		quotation marks if the {@param var} is a string type
	// cleanpat stores the regular expression used by the clean option
	// open defines compound double quotes for string opening
	// close defines compount double quotes for string closing
	string scalar q, cleanpat, open, close
	
	// Indicates whether the variable of interest is numeric
	isnum = st_isnumvar(var)
		
	// Quotation mark character
	q = char((34))
	
	// Regex used to test for clean option
	cleanpat = char(96) + "|" + char(34) + "|" + char(39)
	
	// Opening compound double quotes
	open = char((96, 34))
	
	// Closing compound double quotes
	close = char((34, 39))

	// Gets the index variable created by levelsof2
	st_view(indices, ., (idx), 0)
	
	// Gets a string view onto the data of the variable of interest
	if (isnum == 0) st_sview(variableValues, ., (var))
	
	// Gets a numeric view onto the data of the variable of interest
	else st_view(variableValues, ., (var))

	// Gets the unique values from the variable of interest
	// These are sorted by default
	uvals = uniqrows(variableValues[indices, .])
	
	// Initializes a matrix to store the first index value for each unique value
	minindices = J(rows(uvals), 1, .)
	
	// Loop over the unique values from the variable of interest
	for(i = 1; i <= rows(uvals); i++) {
	
		// Select the observation indices from the variable of interest where 
		// the value equals the current unique value.  Then select the minimum 
		// value of the observation indices of those returned and store them
		// in the minindices matrix
		minindices[i, 1] = min(selectindex(variableValues[., 1] :== uvals[i, 1]))
		
	} // End Loop over unique values
	
	// For numeric variables, the matrix of returned values will select the 
	// values of the variable of interest based on the sorted order of 
	// the observation indices (e.g., the order of data in the dataset) and cast 
	// to string values
	if (isnum == 1) retvals = strofreal(variableValues[sort(minindices, 1), 1])
	
	// Do the same for string variables, but enclose each value in quotation 
	// marks
	else {
	
		// Get the variable values that need to be returned
		variableValues = variableValues[sort(minindices, 1), 1]
		
		// Loop over records in the values
		for(i = 1; i <= rows(minindices); i++) {
			
			// Check for clean option
			if (clean != "") {
			
				// If string contains any quottation marks enclose it in 
				// compound double quotes
				variableValues[i, 1] = open + variableValues[i, 1] + close
		
			} // End IF Block for clean 
			
			// If clean option automatically returns values in compound double 
			// quotes if any quotation mark characters are found in the string
			else if (regexm(variableValues[i, 1], `"`|"|'"') == 1) {
			
				// Enclose strings in compound double quotes
				variableValues[i, 1] = open + variableValues[i, 1] + close

			} // End of ELSEIF Block for non-clean option
			
			// For all other cases
			else {
			
				// Use regular quotation marks around the values
				variableValues[i, 1] = q + variableValues[i, 1] + q
				
			} // End ELSE Block for all other cases	
			
		} // End of Loop over the values that will be returned
		
		// Sets the return values matrix
		retvals = variableValues
		
	} // End of ELSE Block for string variable
	
	// If user requests sorted values
	if (sorted != "") retvals = sort(retvals, 1)
	
	// If the user specified a separation character insert it when returning the
	// values to the local macro mylevels
	if (sep != "") st_strscalar("levels", invtokens(retvals', sep))
	
	// Otherwise just return the values in the local mylevels
	else st_strscalar("levels", invtokens(retvals'))
	
} // End of Mata function definition

// Exit Mata 
end
	
