# Stata levelsof implementation for unsorted lists
Currently the Stata implementation of the `levelsof` command returns a sorted list only.  However, there are cases where maintaining the sort order of the data is necessary.  For example, in the [brewscheme](https://github.com/wbuchanan/brewscheme) package, the RGB values that define a color palette need to be returned in the order specified in the dataset.  But the `levelsof` command does not currently support this.  In addition to the base functionality provided by `levelsof` the `levelsof2` command will return the results in the order in which the data are currently sorted as the default behavior and provides the same functionality as `levelsof` in addition.  The only currently known case where the functionality is not equivalent is in the handling of missing values when sorted.


# Example 1
Getting the unique values from a numeric variable

```Stata
. sysuse auto.dta, clear
(1978 Automobile Data)

. levelsof rep78 if foreign == 0
1 2 3 4 5

. levelsof2 rep78 if foreign == 0
3 4 2 5 1
```

# Example 2
Same as above, but including missing values

```Stata
. levelsof rep78 if foreign == 0, missing
1 2 3 4 5 .

. levelsof2 rep78 if foreign == 0, missing
3 . 4 2 5 1
```

# Example 3
Mirroring sort order

```Stata
. levelsof2 rep78 if foreign == 0, sorted
1 2 3 4 5

. levelsof2 rep78 if foreign == 0, missing sorted
. 1 2 3 4 5
```

# Example 4 
String data

```Stata
. levelsof make if rep78 == 4 
`"BMW 320i"' `"Buick Electra"' `"Chev. Impala"' `"Datsun 200"' `"Datsun 510"' 
> `"Datsun 810"' `"Ford Fiesta"' `"Honda Civic"' `"Mazda GLC"' `"Merc. Bobcat"' 
> `"Merc. Cougar"' `"Merc. XR-7"' `"Olds 98"' `"Olds Delta 88"' `"Pont. Catalina"' 
> `"VW Dasher"' `"VW Rabbit"' `"VW Scirocco"'

. levelsof2 make if rep78 == 4 
`"Buick Electra"' `"Chev. Impala"' `"Ford Fiesta"' `"Merc. Bobcat"' 
> `"Merc. Cougar"' `"Merc. XR-7"' `"Olds 98"' `"Olds Delta 88"' `"Pont. Catalina"' 
> `"BMW 320i"' `"Datsun 200"' `"Datsun 510"' `"Datsun 810"' `"Honda Civic"' 
> `"Mazda GLC"' `"VW Dasher"' `"VW Rabbit"' `"VW Scirocco"'
```

# Example 5
With user defined string delimiters

```Stata
. levelsof make if rep78 == 4, sep(", ")
`"BMW 320i"', `"Buick Electra"', `"Chev. Impala"', `"Datsun 200"', `"Datsun 510"', 
> `"Datsun 810"', `"Ford Fiesta"', `"Honda Civic"', `"Mazda GLC"', `"Merc. Bobcat"', 
> `"Merc. Cougar"', `"Merc. XR-7"', `"Olds 98"', `"Olds Delta 88"', 
> `"Pont. Catalina"', `"VW Dasher"', `"VW Rabbit"', `"VW Scirocco"'

. levelsof2 make if rep78 == 4, sep(", ")
`"Buick Electra"', `"Chev. Impala"', `"Ford Fiesta"', `"Merc. Bobcat"', 
> `"Merc. Cougar"', `"Merc. XR-7"', `"Olds 98"', `"Olds Delta 88"', `"Pont. Catalina"', 
> `"BMW 320i"', `"Datsun 200"', `"Datsun 510"', `"Datsun 810"', `"Honda Civic"', 
> `"Mazda GLC"', `"VW Dasher"', `"VW Rabbit"', `"VW Scirocco"'
```





