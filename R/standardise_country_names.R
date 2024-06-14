#' Standardise Country Names
#' @description
#' Standardise country names in the dataset.
#'
#' @param country Name of Country
#'
#' @return Name of country
standardise_country_names = function(country) {
  country_names <- country
  country_names[country_names == "Antigua and Bar"] <- "Antigua and Barbuda"
  country_names[country_names == "Bosnia and Herz"] <- "Bosnia and Herzegovina"
  country_names[country_names == "Cabo Verde"] <- "Cape Verde"
  country_names[country_names == "Central African"] <- "Central African Republic"
  country_names[country_names == "Cote d'Ivoire"] <- "Cote d'Ivoire"
  country_names[country_names == "Congo, Democrat"] <- "Democratic Republic of the Congo"
  country_names[country_names == "Dominican Repub"] <- "Dominican Republic"
  country_names[country_names == "Egypt, Arab Rep"] <- "Egypt"
  country_names[country_names == "Equatorial Guin"] <- "Equatorial Guinea"
  country_names[country_names == "Gambia, The"] <- "Gambia"
  country_names[country_names == "Iran, Islamic R"] <- "Iran, Islamic Republic of"
  country_names[country_names == "Korea, Republic"] <- "Korea, Republic of"
  country_names[country_names == "Kyrgyz Republic"] <- "Kyrgyzstan"
  country_names[country_names == "Lao People's De"] <- "Lao People's Democratic Republic"
  country_names[country_names == "Macedonia, form"] <- "Macedonia, the Former Yugoslav Republic of"
  country_names[country_names == "Moldova"] <- "Moldova, Republic of"
  country_names[country_names == "Papua New Guine"] <- "Papua New Guinea"
  country_names[country_names == "Russian Federat"] <- "Russian Federation"
  country_names[country_names == "St. Kitts and N"] <- "Saint Kitts and Nevis"
  country_names[country_names == "St. Lucia"] <- "Saint Lucia"
  country_names[country_names == "St. Vincent and"] <- "Saint Vincent and the Grenadines"
  country_names[country_names == "Sao Tome and Pr"] <- "Sao Tome and Principe"
  country_names[country_names == "Slovak Republic"] <- "Slovakia"
  country_names[country_names == "Syrian Arab Rep"] <- "Syrian Arab Republic"
  country_names[country_names == "Trinidad and To"] <- "Trinidad and Tobago"
  country_names[country_names == "Tanzania"] <- "United Republic of Tanzania"
  country_names[country_names == "Venezuela, Repu"] <- "Venezuela"
  country_names[country_names == "Vietnam"] <- "Viet Nam"
  country_names[country_names == "West Bank and G"] <- "West Bank and Gaza"
  country_names[country_names == "Yemen, Republic"] <- "Yemen"
  return(country_names)
}