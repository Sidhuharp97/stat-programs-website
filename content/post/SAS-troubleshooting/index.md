---
title: Common Errors and Solutions in SAS
authors:
- bprice
categories:
- SAS
- troubleshooting
- documentation
date: "2022-08-10T00:00:00Z"
draft: false
image:
  caption: 'Computer Meltdown'
  focal_point: ""
  placement: 2
  preview_only: false
lastmod: "2021-04-15T00:00:00Z"
projects:
subtitle: 
summary: "Common errors you will encounter in SAS and how to fix them."
tags:
---

You need to get that analysis done so you can write that report/paper/dissertation/thesis/presentation to meet that deadline to please the boss ... BUT ... SAS is giving you heartburn! DON'T PANIC. 

Although SAS errors look confusing, SAS is really trying to help you find the problem. Really! Look in the Log Window for any error messages. They are marked in <span style="color:red">RED</span>. Recall that SAS runs sequentially from top to bottom, so any mistakes at the top of the program will propagate more errors down the line. **Always start by trying to fix the first error**, then rerun the program. You may find that when the initial problems are fixed, the rest of the errors will vanish. 

When SAS gives an error message, it also lists a numeric code, like 201 or 76 indicating the line and character in the line where it had trouble. SAS will also underline the offending part of the program and mark it with the numeric code so you can match an error message with the problem area. It can't always find the exact place where the problem occurred, but it usually close by. For more debugging information take a look at the TIPS below on common mistakes and problems. 

Good Luck!

## Tips

### Missing Quotes:

If you've recieved the *"longer than 200 characters"* message then the cause of the problem is easy to find. You have left out a quote somewhere. Carefully go back through the program and check for both beginning and ending quotes in any statements that use quoted strings such as `TITLE`, `INFILE`, or `AXIS` statements . Quoted strings in SAS are color coded as a magenta color to make them easier to see. Large blocks of text appearing this color are an indicator of a missing quote. Also note that single quotes are different than double quote characters. If you start a string with one of these and end with the other type, SAS will indicate a missing quote.

After you find the culprit, fix it. But wait! Correcting the problem is not quite that easy (somehow you knew that!). SAS builds up the code you run sequentially. So if you try to run the "corrected" code, SAS will STILL be looking for an ending quote from last time. The quotes will still be unbalanced and you'll still get an error message. This can be very frustrating, but here is the solution. First, correct the code, but before you run it, open a new editor window. Next, give SAS what it is looking for, the offending single quote. In the new editor window enter this: `';` and submit that as a program. This will satisfy SAS (ignore any error messages at this point). Then, go back to the original program and run it. The "quote" problem should go away.

### Missing Semicolons:

Leaving out a semicolon is probably the easiest mistake to make. The error message you get may vary here depending on where the mistake was made. Usually you get a message like *"variable XXX not found"* or *"invalid option"*. SAS is trying to interpret the errant statement as part of the preceding statement and, therefore, gets it's cyberfeet tangled. The solution is straight forward: insert a `;` and resubmit the program.

### Missing RUN Statement:

Sometimes while running a program several times you'll notice that the `PROC LOTTERY` you had at the end of your program is missing from the output listing. So, thinking that SAS maybe just "forgot" to run it the first time, you run the program again. Now you find it at the top of the output listing instead of the bottom! What the heck is going on!? Remember, SAS runs both sequentially and cumulatively. The first time you ran the program, SAS saw the `PROC LOTTERY` at the end, but didn't find a `RUN;` statement. Without that it will hold on to the `PROC LOTTERY` and wait to execute it when it sees the next DATA or PROC step. When you run the program for the second time SAS first executes the PROC it is holding on to and then runs the submitted program (again, leaving off the last PROC). This can cause confusion to no end (no pun intended!). The solution, of course, is to put in the missing `RUN;`. By the way, before you go running to your SAS manuals looking for `PROC LOTTERY`, remember this is only and example!

### LISTING Window/File:

Like other portions of SAS, the Listing and Log windows or output files may be cumulative. If you know you have changed your calculations for yield from lbs to kilograms, but SAS seems to keep printing lbs in the output, make sure you have cleared out the Listing window. You are probably looking at an "old" output created before you changed things. This also applies to the Log window.

### Case problems:

SAS is creating too many levels of a variable, for example, when running `PROC MIXED`, `PROC GLIMMIX` or `PROC FREQ`. Go back and check the data very carefully. Alphabetic variables are case sensitive so the value *"Trt1"* is different from *"TRT1"*. This problem often creeps into programs when data has been combined over several years or locations. If you have this type of data, try to formulate a consistent template for yourself and others to use for entering data. Define what the treatment codes and variable names will be ahead of time. The only way to handle this problem is to change the data or use a data step and the `IF` statement to correct the problem.

### 0 and O problems:

SAS keeps insisting that it can't find your variable *"TRT0"*, but you know it's there in the `INPUT` statement! Check things carefully. You may have used *O* (capital letter oh) instead of *0*, a zero. This is very easy to do and is made worse by the fact that the two are physically close together on most keyboards. Similar to problems with case above, this mix up may also show up as a problem when reading in data. The only solution is to change the problem characters to the appropriate values and try again. If this problem occurs a lot, you might consider trying a different font which uses a dot or slash when writing a zero.

### General Debugging Tips:

Debugging SAS can be a trying experience. Here are some techniques I use to help the process.

1.  Build long complex programs a step at a time. Start by reading in the data. Print it. Check it. Then do any calculations, then add `PROC` steps and other `DATA` steps. Don't try to write the whole thing at once. Verify that a piece of code works and then move on.

2.  Use comments. Try to isolate problem code by commenting out sections of the program. This is a very useful technique. See [Comments](https://agstats.io/tutorials/sas-data-step.html#42_Commenting_and_Documentation).

3.  Try writing programs with consistent and readable structure. Use line breaks and indentation where needed and throw in comments to explain what is happening in the program. This will help organize the program flow in your mind and point out where things are going wrong. See [Programming Habits](https://agstats.io/tutorials/sas-data-step.html#4_Programming_Habits).

4.  Stay calm! Learning the quirks of SAS takes time. If all else fails let us know!

### Some SAS Resources for Error Corrections:

-   Simply copy and paste the error message into a search engine like Google

-   Ask a question on the [SAS forums:](https://communities.sas.com/)

-   [Types of Errors in SAS](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/lrcon/n1g8q3l1j2z1hjn1gj1hln0ci5gn.htm)

-   Beginning [SAS books](https://blogs.sas.com/content/sgf/2021/09/13/top-books-for-sas-programmers/)

-   [Tips and Strategies for Mixed Modeling](http://support.sas.com/resources/papers/proceedings12/332-2012.pdf)
