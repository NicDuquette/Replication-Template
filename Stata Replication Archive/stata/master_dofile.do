/*********************
  An example of a Stata do-file that calls all other do files to run
  a research project from start to finish.
  
  Nicolas J. Duquette
  University of Southern California
  nduquett@usc.edu
  Comments Welcome
  
  This version: 2020-Nov-30
 ********************/

clear all                // Get rid of anything stored in memory

version 16.1             // Store the version of Stata for forward
                         // compatibility

                         
                         
    // You should put comments throughout your code that explain
    // to others (and to yourself) what you are doing. 
    // A line that starts with a double right slash, // is a 
*      comment, but so is a line that starts with an asterisk *
/*     To write a multi-line block comment without a comment indicator
       at the start of every line, you can begin with slash-asterisk
       and end with asterisk-slash, like this: */


       
    
    // I'm going to show you a neat trick: you can define 
    // separate filepaths for each group member. First let's
    // see the username from your computer's operating system:
disp "`c(username)'"


/* ======================================================================
   Stata stores programming variables (which Stata calls "macros"), as 
   "locals" or "globals." A local macro is only accessible within a loop
   or do-file and won't carry over. You invoke it by putting the name
   of the local macro between a slanted quote/accent (the ` character
   above tab on US keyboards) and ending with a single straight quote, '.
   In the line above, c(username) is a special local defined by the
   computing environment.
   
   Global macros will carry over to any other loops or files until they are
   cleared or replaced; invoke them with a dollar sign and brackets, as in
   ${myglobalname}.
   
   We'll use macros in future do-files to pass file paths. By storing filepaths
   in globals, we will make them available in all downstream do-files. We'll
   invoke them like this,
   
   use "${data}/mydata", clear
   
   where ${data} will be replaced with the global path to the data,
   and the double quotes will make sure Stata is not thrown off by 
   spaces in folder and file names, or by the / on file systems like Windows 
   that expect \ after a subdirectory.
======================================================================  */  

	// We now use the c(username) local to create conditional,
    // user-specific filepaths that are stored in globals.
	// As long as we always use the globals to tell where we
	// want to read and write files, then the same replication archive
	// can be synchrnoized and run without further changes on all
	// co-authors' computers.
	
    // Globals containing filepaths for Nic Duquette:
if "`c(username)'"=="nicolasduquette" {

        // Most of the paths are subdirectories of this main folder
    local root "/Users/nicolasduquette/Documents/Replication-Template/Stata Replication Archive"

        // Source-data directory. Never ever ever save to them from Stata!
    global data "`root'/data"

        // Temp directory. Cleaned-up data files go here
    global temp "`root'/temp"
        
        // Do-files called within this project
    global do_files "`root'/stata"

        // Tables and figures go here
    global output "`root'/output"
    
    
}

    // Globals containing filepaths for other group members
if "`c(username)'"=="coauthor2" {

        // Most of the paths are subdirectories of this main folder
    local root "C:\Users\coauthor2\My Documents\Dropbox\"

    global data "`root'/data"
    global temp "`root'/temp"
    global do_files "`root'/stata"
    global output "`root'/output"   
}
if "`c(username)'"=="coauthor3" {

        // Most of the paths are subdirectories of this main folder
    local root "~/Users/coauthor3/Dropbox/"

    global data "`root'/data"
    global temp "`root'/temp"
    global do_files "`root'/stata"
    global output "`root'/output"   
}

/* ======================================================================
   Now, we call each do-file in the project in sequence to create
   the project from start to finish.
   1. Call raw data, clean it, and store temporary files in .dta format
   2. Create tables and figures.
   3. If for a replication archive, export any final data in 
       a plain-text format.
======================================================================  */  


do "${do_files}/clean_data.do"          /* Prepare the data for analysis */


do "${do_files}/main_regressions.do"     /* Estimate regressions and export the
                                           results to a formatted table */

do "${do_files}/plot_data"              /* Create data visualizations */

    

