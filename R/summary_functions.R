#' Get Summary Calculation Names
#'
#' Generates a set of unique names for summary calculations, based on provided summaries, columns, and filters.
#'
#' @param calc A calculation object (unused in the current implementation).
#' @param summaries A vector of summary function names.
#' @param columns_to_summarise A vector of column names to summarize.
#' @param calc_filters A list of filter objects applied to the calculations.
#' @return A character vector of unique summary calculation names.
#' @export
get_summary_calculation_names <- function(calc, summaries, columns_to_summarise, calc_filters) {
  filter_description <- ""
  i = 1
  for(filt in calc_filters) {
    if(!filt$parameters[["is_no_filter"]]) {
      if(i == 1) filter_description <- filt$name
      else filter_description <- paste(filter_description, filt$name, sep = ".")
    }
    i = i + 1
  }
  if(filter_description == "") {
    out <- apply(expand.grid(paste0(substring(summaries, 9),"."), columns_to_summarise), 1, paste, collapse="")
  }
  else out <- apply(expand.grid(paste0(substring(summaries, 9),"."), paste0(columns_to_summarise, "_"), filter_description), 1, paste, collapse="")
  out <- make.names(out)
  return(out)
}


#' Check for Missing Values
#'
#' A placeholder function that always returns `FALSE`.
#'
#' @param x A vector to check for missing values.
#' @return Logical. Always returns `FALSE`.
#' @export
missing_values_check <- function(x) {
  return(FALSE)
}

#' Calculate Mode
#'
#' Determines the mode (most frequent value) of a vector.
#'
#' @param x A vector of data.
#' @param ... Additional arguments (unused).
#' @return The mode of the vector. Returns `NA` if the input is `NULL`.
#' @export
summary_mode <- function(x,...) {
  ux <- unique(x)
  out <- ux[which.max(tabulate(match(x, ux)))]
  if(is.factor(x)) out <- as.character(out)
  if(is.null(out)) return(NA)
  else return(out)
}

#' Check Missing Values Based on Conditions
#'
#' Evaluates a vector against specified conditions for missing values.
#'
#' @param x A vector to check for missing values.
#' @param na_type A character vector specifying the types of checks to perform. Options include:
#'   \itemize{
#'     \item `"n"`: Total number of missing values (`<= na_max_n`).
#'     \item `"prop"`: Proportion of missing values (`<= na_max_prop` in percentage).
#'     \item `"n_non_miss"`: Minimum number of non-missing values (`>= na_min_n`).
#'     \item `"FUN"`: A custom function to evaluate missing values.
#'     \item `"con"`: Maximum consecutive missing values (`<= na_consecutive_n`).
#'   }
#' @param na_consecutive_n Optional. Maximum allowed consecutive missing values.
#' @param na_max_n Optional. Maximum allowed missing values.
#' @param na_max_prop Optional. Maximum allowed proportion of missing values (in percentage).
#' @param na_min_n Optional. Minimum required non-missing values.
#' @param na_FUN Optional. A custom function to evaluate missing values.
#' @param ... Additional arguments passed to the custom function `na_FUN`.
#' @return Logical. Returns `TRUE` if all specified checks pass, otherwise `FALSE`.
#' @export
na_check <- function(x, na_type = c(), na_consecutive_n = NULL, na_max_n = NULL, na_max_prop = NULL, na_min_n = NULL, na_FUN = NULL, ...) {
  res <- c()
  for (i in seq_along(na_type)) {
    type <- na_type[i]
    if (type %in% c("n","'n'")) {
      res[i] <- summary_count_miss(x) <= na_max_n
    }
    else if (type %in% c("prop","'prop'")) {
      res[i] <- (summary_count_miss(x) / summary_count(x)) <= na_max_prop / 100
    }
    else if (type %in% c("n_non_miss","'n_non_miss'")) {
      res[i] <- summary_count(x) >= na_min_n
    }
    else if (type %in% c("FUN","'FUN'")) {
      res[i] <- na_FUN(x, ...)
    }
    else if (type %in% c("con","'con'")) {
      is_na_rle <- rle(is.na(x))
      res[i] <- max(is_na_rle$lengths[is_na_rle$values]) <= na_consecutive_n
    }
    else {
      stop("Invalid na_type specified for missing values check.")
    }
    if (!res[i]) {
      return(FALSE)
    }
  }
  return(all(res))
}

#' Calculate the Mean of Circular Data
#'
#' Computes the mean of circular data using `circular::mean.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param control.circular List of control parameters for circular objects.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The mean of the circular data.
#' @export
summary_mean_circular <- function (x, na.rm = FALSE, control.circular = list(), na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::mean.circular(x, na.rm = na.rm, trim = trim, control.circular = control.circular)[[1]])
}

#' Calculate the Median of Circular Data
#'
#' Computes the median of circular data using `circular::median.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The median of the circular data.
#' @export
summary_median_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(!na.rm & anyNA(x)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::median.circular(x, na.rm = na.rm)[[1]])
}

#' Calculate the Hodges-Lehmann Median of Circular Data
#'
#' Computes the Hodges-Lehmann median of circular data using `circular::medianHL.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param method Character string specifying the HL method ("HL1", "HL2", or "HL3").
#' @param prop Numeric. Proportion of data to consider.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The Hodges-Lehmann median of the circular data.
#' @export
summary_medianHL_circular <- function (x, na.rm = FALSE, method = c("HL1","HL2","HL3"), prop = NULL, na_type = "", ...) {
  if(!na.rm & anyNA(x)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::medianHL.circular(x, na.rm = na.rm, method = method, prop = prop)[[1]])
}

