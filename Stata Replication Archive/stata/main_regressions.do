/* Estimate regressions and export to a formatted table */


    // Load the cleaned data
use "${temp}/stata_data_clean", clear   

	// I will use user-written command "eststo" to save the estimates
	// for tabular export. Alternatives include native "estimates store"
	// and user-written "regsave"
eststo clear

	// Estimate three regressons of unemployment on average income and education
	// "regress" runs the actual estimation;
	// "eststo" stores the estimates and gives them a name for later export to 
	// a table.
reg ur grads
eststo reg1

reg ur pcpi
eststo reg2

reg ur grads pcpi
eststo reg3

    // ==========================
    // EXPORT TO TABLE
    //
    // I will be using "esttab," a user-written command that exports
    // formatted regression tables to Excel-friendly formats
    // (tab- or comma-separated text), Rich Text Format, and LaTeX.
    // Install it with the Stata command "ssc install esttab".
    // This is not the only option; "ssc install asdoc" is also popular with
    // students who want to export to MS Word format; Stata 16 also
    // includes a command, "putdocx", that will export to MS Word natively;
    // see here: https://www.stata.com/new-in-stata/truly-reproducible-reporting/#dword
	
	
#delimit ;                           // The #delimit ; tells Stata that the
                                     // command ends when it gets to a 
                                     // semicolon, not at the end of the 
                                     // line of text. 
	
esttab reg1 reg2 reg3                // 
    using "${output}/regtable.rtf"   // save table to file
	,                                // 
	rtf                              // RTF format
	replace                          // Overwrite existing file
	se                               // Standard errors, not t-stats
	label                            // Use variable labels, not names
	;
	
#delimit cr                          // Go back to end-of-line command endings
