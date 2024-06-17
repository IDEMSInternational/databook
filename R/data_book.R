#' DataBook Class
#'
#' An R6 class to manage a collection of data tables along with their metadata and other associated properties.
#'
#' @name DataBook
#' @docType class
#' @format An R6 class object.
#' @usage DataBook$new(data_tables = list(), instat_obj_metadata = list(), 
#'                     data_tables_variables_metadata = rep(list(data.frame()), length(data_tables)),
#'                     data_tables_metadata = rep(list(list()), length(data_tables)),
#'                     data_tables_filters = rep(list(list()), length(data_tables)),
#'                     data_tables_column_selections = rep(list(list()), length(data_tables)),
#'                     imported_from = as.list(rep("", length(data_tables))),
#'                     messages = TRUE, convert = TRUE, create = TRUE)
#'
#' @section Methods:
#' \describe{
#'   \item{\code{set_data(new_data, messages, check_names)}}{Sets the data for the DataSheet object.}
#'   \item{\code{standardise_country_names(data_name, country_columns = c())}}{Standardizes country names in the specified data table.}
#'   \item{\code{define_as_climatic(data_name, types, key_col_names, key_name)}}{Defines a data table as climatic data.}
#'   \item{\code{define_corruption_outputs(data_name, output_columns = c())}}{Defines corruption output columns in the specified data table.}
#'   \item{\code{define_red_flags(data_name, red_flags = c())}}{Defines red flag columns in the specified data table.}
#'   \item{\code{define_as_procurement(data_name, primary_types = c(), calculated_types = c(), country_data_name, country_types, auto_generate = TRUE)}}{Defines a data table as procurement data.}
#'   \item{\code{define_as_procurement_country_level_data(data_name, contract_level_data_name, types = c(), auto_generate = TRUE)}}{Defines a data table as procurement country-level data.}
#'   \item{\code{get_CRI_component_column_names(data_name)}}{Gets the names of CRI component columns in the specified data table.}
#'   \item{\code{get_red_flag_column_names(data_name)}}{Gets the names of red flag columns in the specified data table.}
#'   \item{\code{get_CRI_column_names(data_name)}}{Gets the names of CRI columns in the specified data table.}
#'   \item{\code{get_corruption_column_name(data_name, type)}}{Gets the name of the corruption column in the specified data table.}
#' }
#'
#' @export
DataBook <- R6::R6Class("DataBook",
                        public = list(
                          #' @description
                          #' Initialize a new DataBook object.
                          #' @param data_tables A list of data frames to be included in the DataBook.
                          #' @param instat_obj_metadata Metadata for the instat object.
                          #' @param data_tables_variables_metadata A list of data frames, each containing metadata for the corresponding data table.
                          #' @param data_tables_metadata A list of lists, each containing metadata for the corresponding data table.
                          #' @param data_tables_filters A list of lists, each containing filter information for the corresponding data table.
                          #' @param data_tables_column_selections A list of lists, each containing column selection information for the corresponding data table.
                          #' @param imported_from A list of strings indicating the source from which each data table was imported.
                          #' @param messages A boolean indicating whether to display messages.
                          #' @param convert A boolean indicating whether to perform data conversion.
                          #' @param create A boolean indicating whether to create new data objects.
                          initialize = function(data_tables = list(), instat_obj_metadata = list(), 
                                                data_tables_variables_metadata = rep(list(data.frame()), length(data_tables)),
                                                data_tables_metadata = rep(list(list()), length(data_tables)),
                                                data_tables_filters = rep(list(list()), length(data_tables)),
                                                data_tables_column_selections = rep(list(list()), length(data_tables)),
                                                imported_from = as.list(rep("", length(data_tables))),
                                                messages = TRUE, convert = TRUE, create = TRUE) {
                            self$set_meta(instat_obj_metadata)
                            self$set_objects(list())
                            
                            if (missing(data_tables) || length(data_tables) == 0) {
                              self$set_data_objects(list())
                            } else {
                              self$import_data(data_tables = data_tables, data_tables_variables_metadata = data_tables_variables_metadata, 
                                               data_tables_metadata = data_tables_metadata, 
                                               imported_from = imported_from, messages = messages, convert = convert, create = create, 
                                               data_tables_filters = data_tables_filters, 
                                               data_tables_column_selections = data_tables_column_selections)
                            }
                            
                            private$.data_sheets_changed <- FALSE
                          },
                          
                          #' @description
                          #' Standardize country names in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param country_columns A vector of column names containing country data.
                          standardise_country_names = function(data_name, country_columns = c()) {
                            self$get_data_objects(data_name)$standardise_country_names(country_columns)
                          },
                          
                          #' @description
                          #' Define a data table as climatic data.
                          #' @param data_name The name of the data table.
                          #' @param types A vector specifying the types of climatic data.
                          #' @param key_col_names A vector of column names to be used as keys.
                          #' @param key_name The name of the key.
                          define_as_climatic = function(data_name, types, key_col_names, key_name) {
                            self$add_key(data_name = data_name, col_names = key_col_names, key_name = key_name)
                            self$append_to_dataframe_metadata(data_name, is_climatic_label, TRUE)
                            
                            for (curr_data_name in self$get_data_names()) {
                              if (!self$get_data_objects(data_name)$is_metadata(is_climatic_label)) {
                                self$append_to_dataframe_metadata(curr_data_name, is_climatic_label, FALSE)
                              }
                            }
                            self$get_data_objects(data_name)$set_climatic_types(types)
                          },
                          
                          #' @description
                          #' Define corruption output columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param output_columns A vector of column names to be defined as corruption outputs.
                          define_corruption_outputs = function(data_name, output_columns = c()) {
                            self$get_data_objects(data_name)$define_corruption_outputs(output_columns)
                          },
                          
                          #' @description
                          #' Define red flag columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param red_flags A vector of column names to be defined as red flags.
                          define_red_flags = function(data_name, red_flags = c()) {
                            self$get_data_objects(data_name)$define_red_flags(red_flags)
                          },
                          
                          #' @description
                          #' Define a data table as procurement data.
                          #' @param data_name The name of the data table.
                          #' @param primary_types A vector of primary types of procurement data.
                          #' @param calculated_types A vector of calculated types of procurement data.
                          #' @param country_data_name The name of the country-level data table.
                          #' @param country_types A vector of types for the country-level data.
                          #' @param auto_generate A boolean indicating whether to auto-generate procurement types.
                          define_as_procurement = function(data_name, primary_types = c(), calculated_types = c(), 
                                                           country_data_name, country_types, auto_generate = TRUE) {
                            self$append_to_dataframe_metadata(data_name, corruption_data_label, corruption_contract_level_label)
                            self$get_data_objects(data_name)$set_procurement_types(primary_types, calculated_types, auto_generate)
                            if (!missing(country_data_name)) {
                              self$define_as_procurement_country_level_data(data_name = country_data_name, 
                                                                            contract_level_data_name = data_name, 
                                                                            types = country_types, 
                                                                            auto_generate = auto_generate)
                            }
                          },
                          
                          #' @description
                          #' Define a data table as procurement country-level data.
                          #' @param data_name The name of the data table.
                          #' @param contract_level_data_name The name of the contract-level data table.
                          #' @param types A vector of types for the procurement country-level data.
                          #' @param auto_generate A boolean indicating whether to auto-generate procurement types.
                          define_as_procurement_country_level_data = function(data_name, contract_level_data_name, types = c(), auto_generate = TRUE) {
                            self$append_to_dataframe_metadata(data_name, corruption_data_label, corruption_country_level_label)
                            self$get_data_objects(data_name)$define_as_procurement_country_level_data(types, auto_generate)
                            contract_level_country_name <- self$get_corruption_column_name(contract_level_data_name, corruption_country_label)
                            country_level_country_name <- self$get_corruption_column_name(data_name, corruption_country_label)
                            if (contract_level_country_name == "" || country_level_country_name == "") stop("country column must be defined in the contract level data and country level data.")
                            link_pairs <- country_level_country_name
                            names(link_pairs) <- contract_level_country_name
                            self$add_link(from_data_frame = contract_level_data_name, to_data_frame = data_name, link_pairs = link_pairs, type = keyed_link_label)
                          },
                          
                          #' @description
                          #' Get the names of CRI component columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A vector of CRI component column names.
                          get_CRI_component_column_names = function(data_name) {
                            self$get_data_objects(data_name)$get_CRI_component_column_names()
                          },
                          
                          #' @description
                          #' Get the names of red flag columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A vector of red flag column names.
                          get_red_flag_column_names = function(data_name) {
                            self$get_data_objects(data_name)$get_red_flag_column_names()
                          },
                          
                          #' @description
                          #' Get the names of CRI columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A vector of CRI column names.
                          get_CRI_column_names = function(data_name) {
                            self$get_data_objects(data_name)$get_CRI_column_names()
                          },
                          
                          #' @description
                          #' Get the name of the corruption column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param type The type of the corruption column.
                          #' @return The name of the corruption column.
                          get_corruption_column_name = function(data_name, type) {
                            self$get_data_objects(data_name)$get_corruption_column_name(type)
                          }
                        ),
                        private = list(
                          .data_sheets = list(),
                          .metadata = list(),
                          .objects = list(),
                          .links = list(),
                          .data_sheets_changed = FALSE,
                          .database_connection = NULL,
                          .last_graph = NULL
                        ),
                        active = list(
                          #' @field data_objects_changed Logical indicating whether the data objects have changed.
                          data_objects_changed = function(new_value) {
                            if (missing(new_value)) return(private$.data_sheets_changed)
                            else {
                              if (new_value != TRUE && new_value != FALSE) stop("new_value must be TRUE or FALSE")
                              private$.data_sheets_changed <- new_value
                              invisible(sapply(self$get_data_objects(), function(x) x$data_changed <- new_value))
                            }
                          }
                        )
)