#' Calculate the Minimum of Circular Data
#'
#' Computes the minimum value of circular data using `circular::quantile.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param names Logical. Should the names of the quantiles be returned? Defaults to `FALSE`.
#' @param type Integer. Type of quantile calculation.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The minimum of the circular data.
#' @export
summary_min_circular <- function (x, na.rm = FALSE, names = FALSE, type = 7, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)||(!na.rm & anyNA(x))) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::quantile.circular(x, probs = 0, na.rm = na.rm, names = names, type = type)[[1]])
}

#' Calculate the Maximum of Circular Data
#'
#' Computes the maximum value of circular data using `circular::quantile.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param names Logical. Should the names of the quantiles be returned? Defaults to `FALSE`.
#' @param type Integer. Type of quantile calculation.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The maximum of the circular data.
#' @export
summary_max_circular <- function (x, na.rm = FALSE, names = FALSE, type = 7, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)||(!na.rm & anyNA(x))) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::quantile.circular(x, probs = 1, na.rm = na.rm, names = names, type = type)[[1]])
}

#' Calculate Quantiles of Circular Data
#'
#' Computes the quantiles of circular data using `circular::quantile.circular`.
#'
#' @param x A vector of circular data.
#' @param probs Numeric vector of probabilities.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param names Logical. Should the names of the quantiles be returned? Defaults to `FALSE`.
#' @param type Integer. Type of quantile calculation.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The quantiles of the circular data.
#' @export
summary_quantile_circular <- function (x, probs = seq(0, 1, 0.25), na.rm = FALSE, names = FALSE, type = 7, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)||(!na.rm & anyNA(x))) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::quantile.circular(x, probs = probs, na.rm = na.rm, names = names, type = type)[[1]])
}

#' Calculate the Third Quartile of Circular Data
#'
#' Computes the third quartile (Q3) of circular data using `circular::quantile.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param names Logical. Should the names of the quantiles be returned? Defaults to `FALSE`.
#' @param type Integer. Type of quantile calculation.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The third quartile of the circular data.
#' @export
summary_Q3_circular <- function (x, na.rm = FALSE, names = FALSE, type = 7, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)||(!na.rm & anyNA(x))) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::quantile.circular(x, probs = 0.75, na.rm = na.rm, names = names, type = type)[[1]])
}

#' Calculate the First Quartile of Circular Data
#'
#' Computes the first quartile (Q1) of circular data using `circular::quantile.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param names Logical. Should the names of the quantiles be returned? Defaults to `FALSE`.
#' @param type Integer. Type of quantile calculation.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The first quartile of the circular data.
#' @export
summary_Q1_circular <- function (x, na.rm = FALSE, names = FALSE, type = 7, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)||(!na.rm & anyNA(x))) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::quantile.circular(x, probs = 0.25, na.rm = na.rm, names = names, type = type)[[1]])
}

#' Calculate the Standard Deviation of Circular Data
#'
#' Computes the standard deviation of circular data using `circular::sd.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The standard deviation of the circular data.
#' @export
summary_sd_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::sd.circular(x, na.rm = na.rm))
}

#' Calculate the Variance of Circular Data
#'
#' Computes the variance of circular data using `circular::var.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The variance of the circular data.
#' @export
summary_var_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::var.circular(x, na.rm = na.rm))
}

#' Calculate Angular Deviation of Circular Data
#'
#' Computes the angular deviation of circular data using `circular::angular.deviation`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The angular deviation of the circular data.
#' @export
summary_ang_dev_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::angular.deviation(x, na.rm = na.rm))
}


#' Calculate Angular Variance of Circular Data
#'
#' Computes the angular variance of circular data using `circular::angular.variance`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The angular variance of the circular data.
#' @export
summary_ang_var_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::angular.variance(x, na.rm = na.rm))
}

#' Calculate Range of Circular Data
#'
#' Computes the range of circular data using `circular::range.circular`.
#'
#' @param x A vector of circular data.
#' @param test Logical. Perform a statistical test on the range. Defaults to `FALSE`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param finite Logical. Should only finite values be considered? Defaults to `FALSE`.
#' @param control.circular List of control parameters for circular objects.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The range of the circular data.
#' @export
summary_range_circular <- function (x, test = FALSE, na.rm = FALSE, finite = FALSE, control.circular = list(),  na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::range.circular(x, test = test, na.rm = na.rm, finite = finite,  control.circular = control.circular)[[1]])
}

#' Calculate Rho of Circular Data
#'
#' Computes the Rho (mean resultant length) of circular data using `circular::rho.circular`.
#'
#' @param x A vector of circular data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The Rho of the circular data.
#' @export
summary_rho_circular <- function (x, na.rm = FALSE, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else return(circular::rho.circular(x, na.rm = na.rm))
}

#' Calculate Mean of Data
#'
#' Computes the mean or weighted mean of a dataset.
#'
#' @param x A numeric vector.
#' @param add_cols Additional columns (not used directly in calculation).
#' @param weights Optional weights for the data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param trim Numeric. Fraction of observations to trim from each end before computing the mean.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The mean or weighted mean of the data.
#' @export
summary_mean <- function (x, add_cols, weights = NULL, na.rm = FALSE, trim = 0, na_type = "", ...) {
  if( length(x)==0 || (na.rm && length(x[!is.na(x)])==0) ) return(NA)
  else {
    if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
    else {
      if (missing(weights) || is.null(weights))
        return(mean(x, na.rm = na.rm, trim = trim))
      else 
        return(stats::weighted.mean(x, w = weights, na.rm = na.rm))
    }
  }
}

#' Calculate Trimmed Mean of Data
#'
#' Computes the trimmed mean of a dataset.
#'
#' @param x A numeric vector.
#' @param add_cols Additional columns (not used directly in calculation).
#' @param weights Optional weights for the data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param trimmed Numeric. Fraction of observations to trim from each end before computing the mean.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The trimmed mean of the data.
#' @export
summary_trimmed_mean <- function (x, add_cols, weights = NULL, na.rm = FALSE, trimmed = 0, na_type = "", ...) {
  if( length(x)==0 || (na.rm && length(x[!is.na(x)])==0) ) return(NA)
  else {
    if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
    else 
      return(mean(x, na.rm = na.rm, trim = trimmed))
  }
}

