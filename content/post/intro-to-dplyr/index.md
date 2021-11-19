---
title: "Introduction to Data Cleaning with the Tidyverse"
author: jpiaskowski
date: 2021-11-18
categories: ["R"]
tags: ["dplyr", "tidyr", "tidyverse"]
draft: true
---

 


![](phd_comics_filenames.png)


[**from PHD comics**](https://phdcomics.com/comics/archive_print.php?comicid=1323)

### Introduction

> Equip everyone regardless of means, to participate in the global economy that rewards data literacy.    
<center> —RStudio mission statement </center>

The tidyverse is developed and maintained by many individuals, and it is closely tied to RStudio. It uses "non-standard evaluation" ([NSE](http://adv-r.had.co.nz/Computing-on-the-language.html)) principles in its functions. NSE is a complicated topic, but in brief, it means that tidyverse function follow different rules than base R function. Tidyverse functions are easier to use, but, if you are used to base R functions, reorienting your thinking takes some effort. Just a friendly warning before we dive in! 

Most tidyverse functions have equivalent functions in base R. The difference is that tidyverse functions are often faster, the code itself is usually (always?) shorter, and the results are consistent across systems and data types. Also, tidyverse functions are written for data frames, while many base functions are written for vectors. 

#### Abbreviated list of packages useful for data cleaning   
There are many packages to load. Here is a summary table of what each package does. We won't explore all these packages today, but they are worth checking out, depending on your data analytic needs. 

| Package | Purpose |
|------------------|-----------------------------------------------|
|data.table | not part of the tidyverse, advanced handling of data frames, very efficient |
|dplyr | main package for organizing data |
|forcats | for managing categorical data |
|janitor | also not part of the tidyverse, has useful data cleaning functions |
|lubridate | for manipulating dates |
|purrr | advanced broadcasting of functions across data |
|readr | for reading in tabular data |
|readxl | for reading in MS excel sheets  |
|stringr | for managing "strings" (character variables) |
|tidyr | to reshape data and handle missing values |

![](tidyverse_hex.png)

**Please Note!**

The functions for reshaping data in 'tidyr` are currently under revision, but the new versions are likely to be finalised and adopted soon, so this tutorial will introduce the new ones (as well as demonstrate how to use alternative reshaping functions). In order to access the new 'tidyr' functions, you will need to download tidyr directly from its github repo:
```
# install.packages("devtools") # only run this line if you do not have devtools installed
devtools::install_github("tidyverse/tidyr")
```

##### Load packages:
(just the ones we will use today)


The warning messages indicate when there are identical function names across different packages. The last package loaded will override functions from previous-loaded packages when such conflicts arise. So, the order of how packages are loaded can matter. However, any function can be accessed by add a prefix of the package name and two colons to a particular function:
```
base::intersect(...)
```

### Loading data with 'readr'

For this tutorial, 3 data sets will be used, "nass_cotton", "nass_barley", and "nass_barley". These are historical data sets from the National Agricultural Statistics Service that indicate the total acreage and yield for the crops indicated for each each U.S. state and year from 1866 to 2011. They were provided by packaged 'agridat'. 

*Note: these data sets were originally obtained as thus:*
```
library(agridat) # a package of agricultural data sets
data("nass.corn")
data("nass.barley")
data("nass.cotton")

write.csv(nass.corn, "Data/nass_corn.csv", row.names = F)
write.csv(nass.barley, "Data/nass_barley.csv", row.names = F)
write.csv(nass.cotton, "Data/nass_cotton.csv", row.names = F)
```

When using the RStudio's point-and-click interface to load tabular data, it will typically call the function `read_csv()` for CSV files and `read_delim()` for text files. `read_csv()` is a wrapper for `read_delim()` with different default arguments. 

These arguments can be called using the command line interface as well. 


#### A bit on the tibble

A tibble is an object type created for the tidyverse. This is the object type imported by 'readr' and returned by many tidyverse functions. The tibble is like a data frame with a few other rules. Tibbles have a simplified printing function if you accidentally type in the object name - it will only print the first 10 lines and will truncate the number of columns to fit your screen. If you type the object name of a traditional data frame, the first 1000 lines of data are printed! 

To create a new tibble, you can use the function `tribble()` to create a tibble by rows, or the function `tibble()` for building a tibble column-wise, or `as.tibble()` to coerce an object to a tibble.  



There are a few aspects of tibbles that are fundamentally different from a standard data frame. Tibbles do not handle row names well and many tidyverse functions discard that information. This is often just fine - row names are computationally expensive to set and maintain. Also, it can be difficult to filter and sort data based on rownames. However, many other (non-tidyverse) package functions rely on the rownames attribute, so be aware of this behavior when using tidyverse functions on data sets. 

#### Function details

  * the most noticeable difference between `read.csv()` and `read_csv()` is that `read.csv()`'s default behavior is to import character variables that with repeat values as factors, while `read_csv()` keeps those variables as character. The default behavior can be overrode in both functions. 
  
  * `read_delim()` and its wrappers are faster than base versions (e.g. `read.csv()`), however, the difference will not be noticeable for small files (< 10 Mb) 
  
  * `read_delim()` offers additional flexibility such removing trailing and leading white space (" hello" and "hello  ") and automatically deleting empty rows (these things occur by default). 

  * specific values for missing data that are not "NA" (e.g. "-9", ".") can be set with with argument `na = ...`

  * the function can be sped up by setting values for the `col_types = ...` argument (e.g. character, numeric, date, et cetera)  


**Note:** if you have truly huge data, consider the `fread()` function in 'data.table' or storing the data in database and using 'dbplyr' to access it.
  
  
### Data selection and subsetting
*(from the package 'dplyr')*

#### Column selection

The `select()` function is used for column selection and has the formulation: `select(data, vars_to_select)`.

**Select only the columns that you want: **


**Select the columns you do not want: **


#### Sorting data

Sort functions have the formulation: `sort(data, vars_to_sort)`.

**Sort across one column:**


**Sort across several columns:**


**Sort in reverse order:**


#### Row selection 

Based on their position or index (where the first row = 1):


#### Filtering Data
*(actually a type of row selection)*

Filtering enables users to select all columns of data based on a condition within a row or rows. The `filter()` function has the formulation: `select(data, condition_for_filter)`.

**Filter based on one variable and exact match:** 


**Filter for matching several items: **


**Filter by numerical cut-off: **
(first, look at summary of data)


<span style="color:mediumblue">Logical operators in R:</span>

|symbol    | meaning  |        
|------|-------|
|<    | less than |
|<=	  | less than or equal to |
|>     | greater than |
|>=	   | greater than or equal to  |
| ==    | exactly equal to  |
|!=     | not equal to  |
|!x       | Not x  |
|x | y     | x OR y  |
|x & y     | x AND y  |


**Combine multiple filters:**

(again, let's look at summaries of the data first)



### Data transformations

#### The `mutate()` function to define new variables

Mutate functions have the formulation: `mutate(data, new_var_name = data_transformation)`. New variables are declared on the left and the right provides the operations for variable creation itself. Many operations are allowed within a mutate function: 


#### Renaming variables

The `rename()` function renames columns using this notation: `rename(dataframe, newname = "oldname")`:



#### Splitting and Merging Columns

Combine multiple columns into one with the function `unite()`. Column data are pasted together as text, not added as numbers. The columns used to make the new variables are automatically discarded (this behavior can be stopped with the argument `remove = F`). 

`unite()` functions have this formulation: `unite(data, new_var_name, vars_to_select)`.



The Opposite function,`separate()`, has this structure:  `separate(data, col_to_split, names_of_new_cols)`  



These last two functions are often quite useful - for pulling apart complicated ID columns, or for creating a unique identifier that can later be used for merging two data sets together.  

### Merging data sets with 'dplyr'

Merging different data sets by a common variable is a major advantage to using automated software. Doing this manually in spreadsheet programs is nearly impossible to do without introducing errors. There are 6 different merging or joining functions which differ in what data they keep and what are discarded. 

#### Standard join functions

For merging 2 data frames. Join functions are first and foremost defined by the rows they return. The function use a common ID, which can be automatically detected or explicitly declared, to match observations in A with observations in B and returned a merged data frame. In most cases, all columns from both data frames are returned. 

The general formulation for join functions: `type_join(x_data, y_data, ID_key_variable)`  

![](dplyr_joins.png)

<center> **Know Your Joins** </center>
<p><br></p>

The column(s) used for ID are only included once in the merged data frame, that is, the duplicated key column is dropped. However, if there are other (non-ID) columns with duplicated names across the data sets, the duplicate columns from first data set listed are given a ".x" suffix and the duplicate columns from second data set listed are given a ".y" suffix. 

**1. The `full_join()`:**    
    - always the safest option, everything is returned
    - searches and matches when both the year and state of a single observation match the year and state: 


    - **Note:** for the rest of the joins, which employ a filtering step, always use a single unique identifier (called a "key") for the joins. 
    - When there is not a match, the rows from each data set are still returned and filled with NA for columns from the other data set. 

**2. The `inner_join()`:**   
    - this function only keeps what is common between data sets:

    - several column names duplicates resulted in the addition of ".x" to duplicate columns from the cotton data set and ".y" to duplicate columns from the barley data set. 



**3. The `left_join()`:**    
   - matches all rows for observations found in the tibble listed on the left:  


**14. The `right_join()`:**  
   - matches all rows for observations found in the tibble listed on the left:  


**5. The `semi_join()`: **   
    - This function is like `inner_join()` (only rows with keys in both data sets are kept) except it does not keep any data from the data set listed second:


**6. The `anti_join()`: **   
    - observations from A that *do not* match B are kept:



#### Set operations

These are different from standard joins. They compare across *vectors* and return what has been specified in the statement. *Duplicates are discarded.* The purpose of set operations is to determine common or uncommon observations, not merge two different data sets. 

**Common set operations**   

![](set operations.png)



**What happens when there are multiple matches for an identifier?** Each time there is a new match between the keys of two data frames, a new row is added for the matched data. 

### Reshaping data

![](wide_v_long.png)
**Same data, two formats**  


#### Two common approaches to reshaping data: 

1. 'tidyr' (popular, in transition currently)
1. 'data.table' (flexible, fast)

|reshaping action | tidyr function | data.table function |
|----------|-------------|--------------|
|long to wide | `pivot_wider()`  | `dcast()`  |
|wide to long | `pivot_longer()`   | `melt()`  |

*Note: the tidyr functions `pivot_wider()` and `pivot_longer()` replace `spread()` and `gather()`.*

##### The tidyr approach: 

*At the time of writing this (April 9, 2019), these functions are available through GitHub, but they are still under developement and available through CRAN. However, they are likely to be completed and pushed to CRAN soon and become part of standard tidyverse functions.* 

**Reshaping from long to wide:  **

There is also a `values_fill=` argument to fill in missing values when you know what those should be. The default behavior is to fill with an NA. 

**Reshaping multiple variables:  **


**Reshaping from wide to long:**



##### The data.table approach

Thus far, the package 'data.table' has not been explored in any depth (and it still won't be for space considerations). Nevertheless, 'data.table' is useful for manipulating large tables; it is extremely efficient (even better than tidyverse functions).

**Reshaping from long to wide: **
  -we will use the previously created data set "cotton_barley_inner" from inner join of the barley and cotton data sets. 


Reshape cotton acreage, using State as the ID variable: 


**Reshaping with multiple variables**  

Multiple ID variables can be specified on the left side of the tilde and/or multiple column categories can be specified on right side. Furthermore, multiple columns (the "value.var") can be specified to fill the cells.

Reshape cotton acreage, using State as the ID variable using both cotton acres and cotton yield to fill the cells:  


**Implementing a summary function in the reshape:** if there is more than one  observation for each cell, a summary function like mean can be used. If  function is not specified, the number of observations for that variable combination will be used.  


**Reshaping from wide to long:**





### Grouping and summarising data

 - The function `group_by()` provides a handy tool for breaking data into groups based on a common factor. 
 - The function `summarise()` often follows a grouping command. It will apply a summary function to a data set or a grouped data set.
 - these all rely on the idea of piping, or chaining together operations, using the pipe operator: ` %>% `, rather than (1) a complicated nesting arrangement (see below) or (2) a large number of intermediate objects that you don't actually need. 




**Example:** group the cotton data set by year and output the mean yield for each year. 


**Example:** Determine which states had the highest yields each year and plot highest yields over time


### Free training resources 

* [R for data science]("https://r4ds.had.co.nz/")
* [RStudio Cheat sheets]("https://www.rstudio.com/resources/cheatsheets/")
* [Package documentation]("https://www.tidyverse.org/packages/")
* Tutorials put together by package authors: 
```
vignette("dplyr")
```

### Other useful functions

|Package | Function |  Purpose  |
|---------|-----------|------------------------------------------------------------|
| dplyr | `pull()` | extracts a single column and returns a vector | 
| dplyr |  `n()` | counts observations |
| dplyr |  `n_distinct()` | counts the number of unique observations |
| dplyr | `distinct()` | keeps only unique observations |
| dplyr | `starts_with()` | used within `select()`, for selecting columns that start with a specific string of characters |
| tidyr | `drop_na()` | remove rows with any missing data |
| tidyr | `fill()` | fills in missing values with whatever occurs before it (column-wise). Its behavior is dependent on row order |
|tidyr | `replace_na()` | replace missing values with a user-defined value (only when is.na(x) evaluates as "TRUE")


 
