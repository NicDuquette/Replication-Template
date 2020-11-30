/* Import the data to Stata and prepare it for analysis */

    /* The "///" at the end of a line tells Stata to ignore any
       comments following on the same line AND to continue the command
       onto the next line. 
       
       A "//" will allow a trailing comment, but end the command there.
       
       We will use the "import delimited" command to pull in a file
       that stores data using comma separated values (csv) */

import delimited                    ///
    using "${data}/state_data.csv", ///
    clear                           /// clear any data already in memory
    varnames(1)                     //  Use row 1 as variable names
    

    // Add Stata labels to each variable
label var stpostal "State Postal"
label var grads "High School Graduates (%)" 
label var ur "Unemployment Rate (%)"
label var pop "Population (1000s)"
label var pcpi "Per Capita Personal Income ($)"
label var stfips "State FIPS number (2-digit)"
label var fipsnum "State FIPS number (5-digit)"


    // The raw data were sorted alphabetically by postal code.
    // Let's sort by FIPS (which is alphabetical by full state name)
sort stfips

    // Make sure each variable is stored in the most compact possible 
    // format
compress

    // Save clean data in Stata format to the temp folder
save "${temp}/stata_data_clean", replace