#' Calculate Sum of Data
#'
#' Computes the sum or weighted sum of a dataset.
#'
#' @param x A numeric vector.
#' @param weights Optional weights for the data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The sum or weighted sum of the data.
#' @export
summary_sum <- function (x, weights = NULL, na.rm = FALSE, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else {
    if (missing(weights) || is.null(weights)) return(sum(x, na.rm = na.rm))
    else return(sum(x * weights, na.rm = na.rm))
  }
}

#' Count Elements in a Dataset
#'
#' Counts the number of elements in a dataset.
#'
#' @param x A vector of data.
#' @param ... Additional arguments (not used).
#' @return The count of elements in the dataset.
#' @export
summary_count_all <- function(x, ...) {
  return(length(x))
}

#' Count Missing Elements in a Dataset
#'
#' Counts the number of missing (NA) elements in a dataset.
#'
#' @param x A vector of data.
#' @param ... Additional arguments (not used).
#' @return The count of missing elements in the dataset.
#' @export
summary_count_miss <- function(x, ...) {
  return(sum(is.na(x)))
}

#' Count Non-Missing Elements
#'
#' Counts the number of non-missing (non-NA) elements in a dataset.
#'
#' @param x A vector of data.
#' @param ... Additional arguments (not used).
#' @return The count of non-missing elements in the dataset.
#' @export
summary_count <- function(x, ...) {
  return(sum(!is.na(x)))
}

#' Calculate Standard Deviation
#'
#' Computes the standard deviation or weighted standard deviation of a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The standard deviation or weighted standard deviation of the data.
#' @export
summary_sd <- function(x, na.rm = FALSE, weights = NULL, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(sd(x, na.rm = na.rm))
    } else {
      return(sqrt(Hmisc::wtd.var(x, weights = weights, na.rm = na.rm)))
    }
  }  
}

#' Calculate Variance
#'
#' Computes the variance or weighted variance of a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The variance or weighted variance of the data.
#' @export
summary_var <- function(x, na.rm = FALSE, weights = NULL, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(stats::var(x,na.rm = na.rm))
    }
    else {
      return(Hmisc::wtd.var(x, weights = weights, na.rm = na.rm))
    }
  }
}

#' Calculate Maximum Value
#'
#' Computes the maximum value in a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The maximum value in the dataset.
#' @export
summary_max <- function (x, na.rm = FALSE, na_type = "", ...) {
  #TODO This prevents warning and -Inf being retured. Is this desirable?
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    return(max(x, na.rm = na.rm))
  } 
}

#' Calculate Minimum Value
#'
#' Computes the minimum value in a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The minimum value in the dataset.
#' @export
summary_min <- function (x, na.rm = FALSE, na_type = "", ...) {
  #TODO This prevents warning and Inf being retured. Is this desirable?
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    return(min(x, na.rm = na.rm))
  } 
}

#' Get Indices of Maximum Value
#'
#' Finds all indices of the maximum value in a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `TRUE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return A vector of indices corresponding to the maximum value.
#' @export
summary_which_max <- function (x, na.rm = TRUE, na_type = "", ...) {
  if(length(x)==0 || (na.rm && length(x[!is.na(x)])==0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    # Get the minimum value
    max_value <- max(x, na.rm = na.rm)
    # Return all indices where x is equal to the minimum value
    return(which(x == max_value))
  } 
}

#' Get Indices of Minimum Value
#'
#' Finds all indices of the minimum value in a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `TRUE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return A vector of indices corresponding to the minimum value.
#' @export
summary_which_min <- function(x, na.rm = TRUE, na_type = "", ...) {
  if(length(x) == 0 || (na.rm && length(x[!is.na(x)]) == 0)) return(NA)
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else {
    # Get the minimum value
    min_value <- min(x, na.rm = na.rm)
    # Return all indices where x is equal to the minimum value
    return(which(x == min_value))
  }
}

#' Get Corresponding Value for Maximum
#'
#' Returns the value in another vector corresponding to the maximum value in a dataset.
#'
#' @param x A numeric vector.
#' @param summary_where_y A vector of values corresponding to `x`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `TRUE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The value in `summary_where_y` corresponding to the maximum value in `x`.
#' @export
summary_where_max <- function(x, summary_where_y=NULL, na.rm = TRUE, na_type = "", ...) {  
  # Check if vectors are empty
  if (length(x) == 0 || length(summary_where_y) == 0) {
    return(NA)
  }
  
  # Handle NA values
  if (na.rm) {
    valid_indices <- !is.na(x) & !is.na(summary_where_y)
    x <- x[valid_indices]
    summary_where_y <- summary_where_y[valid_indices]
  }
  
  # Find the index of the maximum value in x
  max_index <- which.max(x)
  
  # Return the corresponding value in summary_where_y
  return(summary_where_y[max_index])
}


#' Get Corresponding Value for Minimum
#'
#' Returns the value in another vector corresponding to the minimum value in a dataset.
#'
#' @param x A numeric vector.
#' @param summary_where_y A vector of values corresponding to `x`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `TRUE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The value in `summary_where_y` corresponding to the minimum value in `x`.
#' @export
summary_where_min <- function(x, summary_where_y=NULL, na.rm = TRUE, na_type = "", ...) {
  # Check if vectors are empty
  if (length(x) == 0 || length(summary_where_y) == 0) {
    return(NA)
  }
  
  # Handle NA values
  if (na.rm) {
    valid_indices <- !is.na(x) & !is.na(summary_where_y)
    x <- x[valid_indices]
    summary_where_y <- summary_where_y[valid_indices]
  }
  
  # Find the index of the minimum value in x
  min_index <- summary_which_min(x, na.rm = na.rm, na_type = na_type, ...)
  
  # Return the corresponding value in summary_where_y
  return(summary_where_y[min_index])
}

#' Calculate Range
#'
#' Computes the range of a dataset (difference between the maximum and minimum values).
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The range of the dataset.
#' @export
summary_range <- function(x, na.rm = FALSE, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    return(max(x, na.rm = na.rm) - min(x, na.rm = na.rm))
  }
}

