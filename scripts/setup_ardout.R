# ==== CONFIG (edit if you like) ==============================================
author_name   <- "rep-solutions"         # shows in LICENSE, commits, etc.
author_email  <- "cox_marc@hotmail.com"  # for CODE_OF_CONDUCT contact
lifecycle_tag <- "experimental"          # "experimental" | "maturing" | "stable"
license_type  <- "MIT"                   # "MIT" | "GPL-3" | "Apache-2.0"

# ==== ENSURE REQUIRED PACKAGES ===============================================
need <- c("usethis","devtools","roxygen2","testthat","pkgdown","lintr")
to_install <- setdiff(need, rownames(installed.packages()))
if (length(to_install)) install.packages(to_install)
options(usethis.quiet = TRUE, usethis.protocol = "https")

# Safety check: ensure we're in a package project
stopifnot(usethis::proj_get() == getwd())

# ==== CORE SCAFFOLD ==========================================================
# License
switch(license_type,
       "MIT"      = usethis::use_mit_license(author_name),
       "GPL-3"    = usethis::use_gpl3_license(author_name),
       "Apache-2.0" = usethis::use_apl2_license(author_name),
       { } # no license
)

# Docs layout
usethis::use_roxygen_md()   # roxygen + markdown Rd
usethis::use_readme_rmd(open = FALSE)
usethis::use_news_md()
usethis::use_namespace()    # ensure NAMESPACE is managed by roxygen

# Testing & vignette
usethis::use_testthat(edition = 3)
usethis::use_vignette("getting-started")

# CI (GitHub Actions) + badge
usethis::use_github_action_check_release()
usethis::use_github_actions_badge()

# Package website
usethis::use_pkgdown()
# If your repo is already on GitHub, this will set up Pages on the 'gh-pages' branch:
try(usethis::use_pkgdown_github_pages(), silent = TRUE)

# ==== NICE-TO-HAVES ==========================================================
usethis::use_code_of_conduct(contact = author_email)
usethis::use_contributing()
usethis::use_cran_comments()
usethis::use_tidy_description()
usethis::use_lifecycle_badge(lifecycle_tag)

# Linting (optional template)
usethis::use_lintr()
if (!file.exists(".lintr")) {
  writeLines(
    c("linters: with_defaults(line_length_linter = line_length_linter(120))"),
    ".lintr"
  )
}

# ==== DATA WORKFLOW (optional scaffolding) ===================================
usethis::use_data_raw()  # creates data-raw/ and a template script
# Example for later, when you create an object in data-raw:
# usethis::use_data(my_object, overwrite = TRUE)

# ==== DEPENDENCIES (add as needed) ===========================================
# Examples — uncomment when you actually use them in your code:
 usethis::use_package("dplyr", type = "Imports")
 usethis::use_package("glue",  type = "Imports")
 usethis::use_package("ggplot2", type = "Suggests")
 usethis::use_package("gt", type = "Suggests")

# ==== STARTER FUNCTION + TEST ================================================
usethis::use_r("hello")
writeLines(
  'hello <- function(name = "world") {
  sprintf("Hello, %s!", name)
}', "R/hello.R")

usethis::use_test("hello")
writeLines(
  ' test_that("hello works", {
    expect_equal(hello(), "Hello, world!")
    expect_match(hello("Marc"), "Hello, Marc!")
  })',
  "tests/testthat/test-hello.R")

# ==== BUILD DOCS, CHECK, AND (OPTIONAL) BUILD SITE ===========================
devtools::document(quiet = TRUE)
devtools::check()

# Build pkgdown site locally (ok if it fails before first push/gh-pages setup)
try(pkgdown::build_site(), silent = TRUE)

message("\n✔ All set! `ardout` now has tests, vignette, docs, CI, pkgdown, and scaffolding.")
message("Next: add your own functions in R/, write tests in tests/testthat/, then document & check.")
