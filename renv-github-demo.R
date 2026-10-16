
# ============================================================================== #
# 1. PROJECT SETUP: WHAT renv CREATES ----
# ============================================================================== #

# When renv is initialized via renv::init(), it creates project files such as:
#
# .Rprofile
# project.Rproj
# renv.lock
# renv/
#   activate.R
#   settings.json
#
# The renv/library/ contains packages installed locally for the project
# It should not be committed to GitHub (i.e. you can include it in .gitignore)

# Run renv::init just once in the console when first setting up the project

# ============================================================================== #
# 2. WHAT A COLLABORATOR DOES AFTER CLONING / PULLING ----
# ============================================================================== #

# A collaborator:
#   1. Clones or pulls the repository from GitHub
#   2. Opens the .Rproj file
#   3. Restores the package environment from renv.lock with renv::restore()

# Optional check in the console before running renv::restore():
# renv::status()

# restore() reads renv.lock and installs the recorded package versions
# into the collaborator's local project library.

# After restoring, restart R and run the analysis.
# If this file is saved as R/analysis.R:
# source("R/analysis.R")


# ============================================================================== #
# 3. WHAT BELONGS IN YOUR SCRIPT ----
# ============================================================================== #

# Notice that our script does not run renv::init(), renv::restore(),
# renv::snapshot(), or install.packages() as code

# If we still want to tell a collaborator to use renv::restore() prior to running 
# the script, we can just include it in a comment (and not as a line of code)

data <- tibble::tibble(
  site = c("A", "B", "C"),
  value = c(4, 7, 5)
)

summary_data <- data |>
  dplyr::summarise(
    mean_value = mean(value)
  )

print(summary_data)

# ============================================================================== #
# 3. ADDING PACKAGES AND RECORDING THE ENVIRONMENT ----
# ============================================================================== #

# During your edits to a script, let's say you add a package to it: 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# Run renv::install("ggplot2") in the console

# After adding packages, run:
# renv::snapshot()

# renv::snapshot() records the current package versions in renv.lock

# You can then check that they've been recorded to renv.lock by looking directly
# in the lockfile or by running renv::status()


# ============================================================================== #
# 4. TROUBLESHOOTING A FAILED renv::restore() ----
# ============================================================================== #

# renv reproduces R package versions, but it does not fully reproduce:
#   - the R version
#   - the operating system
#   - compilers
#   - system libraries

# so there can sometimes be incompatibilities that we have to troubleshoot...

# If renv::restore() fails:
#
#   1. Check the first package error
#   2. Check the R version
#   3. Check for package/system dependency problems
#   4. Don't immediately run renv::snapshot() (this will change the lockfile)

# Useful Console checks:
# R.version.string -- shows your R version
# renv::status() -- tells you about issues & inconsistencies in the project

# ============================================================================== #
# 5. FOUR COMMANDS TO REMEMBER ---- 
# ============================================================================== #

# Project creator - just once (this was likely already done by your group postdoc or TA)
# renv::init()

# After intentionally changing package dependencies:
# renv::snapshot()

# Collaborator -- after cloning or pulling a changed renv.lock file:
# renv::restore()

# Anyone -- check the current state:
# renv::status()


# ============================================================================== #
# 8. RECOMMENDED TEAM WORKFLOW ----
# ============================================================================== #

# Project creator:
# initialize -> work -> snapshot -> commit
#
# Collaborator:
# pull/clone -> restore -> work
#
# Everyone:
# only snapshot when intentionally changing the shared environment