#' Calculate Median
#'
#' Computes the median or weighted median of a dataset. Handles ordered factors and dates.
#'
#' @param x A numeric vector, ordered factor, or date.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The median or weighted median of the dataset.
#' @export
summary_median <- function(x, na.rm = FALSE, weights = NULL, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(missing(weights) || is.null(weights)) {
      if (stringr::str_detect(class(x), pattern = "ordered") || stringr::str_detect(class(x), pattern = "Date")) {
        return(stats::quantile(x, na.rm = na.rm, probs = 0.5, type = 1)[[1]])
      } else {
        return(stats::median(x, na.rm = na.rm))
      }
    } else {
      return(Hmisc::wtd.quantile(x, weights = weights, probs = 0.5, na.rm = na.rm))
    }
  }
}

#' Calculate Quantile
#'
#' Computes the quantile or weighted quantile of a dataset. Handles ordered factors and dates.
#'
#' @param x A numeric vector, ordered factor, or date.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param probs Numeric vector of probabilities (e.g., 0.1 for 10th percentile).
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The quantile or weighted quantile of the dataset.
#' @export
summary_quantile <- function(x, na.rm = FALSE, weights = NULL, probs, na_type = "", ...) {
  if(!na.rm && anyNA(x)) return(NA)
  # This prevents multiple values being returned
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else {
    if(missing(weights) || is.null(weights)) {
      if (stringr::str_detect(class(x), pattern = "ordered") || stringr::str_detect(class(x), pattern = "Date")) {
        return(stats::quantile(x, na.rm = na.rm, probs = probs, type = 1)[[1]])
      } else {
        return(stats::quantile(x, na.rm = na.rm, probs = probs)[[1]])
      }
    }
    else {
      return(Hmisc::wtd.quantile(x, weights = weights, probs = probs, na.rm = na.rm))
    }
  }
}

#' Calculate 10th Percentile
#'
#' Computes the 10th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 10th percentile of the dataset.
#' @export
p10 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.1, na_max_prop = na_max_prop, ...)
}

#' Calculate 20th Percentile
#'
#' Computes the 20th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 20th percentile of the dataset.
#' @export
p20 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL,...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.2, na_max_prop = na_max_prop, ...)
}

#' Calculate 25th Percentile (First Quartile)
#'
#' Computes the 25th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 25th percentile of the dataset.
#' @export
p25 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.25, na_max_prop = na_max_prop, ...)
}

#' Calculate 30th Percentile
#'
#' Computes the 30th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 30th percentile of the dataset.
#' @export
p30 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.3, na_max_prop = na_max_prop, ...)
}

#' Calculate 33rd Percentile
#'
#' Computes the 33rd percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 33rd percentile of the dataset.
#' @export
p33 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.33, na_max_prop = na_max_prop, ...)
}

#' Calculate 40th Percentile
#'
#' Computes the 40th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 40th percentile of the dataset.
#' @export
p40 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.4, na_max_prop = na_max_prop, ...)
}

#' Calculate 60th Percentile
#'
#' Computes the 60th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 60th percentile of the dataset.
#' @export
p60 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.6, na_max_prop = na_max_prop, ...)
}

#' Calculate 67th Percentile
#'
#' Computes the 67th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 67th percentile of the dataset.
#' @export
p67 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.67, na_max_prop = na_max_prop, ...)
}

#' Calculate 70th Percentile
#'
#' Computes the 70th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 70th percentile of the dataset.
#' @export
p70 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.7, na_max_prop = na_max_prop, ...)
}

#' Calculate 75th Percentile (Third Quartile)
#'
#' Computes the 75th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 75th percentile of the dataset.
#' @export
p75 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.75, na_max_prop = na_max_prop, ...)
}

#' Calculate 80th Percentile
#'
#' Computes the 80th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 80th percentile of the dataset.
#' @export
p80 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.8, na_max_prop = na_max_prop, ...)
}

#' Calculate 90th Percentile
#'
#' Computes the 90th percentile of a dataset using `summary_quantile`.
#'
#' @inheritParams summary_quantile
#' @return The 90th percentile of the dataset.
#' @export
p90 <- function(x, na.rm = FALSE, na_type = "", weights = NULL, na_max_prop = NULL, ...) {
  summary_quantile(x = x, na.rm = na.rm, na_type = na_type, weights = weights, probs = 0.9, na_max_prop = na_max_prop, ...)
}

#' Calculate Skewness
#'
#' Computes the skewness or weighted skewness of a dataset.
#'
#' @param x A numeric vector.
#' @param weights Optional weights for the data.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param type Integer. Type of skewness calculation. Defaults to `2`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The skewness or weighted skewness of the dataset.
#' @export
summary_skewness <- function(x, weights = NULL, na.rm = FALSE, type = 2, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(e1071::skewness(x, na.rm = na.rm, type = type))
    }
    if (length(weights) != length(x)) stop("'x' and 'weights' must have the same length")
    if (na.rm) {
      i <- !is.na(x) && !is.na(weights)
      weights <- weights[i]
      x <- x[i]
    }
    ( sum( weights * (x - Weighted.Desc.Stat::w.mean(x, weights))^3 ) / sum(weights)) / Weighted.Desc.Stat::w.sd(x, weights)^3
  }
}

