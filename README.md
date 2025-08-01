
<!-- README.md is generated from README.Rmd. Please edit that file -->

# databook

<!-- badges: start -->

[![R-CMD-check](https://github.com/IDEMSInternational/databook/workflows/R-CMD-check/badge.svg)](https://github.com/IDEMSInternational/databook/actions)
[![Codecov test
coverage](https://codecov.io/gh/IDEMSInternational/databook/branch/main/graph/badge.svg)](https://app.codecov.io/gh/IDEMSInternational/databook?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![license](https://img.shields.io/badge/license-LGPL%20(%3E=%203)-lightgrey.svg)](https://www.gnu.org/licenses/lgpl-3.0.en.html)
<!-- badges: end -->

This is an R package containing assorted functions which are created for
[R-Instat](https://r-instat.org/), a GUI-free front-end being developed
for R. These functions are designed to provide standalone capabilities
for various tasks within the R programming environment.

## Installation

You can install the development version of databook from
[GitHub](https://github.com/) with:

``` r
 # Install devtools package if not already installed
 if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Install databook
devtools::install_github("IDEMSInternational/databook")
```

## Usage

Once installed, you can load the package and start using its functions.

``` r
# Load the databook package
library(databook)
```

For detailed documentation on individual functions and their usage,
please refer to the function documentation within R.

## Contribution

Contributions to `databook` are welcome! If you find any issues or have
suggestions for improvements, please open an issue on the GitHub
repository.

## Acknowledgments

This package was developed as part of the
[R-Instat](https://r-instat.org/) project. We acknowledge the
contributions of all developers and contributors to the project.
