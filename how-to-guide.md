# A *framework* for project structure with R 
**Write comprehensible R-projects without a time lag.**

Using R and RStudio facilitates the process of initializing R-projects to 
structure your work. However it is advisable to standardize your workflow in 
order to write well organized code that can be passed on to others and try to 
include standards of reproducibility. The R-package *framework* gives you the 
opportunity to initialize a well-conceived project structure with only one line 
of R-code: 

``` framework::project_framework("path/2/your/new/project") ```

## Features of a framework-project 
- Easy setup of your preferred directory structure
- Use your favourite IDE
- Automatic integration of **git** 
- Automatic integration of **packrat** 
- Automatic **backup** of a predefined set of files (e.g. the input or output of your project) to a mounted volume (such as your web server, dropbox-cloud, external-usb-drive etc.) 
- Automatic installation of additional R-packages 
- Automatically remove all objects in your .GlobalEnvironment to `ensure reproducibility` 
- Automatic creation of **standard output**: 
    - rendered documents of R and Rmd files (html, pdf, docx) 
    - all plots will be saved with a meaningful name. You can easily specify the format (pdf, png, jpeg,etc) and the names of the files by using chunk-labels (and/or global chunk options). 
    - current session-info 
    - all datasets will be saved as csv, RData or rds 
- **Traceability** features: 
    - a how-to-file (kind of a FAQ) makes it easy to pass on your work to colleagues without the necessity of additional explanation of your project structure or processing steps 
    - A Readme.md at the top level of your project 
    - Easy implementation of roxygen comments within R-files via templates.
- **stand-alone integration**: 
    - Once you have initialized a framework-project there is no need of an installation of the package itself. As a result framework-projects can be passed on to colleagues 
'as is'. The only requirement is an installation of R (>= 3.2).
- **Modular concept** to exchange (and reuse) different parts of your analysis 
- Increase of **processing speed** by using a cache
- Make sure your output is **always up-to-date** and detect bugs at an early stage
- **Reuse your functions**: When choosing the option 'devtools_create' your project will be shipped with a 'DESCRIPTION' file. By using an appropriate directory structure it is straightforward to bundle your project into an R-package.

## Structure of a framework-project 
Almost every researcher/statistician (...) has its own workflow. At least there are many different demands people prefer to work with. Anyhow the setup plays a very important role when working on projects. **Therefore the directory structure of framework projects are fully customizable from the start.** All you have to do is to pass different arguments when invoking the function 'project_framework'. It is even possible to copy a local template of a makefile by using this function.

However per default the following directory structure will be implemented:
 