#' Calculate Medcouple Skewness
#'
#' Computes the medcouple skewness using `robustbase::mc`.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The medcouple skewness.
#' @export
summary_skewness_mc <- function(x, na.rm = FALSE, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    return(robustbase::mc(x, na.rm = na.rm))
  }
}

#' Calculate Outlier Limits
#'
#' Computes the upper or lower outlier limits based on skewness and interquartile range.
#'
#' @param x A numeric vector.
#' @param coef Numeric. Coefficient for the IQR. Defaults to `1.5`.
#' @param bupperlimit Logical. Calculate upper limit if `TRUE`, lower limit otherwise. Defaults to `TRUE`.
#' @param bskewedcalc Logical. Use skewness in the calculation if `TRUE`. Defaults to `FALSE`.
#' @param skewnessweight Numeric. Weight for skewness in the calculation. Defaults to `4`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `TRUE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param omit Logical. Omit values below a threshold. Defaults to `FALSE`.
#' @param value Numeric. Threshold for omission. Defaults to `0`.
#' @param ... Additional arguments passed to `na_check`.
#' @return The calculated outlier limit.
#' @export
summary_outlier_limit <- function(x, coef = 1.5, bupperlimit = TRUE, bskewedcalc = FALSE, skewnessweight = 4, na.rm = TRUE, na_type = "", omit = FALSE, value = 0, ...){ 
  if(omit){
    #This is needed when we need rainy days defined(Rain>=0.85)
    #if(value!=0){
    # x <- x[x>=value]
    #}else{
    x <- x[x>value]
    #}
  }
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    quart <- stats::quantile(x, na.rm = na.rm)
    Q1 <- quart[[2]]
    Q3 <- quart[[4]]
    IQR <- Q3 - Q1
    MC <- 0
    if(bskewedcalc){
      MC <- robustbase::mc(x, na.rm = na.rm)
    }
    if(bupperlimit){
      Q3 + coef*exp(skewnessweight*MC)*IQR
    } else {
      Q1 - coef*exp(-skewnessweight*MC)*IQR
    }
  }
}

#' Calculate Kurtosis
#'
#' Computes the kurtosis or weighted kurtosis of a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param type Integer. Type of kurtosis calculation. Defaults to `2`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The kurtosis or weighted kurtosis of the dataset.
#' @export
summary_kurtosis <- function(x, na.rm = FALSE, weights = NULL, type = 2, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(e1071::kurtosis(x, na.rm = na.rm, type = type))
    }
    if (length(weights) != length(x)) 
      stop("'x' and 'weights' must have the same length")
    if (na.rm) {
      i <- !is.na(x) && !is.na(weights)
      weights <- weights[i]
      x <- x[i]
    }
    ((sum(weights * (x - Weighted.Desc.Stat::w.mean(x, weights))^4)/sum(weights))/Weighted.Desc.Stat::w.sd(x, weights)^4) - 3
  }
}

#' Calculate Coefficient of Variation
#'
#' Computes the coefficient of variation for a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The coefficient of variation.
#' @export
summary_coef_var <- function(x, na.rm = FALSE, weights = NULL, na_type = "", ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(summary_sd(x) / summary_mean(x))
    }
    if (length(weights) != length(x)) 
      stop("'x' and 'weights' must have the same length")
    if (na.rm) {
      i <- !is.na(x) && !is.na(weights)
      weights <- weights[i]
      x <- x[i]
    }
    Weighted.Desc.Stat::w.cv(x = x, mu = weights)
  }
}

