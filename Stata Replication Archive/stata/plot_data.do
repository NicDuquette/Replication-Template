/* Create a scatterplot of high school graduates versus unemployment rate */

	// Load the cleaned data
use "${temp}/stata_data_clean", clear	

	// Create a new variable for plotting that will tell
	// Stata to label states using bold ("bf:") and
	// monospace ("stMono:") text. This is a Stata-specific
	// text-formatting syntax called SMCL.
	// See more at:
	// https://www.stata.com/manuals/psmcl.pdf
gen stlabel="{bf:{stMono:"+stpostal+"}}"

    // ====================================================
    // Create the chart, a scatterplot of state-level
    // unemployment rate vs. share of the population with
    // graduate degrees.
    
#delimit ;                           // The #delimit ; tells Stata that the
                                     // commadn ends when it gets to a 
                                     // semicolon, not at the end of the 
                                     // line of text. 
twoway
    (scatter ur grads,               // Create a scatterplot
        msymbol(i)                   //  No marking symbol (i = invisible)
        mlabel(stlabel)              //  Instead, label with "stlabel"
        mlabpos(0)                   //  ... where the marker symbol would be
        mlabcolor(black)             //  ... black color,
        mlabsize(medium)             //  ... and medium size
    )
	
    (lfit ur grads,                  // Overlay a plot of the OLS fit line,
        lcolor(gs8)                  //  ... in a midrange gray color
        lpattern(dash)               //  ... with a dashed line
    )
    ,                                // The comma tells Stata we are moving
	                                 // to graph-wide options now
									 
    scheme(s1mono)                   // Set defaults to basic monochrome
	
    legend(off)                      // Do not add a legend
	
    ylabel(                          // Label the y-axis
        3(1)7 7 "7%"                 // Manually add or modify labels using
        ,                            // quotes to get % or $ once
        angle(horizontal)            // Angle the labels for readability
        labsize(medium)
    )    
	
    ytitle("Unemployment" "Rate",     // Title the y-axis
	                                  //  Separate quotes = line breaks
        orientation(horizontal)       // Make title horizontal if preferred
        size(medsmall)                // Title text size
        margin(r-3)                   // Eliminate extra space between 
                                      //   title textbox and axis labels
    )
	
    xlabel(83(2)93 93 "93%",          // Label the horizontal axis
        labsize(medsmall)
    )
	
    xtitle("High School Graduates",   // Title the x-axis
        size(medsmall)                // Title text size
    )
	
    plotregion(
        style(none)                   // No formatting in the plot region,
                                      // including the plot box.
    )
	
    xscale(noline)                    // Remove X-axis line
    yscale(noline)                    // Remove Y-axis line
	
    graphregion(
        margin(small)                 // "Small" margin around the plot
                                      // trims excess white space but without
                                      // cutting off labels. "None" is good
    )                                  // but sometimes too aggressive.
;

#delimit cr                           // Go back to end-of-line command endings


    // ====================================================
    // Export out chart to formats other programs can use.
	// PDF format is best, as it always produces crisp 
	// images and does not take up a lot of disk space
	// ---it is a vector not a raster format, if you know
	// what that means---but older versions of Word and
	// Google Docs will not accept PDF images; for those,
	// use PNG or JPG.
	
graph export "${output}/scatterplot.pdf", as(pdf) replace