- \***Top-level** 
    - **make.R** --> Complete instructions to process the whole project 
    - **scripts/** --> source-files (R-scripts, Rmd-files etc that should be processed)
    - **R/** --> functions (will be loaded and attached to a new environment) 
    - **data/** --> raw data files (directory will be monitored via snapshots - if files change the cache won´t be used)
    - **out/** --> All resulting files after processing your project. By using a single directory for output it is easy to prevent intermixing of input and output. 
      - \*\***data/** --> output data (per default all dataframes within the Global Environment) 
      - \*\***docs/** --> rendered html/pdf/docx-versions of your source-files (including temporary formats such as `md` etc. within a subdirectory) 
      - \*\***figure/** --> plots of rendered source-files (png and pdf per default) 
      - **usr/** --> predefined directory for user-specified or custom output

\* This directory further includes additional files and subdirectories: e.g. an 
Rproj-file, packrat-repo, git-repo, git-ignore, a hidden cache-directory, a 
backup-directory, a how-to-manual, a README.md and a current session info. 
\*\* These directories should be treated as read only, because they will be deleted 
and rebuilt every time you source the file `make.R`

## More information on the structure of framework-projects 
The functional principle of framework-projects is inspired by the software `GNU Make`. 
Basically a project consists of several processing steps. Ideally these steps 
are written separately into different files (which will hereinafter be referred 
to as 'source-files'). An additional `makefile` (or in the case of a 
framework-project a make-like file `make.R`) contains all information and 
instructions to process and combine the source-files. In other words: **By calling the make-like file `make.R` the whole framework-project will be processed.** Additionally you will always be able to keep track of your processing steps by reading the file `make.R`. If your source-files as well as the order of your processing steps do not change it is not necessary to process 
them. Therefore a framework-project makes use of a cache-directory per default 
(nonetheless optionally for each source-file). Thanks to this feature the 
processing speed of a framework-project is very fast. Furthermore the output of 
a framework-project is always up-to-date and you will be able to detect and 
locate bugs at an early stage.

## Choose your favourite IDE
Although the package includes addins for RStudio **you can use ANY Text-Editor**. It is even straightforward to work on your project from the command line (using Text-Editors like nano or vim and process your whole project by running ```RScript make.R```). If your Text-Editor supports custom keybindings for shell scripts (e.g. the GNOME text editor 'Gedit') you can write a simple shell script (see command above) and process your whole project with a simple shortcut. If you are using RStudio you simply need to specify a custom keybinding for the addin ```Execute source('make.R')```.

## A Metaphor on how to use a framework-project 
Writing a book is similar to writing an R-project. 
- First of all you will specify a title and make up a concept to work on: `framework::project_framework("path/2/your/new/project")` 
- Afterwards you don´t want to loose time and start writing your "chapters" (alias
source-files). To create a link you should specify the chapters in your table of
contents: Add the path of your source-files within the file `make.R`. 
- At some point you want to print the book and see if you forgot something to mention: 
`source("make.R")` 
- Because you can not write an entire book without interruption you should comment the stage of your work in a README and be sure that you backup your files: Frequently edit the file README.md and write 
comments while coding. 
- Sometimes you want to store several version of your book while keeping track of all changes: use git to commit snapshots of your project. 
- Someday you want to pass on your work to colleagues and/or reviewers:
use packrat to ensure applicability of your project.

## Installation of the R-package `framework`

### Required Software
- `R` (>= 3.2) 
- R-package `devtools` (for installation via github)

### Recommended Software 
- `RStudio` (testet under 0.99.878) 
- rmarkdown 
- knitr 
- pandoc 
- git 
- packrat

### Installation `devtools::install_github("sachserf/framework")`

## Initialize a framework-project 
- To start a new framework-project all you have to do is: `framework::project_framework("path/2/your/new/project")` 
    - Non-existing directories will be created recursively. 
    - The last directory will be the name of your project. 
- Afterwards you can open the file `projectname.Rproj` with RStudio (optionally)

## Usage of a framework-project 
- Create new files (`.R` or `.Rmd`) 
    - Optionally use the functions `template_R(path/to/the/new/file.R)` and `template_Rmd(path/to/the/new/file.Rmd)` 
- make changes to the files and save them 
- open the file `make.R` 
- scroll down to the function `instructions` and add the `path/to/the/new/file.*` to the option `source_files` 
- \*\*\*source the file `make.R`

\*\*\* There are several ways to source the makefile: 
1. open the R-console and type `source("make.R")` (Or use the Addin `insert source make R`) 
2. open the file `make.R` and hit the `source`-button (upper-right corner of the source-pane
in RStudio) 
3. Use a keybinding for the Addin `source make R` to source the file
`make.R` automatically (To enable this feature you will need to specify a custom
keybinding within RStudio: Tools --> Modify Keyboard Shortcuts...)
4. Start a terminal in your project directory and use the command `RScript make.R`

## Further *Good behaviour* when working on framework-projects 
- add additional R-packages within the file `make.R` 
- consistently commit changes to your git-repository 
- steadily write comments within your source-files 
- Use Roxygen comment prefixes within R-files 
- make use of the README.md to give an outline of your project

## NOT-TO-DO-LIST when working on framework-projects 
- Do not source another R-script within R-Scripts if you want to use the cache: Detection of changed 
files is not recursive (You can specify a subset of cached files) 
- Do not use child-documents within Rmd-files if you want to use the cache for this document:
Detection of changed files is not recursive (You can specify a subset of cached 
files) 
- Do not change the working directory manually 
- Do not edit the files within specified target_directories (per default 'out/data', 'out/docs' etc). These directories should be treated as read-only!
- Do not write 'source('make.R')' inside a script that should be sourced by 'make.R'

## Further information 
- see https://github.com/sachserf/framework for further information and source code of the package *framework* 
- For detailed information on specific functions of the R-package `framework` see the help pages (`?function_name`: eg `?framework::write_dataframe`)
- visit https://sachserf.github.io/tutorials.html