#' Calculate Median Absolute Deviation
#'
#' Computes the median absolute deviation or weighted absolute deviation.
#'
#' @param x A numeric vector.
#' @param constant Numeric. Scale factor. Defaults to `1.4826`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param weights Optional weights for the data.
#' @param low Logical. Use only values below the median. Defaults to `FALSE`.
#' @param high Logical. Use only values above the median. Defaults to `FALSE`.
#' @param ... Additional arguments passed to `na_check`.
#' @return The median absolute deviation or weighted absolute deviation.
#' @export
summary_median_absolute_deviation <- function(x, constant = 1.4826, na.rm = FALSE, na_type = "", weights = NULL, low = FALSE, high = FALSE, ...) {
  if (na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else {
    if (missing(weights) || is.null(weights)) {
      return(stats::mad(x, constant = constant, na.rm = na.rm, low = low, high = high))
    }
    else {
      Weighted.Desc.Stat::w.ad(x = x, mu = weights)
    }
  }
}

#' Calculate Qn
#'
#' Computes the robust Qn scale estimator using `robustbase::Qn`.
#'
#' @param x A numeric vector.
#' @param constant Numeric. Scale factor. Defaults to `2.21914`.
#' @param finite.corr Logical. Apply finite sample correction. Defaults to `TRUE`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The Qn scale estimator.
#' @export
summary_Qn <- function(x, constant = 2.21914, finite.corr = missing(constant), na.rm = FALSE, na_type = "", ...) {
  if(!na.rm && anyNA(x)) return(NA)
  else {
    if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
    else{
      x <- x[!is.na(x)]
      return(robustbase::Qn(x, constant = constant, finite.corr = finite.corr))
    }
  }
}

#' Calculate Sn
#'
#' Computes the robust Sn scale estimator using `robustbase::Sn`.
#'
#' @param x A numeric vector.
#' @param constant Numeric. Scale factor. Defaults to `1.1926`.
#' @param finite.corr Logical. Apply finite sample correction. Defaults to `TRUE`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The Sn scale estimator.
#' @export
summary_Sn <- function(x, constant = 1.1926, finite.corr = missing(constant), na.rm = FALSE, na_type = "", ...) {
  if(!na.rm && anyNA(x)) return(NA)
  else {
    if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
    else{
      x <- x[!is.na(x)]
      return(robustbase::Qn(x, constant = constant, finite.corr = finite.corr))
    }
  }
}

#' Calculate Correlation
#'
#' Computes the correlation or weighted correlation between two datasets.
#'
#' @param x A numeric vector.
#' @param y A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param weights Optional weights for the data.
#' @param method Character. Correlation method ("pearson", "kendall", "spearman"). Defaults to `"pearson"`.
#' @param cor_use Character. How missing data is handled ("everything", "all.obs", etc.). Defaults to `"everything"`.
#' @param ... Additional arguments passed to `na_check`.
#' @return The correlation or weighted correlation.
#' @export
summary_cor <- function(x, y, na.rm = FALSE, na_type = "", weights = NULL, method = c("pearson", "kendall", "spearman"), cor_use = c("everything", "all.obs", "complete.obs", "na.or.complete", "pairwise.complete.obs"), ...) {
  cor_use <- match.arg(cor_use)
  if (na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else {
    if (missing(weights) || is.null(weights)) {
      return(stats::cor(x = x, y = y, use = cor_use, method = method))
    }
    else {
      weights::wtd.cor(x = x, y = y, weight = weights)[1]
    }
  }
}

#' Calculate Covariance
#'
#' Computes the covariance or weighted covariance between two datasets.
#'
#' @param x A numeric vector.
#' @param y A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param weights Optional weights for the data.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param method Character. Covariance method ("pearson", "kendall", "spearman"). Defaults to `"pearson"`.
#' @param use Character. How missing data is handled ("everything", "all.obs", etc.). Defaults to `"everything"`.
#' @param ... Additional arguments passed to `na_check`.
#' @return The covariance or weighted covariance.
#' @export
summary_cov <- function(x, y, na.rm = FALSE, weights = NULL, na_type = "", method = c("pearson", "kendall", "spearman"), use = c( "everything", "all.obs", "complete.obs", "na.or.complete", "pairwise.complete.obs"), ...) {
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (missing(weights) || is.null(weights)) {
      return(stats::cov(x = x, y = y, use = use, method = method))
    }
    if (length(weights) != length(x)) 
      stop("'x' and 'weights' must have the same length")
    if (na.rm) {
      i <- !is.na(x) && !is.na(weights)
      weights <- weights[i]
      x <- x[i]
    }
    (sum(weights * x * y)/sum(weights)) - (Weighted.Desc.Stat::w.mean(x = x, mu = weights) * Weighted.Desc.Stat::w.mean(x = y, mu = weights))
  }
}

#' Get First Element
#'
#' Returns the first element of a vector, optionally ordered by another vector.
#'
#' @param x A vector.
#' @param order_by Optional vector to order by.
#' @param ... Additional arguments (not used).
#' @return The first element of the vector.
#' @export
summary_first <- function(x, order_by = NULL, ...) {
  return(dplyr::first(x = x, order_by = order_by))
}

#' Get Last Element
#'
#' Returns the last element of a vector, optionally ordered by another vector.
#'
#' @param x A vector.
#' @param order_by Optional. A vector to order by before selecting the last element.
#' @param ... Additional arguments (not used).
#' @return The last element of the vector.
#' @export
summary_last <- function(x, order_by = NULL, ...) {
  return(dplyr::last(x = x, order_by = order_by))
}

#' Get nth Element
#'
#' Returns the nth element of a vector, optionally ordered by another vector.
#'
#' @param x A vector.
#' @param nth_value Integer. The position of the element to return.
#' @param order_by Optional. A vector to order by before selecting the nth element.
#' @param ... Additional arguments (not used).
#' @return The nth element of the vector.
#' @export
summary_nth <- function(x, nth_value, order_by = NULL, ...) {
  return(dplyr::nth(x = x, n = nth_value, order_by = order_by))
}

#' Count Distinct Elements
#'
#' Counts the number of distinct elements in a vector.
#'
#' @param x A vector of data.
#' @param na.rm Logical. Should missing values (`NA`) be removed? Defaults to `FALSE`.
#' @param ... Additional arguments (not used).
#' @return The count of distinct elements in the vector.
#' @export
summary_n_distinct<- function(x, na.rm = FALSE, ...) {
  return(dplyr::n_distinct(x = x, na.rm = na.rm))
}                              

#' Sample a Single Element
#'
#' Randomly samples a single element from a vector.
#'
#' @param x A vector of data.
#' @param replace Logical. Should sampling be with replacement? Defaults to `FALSE`.
#' @param seed Optional. A seed for reproducibility.
#' @param ... Additional arguments (not used).
#' @return A randomly sampled element from the vector.
#' @export
summary_sample <- function(x, replace = FALSE, seed, ...){
  if(!missing(seed)) set.seed(seed = seed)
  return(sample(x = x, size = 1, replace = replace))
}

#' Calculate Proportion
#'
#' Calculates the proportion of elements in a dataset that satisfy a specified condition.
#'
#' @param x A numeric vector.
#' @param prop_test Character. The comparison operator (e.g., `"=="`, `">="`).
#' @param prop_value Numeric. The value to compare against.
#' @param As_percentage Logical. Return the result as a percentage if `TRUE`. Defaults to `FALSE`.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The calculated proportion or percentage.
#' @export
proportion_calc <- function(x, prop_test = "==", prop_value, As_percentage = FALSE, na.rm = FALSE, na_type = "", ... ){ 
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(!na.rm){
      if(sum(is.na(x)) > 0) return(NA)
      y <- x[eval(parse(text = paste("x", prop_value, sep = prop_test)))]
      if(!As_percentage){
        return(round(length(y)/length(x),digits = 2))
      }
      else {
        return(round((length(y)/length(x)*100),digits = 2 ))
      }  
    }
    else {
      remove.na <- stats::na.omit(x)
      y <- remove.na[eval(parse(text = paste("remove.na", prop_value, sep = prop_test)))]
      if (!As_percentage){
        return(round(length(y)/length(remove.na), digits = 2))
      }
      else{
        return(round(length(y)/length(remove.na)*100, digits = 2 ))
      }
    }
  }
}

#' Count Matching Elements
#'
#' Counts the number of elements in a dataset that satisfy a specified condition.
#'
#' @param x A numeric vector.
#' @param count_test Character. The comparison operator (e.g., `"=="`, `">="`).
#' @param count_value Numeric. The value to compare against.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The count of matching elements.
#' @export
count_calc <- function(x, count_test = "==", count_value, na.rm = FALSE, na_type = "", ...){ 
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (!na.rm){
      if (sum(is.na(x)) > 0) return(NA)
      return(length(x[eval(parse(text = paste("x", count_value, sep = count_test)))]))
    }
    else{
      y <- stats::na.omit(x)
      return(length(y[eval(parse(text = paste("y", count_value, sep = count_test)))]))
    }
  }
}

#' Calculate Standard Error of the Mean
#'
#' Computes the standard error of the mean for a dataset.
#'
#' @param x A numeric vector.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The standard error of the mean.
#' @export
standard_error_mean <- function(x, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if (!na.rm){
      if(sum(is.na(x) > 0)) return(NA)
      return(stats::sd(x)/sqrt(length(x)))
    }
    else{
      y <- stats::na.omit(x)
      return(stats::sd(y)/sqrt(length(y)))
    }
  }
}

#' Calculate Mean Error
#'
#' Computes the mean error using the `hydroGOF::me` function.
#'
#' @param x Observed values.
#' @param y Simulated values.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The mean error.
#' @export
me <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::me(sim = y, obs = x, na.rm = na.rm))
  }
} 

#' Calculate Mean Absolute Error
#'
#' Computes the mean absolute error using the `hydroGOF::mae` function.
#'
#' @inheritParams me
#' @return The mean absolute error.
#' @export
mae <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::mae(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Root Mean Square Error
#'
#' Computes the root mean square error using the `hydroGOF::rmse` function.
#'
#' @inheritParams me
#' @return The root mean square error.
#' @export
rmse <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::rmse(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Normalized Root Mean Square Error
#'
#' Computes the normalized root mean square error using the `hydroGOF::nrmse` function.
#'
#' @inheritParams me
#' @return The normalized root mean square error.
#' @export
nrmse <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::nrmse(sim = y, obs = x, na.rm = na.rm))
  }
} 

#' Calculate Percent Bias
#'
#' Computes the percent bias using the `hydroGOF::pbias` function.
#'
#' @inheritParams me
#' @return The percent bias.
#' @export
PBIAS <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::pbias(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Nash-Sutcliffe Efficiency
#'
#' Computes the Nash-Sutcliffe efficiency using the `hydroGOF::NSeff` function.
#'
#' @inheritParams me
#' @return The Nash-Sutcliffe efficiency.
#' @export
NSE <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::NSeff(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Modified Nash-Sutcliffe Efficiency
#'
#' Computes the modified Nash-Sutcliffe efficiency using the `hydroGOF::mNSE` function.
#'
#' @param j Numeric. Exponent parameter for the modified NSE calculation. Defaults to `1`.
#' @inheritParams me
#' @return The modified Nash-Sutcliffe efficiency.
#' @export
mNSE <- function(x, y, j = 1, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::mNSE(sim = y, obs = x, j = j, na.rm = na.rm))
  }
} 

#' Calculate Relative Nash-Sutcliffe Efficiency
#'
#' Computes the relative Nash-Sutcliffe efficiency using the `hydroGOF::rNSeff` function.
#'
#' @param x Observed values.
#' @param y Simulated values.
#' @param na.rm Logical. Should missing values be removed? Defaults to `FALSE`.
#' @param na_type Character string indicating the type of NA check to perform.
#' @param ... Additional arguments passed to `na_check`.
#' @return The relative Nash-Sutcliffe efficiency.
#' @export
rNSE <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::rNSeff(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Index of Agreement
#'
#' Computes the index of agreement using the `hydroGOF::d` function.
#'
#' @inheritParams rNSE
#' @return The index of agreement.
#' @export
d <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::d(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Modified Index of Agreement
#'
#' Computes the modified index of agreement using the `hydroGOF::md` function.
#'
#' @param j Numeric. Parameter for the modified index of agreement. Defaults to `1`.
#' @inheritParams rNSE
#' @return The modified index of agreement.
#' @export
md <- function(x, y, j = 1, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::md(sim = y, obs = x, j = j,  na.rm = na.rm))
  }
}

#' Calculate Relative Index of Agreement
#'
#' Computes the relative index of agreement using the `hydroGOF::rd` function.
#'
#' @inheritParams rNSE
#' @return The relative index of agreement.
#' @export
rd <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::rd(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Coefficient of Determination (R²)
#'
#' Computes the coefficient of determination using the `hydroGOF::br2` function.
#'
#' @inheritParams rNSE
#' @return The coefficient of determination (R²).
#' @export
R2 <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::br2(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Coefficient of Persistence
#'
#' Computes the coefficient of persistence using the `hydroGOF::cp` function.
#'
#' @inheritParams rNSE
#' @return The coefficient of persistence.
#' @export
cp <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(unique(y))==1||length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::cp(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Kling-Gupta Efficiency
#'
#' Computes the Kling-Gupta efficiency using the `hydroGOF::KGE` function.
#'
#' @inheritParams rNSE
#' @return The Kling-Gupta efficiency.
#' @export
KGE <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::KGE(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Mean Squared Error
#'
#' Computes the mean squared error using the `hydroGOF::mse` function.
#'
#' @inheritParams rNSE
#' @return The mean squared error.
#' @export
mse <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::mse(sim = y, obs = x, na.rm = na.rm))
  }
} 

#' Calculate Ratio of Standard Deviations
#'
#' Computes the ratio of standard deviations using the `hydroGOF::rSD` function.
#'
#' @inheritParams rNSE
#' @return The ratio of standard deviations.
#' @export
rSD <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::rSD(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Ratio of RMSE
#'
#' Computes the ratio of RMSE using the `hydroGOF::rsr` function.
#'
#' @inheritParams rNSE
#' @return The ratio of RMSE.
#' @export
rsr <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::rsr(sim = y, obs = x, na.rm = na.rm))
  }
}


#' Calculate Sum of Squared Residuals
#'
#' Computes the sum of squared residuals using the `hydroGOF::ssq` function.
#'
#' @inheritParams rNSE
#' @return The sum of squared residuals.
#' @export
ssq <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::ssq(sim = y, obs = x, na.rm = na.rm))
  }
}

#' Calculate Volumetric Efficiency
#'
#' Computes the volumetric efficiency using the `hydroGOF::VE` function.
#'
#' @inheritParams rNSE
#' @return The volumetric efficiency.
#' @export
VE <- function(x, y, na.rm = FALSE, na_type = "", ...){
  if(na.rm && na_type != "" && !na_check(x, na_type = na_type, ...)) return(NA)
  else{
    if(length(x[is.na(x)])==length(x)||length(y[is.na(y)])==length(y)) return(NA)
    return(hydroGOF::VE(sim = y, obs = x, na.rm = na.rm))
  }
}

# This repetition causes issue in package
# #' Calculate Percent Correct
# #'
# #' Computes the percent correct using the `verification::verify` function.
# #'
# #' @param x Observed values.
# #' @param y Predicted values.
# #' @param frcst.type Character. The type of forecast (e.g., "binary").
# #' @param obs.type Character. The type of observation (e.g., "binary").
# #' @param ... Additional arguments passed to `verification::verify`.
# #' @return The percent correct.
# #' @export
# pc <- function(x, y, frcst.type, obs.type, ...){
#   A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
#   return(A$pc)  
# }
# #' Calculate Heidke Skill Score
# #'
# #' Computes the Heidke skill score using the `verification::verify` function.
# #'
# #' @inheritParams PC
# #' @return The Heidke skill score.
# #' @export
# hss <- function(x, y, frcst.type, obs.type, ...){
#   A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
#   return(A$hss)  
# }

#' Calculate Pierce Skill Score
#'
#' Computes the Pierce skill score using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The Pierce skill score.
#' @export
pss <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$pss)  
}

#' Calculate Gerrity Score
#'
#' Computes the Gerrity score using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The Gerrity score.
#' @export
GS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$gs)  
}

#' Calculate Probability of Detection (PODy)
#'
#' Computes the probability of detection (PODy) using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The probability of detection.
#' @export
PODy <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$POD)  
}

#' Calculate Threat Score
#'
#' Computes the threat score using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The threat score.
#' @export
TS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$TS)  
}

#' Calculate Equitable Threat Score
#'
#' Computes the equitable threat score using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The equitable threat score.
#' @export
ETS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$ETS)  
}

#' Calculate False Alarm Ratio
#'
#' Computes the false alarm ratio using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The false alarm ratio.
#' @export
FAR <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$FAR)  
}

#' Calculate Heidke Skill Score (HSS)
#'
#' Computes the Heidke skill score using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The Heidke skill score.
#' @export
HSS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$HSS)  
}

#' Calculate Percent Correct (PC)
#'
#' Computes the percent correct using the `verification::verify` function.
#'
#' @param x Observed values.
#' @param y Predicted values.
#' @param frcst.type Character. The type of forecast (e.g., "binary").
#' @param obs.type Character. The type of observation (e.g., "binary").
#' @param ... Additional arguments passed to `verification::verify`.
#' @return The percent correct.
#' @export
PC <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$PC)  
}

#' Calculate Bias
#'
#' Computes the bias using the `verification::verify` function.
#'
#' @inheritParams PC
#' @return The bias.
#' @export
BIAS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$BIAS)  
}




#' Calculate Extreme Dependency Score
#'
#' Computes the extreme dependency score (EDS) using the `verification::verify` function.
#'
#' @param x Observed values.
#' @param y Predicted values.
#' @param frcst.type Character. The type of forecast (e.g., "categorical").
#' @param obs.type Character. The type of observation (e.g., "categorical").
#' @param ... Additional arguments passed to `verification::verify`.
#' @return The extreme dependency score.
#' @export
EDS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$eds)  
}

#' Calculate Symmetric Extreme Dependency Score
#'
#' Computes the symmetric extreme dependency score (SEDS) using the `verification::verify` function.
#'
#' @inheritParams EDS
#' @return The symmetric extreme dependency score.
#' @export
SEDS <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$seds)  
}

#' Calculate Extremal Dependency Index
#'
#' Computes the extremal dependency index (EDI) using the `verification::verify` function.
#'
#' @inheritParams EDS
#' @return The extremal dependency index.
#' @export
EDI <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$EDI)  
}

#' Calculate Symmetric Extremal Dependency Index
#'
#' Computes the symmetric extremal dependency index (SEDI) using the `verification::verify` function.
#'
#' @inheritParams EDS
#' @return The symmetric extremal dependency index.
#' @export
SEDI <- function(x, y, frcst.type, obs.type, ...){
  A <- verification::verify(obs = x, pred = y,  frcst.type = frcst.type, obs.type = obs.type)
  return(A$SEDI)  
}