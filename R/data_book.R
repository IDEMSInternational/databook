#' @title DataBook Class
#'
#' @description An R6 class to manage a collection of data tables along with their metadata and other associated properties.
#'
#' @name DataBook
#' @docType class
#' @format An R6 class object.
#' @aliases DataBook
#'
#' @usage NULL
#' 
#' @param data_tables A list of data frames to be included in the DataBook.
#' @param instat_obj_metadata Metadata for the instat object.
#' @param data_tables_variables_metadata A list of data frames, each containing metadata for the corresponding data table.
#' @param data_tables_metadata A list of lists, each containing metadata for the corresponding data table.
#' @param data_tables_filters A list of lists, each containing filter information for the corresponding data table.
#' @param data_tables_column_selections A list of lists, each containing column selection information for the corresponding data table.
#' @param imported_from A list of strings indicating the source from which each data table was imported.
#' @param messages A Boolean indicating whether to display messages.
#' @param convert A Boolean indicating whether to perform data conversion.
#' @param create A Boolean indicating whether to create new data objects.
#'
#' @section Methods:
#' \describe{
#'   \item{\code{summary(data_name, columns_to_summarise, summaries, factors = c(), store_results = FALSE, drop = FALSE, return_output = FALSE, summary_name = NA, add_cols = c(), filter_names = c(), ...)}}{Perform and Return Summaries for a Data Object}
#'   \item{\code{summary_table(data_name, columns_to_summarise = NULL, summaries, factors = c(), store_table = FALSE, store_results = FALSE, drop = TRUE, na.rm = FALSE, summary_name = NA, include_margins = FALSE, margins = "outer", return_output = FALSE, treat_columns_as_factor = FALSE, page_by = NULL, signif_fig = 2, na_display = "", na_level_display = "NA", weights = NULL, caption = NULL, result_names = NULL, percentage_type = "none", perc_total_columns = NULL, perc_total_factors = c(), perc_total_filter = NULL, perc_decimal = FALSE, include_counts_with_percentage = FALSE, margin_name = "(All)", additional_filter, ...)}}{Generate a Summary Table}
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
#'   \item{\code{import_data(data_tables = list(), data_tables_variables_metadata = rep(list(data.frame()),length(data_tables)), data_tables_metadata = rep(list(list()),length(data_tables)), data_tables_filters = rep(list(list()),length(data_tables)), data_tables_column_selections = rep(list(list()),length(data_tables)), imported_from = as.list(rep("",length(data_tables))), data_names = NULL, messages=TRUE, convert=TRUE, create=TRUE, prefix=TRUE, add_to_graph_book = TRUE)}}{Imports data into the DataBook from a list of data tables and their metadata.}
#'   \item{\code{replace_instat_object(new_instat_object)}}{Replaces the current instat object with a new one.}
#'   \item{\code{set_data_objects(new_data_objects)}}{Sets the data objects for the DataBook.}
#'   \item{\code{copy_data_object(data_name, new_name, filter_name = "", column_selection_name = "", reset_row_names = TRUE)}}{Copies a data object with optional filtering and column selection.}
#'   \item{\code{import_RDS(data_RDS, keep_existing = TRUE, overwrite_existing = FALSE, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE)}}{Imports data from an RDS file into the DataBook.}
#'   \item{\code{clone_data_object(curr_data_object, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, include_scalars = TRUE...)}}{Clones a data object with options to include various components.}
#'   \item{\code{clone_instat_calculation(curr_instat_calculation, ...)}}{Clones an instat calculation.}
#'   \item{\code{import_from_ODK(username, form_name, platform)}}{Imports data from ODK (Open Data Kit).}
#'   \item{\code{set_meta(new_meta)}}{Sets the metadata for the DataBook.}
#'   \item{\code{set_objects(new_objects)}}{Sets the objects for the DataBook.}
#'   \item{\code{set_scalars(new_scalars)}}{Sets scalar values in the DataBook.}
#'   \item{\code{set_undo_history(new_undo_history)}}{Set the undo history for the DataBook.}
#'   \item{\code{get_scalars(data_name)}}{Retrieve scalars for a specific data object or overall DataBook.}
#'   \item{\code{set_scalar_names(data_name, as_list = FALSE, excluded_items = c(), ...)}}{Retrieve scalar names for a specific data table.}
#'   \item{\code{get_scalar_value(data_name, scalar_name)}}{Retrieve the value of a specific scalar for a given data object.}
#'   \item{\code{add_scalar(data_name, scalar_name = "", scalar_value)}}{Add a scalar to a specific data object or the overall DataBook.}
#'   \item{\code{set_enable_disable_undo(data_name, disable_undo)}}{Enable or disable undo functionality for a specific data object.}
#'   \item{\code{is_undo(data_name)}}{Check if undo functionality is enabled for a specific data object.}
#'   \item{\code{has_undo_history(data_name)}}{Check if there is undo history for a specific data object.}
#'   \item{\code{undo_last_action(data_name)}}{Undo the last action for a specific data object.}
#'   \item{\code{redo_last_action(data_name)}}{Redo the last undone action for a specific data object.}
#'   \item{\code{get_column_climatic_type(data_name, col_name, attr_name)}}{Retrieve the climatic type attribute for a specific column.}
#'   \item{\code{append_data_object(name, obj, add_to_graph_book = TRUE)}}{Appends a data object to the DataBook.}
#'   \item{\code{get_data_objects(data_name, as_list = FALSE, ...)}}{Gets data objects from the DataBook.}
#'   \item{\code{get_data_frame(data_name, convert_to_character = FALSE, stack_data = FALSE, include_hidden_columns = TRUE, use_current_filter = TRUE, filter_name = "", use_column_selection = TRUE, column_selection_name = "", remove_attr = FALSE, retain_attr = FALSE, max_cols, max_rows, drop_unused_filter_levels = FALSE, start_row, start_col, ...)}}{Gets a data frame from the DataBook with various options.}
#'   \item{\code{get_variables_metadata(data_name, data_type = "all", convert_to_character = FALSE, property, column, error_if_no_property = TRUE, direct_from_attributes = FALSE, use_column_selection = TRUE)}}{Gets the variables metadata for the specified data table.}
#'   \item{\code{get_column_data_types(data_name, columns)}}{Gets the data types of the specified columns in the data table.}
#'   \item{\code{get_column_labels(data_name, columns)}}{Gets the labels of the specified columns in the data table.}
#'   \item{\code{get_data_frame_label(data_name, use_current_filter = FALSE)}}{Gets the label of the data frame.}
#'   \item{\code{get_data_frame_metadata(data_name, label, include_calculated = TRUE, excluded_not_for_display = TRUE)}}{Gets the metadata of the data frame.}
#'   \item{\code{get_combined_metadata(convert_to_character = FALSE)}}{Gets combined metadata from all data tables.}
#'   \item{\code{get_metadata(name, ...)}}{Gets metadata for the specified name.}
#'   \item{\code{get_data_names(as_list = FALSE, include, exclude, excluded_items, include_hidden = TRUE, ...)}}{Gets the names of the data tables in the DataBook.}
#'   \item{\code{get_data_changed(data_name)}}{Checks if the data has changed.}
#'   \item{\code{get_variables_metadata_changed(data_name)}}{Checks if the variables metadata has changed.}
#'   \item{\code{get_metadata_changed(data_name)}}{Checks if the metadata has changed.}
#'   \item{\code{get_calculations(data_name)}}{Gets the calculations for the specified data table.}
#'   \item{\code{get_calculation_names(data_name, as_list = FALSE, excluded_items = c())}}{Gets the names of the calculations for the specified data table.}
#'   \item{\code{dataframe_count()}}{Gets the count of data frames in the DataBook.}
#'   \item{\code{set_data_frames_changed(data_name = "", new_val)}}{Sets the changed status for data frames.}
#'   \item{\code{set_variables_metadata_changed(data_name = "", new_val)}}{Sets the changed status for variables metadata.}
#'   \item{\code{set_metadata_changed(data_name = "", new_val)}}{Sets the changed status for metadata.}
#'   \item{\code{add_columns_to_data(data_name, col_name = "", col_data, use_col_name_as_prefix = FALSE, hidden = FALSE, before, adjacent_column = "", num_cols, require_correct_length = TRUE, keep_existing_position = TRUE)}}{Adds columns to the specified data table.}
#'   \item{\code{get_columns_from_data(data_name, col_names, from_stacked_data = FALSE, force_as_data_frame = FALSE, use_current_filter = TRUE, remove_labels = FALSE, drop_unused_filter_levels = FALSE)}}{Gets columns from the specified data table.}
#'   \item{\code{create_graph_data_book()}}{Creates a graph data book.}
#'   \item{\code{add_object(data_name = NULL, object_name = NULL, object_type_label, object_format, object)}}{Adds an object to the DataBook.}
#'   \item{\code{get_object_names(data_name = NULL, object_type_label = NULL, as_list = FALSE, ...)}}{Gets the names of the objects in the DataBook.}
#'   \item{\code{get_objects(data_name = NULL, object_type_label = NULL)}}{Gets the objects from the DataBook.}
#'   \item{\code{get_object(data_name = NULL, object_name)}}{Gets a specific object from the DataBook.}
#'   \item{\code{get_object_data(data_name = NULL, object_name, as_file = FALSE)}}{Gets the data of a specific object from the DataBook.}
#'   \item{\code{get_objects_data(data_name = NULL, object_names = NULL, as_files = FALSE)}}{Gets the data of multiple objects from the DataBook.}
#'   \item{\code{get_last_object_data(object_type_label, as_file = TRUE)}}{Gets the data of the last object of a specified type from the DataBook.}
#'   \item{\code{rename_object(data_name, object_name, new_name, object_type = "object")}}{Renames an object in the DataBook.}
#'   \item{\code{delete_objects(data_name, object_names, object_type = "object")}}{Deletes objects from the DataBook.}
#'   \item{\code{reorder_objects(data_name, new_order)}}{Reorders the objects in the DataBook.}
#'   \item{\code{get_from_object(data_name, object_name, value1, value2, value3)}}{Gets values from a specified object in the DataBook.}
#'   \item{\code{add_filter(data_name, filter, filter_name = "", replace = TRUE, set_as_current_filter = FALSE, na.rm = TRUE, is_no_filter = FALSE, and_or = "&", inner_not = FALSE, outer_not = FALSE)}}{Adds a filter to the specified data table.}
#'   \item{\code{add_filter_as_levels(data_name, filter_levels, column)}}{Adds filter levels to the specified column.}
#'   \item{\code{current_filter(data_name)}}{Gets the current filter for the specified data table.}
#'   \item{\code{set_current_filter(data_name, filter_name = "")}}{Sets the current filter for the specified data table.}
#'   \item{\code{get_filter(data_name, filter_name)}}{Gets a filter by name from the specified data table.}
#'   \item{\code{get_filter_as_logical(data_name, filter_name)}}{Gets a filter as a logical vector from the specified data table.}
#'   \item{\code{get_current_filter(data_name)}}{Gets the current filter for the specified data table.}
#'   \item{\code{get_filter_row_names(data_name, filter_name)}}{Gets the row names that match a specified filter in the data table.}
#'   \item{\code{get_current_filter_name(data_name)}}{Gets the name of the current filter for the specified data table.}
#'   \item{\code{get_filter_names(data_name, as_list = FALSE, include = list(), exclude = list(), excluded_items = c())}}{Gets the names of the filters in the specified data table.}
#'   \item{\code{remove_current_filter(data_name)}}{Removes the current filter from the specified data table.}
#'   \item{\code{filter_applied(data_name)}}{Checks if a filter is applied to the specified data table.}
#'   \item{\code{filter_string(data_name, filter_name)}}{Gets the filter string for a specified filter in the data table.}
#'   \item{\code{get_filter_as_instat_calculation(data_name, filter_name)}}{Gets a filter as an instat calculation from the specified data table.}
#'   \item{\code{add_column_selection(data_name, column_selection, name = "", replace = TRUE, set_as_current = FALSE, is_everything = FALSE, and_or = "|")}}{Adds a column selection to the specified data table.}
#'   \item{\code{current_column_selection(data_name)}}{Gets the current column selection for the specified data table.}
#'   \item{\code{set_current_column_selection(data_name, name = "")}}{Sets the current column selection for the specified data table.}
#'   \item{\code{get_column_selection(data_name, name)}}{Gets a column selection by name from the specified data table.}
#'   \item{\code{get_column_selection_column_names(data_name, filter_name)}}{Gets the column names for a specified filter in the data table.}
#'   \item{\code{get_column_selected_column_names(data_name, column_selection_name = "")}}{Gets the names of the selected columns in the specified data table.}
#'   \item{\code{get_current_column_selection(data_name)}}{Gets the current column selection for the specified data table.}
#'   \item{\code{get_current_column_selection_name(data_name)}}{Gets the name of the current column selection for the specified data table.}
#'   \item{\code{get_column_selection_names(data_name, as_list = FALSE, include = list(), exclude = list(), excluded_items = c())}}{Gets the names of the column selections in the specified data table.}
#'   \item{\code{remove_current_column_selection(data_name)}}{Removes the current column selection from the specified data table.}
#'   \item{\code{column_selection_applied(data_name)}}{Checks if a column selection is applied to the specified data table.}
#'   \item{\code{replace_value_in_data(data_name, col_names, rows, old_value, old_is_missing = FALSE, start_value = NA, end_value = NA, new_value, new_is_missing = FALSE, closed_start_value = TRUE, closed_end_value = TRUE, locf = FALSE, from_last = FALSE)}}{Replaces values in the specified columns and rows of the data table.}
#'   \item{\code{paste_from_clipboard(data_name, col_names, start_row_pos = 1, first_clip_row_is_header = TRUE, clip_board_text)}}{Pastes data from the clipboard into the specified columns of the data table.}
#'   \item{\code{rename_column_in_data(data_name, column_name = NULL, new_val = NULL, label = "", type = "single", .fn, .cols = everything(), new_column_names_df, new_labels_df, ...)}}{Renames a column in the specified data table.}
#'   \item{\code{frequency_tables(data_name, x_col_names, y_col_name, n_column_factors = 1, store_results = TRUE, drop = TRUE, na.rm = FALSE, summary_name = NA, include_margins = FALSE, return_output = TRUE, treat_columns_as_factor = FALSE, page_by = "default", as_html = TRUE, signif_fig = 2, na_display = "", na_level_display = "NA", weights = NULL, caption = NULL, result_names = NULL, percentage_type = "none", perc_total_columns = NULL, perc_total_factors = c(), perc_total_filter = NULL, perc_decimal = FALSE, margin_name = "(All)", additional_filter, ...)}}{Creates frequency tables for the specified data table.}
#'   \item{\code{anova_tables(data_name, x_col_names, y_col_name, signif.stars = FALSE, sign_level = FALSE, means = FALSE)}}{Creates ANOVA tables for the specified data table.}
#'   \item{\code{cor(data_name, x_col_names, y_col_name, use = "everything", method = c("pearson", "kendall", "spearman"))}}{Calculates correlations for the specified columns in the data table.}
#'   \item{\code{remove_columns_in_data(data_name, cols, allow_delete_all = FALSE)}}{Removes columns from the specified data table.}
#'   \item{\code{remove_rows_in_data(data_name, row_names)}}{Removes rows from the specified data table.}
#'   \item{\code{get_next_default_column_name(data_name, prefix)}}{Gets the next default column name for the specified data table.}
#'   \item{\code{get_column_names(data_name, as_list = FALSE, include = list(), exclude = list(), excluded_items = c(), max_no, use_current_column_selection = TRUE)}}{Gets the column names in the specified data table.}
#'   \item{\code{reorder_columns_in_data(data_name, col_order)}}{Reorders the columns in the specified data table.}
#'   \item{\code{insert_row_in_data(data_name, start_row, row_data = c(), number_rows = 1, before = FALSE)}}{Inserts rows into the specified data table.}
#'   \item{\code{get_data_frame_length(data_name, use_current_filter = FALSE)}}{Gets the length of the data frame in the specified data table.}
#'   \item{\code{get_next_default_dataframe_name(prefix, include_index = TRUE, start_index = 1)}}{Gets the next default name for a data frame in the DataBook.}
#'   \item{\code{delete_dataframes(data_names, delete_graph_book = TRUE)}}{Deletes data frames from the DataBook.}
#'   \item{\code{remove_link(link_name)}}{Removes a link from the DataBook.}
#'   \item{\code{get_column_factor_levels(data_name, col_name = "")}}{Gets the factor levels of a column in the specified data table.}
#'   \item{\code{get_factor_data_frame(data_name, col_name = "", include_levels = TRUE, include_NA_level = FALSE)}}{Gets a factor data frame for the specified column in the data table.}
#'   \item{\code{sort_dataframe(data_name, col_names = c(), decreasing = FALSE, na.last = TRUE, by_row_names = FALSE, row_names_as_numeric = TRUE)}}{Sorts the specified data table.}
#'   \item{\code{rename_dataframe(data_name, new_value = "", label = "")}}{Renames the specified data table.}
#'   \item{\code{convert_column_to_type(data_name, col_names = c(), to_type, factor_values = NULL, set_digits, set_decimals = FALSE, keep_attr = TRUE, ignore_labels = FALSE, keep.labels = TRUE)}}{Converts the specified columns to a different type in the data table.}
#'   \item{\code{append_to_variables_metadata(data_name, col_names, property, new_val = "")}}{Appends a new value to the specified property in the variables metadata for the given columns in the specified data table.}
#'   \item{\code{append_to_dataframe_metadata(data_name, property, new_val = "")}}{Appends a new value to the specified property in the dataframe metadata for the specified data table.}
#'   \item{\code{append_to_metadata(property, new_val = "", allow_override_special = FALSE)}}{Appends a new value to the specified property in the overall metadata, with an option to override special properties.}
#'   \item{\code{add_metadata_field(data_name, property, new_val = "")}}{Adds a new metadata field to the specified data table or to the overall metadata.}
#'   \item{\code{reorder_dataframes(data_frames_order)}}{Reorders the data frames in the object based on the provided order.}
#'   \item{\code{copy_columns(data_name, col_names = "", copy_to_clipboard = FALSE)}}{Copies the specified columns from the given data table, with an option to copy to the clipboard.}
#'   \item{\code{drop_unused_factor_levels(data_name, col_name)}}{Drops unused factor levels from the specified column in the given data table.}
#'   \item{\code{set_factor_levels(data_name, col_name, new_labels, new_levels, set_new_labels = TRUE)}}{Sets new factor levels and labels for the specified column in the given data table.}
#'   \item{\code{edit_factor_level(data_name, col_name, old_level, new_level)}}{Edits an existing factor level in the specified column of the given data table.}
#'   \item{\code{set_factor_reference_level(data_name, col_name, new_ref_level)}}{Sets a new reference level for the specified factor column in the given data table.}
#'   \item{\code{get_column_count(data_name, use_column_selection = FALSE)}}{Returns the count of columns in the specified data table, with an option to use the current column selection.}
#'   \item{\code{reorder_factor_levels(data_name, col_name, new_level_names)}}{Reorders the factor levels in the specified column of the given data table.}
#'   \item{\code{get_data_type(data_name, col_name)}}{Returns the data type of the specified column in the given data table.}
#'   \item{\code{copy_data_frame(data_name, new_name, label = "", copy_to_clipboard = FALSE)}}{Copies the specified data table to a new data table with an optional new name, label, and option to copy to the clipboard.}
#'   \item{\code{copy_col_metadata_to_clipboard(data_name, property_names)}}{Copies the specified column metadata properties from the given data table to the clipboard.}
#'   \item{\code{copy_data_frame_metadata_to_clipboard(data_name, property_names)}}{Copies the specified data frame metadata properties from the given data table to the clipboard.}
#'   \item{\code{copy_to_clipboard(content)}}{Copies the given content to the clipboard.}
#'   \item{\code{set_hidden_columns(data_name, col_names = c())}}{Sets the specified columns in the given data table to be hidden.}
#'   \item{\code{unhide_all_columns(data_name)}}{Unhides all columns in the specified data table.}
#'   \item{\code{set_hidden_data_frames(data_names = c())}}{Sets the specified data frames to be hidden.}
#'   \item{\code{get_hidden_data_frames()}}{Returns the names of all hidden data frames.}
#'   \item{\code{set_row_names(data_name, row_names)}}{Sets new row names for the specified data table.}
#'   \item{\code{get_row_names(data_name)}}{Returns the row names of the specified data table.}
#'   \item{\code{set_protected_columns(data_name, col_names)}}{Sets the specified columns in the given data table to be protected.}
#'   \item{\code{get_metadata_fields(data_name, include_overall, as_list = FALSE, include, exclude, excluded_items = c())}}{Returns the metadata fields for the specified data table and overall metadata, with options to include or exclude specific fields.}
#'   \item{\code{freeze_columns(data_name, column)}}{Freezes the specified columns in the given data table.}
#'   \item{\code{unfreeze_columns(data_name)}}{Unfreezes all columns in the specified data table.}
#'   \item{\code{is_variables_metadata(data_name, property, column, return_vector = FALSE)}}{Checks if the specified property is part of the variables metadata for the given column in the specified data table.}
#'   \item{\code{data_frame_exists(data_name)}}{Checks if the specified data table exists in the object.}
#'   \item{\code{add_key(data_name, col_names, key_name)}}{Adds a key to the specified data table using the given columns and key name.}
#'   \item{\code{is_key(data_name, col_names)}}{Checks if the specified columns form a key in the given data table.}
#'   \item{\code{has_key(data_name)}}{Checks if the specified data table has a key.}
#'   \item{\code{get_keys(data_name, key_name)}}{Returns the keys for the specified data table and key name.}
#'   \item{\code{add_new_comment(data_name, row = "", column = "", comment)}}{Adds a new comment to the specified data table, optionally specifying the row and column.}
#'   \item{\code{get_comments(data_name, comment_id)}}{Returns the comments for the specified data table and comment ID.}
#'   \item{\code{get_links(link_name, ...)}}{Returns the links for the specified link name or all links if no name is provided.}
#'   \item{\code{set_structure_columns(data_name, struc_type_1 = c(), struc_type_2 = c(), struc_type_3 = c())}}{Sets the structure columns for the specified data table.}
#'   \item{\code{add_dependent_columns(data_name, columns, dependent_cols)}}{Adds dependent columns to the specified columns in the given data table.}
#'   \item{\code{set_column_colours(data_name, columns, colours)}}{Sets the colors for the specified columns in the given data table.}
#'   \item{\code{has_colours(data_name, columns)}}{Checks if the specified columns in the given data table have colors.}
#'   \item{\code{remove_column_colours(data_name)}}{Removes colors from all columns in the specified data table.}
#'   \item{\code{set_column_colours_by_metadata(data_name, columns, property)}}{Sets the colors for the specified columns in the given data table based on the specified metadata property.}
#'   \item{\code{graph_one_variable(data_name, columns, numeric = "geom_boxplot", categorical = "geom_bar", character = "geom_bar", output = "facets", free_scale_axis = FALSE, ncol = NULL, coord_flip  = FALSE, ... = ...)}}{Creates a graph for one variable in the specified data table with options for the type of graph, axis scaling, and other parameters.}
#'   \item{\code{make_date_yeardoy(data_name, year, doy, base, doy_typical_length = "366")}}{Creates a date column from the specified year and day of year columns in the given data table.}
#'   \item{\code{make_date_yearmonthday(data_name, year, month, day, f_year, f_month, f_day, year_format, month_format)}}{Creates a date column from the specified year, month, and day columns in the given data table, with options for formatting.}
#'   \item{\code{set_contrasts_of_factor(data_name, col_name, new_contrasts, defined_contr_matrix)}}{Sets the contrasts for the specified factor column in the given data table.}
#'   \item{\code{create_factor_data_frame(data_name, factor, factor_data_frame_name, include_contrasts = FALSE, replace = FALSE, summary_count = TRUE)}}{Creates a new data frame for the specified factor column in the given data table, with options to include contrasts and summary counts.}
#'   \item{\code{split_date(data_name, col_name = "", year_val = FALSE, year_name = FALSE, leap_year = FALSE,  month_val = FALSE, month_abbr = FALSE, month_name = FALSE, week_val = FALSE, week_abbr = FALSE, week_name = FALSE, weekday_val = FALSE, weekday_abbr = FALSE, weekday_name = FALSE,  day = FALSE, day_in_month = FALSE, day_in_year = FALSE, day_in_year_366 = FALSE, pentad_val = FALSE, pentad_abbr = FALSE, dekad_val = FALSE, dekad_abbr = FALSE, quarter_val = FALSE, quarter_abbr = FALSE, with_year = FALSE, s_start_month = 1, s_start_day_in_month = 1, days_in_month = FALSE)}}{Splits the specified date column into multiple components such as year, month, day, etc. in the given data table.}
#'   \item{\code{import_SST(dataset, data_from = 5, data_names = c())}}{Imports SST data from the specified dataset and data source, creating data tables with the specified names.}
#'   \item{\code{make_inventory_plot(data_name, date_col, station_col = NULL, year_col = NULL, doy_col = NULL, element_cols = NULL, add_to_data = FALSE, year_doy_plot = FALSE, coord_flip = FALSE, facet_by = NULL, graph_title = "Inventory Plot", graph_subtitle = NULL, graph_caption = NULL, title_size = NULL, subtitle_size = NULL, caption_size = NULL, labelXAxis, labelYAxis, xSize = NULL, ySize = NULL, Xangle = NULL, Yangle = NULL, scale_xdate, fromXAxis = NULL, toXAxis = NULL, byXaxis = NULL, date_ylabels, legend_position = NULL, xlabelsize = NULL, ylabelsize = NULL, scale = NULL, dir = "", row_col_number, nrow = NULL, ncol = NULL, key_colours = c("red", "grey"), display_rain_days = FALSE, facet_xsize = 9, facet_ysize = 9, facet_xangle = 90, facet_yangle = 90, scale_ydate = FALSE, date_ybreaks, step = 1, rain_cats = list(breaks = c(0, 0.85, Inf), labels = c("Dry", "Rain"), key_colours = c("tan3", "blue")))}}{Creates an inventory plot for the specified data table with various customisation options.}
#'   \item{\code{import_NetCDF(nc, path, name, only_data_vars = TRUE, keep_raw_time = TRUE, include_metadata = TRUE, boundary, lon_points = NULL, lat_points = NULL, id_points = NULL, show_requested_points = TRUE, great_circle_dist = FALSE)}}{Imports data from a NetCDF file, with options to specify the data variables, time format, metadata inclusion, and boundaries.}
#'   \item{\code{infill_missing_dates(data_name, date_name, factors, start_month, start_date, end_date, resort = TRUE)}}{Infills missing dates in the specified data table using the provided date column and factors.}
#'   \item{\code{get_key_names(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Returns the key names for the specified data table, with options to include overall keys, exclude specific keys, and return as a list.}
#'   \item{\code{remove_key(data_name, key_name)}}{Removes the specified key from the given data table.}
#'   \item{\code{add_climdex_indices(data_name, climdex_output, freq = "annual", station, year, month)}}{Adds climdex indices to the specified data table, with options for frequency, station, year, and month.}
#'   \item{\code{is_metadata(data_name, str)}}{Checks if the specified string is part of the metadata for the given data table.}
#'   \item{\code{get_climatic_column_name(data_name, col_name)}}{Returns the climatic column name for the specified column in the given data table.}
#'   \item{\code{merge_data(data_name, new_data, by = NULL, type = "left", match = "all")}}{Merges new data into the specified data table using the provided columns and merge type.}
#'   \item{\code{get_corruption_data_names()}}{Returns the names of all data tables with corruption data.}
#'   \item{\code{get_corruption_contract_data_names()}}{Returns the names of all data tables with corruption contract data.}
#'   \item{\code{get_database_variable_names(query, data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Returns the database variable names for the specified query and data table, with options to include overall variables, exclude specific variables, and return as a list.}
#'   \item{\code{get_nc_variable_names(file = "", as_list = FALSE, ...)}}{Returns the variable names from the specified NetCDF file, with an option to return as a list.}
#'   \item{\code{has_database_connection()}}{Checks if there is a database connection.}
#'   \item{\code{database_connect(dbname, user, host, port, drv = RMySQL::MySQL())}}{Connects to a database using the provided credentials and driver.}
#'   \item{\code{get_database_connection()}}{Returns the current database connection.}
#'   \item{\code{set_database_connection(dbi_connection)}}{Sets the database connection to the specified DBI connection object.}
#'   \item{\code{database_disconnect()}}{Disconnects from the current database.}
#'   \item{\code{import_from_climsoft(stationfiltercolumn = "stationId", stations = c(), elementfiltercolumn = "elementId", elements = c(), include_observation_data = FALSE, include_observation_flags = FALSE, unstack_data = FALSE, include_elements_info = FALSE, start_date = NULL, end_date = NULL)}}{Imports data from CLIMSOFT using the specified filters and options for observation data, flags, and unstacking.}
#'   \item{\code{export_workspace(data_names, file, include_graphs = TRUE, include_models = TRUE, include_metadata = TRUE)}}{Exports the workspace to a file, including the specified data tables, graphs, models, and metadata.}
#'   \item{\code{set_links(new_links)}}{Sets the links in the object to the specified new links.}
#'   \item{\code{display_daily_graph(data_name, date_col = NULL, station_col = NULL, year_col = NULL, doy_col = NULL, climatic_element = NULL, upper_limit = 100, bar_colour = "blue", rug_colour = "red")}}{Displays a daily graph for the specified data table with options for columns, element, colors, and limits.}
#'   \item{\code{create_variable_set(data_name, set_name, columns)}}{Creates a variable set with the specified name and columns in the given data table.}
#'   \item{\code{update_variable_set(data_name, set_name, columns, new_set_name)}}{Updates the specified variable set with new columns and optionally a new name in the given data table.}
#'   \item{\code{delete_variable_sets(data_name, set_names)}}{Deletes the specified variable sets from the given data table.}
#'   \item{\code{get_variable_sets_names(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Returns the names of variable sets for the specified data table, with options to include overall sets, exclude specific sets, and return as a list.}
#'   \item{\code{get_variable_sets(data_name, set_names, force_as_list = FALSE)}}{Returns the specified variable sets from the given data table, with an option to force the result as a list.}
#'   \item{\code{crops_definitions(data_name, year, station, rain, day, rain_totals, plant_days, plant_lengths, start_check = c("both", "yes", "no"), season_data_name, start_day, end_day, return_crops_table = TRUE, definition_props = TRUE)}}{Defines crop parameters for the specified data table using the provided columns and options for seasons, days, and properties.}
#'   \item{\code{tidy_climatic_data(x, format, stack_cols, day, month, year, stack_years, station, element, element_name="value", ignore_invalid = FALSE, silent = FALSE, unstack_elements = TRUE, new_name)}}{Converts wide-format daily climatic data to long format using the specified columns and options for format, elements, and validation.}
#'   \item{\code{get_geometry(data)}}{Returns the geometry column for the specified data table.}
#'   \item{\code{package_check(package)}}{Checks if the specified package is installed and returns information about its version and availability.}
#'   \item{\code{download_from_IRI(source, data, path = tempdir(), min_lon, max_lon, min_lat, max_lat, min_date, max_date, name, download_type = "Point", import = TRUE)}}{Downloads data from IRI using the specified source, data, coordinates, date range, and options for download type and import.}
#'   \item{\code{patch_climate_element(data_name, date_col_name = "", var = "", vars = c(), max_mean_bias = NA, max_stdev_bias = NA, time_interval = "month", column_name, station_col_name = station_col_name)}}{Patches the specified climate element in the given data table using the provided columns and options for bias, time interval, and station.}
#'   \item{\code{visualize_element_na(data_name, element_col_name, element_col_name_imputed, station_col_name, x_axis_labels_col_name, ncol = 2, type = "distribution", xlab = NULL, ylab = NULL, legend = TRUE, orientation = "horizontal", interval_size = interval_size, x_with_truth = NULL, measure = "percent")}}{Visualizes missing data for the specified element in the given data table using the provided columns and options for labels, legend, orientation, and measure.}
#'   \item{\code{get_data_entry_data(data_name, station, date, elements, view_variables, station_name, type, start_date, end_date)}}{Returns data entry data for the specified data table using the provided columns and options for date range, variables, and type.}
#'   \item{\code{save_data_entry_data(data_name, new_data, rows_changed, comments_list = list(), add_flags = FALSE, ...)}}{Saves data entry data to the specified data table with options for adding comments, flags, and rows changed.}
#'   \item{\code{import_from_cds(user, dataset, elements, start_date, end_date, lon, lat, path, import = FALSE, new_name)}}{Imports data from CDS using the specified user, dataset, elements, date range, coordinates, and options for file path and import.}
#'   \item{\code{add_flag_fields(data_name, col_names, key_column_names)}}{Adds flag fields to the specified columns in the given data table, using the provided key columns.}
#'   \item{\code{remove_empty(data_name,  which = c("rows","cols"))}}{Removes empty rows or columns from the specified data table.}
#'   \item{\code{replace_values_with_NA(data_name, row_index, column_index)}}{Replaces values with NA in the specified rows and columns of the given data table.}
#'   \item{\code{has_labels(data_name, col_names)}}{Checks if the specified columns in the given data table have labels.}
#'   \item{\code{wrap_or_unwrap_data(data_name, col_name, column_data, width, wrap = TRUE)}}{Wraps or unwraps the specified column data in the given data table to the specified width.}
#'   \item{\code{anova_tables2(data_name, x_col_names, y_col_name, total = TRUE, signif.stars = FALSE, sign_level = FALSE, means = FALSE, interaction = FALSE)}}{Generate ANOVA tables for specified columns in a dataset.}
#'   \item{\code{define_as_options_by_context(data_name, obyc_types = NULL, key_columns = NULL)}}{Define options by context for a specified dataset.}
#'   \item{\code{display_daily_table(data_name, climatic_element, date_col, year_col, station_col, Misscode, Tracecode, Zerocode, monstats = c("min", "mean", "median", "max", "IQR", "sum"))}}{Display a daily summary table for a specified climatic data element.}
#'   
#'   \item{\code{add_comment(new_comment)}}{Adds a new `instat_comment` object to the data sheet if the key is defined and valid.}
#'   \item{\code{delete_comment(comment_id)}}{Deletes a comment from the data sheet based on the comment ID.}
#'   \item{\code{get_comment_ids()}}{Retrieves all comment IDs currently stored in the data sheet.}
#'   \item{\code{get_comments_as_data_frame()}}{Converts all comments in the data sheet to a data frame format for easier inspection and analysis.}
#'
#'   \item{\code{update_links_rename_data_frame(old_data_name, new_data_name)}}{This function updates all links that reference a data frame with a specified old name, renaming it to a new name.}
#'   \item{\code{update_links_rename_column(data_name, old_column_name, new_column_name)}}{This function updates all links referencing a column in a data frame with a specified old column name, renaming it to a new column name.}
#'   \item{\code{add_link(from_data_frame, to_data_frame, link_pairs, type, link_name)}}{This function adds a new link between two data frames with the specified link pairs and type. It will check if the link already exists or if the link columns are keys.}
#'   \item{\code{get_link_names(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE)}}{Retrieves the names of all links involving a specified data frame, with options to include or exclude specific types.}
#'   \item{\code{link_exists_from(curr_data_frame, link_pairs)}}{Verifies if a link exists from a specific data frame with given link pairs.}
#'   \item{\code{link_exists_between(from_data_frame, to_data_frame, ordered = FALSE)}}{This function checks if there is an ordered or unordered link between two specified data frames.}
#'   \item{\code{get_link_between(from_data_frame, to_data_frame, ordered = FALSE)}}{Retrieves the link definition between two specified data frames.}
#'   \item{\code{link_exists_from_by_to(first_data_frame, link_pairs, second_data_frame)}}{This function checks if a link exists from `first_data_frame` to `second_data_frame` using the specified `link_pairs` columns.}
#'   \item{\code{get_linked_to_data_name(from_data_frame, link_cols = c(), include_self = FALSE)}}{This function returns the names of data frames linked to `from_data_frame`. Optionally, includes `from_data_frame` itself in the output if `include_self` is TRUE. Filters results by `link_cols`, if provided.}
#'   \item{\code{get_linked_to_definition(from_data_frame, link_pairs)}}{This function returns a list of the target data frame and matched columns.}
#'   \item{\code{get_possible_linked_to_definition(from_data_frame, link_pairs)}}{This function attempts to find a linked data frame that matches `link_pairs`. Recursively explores links between multiple data frames.}
#'   \item{\code{get_equivalent_columns(from_data_name, columns, to_data_name)}}{This function returns columns in `to_data_name` equivalent to `columns` in `from_data_name`. Recursively searches links between multiple data frames.}
#'   \item{\code{link_between_containing(from_data_frame, containing_columns, to_data_frame)}}{This function returns columns in `to_data_frame` corresponding to `containing_columns` in `from_data_frame` if a link exists between them.}
#'   \item{\code{view_link(link_name)}}{Displays the details of a specified link.}
#'   
#'   \item{\code{apply_calculation(calc)}}{Apply a Calculation to Data in the DataBook}
#'   \item{\code{save_calculation(end_data_frame, calc)}}{Save a Calculation to a Data Frame}
#'   \item{\code{apply_instat_calculation(calc, curr_data_list, previous_manipulations = list(), param_list = list())}}{Apply an Instat Calculation}
#'   \item{\code{run_instat_calculation(calc, display = TRUE, param_list = list())}}{Run an Instat Calculation and Display Results}
#'   \item{\code{get_corresponding_link_columns(first_data_frame_name, first_data_frame_columns, second_data_frame_name)}}{Get Corresponding Link Columns}
#'   \item{\code{get_link_columns_from_data_frames(first_data_frame_name, first_data_frame_columns, second_data_frame_name, second_data_frame_columns)}}{Get Link Columns Between Data Frames}
#'   \item{\code{save_calc_output(calc, curr_data_list, previous_manipulations)}}{Save the Output of a Calculation}
#'
#'   \item{\code{convert_linked_variable(from_data_frame, link_cols)}}{Convert Linked Variable to Matching Class}
#'   \item{\code{remove_unused_station_year_combinations(data_name, year, station)}}{Remove Unused Station-Year Combinations}
#'   
#'   \item{\code{append_summaries_to_data_object(out, data_name, columns_to_summarise, summaries, factors = c(), summary_name, calc, calc_name = "")}}{Append Summaries to a Data Object}
#'   \item{\code{calculate_summary(data_name, columns_to_summarise = NULL, summaries, factors = c(), store_results = TRUE, drop = TRUE, return_output = FALSE, summary_name = NA, result_names = NULL, percentage_type = "none", perc_total_columns = NULL, perc_total_factors = c(), perc_total_filter = NULL, perc_decimal = FALSE, perc_return_all = FALSE, include_counts_with_percentage = FALSE, silent = FALSE, additional_filter, original_level = FALSE, signif_fig = 2, sep = "_", ...)}}{Calculate Summaries for a Data Object}
#'   }
#'   
#'  @section Active bindings:
#'   \describe{
#'    \item{\code{data_objects_changed}}{Logical indicating whether the data objects have changed.}
#'   }
#' 
#'  @export
DataBook <- R6::R6Class("DataBook",
                        public = list(
                          #' @description Initialize a new DataBook object.
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
                            self$set_scalars(list())
                            self$set_undo_history(list())
                            
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
                          #' Standardise country names in the specified data table.
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
                          },
                          
                          #' @description
                          #' Imports data tables and their associated metadata into the DataBook object.
                          #' @param data_tables A list of data tables to be imported.
                          #' @param data_tables_variables_metadata Metadata for the variables of each data table.
                          #' @param data_tables_metadata General metadata for each data table.
                          #' @param data_tables_filters Filters applied to each data table.
                          #' @param data_tables_column_selections Column selections for each data table.
                          #' @param imported_from The origin/source of the imported data.
                          #' @param data_names Optional names for the data tables.
                          #' @param messages A boolean indicating if messages should be displayed.
                          #' @param convert A boolean indicating if data conversion should occur.
                          #' @param create A boolean to create new data objects.
                          #' @param prefix A boolean indicating whether to prefix data names.
                          #' @param add_to_graph_book A boolean to add the data to a graph book.
                          import_data = function(data_tables = list(), data_tables_variables_metadata = rep(list(data.frame()),length(data_tables)),
                                                 data_tables_metadata = rep(list(list()),length(data_tables)),
                                                 data_tables_filters = rep(list(list()),length(data_tables)),
                                                 data_tables_column_selections = rep(list(list()),length(data_tables)),
                                                 imported_from = as.list(rep("",length(data_tables))), 
                                                 data_names = NULL,
                                                 messages=TRUE, convert=TRUE, create=TRUE, prefix=TRUE,
                                                 add_to_graph_book = TRUE) {
                            if (missing(data_tables) || length(data_tables) == 0) {
                              stop("No data found. No data objects can be created.")
                            }
                            
                            else {
                              
                              if(!(is.list(data_tables)))  {
                                stop("data_tables must be a list of data frames")
                              }
                              
                              if(anyDuplicated(names(data_tables))) {
                                stop("There are duplicate names in the data tables list.")
                              }
                              
                              if(length(data_tables_variables_metadata) != length(data_tables)) { 
                                stop("If data_tables_variables_metadata is specified, it must be a list of metadata lists with the same length as data_tables.")
                              }
                              
                              if(length(data_tables_metadata) != length(data_tables)) { 
                                stop("If data_tables_metadata is specified, it must be a list of metadata lists with the same length as data_tables.")
                              }
                              
                              if (length(imported_from) != length(data_tables)) { 
                                stop("imported_from must be a list of the same length as data_tables")
                              }
                              
                              if(!is.null(data_names) && length(data_names) != length(data_names)) {
                                stop("If data_names is specified it must be a list of the same length as data_tables")
                              }
                              
                              # loop through the data_tables list and create a data object for each
                              # data.frame given
                              new_data_objects = list()
                              for ( i in (1:length(data_tables)) ) {
                                curr_name <- names(data_tables)[[i]]
                                if(is.null(curr_name) && !is.null(data_names)) curr_name <- data_names[i]
                                if (prefix){
                                  if(tolower(curr_name) %in% tolower(names(private$.data_sheets))) {
                                    warning("Cannot have data frames with the same name only differing by case. Data frame will be renamed.")
                                    curr_name <- instatExtras::next_default_item(tolower(curr_name), tolower(names(private$.data_sheets)))
                                  } 
                                }
                                
                                new_data = DataSheet$new(data=data_tables[[i]], data_name = curr_name,
                                                         variables_metadata = data_tables_variables_metadata[[i]],
                                                         metadata = data_tables_metadata[[i]], 
                                                         imported_from = imported_from[[i]], 
                                                         start_point = i, 
                                                         messages = messages, convert = convert, create = create, 
                                                         filters = data_tables_filters[[i]],
                                                         column_selections = data_tables_column_selections[[i]])
                                # Add this new data object to our list of data objects
                                self$append_data_object(new_data$get_metadata(data_name_label), new_data, add_to_graph_book = add_to_graph_book)
                              }
                            }
                          },
                          
                          #' @description
                          #' Replaces the instat object in the DataBook.
                          #' @param new_instat_object The new instat object to replace the existing one.
                          replace_instat_object = function(new_instat_object) {
                            self$set_data_objects(list())
                            for(curr_obj in new_instat_object$get_data_objects()) {
                              self$append_data_object(curr_obj$get_metadata(data_name_label), curr_obj$data_clone())
                            }
                            self$set_meta(new_instat_object$get_metadata())
                            self$set_objects(new_instat_object$get_objects(data_name = overall_label))
                            self$data_objects_changed <- TRUE
                          },
                          
                          #' @description
                          #' Sets the data objects within the DataBook.
                          #' @param new_data_objects A list of data objects to be set.
                          set_data_objects = function(new_data_objects) {
                            # new_data_objects could be of old class type 'data_object'
                            if(!is.list(new_data_objects) || (length(new_data_objects) > 0 && !any(c("DataSheet", "data_object") %in% sapply(new_data_objects, class)))) {
                              stop("new_data_objects must be a list of data_objects")
                            }
                            else private$.data_sheets <- new_data_objects
                          },
                          
                          #' @description
                          #' Copies a data object with an optional filter and column selection.
                          #' @param data_name The name of the data object to copy.
                          #' @param new_name The new name for the copied data object.
                          #' @param filter_name Optional filter to apply during the copy.
                          #' @param column_selection_name Optional column selection to apply during the copy.
                          #' @param reset_row_names A boolean indicating whether to reset row names.
                          copy_data_object = function(data_name, new_name, filter_name = "", column_selection_name = "", reset_row_names = TRUE) {
                            new_obj <- self$get_data_objects(data_name)$data_clone()
                            if(filter_name != "") {
                              subset_data <- self$get_data_objects(data_name)$get_data_frame(use_current_filter = FALSE, filter_name = filter_name, retain_attr = TRUE)
                              if(reset_row_names) rownames(subset_data) <- 1:nrow(subset_data)
                              new_obj$remove_current_filter()
                              new_obj$set_data(subset_data)
                            }
                            if(column_selection_name != "") {
                              subset_data <- self$get_data_objects(data_name)$get_data_frame(use_current_filter = FALSE, filter_name = filter_name, column_selection_name = column_selection_name, use_column_selection = FALSE, retain_attr = TRUE)
                              new_obj$remove_current_column_selection()
                              new_obj$set_data(subset_data)
                            }
                            self$append_data_object(new_name, new_obj)
                          },
                          
                          #' @description
                          #' Imports data from an RDS file into the DataBook.
                          #' @param data_RDS The RDS file containing data.
                          #' @param keep_existing A boolean to keep existing data.
                          #' @param overwrite_existing A boolean to overwrite existing data if necessary.
                          #' @param include_objects A boolean to include objects in the import.
                          #' @param include_metadata A boolean to include metadata in the import.
                          #' @param include_logs A boolean to include logs in the import.
                          #' @param include_filters A boolean to include filters in the import.
                          #' @param include_column_selections A boolean to include column selections in the import.
                          #' @param include_calculations A boolean to include calculations in the import.
                          #' @param include_comments A boolean to include comments in the import.
                          import_RDS = function(data_RDS, 
                                                keep_existing = TRUE, 
                                                overwrite_existing = FALSE, 
                                                include_objects = TRUE,
                                                include_metadata = TRUE, 
                                                include_logs = TRUE, 
                                                include_filters = TRUE, 
                                                include_column_selections = TRUE, 
                                                include_calculations = TRUE, 
                                                include_comments = TRUE) {
                            # TODO add include_calculations options
                            # 'instat_object' is previously used class name, some files may have this name.
                            if(any(c("instat_object", "DataBook") %in% class(data_RDS))) {
                              if(!keep_existing && include_objects && include_metadata && include_logs && include_filters && include_column_selections && include_calculations && include_comments) {
                                self$replace_instat_object(new_instat_object = data_RDS)
                              }else {
                                if(!keep_existing) {
                                  self$set_data_objects(list())
                                  self$set_meta(list())
                                  self$set_objects(list())
                                  self$set_links(list())
                                  self$set_database_connection(NULL)
                                }
                                new_links_list <- data_RDS$get_links()
                                for(data_obj_name in data_RDS$get_data_names()) {
                                  data_obj_clone <- self$clone_data_object(data_RDS$get_data_objects(data_obj_name), include_objects = include_objects, include_metadata = include_metadata, include_logs = include_logs, include_filters = include_filters, include_column_selections = include_column_selections, include_calculations = include_calculations, include_comments = include_comments)
                                  if(tolower(data_obj_name) %in% tolower(self$get_data_names()) && !overwrite_existing) {
                                    warning("Cannot have data frames with the same name only differing by case. Data frame will be renamed.")
                                    new_name <- instatExtras::next_default_item(tolower(data_obj_name), tolower(self$get_data_names()))
                                    data_obj_clone$append_to_metadata(data_name_label, new_name)
                                    if(new_name != data_obj_name) {
                                      for(i in seq_along(new_links_list)) {
                                        new_links_list[[i]]$rename_data_frame_in_link(data_obj_name, new_name)
                                      }
                                    }
                                  }
                                  #if(!data_obj_clone$is_metadata(data_name_label)) data_obj_clone$append_to_metadata(data_name_label, new_name)
                                  curr_data_name = data_obj_clone$get_metadata(data_name_label)
                                  self$append_data_object(curr_data_name, data_obj_clone)
                                }
                                for(i in seq_along(new_links_list)) {
                                  curr_link <- new_links_list[[i]]
                                  for(j in seq_along(curr_link$link_columns)) {
                                    self$add_link(from_data_frame = curr_link$from_data_frame, to_data_frame = curr_link$to_data_frame, link_pairs = curr_link$link_columns[[j]], type = curr_link$type, link_name = names(new_links_list)[i])
                                  }
                                }
                                new_objects_list <- data_RDS$get_objects(data_name = overall_label)
                                new_objects_count <- length(new_objects_list)
                                if(include_objects && new_objects_count > 0) {
                                  for(i in (1:new_objects_count)) {
                                    if(!(names(new_objects_list)[i] %in% names(private$.objects)) || overwrite_existing) {
                                      self$add_object(object_name = names(new_objects_list)[i],
                                                      object_type_label = new_objects_list[[i]]$object_type_label,
                                                      object_format = new_objects_list[[i]]$object_format,
                                                      object = new_objects_list[[i]]$object)
                                    }
                                  }
                                }
                                new_metadata <- data_RDS$get_metadata()
                                new_metadata_count <- length(new_metadata)
                                if(include_metadata && new_metadata_count > 0) {
                                  for(i in (1:new_metadata_count)) {
                                    if(!(names(new_metadata)[i] %in% names(private$metadata)) || overwrite_existing) {
                                      self$append_to_metadata(names(new_metadata)[i], new_metadata[[i]])
                                    }
                                  }
                                }
                              }
                              self$data_objects_changed <- TRUE
                            }else if(is.data.frame(data_RDS) || is.matrix(data_RDS)) {
                              self$import_data(data_tables = list(data_RDS = data_RDS))
                            }else stop("Cannot import an objects of class", paste(class(data_RDS), collapse = ","))
                          },
                          
                          #' @description
                          #' Clones a data object with options to include metadata, logs, filters, etc.
                          #' @param curr_data_object The current data object to be cloned.
                          #' @param include_objects A boolean to include objects in the clone.
                          #' @param include_metadata A boolean to include metadata in the clone.
                          #' @param include_logs A boolean to include logs in the clone.
                          #' @param include_filters A boolean to include filters in the clone.
                          #' @param include_column_selections A boolean to include column selections in the clone.
                          #' @param include_calculations A boolean to include calculations in the clone.
                          #' @param include_comments A boolean to include comments in the clone.
                          #' @param include_scalars A boolean to include scalars in the clone.
                          #' @param ... Additional arguments passed to other methods.
                          clone_data_object = function(curr_data_object, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, include_scalars = TRUE, ...) {
                            curr_names <- names(curr_data_object)
                            if("get_data_frame" %in% curr_names) new_data <- curr_data_object$get_data_frame(use_current_filter = FALSE)
                            else stop("Cannot import data. No 'get_data_frame' method.")
                            if("get_metadata" %in% curr_names) new_data_name <- curr_data_object$get_metadata(data_name_label)
                            if(include_objects && "get_objects" %in% curr_names){
                             new_objects <- curr_data_object$get_objects()
                            }
                            else new_objects <- list()
                            if(include_scalars && "get_scalars" %in% curr_names) new_scalars <- curr_data_object$get_scalars()
                            else new_scalars <- list()
                            if(include_filters && "get_filter" %in% curr_names) {
                              new_filters <- purrr::map(curr_data_object$get_filter(), ~ .x$data_clone())
                              new_filters <- purrr::map(new_filters, ~ check_filter(.x))
                            } else {
                              new_filters <- list()
                            }
                            if(include_column_selections && "get_column_selection" %in% curr_names) new_column_selections <- curr_data_object$get_column_selection()
                            else new_column_selections <- list()
                            if(include_calculations && "get_calculations" %in% curr_names) new_calculations <- lapply(curr_data_object$get_calculations(), function(x) self$clone_instat_calculation(x))
                            else new_calculations <- list()
                            if(include_comments && "get_comments" %in% curr_names) new_comments <- lapply(curr_data_object$get_comments(), function(x) x$data_clone())
                            else new_comments <- list()
                            if("get_keys" %in% curr_names) new_keys <- curr_data_object$get_keys()
                            else new_keys <- list()
                            
                            new_data_object <- DataSheet$new(data = new_data, data_name = new_data_name, filters = new_filters, column_selections = new_column_selections, objects = new_objects, calculations = new_calculations, scalars = new_scalars, keys = new_keys, comments = new_comments, keep_attributes = include_metadata)
                            if(include_logs && "get_changes" %in% curr_names) {
                              new_changes <- curr_data_object$get_changes()
                            }
                            else new_changes <- list()
                            new_data_object$set_changes(new_changes)
                            if(include_filters && "current_filter" %in% curr_names) new_data_object$current_filter <- curr_data_object$get_current_filter()
                            else new_data_object$remove_current_filter()
                            if(include_column_selections && "current_column_selection" %in% curr_names) new_data_object$current_column_selection <- curr_data_object$get_current_column_selection()
                            else new_data_object$remove_current_column_selection()
                            if(!include_metadata) {
                              new_data_object$clear_metadata()
                              new_data_object$clear_variables_metadata()
                            }
                            new_data_object$data_changed <- TRUE
                            new_data_object$metadata_changed <- TRUE
                            new_data_object$variables_metadata_changed <- TRUE
                            return(new_data_object)
                          },
                          
                          #' @description
                          #' Clones an instat calculation with manipulations and sub-calculations.
                          #' @param curr_instat_calculation The current instat calculation to be cloned.
                          #' @param ... Additional arguments passed to other methods.
                          clone_instat_calculation = function(curr_instat_calculation, ...) {
                            new_manips <- lapply(curr_instat_calculation$manipulations, function(x) self$clone_instat_calculation(x))
                            new_subs <- lapply(curr_instat_calculation$sub_calculations, function(x) self$clone_instat_calculation(x))
                            new_instat_calculation <- instatCalculations::instat_calculation$new(function_exp = curr_instat_calculation$function_exp, 
                                                                             type = curr_instat_calculation$type,
                                                                             name = curr_instat_calculation$name, 
                                                                             result_name = curr_instat_calculation$result_name, 
                                                                             manipulations = new_manips,
                                                                             sub_calculations = new_subs,
                                                                             calculated_from = curr_instat_calculation$calculated_from, 
                                                                             save = curr_instat_calculation$save)
                            return(new_instat_calculation)
                          },
                          
                          #' @description
                          #' Imports data from an ODK platform.
                          #' @param username The username for ODK.
                          #' @param form_name The name of the ODK form.
                          #' @param platform The platform used for ODK.
                          import_from_ODK = function(username, form_name, platform) {
                            out <- instatExtras::import_from_ODK(username, form_name, platform)
                            data_list <- list(out)
                            names(data_list) <- form_name
                            self$import_data(data_tables = data_list)
                          },
                          
                          #' @description
                          #' Sets metadata for the DataBook.
                          #' @param new_meta A list of metadata to be set.
                          set_meta = function(new_meta) {
                            if(!is.list(new_meta)) stop("new_meta must be of type: list")
                            for(name in names(attributes(self))) {
                              if(!name  %in% c("class")) attr(self, name) <- NULL
                            }
                            for(name in names(new_meta)) {
                              self$append_to_metadata(name, new_meta[[name]])
                            }
                          },
                          
                          #' @description
                          #' Sets objects in the DataBook.
                          #' @param new_objects A list of objects to be set.
                          set_objects = function(new_objects) {
                            if(!is.list(new_objects)) stop("new_objects must be of type: list")
                            private$.objects <- new_objects 
                          },
                          
                          #' @description 
                          #' Set the undo history for the DataBook.
                          #' @param new_undo_history List, new undo history to set.
                          set_undo_history = function(new_undo_history) {
                            if (!is.list(new_undo_history)) stop("undo_history must be of type: list")
                            private$.undo_history <- new_undo_history 
                          }, 
                          
                          #' @description 
                          #' Set the scalars for the DataBook.
                          #' @param new_scalars List, new scalars to set.
                          set_scalars = function(new_scalars) {
                            if (!is.list(new_scalars)) stop("new_scalars must be of type: list")
                            private$.scalars <- new_scalars 
                          }, 
                          
                          #' @description 
                          #' Retrieve scalars for a specific data object or overall DataBook.
                          #' @param data_name Character, the name of the data object to retrieve scalars for. Defaults to overall DataBook if NULL or `overall_label`.
                          #' @return List of scalars.
                          get_scalars = function(data_name) {
                            if (is.null(data_name) || identical(data_name, overall_label)) {
                              out <- private$.scalars[self$get_scalar_names(data_name = data_name)]
                            } else {
                              out <- self$get_data_objects(data_name)$get_scalars()
                            }
                            return(out)
                          }, 
                          
                          #' @description
                          #' Retrieve scalar names for a specific data table.
                          #' @param data_name The name of the data table.
                          #' @param as_list A boolean indicating whether to return results as a list.
                          #' @param excluded_items A vector of excluded items.
                          #' @param ... Additional arguments passed to other methods.
                          get_scalar_names = function(data_name, as_list = FALSE, excluded_items = c(), ...) {
                            if (is.null(data_name) || identical(data_name, overall_label)) {
                              out <-
                                get_data_book_scalar_names(
                                  scalar_list = private$.scalars,
                                  as_list = as_list,
                                  list_label = overall_label
                                )
                            } else {
                              out <-
                                self$get_data_objects(data_name)$get_scalar_names(as_list = as_list, excluded_items = excluded_items)
                            }
                            return(out)
                          },
                          
                          #' @description 
                          #' Retrieve the value of a specific scalar for a given data object.
                          #' @param data_name Character, the name of the data object.
                          #' @param scalar_name Character, the name of the scalar to retrieve.
                          #' @return The value of the specified scalar.
                          get_scalar_value = function(data_name, scalar_name) {
                            self$get_data_objects(data_name)$get_scalar_value(scalar_name)
                          }, 
                          
                          #' @description 
                          #' Add a scalar to a specific data object or the overall DataBook.
                          #' @param data_name Character, the name of the data object. Adds to the overall DataBook if NULL or `overall_label`.
                          #' @param scalar_name Character, the name of the scalar. Defaults to a generated name if missing.
                          #' @param scalar_value The value of the scalar to add.
                          add_scalar = function(data_name, scalar_name = "", scalar_value) {
                            if (is.null(data_name) || identical(data_name, overall_label)) {
                              if (missing(scalar_name)) scalar_name <- instatExtras::next_default_item("scalar", names(private$.scalars))
                              if (scalar_name %in% names(private$.scalars))
                                warning("A scalar called ", scalar_name, " already exists. It will be replaced.")
                              private$.scalars[[scalar_name]] <- scalar_value
                            } else {
                              self$get_data_objects(data_name)$add_scalar(scalar_name, scalar_value)
                            }
                          }, 
                          
                          #' @description 
                          #' Enable or disable undo functionality for a specific data object.
                          #' @param data_name Character, the name of the data object.
                          #' @param disable_undo Logical, whether to disable undo functionality.
                          set_enable_disable_undo = function(data_name, disable_undo) {
                            self$get_data_objects(data_name)$set_enable_disable_undo(disable_undo)
                          }, 
                          
                          #' @description 
                          #' Check if undo functionality is enabled for a specific data object.
                          #' @param data_name Character, the name of the data object.
                          #' @return Logical, whether undo is enabled.
                          is_undo = function(data_name) {
                            self$get_data_objects(data_name)$is_undo()
                          }, 
                          
                          #' @description 
                          #' Check if there is undo history for a specific data object.
                          #' @param data_name Character, the name of the data object.
                          #' @return Logical, whether undo history exists.
                          has_undo_history = function(data_name) {
                            self$get_data_objects(data_name)$has_undo_history()
                          }, 
                          
                          #' @description 
                          #' Undo the last action for a specific data object.
                          #' @param data_name Character, the name of the data object.
                          undo_last_action = function(data_name) {
                            self$get_data_objects(data_name)$undo_last_action()
                          }, 
                          
                          #' @description 
                          #' Redo the last undone action for a specific data object.
                          #' @param data_name Character, the name of the data object.
                          redo_last_action = function(data_name) {
                            self$get_data_objects(data_name)$redo_last_action()
                          }, 
                          
                          #' @description 
                          #' Retrieve the climatic type attribute for a specific column in a given data object.
                          #' @param data_name Character, the name of the data object.
                          #' @param col_name Character, the name of the column.
                          #' @param attr_name Character, the name of the attribute to retrieve.
                          #' @return The value of the specified attribute, or NULL if not available.
                          get_column_climatic_type = function(data_name, col_name, attr_name) {
                            self$get_data_objects(data_name)$get_column_climatic_type(col_name = col_name, attr_name = attr_name)
                          }, 
                          
                          
                          #' @description
                          #' Appends a data object to the DataBook.
                          #' @param name The name of the data object.
                          #' @param obj The data object to append.
                          #' @param add_to_graph_book A boolean to add the data to the graph book.
                          append_data_object = function(name, obj, add_to_graph_book = TRUE) {
                            if(!is.character(name)) stop("name must be a character")
                            # obj could be of old class type 'data_object'
                            if(!any(c("data_object", "DataSheet") %in% class(obj))) {
                              stop("obj must be a data object")
                            }
                            obj$append_to_metadata(data_name_label, name)
                            private$.data_sheets[[name]] <- obj
                            if (add_to_graph_book && exists(".graph_data_book")) {
                              dfs <- list(data.frame())
                              names(dfs) <- name
                              .graph_data_book$import_data(data_tables = dfs, add_to_graph_book = FALSE)
                            }
                          },
                          
                          #' @description
                          #' Retrieve data objects from the DataBook by name.
                          #' @param data_name The name or index of the data object(s) to retrieve.
                          #' @param as_list A boolean to return the data objects as a list (default: FALSE).
                          #' @param ... Additional arguments passed to other methods.
                          get_data_objects = function(data_name, as_list = FALSE, ...) {
                            if (missing(data_name)) {
                              return(private$.data_sheets)
                            } else {
                              if (all(is.character(data_name))) type = "character"
                              else if (all(is.numeric(data_name)) && all((data_name %% 1) == 0)) type = "integer"
                              else stop("data_name must be of type character or integer")
                              
                              if (type == "character" && !all(data_name %in% names(private$.data_sheets))) stop(paste(data_name, "not found"))
                              if (type == "integer" && (!all(1 <= data_name) || !all(data_name <= length(private$.data_sheets)))) stop(paste(data_name, "not found"))
                              if (length(data_name) > 1 || as_list) return(private$.data_sheets[data_name])
                              else return(private$.data_sheets[[data_name]])
                            }
                          },
                          
                          #' @description
                          #' Retrieve data frames from the DataBook.
                          #' @param data_name The name of the data frame to retrieve.
                          #' @param convert_to_character A boolean indicating whether to convert data to character type (default: FALSE).
                          #' @param stack_data A boolean to stack data (default: FALSE).
                          #' @param include_hidden_columns A boolean to include hidden columns (default: TRUE).
                          #' @param use_current_filter A boolean to apply the current filter (default: TRUE).
                          #' @param ... Additional arguments passed to other methods.
                          get_data_frame = function(data_name, convert_to_character = FALSE, stack_data = FALSE, 
                                                    include_hidden_columns = TRUE, use_current_filter = TRUE, ...) {
                            if (!stack_data) {
                              if (missing(data_name)) data_name <- self$get_data_names()
                              if (length(data_name) > 1) {
                                retlist <- list()
                                for (curr_name in data_name) {
                                  retlist[[curr_name]] = self$get_data_objects(curr_name)$get_data_frame(
                                    convert_to_character = convert_to_character,
                                    include_hidden_columns = include_hidden_columns,
                                    use_current_filter = use_current_filter, ...)
                                }
                                return(retlist)
                              } else {
                                return(self$get_data_objects(data_name)$get_data_frame(
                                  convert_to_character = convert_to_character,
                                  include_hidden_columns = include_hidden_columns,
                                  use_current_filter = use_current_filter, ...))
                              }
                            } else {
                              if (missing(data_name)) stop("data to be stacked is missing")
                              if (!data_name %in% names(private$.data_sheets)) stop(paste(data_name, "not found."))
                              return(self$get_data_objects(data_name)$get_data_frame(
                                include_hidden_columns = include_hidden_columns,
                                use_current_filter = use_current_filter,
                                stack_data = TRUE, ...))
                            }
                          },
                          
                          #' @description
                          #' Retrieve metadata for variables in a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param data_type The type of data to retrieve (default: "all").
                          #' @param convert_to_character A boolean indicating whether to convert data to character type (default: FALSE).
                          #' @param property The specific property to retrieve.
                          #' @param column The column for which metadata is to be retrieved.
                          #' @param ... Additional arguments passed to other methods.
                          get_variables_metadata = function(data_name, data_type = "all", convert_to_character = FALSE, 
                                                            property, column, ...) {
                            if (missing(data_name)) {
                              retlist <- list()
                              for (curr_obj in private$.data_sheets) {
                                retlist[[curr_obj$get_metadata(data_name_label)]] = curr_obj$get_variables_metadata(
                                  data_type = data_type, convert_to_character = convert_to_character, property = property, column = column, ...)
                              }
                              return(retlist)
                            } else {
                              return(self$get_data_objects(data_name)$get_variables_metadata(
                                data_type = data_type, convert_to_character = convert_to_character, property = property, column = column, ...))
                            }
                          },
                          
                          #' @description
                          #' Retrieve data types for specific columns in a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param columns A vector of columns to retrieve the data types for.
                          get_column_data_types = function(data_name, columns) {
                            return(self$get_data_objects(data_name)$get_column_data_types(columns = columns))
                          },
                          
                          #' @description
                          #' Retrieve labels for specific columns in a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param columns A vector of columns to retrieve the labels for.
                          get_column_labels = function(data_name, columns) {
                            return(self$get_data_objects(data_name)$get_column_labels(columns = columns))
                          },
                          
                          #' @description
                          #' Retrieve the label of a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param use_current_filter A boolean indicating whether to use the current filter (default: FALSE).
                          get_data_frame_label = function(data_name, use_current_filter = FALSE) {
                            self$get_data_objects(data_name)$get_data_frame_label(use_current_filter)
                          },
                          
                          #' @description
                          #' Retrieve metadata for a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param label The label for the metadata to retrieve.
                          #' @param include_calculated A boolean indicating whether to include calculated columns (default: TRUE).
                          #' @param excluded_not_for_display A boolean to exclude columns not for display (default: TRUE).
                          get_data_frame_metadata = function(data_name, label, include_calculated = TRUE, excluded_not_for_display = TRUE) {
                            return(self$get_data_objects(data_name)$get_metadata(
                              label = label, include_calculated = include_calculated, excluded_not_for_display = excluded_not_for_display))
                          },
                          
                          #' @description
                          #' Retrieve combined metadata across all data objects in the DataBook.
                          #' @param convert_to_character A boolean to convert the metadata to a character matrix (default: FALSE).
                          get_combined_metadata = function(convert_to_character = FALSE) {
                            retlist <- data.frame()
                            i = 1
                            for (curr_obj in private$.data_sheets) {
                              templist = curr_obj$get_metadata()
                              for (j in seq_along(templist)) {
                                if (is.list(templist[[j]]) || length(templist[[j]]) > 1) {
                                  if (length(templist[[j]]) > 0) {
                                    templist[[j]] <-
                                      paste(names(templist[[j]]), " = ", templist[[j]], collapse = ", ")
                                  } else {
                                    next
                                  }
                                }
                                retlist[i, names(templist[j])] = templist[[j]]
                              }
                              if(all(c(data_name_label, label_label, row_count_label, column_count_label,
                                       data_type_label, is_calculated_label, is_hidden_label, is_linkable, key_label) %in% names(retlist))){
                                retlist <- retlist[ ,c(c(data_name_label, label_label, row_count_label, column_count_label, data_type_label,
                                                         is_calculated_label, is_hidden_label, is_linkable, key_label),
                                                       sort(setdiff(names(retlist), c(data_name_label,label_label, row_count_label, column_count_label,
                                                                                      data_type_label, is_calculated_label,is_hidden_label,is_linkable, key_label))))]
                              }
                              else if(data_name_label %in% names(retlist)) retlist <- retlist[ ,c(data_name_label, sort(setdiff(names(retlist), data_name_label)))]
                              i = i + 1
                            }
                            if(convert_to_character) return(instatExtras::convert_to_character_matrix(retlist, FALSE))
                            else return(retlist)
                          },
                          
                          #' @description
                          #' Retrieve metadata for a specific property.
                          #' @param name The name of the metadata to retrieve.
                          #' @param ... Additional arguments passed to other methods.
                          get_metadata = function(name, ...) {
                            if (missing(name)) return(private$.metadata)
                            if (!is.character(name)) stop("name must be a character")
                            if (!name %in% names(private$.metadata)) stop(paste(name, "not found in metadata"))
                            return(private$.metadata[[name]])
                          },
                          
                          #' @description
                          #' Retrieve data names from the data book.
                          #' @param as_list A boolean indicating whether to return results as a list.
                          #' @param include A vector of names to include.
                          #' @param exclude A vector of names to exclude.
                          #' @param excluded_items A vector of excluded items.
                          #' @param include_hidden A boolean indicating whether to include hidden items.
                          #' @param ... Additional arguments passed to other methods.
                          get_data_names = function(as_list = FALSE, include, exclude, excluded_items, include_hidden = TRUE, ...) { 
                            ret <- names(private$.data_sheets)
                            if(!include_hidden) {
                              ret <- ret[sapply(ret, function(x) !isTRUE(self$get_data_objects(x)$get_metadata(label = is_hidden_label)))]
                            }
                            if(as_list) return(list(data_names = ret))
                            else return(ret)
                          },
                          
                          #' @description
                          #' Check if data has changed.
                          #' @param data_name The name of the data table to check.
                          get_data_changed = function(data_name) {
                            if(missing(data_name)) {
                              if(self$data_objects_changed) return(TRUE)
                              for(curr_obj in private$.data_sheets) {
                                if(curr_obj$data_changed) return(TRUE)
                              }
                              return(FALSE)
                            }
                            else {
                              return(self$get_data_objects(data_name)$data_changed)
                            }
                          },
                          
                          #' @description
                          #' Check if variables metadata has changed.
                          #' @param data_name The name of the data table to check.
                          get_variables_metadata_changed = function(data_name) { 
                            if(missing(data_name)) {
                              if(private$.data_sheets_changed) return(TRUE)
                              return(any(sapply(private$.data_sheets, function(x) x$variables_metadata_changed)))
                            }
                            else {
                              return(self$get_data_objects(data_name)$variables_metadata_changed)
                            }
                          },
                          
                          #' @description
                          #' Check if metadata has changed.
                          #' @param data_name The name of the data table to check.
                          get_metadata_changed = function(data_name) { 
                            if(missing(data_name)) {
                              if(private$.data_sheets_changed) return(TRUE)
                              for(curr_obj in private$.data_sheets) {
                                if(curr_obj$metadata_changed) return(TRUE)
                              }
                              return(FALSE)
                            }
                            else {
                              return(self$get_data_objects(data_name)$metadata_changed)
                            }
                          },
                          
                          #' @description
                          #' Retrieve calculations for a specific data table.
                          #' @param data_name The name of the data table.
                          get_calculations = function(data_name) {
                            return(self$get_data_objects(data_name)$get_calculations())
                          },
                          
                          #' @description
                          #' Retrieve calculation names for a specific data table.
                          #' @param data_name The name of the data table.
                          #' @param as_list A boolean indicating whether to return results as a list.
                          #' @param excluded_items A vector of excluded items.
                          get_calculation_names = function(data_name, as_list = FALSE, excluded_items = c()) {
                            return(self$get_data_objects(data_name)$get_calculation_names(as_list = as_list, excluded_items = excluded_items))
                          },
                          
                          #' @description
                          #' Get the count of data frames in the DataBook.
                          #' @return An integer representing the number of data frames.
                          dataframe_count = function() {
                            return(length(private$.data_sheets))
                          },
                          
                          #' @description
                          #' Set the data changed status for the specified data frame.
                          #' @param data_name The name of the data frame. Defaults to an empty string.
                          #' @param new_val A boolean indicating the new changed status.
                          set_data_frames_changed = function(data_name = "", new_val) {
                            if(data_name == "") {
                              for(curr_obj in private$.data_sheets) {
                                curr_obj$data_changed <- new_val
                              }
                            } else {
                              self$get_data_objects(data_name)$set_data_changed(new_val)
                            }
                          },
                          
                          #' @description
                          #' Set the variables metadata changed status for the specified data frame.
                          #' @param data_name The name of the data frame. Defaults to an empty string.
                          #' @param new_val A boolean indicating the new changed status.
                          set_variables_metadata_changed = function(data_name = "", new_val) {
                            if(data_name == "") {
                              for(curr_obj in private$.data_sheets) {
                                curr_obj$variables_metadata_changed <- new_val
                              }
                            } else {
                              self$get_data_objects(data_name)$set_variables_metadata_changed(new_val)
                            }
                          },
                          
                          #' @description
                          #' Set the metadata changed status for the specified data frame.
                          #' @param data_name The name of the data frame. Defaults to an empty string.
                          #' @param new_val A boolean indicating the new changed status.
                          set_metadata_changed = function(data_name = "", new_val) {
                            if(data_name == "") {
                              for(curr_obj in private$.data_sheets) {
                                curr_obj$set_metadata_changed(new_val)
                              }
                            } else {
                              self$get_data_objects(data_name)$set_metadata_changed(new_val)
                            }
                          },
                          
                          #' @description
                          #' Add columns to the specified data frame.
                          #' @param data_name The name of the data frame.
                          #' @param col_name The name of the new column.
                          #' @param col_data The data for the new column.
                          #' @param use_col_name_as_prefix A boolean indicating if the column name should be prefixed.
                          #' @param hidden A boolean indicating if the column should be hidden.
                          #' @param before The name of the column before which to insert the new column.
                          #' @param adjacent_column The name of an adjacent column.
                          #' @param num_cols The number of columns to add.
                          #' @param require_correct_length A boolean indicating if the lengths of the data should match.
                          #' @param keep_existing_position A boolean indicating if the existing column position should be maintained.
                          add_columns_to_data = function(data_name, col_name = "", col_data, use_col_name_as_prefix = FALSE, hidden = FALSE, before, adjacent_column = "", num_cols, require_correct_length = TRUE, keep_existing_position = TRUE) {
                            self$get_data_objects(data_name)$add_columns_to_data(col_name, col_data, use_col_name_as_prefix = use_col_name_as_prefix, hidden = hidden, before = before, adjacent_column = adjacent_column, num_cols = num_cols, require_correct_length = require_correct_length, keep_existing_position = keep_existing_position)
                          },
                          
                          #' @description
                          #' Get specified columns from the data frame.
                          #' @param data_name The name of the data frame.
                          #' @param col_names A vector of column names to retrieve.
                          #' @param from_stacked_data A boolean indicating if the data is stacked.
                          #' @param force_as_data_frame A boolean indicating if the output should be a data frame.
                          #' @param use_current_filter A boolean indicating if the current filter should be used.
                          #' @param remove_labels A boolean indicating if labels should be removed.
                          #' @param drop_unused_filter_levels A boolean indicating if unused filter levels should be dropped.
                          get_columns_from_data = function(data_name, col_names, from_stacked_data = FALSE, force_as_data_frame = FALSE, use_current_filter = TRUE, remove_labels = FALSE, drop_unused_filter_levels = FALSE) {
                            if(missing(data_name)) stop("data_name is required")
                            if(!from_stacked_data) {
                              if(!data_name %in% names(private$.data_sheets)) stop(data_name, "not found")
                              self$get_data_objects(data_name)$get_columns_from_data(col_names, force_as_data_frame, use_current_filter = use_current_filter, remove_labels = remove_labels, drop_unused_filter_levels = drop_unused_filter_levels)
                            } else {
                              if(!exists(data_name)) stop(paste(data_name, "not found."))
                              if(!all(sapply(col_names, function(x) x %in% names(data_name)))) stop("Not all column names were found in data")
                              if(length(col_names) == 1 && !force_as_data_frame) return(data_name[[col_names]])
                              else return(data_name[col_names])
                            }
                          },
                          
                          #' @description
                          #' Create a new graph data book and assign it to the global environment.
                          create_graph_data_book = function() {
                            .graph_data_book <- DataBook$new()
                            df_names <- self$get_data_names()
                            dfs <- vector("list", length(df_names))
                            names(dfs) <- df_names
                            for (i in seq_along(dfs)) {
                              dfs[[i]] <- data.frame()
                            }
                            .graph_data_book$import_data(data_tables = dfs)
                            assign(".graph_data_book", .graph_data_book, envir = .GlobalEnv)
                          },
                          
                          #' @description
                          #' Add an object to the DataBook.
                          #' @param data_name The name of the data frame.
                          #' @param object_name The name of the object. If NULL, a default name is generated.
                          #' @param object_type_label The label for the object type.
                          #' @param object_format The format of the object.
                          #' @param object The object to add.
                          add_object = function(data_name = NULL, 
                                                object_name = NULL, 
                                                object_type_label, 
                                                object_format, 
                                                object) {
                            if(is.null(data_name) || identical(data_name, overall_label)) {
                              if(is.null(object_name)){
                                object_name <- instatExtras::next_default_item("object", names(private$.objects))
                              } 
                              
                              if(object_name %in% names(private$.objects)){
                                message(paste("An object called", object_name, "already exists. It will be replaced."))
                              }
                              
                              private$.objects[[object_name]] <- list(object_type_label = object_type_label, object_format = object_format, object = object)
                            } else { 
                              self$get_data_objects(data_name)$add_object(object_name = object_name, object_type_label = object_type_label, object_format = object_format, object = object)
                            }
                            
                            if(identical(object_type_label, graph_label)){
                              private$.last_graph <- c(data_name, object_name)
                            }
                          },
                          
                          #' @description
                          #' Get the names of objects in the DataBook.
                          #' @param data_name The name of the data frame.
                          #' @param object_type_label The label for the object type.
                          #' @param as_list A boolean indicating if the output should be a list.
                          #' @param ... Additional arguments passed to other methods.
                          #' @return A vector of object names.
                          get_object_names = function(data_name = NULL, 
                                                      object_type_label = NULL,
                                                      as_list = FALSE, ...) {
                            if(is.null(data_name) || identical(data_name, overall_label)){
                              out <- get_data_book_output_object_names(
                                output_object_list = private$.objects,
                                object_type_label = object_type_label,
                                as_list = as_list,
                                list_label = overall_label)
                            } else {
                              out <- self$get_data_objects(data_name)$get_object_names(
                                object_type_label = object_type_label,
                                as_list = as_list)
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Get objects from the DataBook.
                          #' @param data_name The name of the data frame.
                          #' @param object_type_label The label for the object type.
                          #' @return A list of objects.
                          get_objects = function(data_name = NULL, 
                                                 object_type_label = NULL) {
                            if(is.null(data_name) || identical(data_name, overall_label)) {
                              out <- private$.objects[self$get_object_names(data_name = data_name, object_type_label = object_type_label)]
                            } else {
                              out <- self$get_data_objects(data_name)$get_objects(object_type_label = object_type_label)
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Get a specific object from the DataBook.
                          #' @param data_name The name of the data frame.
                          #' @param object_name The name of the object to retrieve.
                          #' @return The requested object, or NULL if not found.
                          get_object = function(data_name = NULL, object_name) {
                            out <- NULL
                            if(is.null(data_name) || identical(data_name, overall_label)) {
                              out <- private$.objects[[object_name]]
                            } else {
                              out <- self$get_data_objects(data_name)$get_object(object_name = object_name)
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Get the data of a specific object.
                          #' @param data_name The name of the data frame.
                          #' @param object_name The name of the object.
                          #' @param as_file A boolean indicating if the output should be formatted as a file.
                          #' @return The object data or NULL if not found.
                          get_object_data = function(data_name = NULL, object_name, as_file = FALSE) {
                            out <- self$get_object(data_name = data_name, object_name = object_name)
                            if(is.null(out)){
                              return(NULL)
                            } else if(as_file){
                              out <- instatExtras::view_object_data(object = out$object, object_format = out$object_format)
                            } else {
                              out <- out$object
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Retrieve data objects from a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param object_names A character vector of object names to retrieve.
                          #' @param as_files A boolean indicating whether to return data as files.
                          get_objects_data = function(data_name = NULL, object_names = NULL, as_files = FALSE) {
                            out <- list()
                            if(is.null(object_names)){
                              objects_list <- self$get_objects(data_name = data_name)
                              out <- self$get_objects_data(data_name = data_name, object_names = names(objects_list))
                            } else {
                              for(object_name in object_names){
                                object_data <- self$get_object_data(data_name = data_name, object_name = object_name, as_file = as_files)
                                if(!is.null(object_data)){
                                  out[[object_name]] <- object_data
                                }
                              }
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Retrieve the last object data based on the specified type label.
                          #' @param object_type_label The label of the object type to retrieve.
                          #' @param as_file A boolean indicating whether to return the data as a file.
                          get_last_object_data = function(object_type_label, as_file = TRUE) {
                            out <- NULL
                            if(identical(object_type_label, graph_label)){
                              if(!is.null(private$.last_graph) && length(private$.last_graph) == 2) {
                                out <- self$get_object_data(data_name = private$.last_graph[1], object_name = private$.last_graph[2], as_file = as_file)
                              }
                            }
                            return(out)
                          },
                          
                          #' @description
                          #' Rename an object within a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param object_name The current name of the object to rename.
                          #' @param new_name The new name for the object.
                          #' @param object_type The type of the object being renamed.
                          rename_object = function(data_name, object_name, new_name, object_type = "object") {
                            if(missing(data_name) || data_name == overall_label) {
                              if(!object_name %in% names(private$.objects)) stop(object_name, " not found in overall objects list")
                              if(new_name %in% names(private$.objects)) stop(new_name, " is already an object name. Cannot rename ", object_name, " to ", new_name)
                              names(private$.objects)[names(private$.objects) == object_name] <- new_name
                            } else {
                              self$get_data_objects(data_name)$rename_object(object_name = object_name, new_name = new_name, object_type = object_type)
                            }
                          },
                          
                          #' @description
                          #' Delete specified objects from a data table.
                          #' @param data_name The name of the data table.
                          #' @param object_names A character vector of object names to delete.
                          #' @param object_type The type of the objects being deleted.
                          delete_objects = function(data_name, object_names, object_type = "object") {
                            if(missing(data_name) || data_name == overall_label) {
                              if(!all(object_names %in% names(private$.objects))) stop("Not all object_names found in overall objects list")
                            } else {
                              self$get_data_objects(data_name)$delete_objects(object_names = object_names, object_type = object_type)
                            }
                          },
                          
                          #' @description
                          #' Reorder objects in a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param new_order A character vector specifying the new order of object names.
                          reorder_objects = function(data_name, new_order) {
                            if(missing(data_name) || data_name == overall_label) {
                              if(length(new_order) != length(private$.objects) || !setequal(new_order, names(private$.objects))) stop("new_order must be a permutation of the current object names.")
                              self$set_objects(private$.objects[new_order])
                            } else {
                              self$get_data_objects(data_name)$reorder_objects(new_order = new_order)
                            }
                          },
                          
                          #' @description
                          #' Retrieve a value from a specified object.
                          #' @param data_name The name of the data table.
                          #' @param object_name The name of the object to retrieve data from.
                          #' @param value1 The first value/key to retrieve.
                          #' @param value2 The second value/key to retrieve.
                          #' @param value3 The third value/key to retrieve.
                          get_from_object = function(data_name, object_name, value1, value2, value3) {
                            if(missing(data_name) || missing(object_name)) stop("data_name and object_name must both be specified.")
                            curr_object = self$get_objects(data_name = data_name, object_name = object_name)
                            if(missing(value1)) {
                              if(!missing(value2) || !missing(value3)) warning("value1 is missing so value2 and value3 will be ignored.")
                              return(curr_object[])
                            }
                            if(!value1 %in% names(curr_object)) stop(value1, " not found in ", object_name)
                            if(missing(value2)) {
                              if(!missing(value3)) warning("value2 is missing so value3 will be ignored.")
                              return(curr_object[[value1]])
                            } else {
                              if(!value2 %in% names(curr_object[[value1]])) stop(paste0(value2, " not found in ", object_name,"[[\"",value1,"\"]]"))
                              if(missing(value3)) return(curr_object[[value1]][[value2]])
                              else {
                                if(!value3 %in% names(curr_object[[value1]][[value2]])) stop(value3, " not found in ", object_name,"[[\"",value1,"\"]]","[[\"",value2,"\"]]")
                                return(curr_object[[value1]][[value2]][[value3]])
                              }
                            }
                          },
                          
                          #' @description
                          #' Add a filter to the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param filter The filter to apply.
                          #' @param filter_name The name of the filter.
                          #' @param replace A boolean indicating whether to replace existing filters.
                          #' @param set_as_current_filter A boolean indicating whether to set this filter as the current filter.
                          #' @param na.rm A boolean indicating whether to remove NA values.
                          #' @param is_no_filter A boolean indicating whether this is a "no filter".
                          #' @param and_or A string indicating whether to apply AND or OR logic.
                          #' @param inner_not A boolean for inner negation.
                          #' @param outer_not A boolean for outer negation.
                          add_filter = function(data_name, filter, filter_name = "", replace = TRUE, set_as_current_filter = FALSE, na.rm = TRUE, is_no_filter = FALSE, and_or = "&", inner_not = FALSE, outer_not = FALSE) {
                            if(missing(filter)) stop("filter is required")
                            self$get_data_objects(data_name)$add_filter(filter, filter_name, replace, set_as_current_filter, na.rm = na.rm, is_no_filter = is_no_filter, and_or = and_or, inner_not = inner_not, outer_not =  outer_not)
                          },
                          
                          #' @description
                          #' Add a filter as levels for a specified column in the data table.
                          #' @param data_name The name of the data table.
                          #' @param filter_levels The levels of the filter to add.
                          #' @param column The column to apply the filter to.
                          add_filter_as_levels = function(data_name, filter_levels, column) {
                            self$get_data_objects(data_name)$add_filter_as_levels(filter_levels, column)
                          },
                          
                          #' @description
                          #' Retrieve the current filter applied to a specified data table.
                          #' @param data_name The name of the data table.
                          #' @return The current filter.
                          current_filter = function(data_name) {
                            return(self$get_data_objects(data_name)$current_filter)
                          },
                          
                          #' @description
                          #' Set the current filter for a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to set as current.
                          set_current_filter = function(data_name, filter_name = "") {
                            self$get_data_objects(data_name)$set_current_filter(filter_name)
                          },
                          
                          #' @description
                          #' Retrieve a specific filter by name.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to retrieve.
                          #' @return The requested filter.
                          get_filter = function(data_name, filter_name) {
                            return(self$get_data_objects(data_name)$get_filter(filter_name))
                          },
                          
                          #' @description
                          #' Retrieve a filter as a logical vector.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to retrieve.
                          #' @return A logical vector representing the filter.
                          get_filter_as_logical = function(data_name, filter_name) {
                            return(self$get_data_objects(data_name)$get_filter_as_logical(filter_name))
                          },
                          
                          #' @description
                          #' Retrieve the currently applied filter for a specified data table.
                          #' @param data_name The name of the data table.
                          #' @return The currently applied filter.
                          get_current_filter = function(data_name) {
                            self$get_data_objects(data_name)$get_current_filter()
                          },
                          
                          #' @description
                          #' Retrieve row names based on a specific filter for a data table.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to use for retrieval.
                          #' @return A vector of row names.
                          get_filter_row_names = function(data_name, filter_name) {
                            row_names <- row.names(self$get_data_frame(data_name, convert_to_character = FALSE, stack_data = FALSE,
                                                                       include_hidden_columns = TRUE, use_current_filter = TRUE, filter_name = filter_name, 
                                                                       remove_attr = FALSE, retain_attr = FALSE, drop_unused_filter_levels = FALSE))
                            return(row_names)
                          },
                          
                          #' @description
                          #' Retrieve the name of the current filter for a specified data table.
                          #' @param data_name The name of the data table.
                          #' @return The name of the current filter.
                          get_current_filter_name = function(data_name) {
                            self$get_data_objects(data_name)$get_current_filter()$name
                          },
                          
                          #' @description
                          #' Retrieve the names of all filters for a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param as_list A boolean indicating whether to return as a list.
                          #' @param include A list of items to include.
                          #' @param exclude A list of items to exclude.
                          #' @param excluded_items A vector of excluded items.
                          #' @return A vector or list of filter names.
                          get_filter_names = function(data_name, as_list = FALSE, include = list(), exclude = list(), excluded_items = c()) {
                            if(missing(data_name)) {
                              return(lapply(self$get_data_objects(), function(x) x$get_filter_names(include = include, exclude = exclude)))
                            } else {
                              return(self$get_data_objects(data_name)$get_filter_names(as_list = as_list, include = include, exclude = exclude, excluded_items = excluded_items))
                            }
                          },
                          
                          #' @description
                          #' Remove the current filter from a specified data table.
                          #' @param data_name The name of the data table.
                          remove_current_filter = function(data_name) {
                            self$get_data_objects(data_name)$remove_current_filter()
                          },
                          
                          #' @description
                          #' Check if a filter is applied to a specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A boolean indicating if a filter is applied.
                          filter_applied = function(data_name) {
                            self$get_data_objects(data_name)$filter_applied()
                          },
                          
                          #' @description
                          #' Retrieve the string representation of a specific filter.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to retrieve the string for.
                          #' @return A string representation of the filter.
                          filter_string = function(data_name, filter_name) {
                            self$get_data_objects(data_name)$filter_string(filter_name)
                          },
                          
                          #' @description
                          #' Retrieve a filter as an Instat calculation.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter to retrieve.
                          #' @return The filter as an Instat calculation.
                          get_filter_as_instat_calculation = function(data_name, filter_name) {
                            self$get_data_objects(data_name)$get_filter_as_instat_calculation(filter_name)
                          },
                          
                          
                          # Column Selections -------------------------------------------------------
                          
                          #' @description
                          #' Add a column selection to a data table.
                          #' @param data_name The name of the data table.
                          #' @param column_selection The selection of columns.
                          #' @param name Optional name for the selection.
                          #' @param replace Logical indicating if the selection should replace an existing one.
                          #' @param set_as_current Logical indicating if the selection should be set as current.
                          #' @param is_everything Logical indicating if all columns should be selected.
                          #' @param and_or String indicating the logical operator to use.
                          add_column_selection = function(data_name, column_selection, name = "", replace = TRUE, 
                                                          set_as_current = FALSE, is_everything = FALSE, and_or = "|") {
                            self$get_data_objects(data_name)$add_column_selection(column_selection, name, replace, set_as_current, is_everything, and_or)
                          },
                          
                          #' @description
                          #' Get the current column selection for a data table.
                          #' @param data_name The name of the data table.
                          #' @return The current column selection.
                          current_column_selection = function(data_name) {
                            return(self$get_data_objects(data_name)$current_column_selection)
                          },
                          
                          #' @description
                          #' Set the current column selection for a data table.
                          #' @param data_name The name of the data table.
                          #' @param name The name of the column selection to set as current.
                          set_current_column_selection = function(data_name, name = "") {
                            self$get_data_objects(data_name)$set_current_column_selection(name)
                          },
                          
                          #' @description
                          #' Get a specific column selection from a data table.
                          #' @param data_name The name of the data table.
                          #' @param name The name of the column selection to retrieve.
                          #' @return The specified column selection.
                          get_column_selection = function(data_name, name) {
                            return(self$get_data_objects(data_name)$get_column_selection(name))
                          },
                          
                          #' @description
                          #' Get column names from a specified filter in a data table.
                          #' @param data_name The name of the data table.
                          #' @param filter_name The name of the filter.
                          #' @return Logical representation of the filter applied to column names.
                          get_column_selection_column_names = function(data_name, filter_name) {
                            return(self$get_data_objects(data_name)$get_filter_as_logical(filter_name))
                          },
                          
                          #' @description
                          #' Get column names selected in a specific column selection.
                          #' @param data_name The name of the data table.
                          #' @param column_selection_name Optional name of the column selection.
                          #' @return A vector of selected column names.
                          get_column_selected_column_names = function(data_name, column_selection_name = "") {
                            return(self$get_data_objects(data_name)$get_column_selected_column_names(column_selection_name))
                          },
                          
                          #' @description
                          #' Get the current column selection for a data table.
                          #' @param data_name The name of the data table.
                          #' @return The current column selection object.
                          get_current_column_selection = function(data_name) {
                            self$get_data_objects(data_name)$get_current_column_selection()
                          },
                          
                          #' @description
                          #' Get the name of the current column selection for a data table.
                          #' @param data_name The name of the data table.
                          #' @return The name of the current column selection.
                          get_current_column_selection_name = function(data_name) {
                            self$get_data_objects(data_name)$get_current_column_selection()$name
                          },
                          
                          #' @description
                          #' Get names of all column selections for a data table.
                          #' @param data_name The name of the data table.
                          #' @param as_list Logical indicating if results should be returned as a list.
                          #' @param include List of items to include.
                          #' @param exclude List of items to exclude.
                          #' @param excluded_items Optional vector of excluded items.
                          #' @return A list or vector of column selection names.
                          get_column_selection_names = function(data_name, as_list = FALSE, include = list(), 
                                                                exclude = list(), excluded_items = c()) {
                            if(missing(data_name)) {
                              return(lapply(self$get_data_objects(), function(x) x$get_column_selection_names(include = include, exclude = exclude)))
                            } 
                            else {
                              return(self$get_data_objects(data_name)$get_column_selection_names(as_list = as_list, include = include, exclude = exclude, excluded_items = excluded_items))
                            }
                          },
                          
                          #' @description
                          #' Remove the current column selection for a data table.
                          #' @param data_name The name of the data table.
                          remove_current_column_selection = function(data_name) {
                            self$get_data_objects(data_name)$remove_current_column_selection()
                          },
                          
                          #' @description
                          #' Check if a column selection has been applied to a data table.
                          #' @param data_name The name of the data table.
                          #' @return Logical indicating if a selection has been applied.
                          column_selection_applied = function(data_name) {
                            self$get_data_objects(data_name)$column_selection_applied()
                          },
                          
                          #' @description
                          #' Replace values in the data of a specified table.
                          #' @param data_name The name of the data table.
                          #' @param col_names Names of the columns to modify.
                          #' @param rows The rows to be modified.
                          #' @param old_value The value to replace.
                          #' @param old_is_missing Logical indicating if old_value is missing.
                          #' @param start_value Optional starting value for replacement.
                          #' @param end_value Optional ending value for replacement.
                          #' @param new_value The new value to replace with.
                          #' @param new_is_missing Logical indicating if new_value is missing.
                          #' @param closed_start_value Logical for start value closure.
                          #' @param closed_end_value Logical for end value closure.
                          #' @param locf Logical indicating if last observation carried forward should be used.
                          #' @param from_last Logical indicating if the replacement should start from the last.
                          replace_value_in_data = function(data_name, col_names, rows, old_value, old_is_missing = FALSE, 
                                                           start_value = NA, end_value = NA, new_value, new_is_missing = FALSE, 
                                                           closed_start_value = TRUE, closed_end_value = TRUE, locf = FALSE, 
                                                           from_last = FALSE) {
                            self$get_data_objects(data_name)$replace_value_in_data(col_names, rows, old_value, old_is_missing, start_value, end_value, new_value, new_is_missing, closed_start_value, closed_end_value, locf, from_last)
                          },
                          
                          #' @description
                          #' Paste data from the clipboard into a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names Names of the columns to paste into.
                          #' @param start_row_pos Position to start pasting in the data.
                          #' @param first_clip_row_is_header Logical indicating if the first row of the clipboard is a header.
                          #' @param clip_board_text The text to paste from the clipboard.
                          paste_from_clipboard = function(data_name, col_names, start_row_pos = 1, first_clip_row_is_header = TRUE, clip_board_text) {
                            self$get_data_objects(data_name)$paste_from_clipboard(col_names, start_row_pos, first_clip_row_is_header, clip_board_text)
                          },
                          
                          #' @description
                          #' Rename a column in the data of a specified table.
                          #' @param data_name The name of the data table.
                          #' @param column_name Optional name of the column to rename.
                          #' @param new_val The new name for the column.
                          #' @param label Optional label for the column.
                          #' @param type Type of renaming operation.
                          #' @param .fn Optional function for renaming.
                          #' @param .cols Optional columns to rename.
                          #' @param new_column_names_df Data frame with new column names.
                          #' @param new_labels_df Data frame with new labels.
                          #' @param ... Additional arguments passed to other methods.
                          rename_column_in_data = function(data_name, column_name = NULL, new_val = NULL, label = "", type = "single", .fn, .cols = everything(), new_column_names_df, new_labels_df, ...) {
                            self$get_data_objects(data_name)$rename_column_in_data(column_name, new_val, label, type, .fn, .cols, new_column_names_df, new_labels_df, ...)
                            self$update_links_rename_column(data_name = data_name, old_column_name = column_name, new_column_name = new_val)
                          },
                          
                          #' @description
                          #' Generate frequency tables for specified columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param x_col_names Names of columns for x-axis.
                          #' @param y_col_name Name of column for y-axis.
                          #' @param n_column_factors Number of column factors.
                          #' @param store_results Logical indicating if results should be stored.
                          #' @param drop Logical indicating if to drop unused levels.
                          #' @param na.rm Logical indicating if NA values should be removed.
                          #' @param summary_name Optional name for the summary.
                          #' @param include_margins Logical indicating if margins should be included.
                          #' @param return_output Logical indicating if output should be returned.
                          #' @param treat_columns_as_factor Logical indicating if columns should be treated as factors.
                          #' @param page_by Pagination option.
                          #' @param as_html Logical indicating if output should be in HTML format.
                          #' @param signif_fig Number of significant figures.
                          #' @param na_display Optional display for NA values.
                          #' @param na_level_display Optional display for NA levels.
                          #' @param weights Optional weights for frequency calculations.
                          #' @param caption Optional caption for the output.
                          #' @param result_names Optional names for results.
                          #' @param percentage_type Type of percentage calculation.
                          #' @param perc_total_columns Optional columns for total percentages.
                          #' @param perc_total_factors Optional factors for total percentages.
                          #' @param perc_total_filter Optional filter for total percentages.
                          #' @param perc_decimal Logical indicating if percentages should be decimal.
                          #' @param margin_name Name for the margin.
                          #' @param additional_filter Optional additional filter.
                          #' @param ... Additional parameters.
                          frequency_tables = function(data_name, x_col_names, y_col_name, n_column_factors = 1, 
                                                      store_results = TRUE, drop = TRUE, na.rm = FALSE, 
                                                      summary_name = NA, include_margins = FALSE, return_output = TRUE, 
                                                      treat_columns_as_factor = FALSE, page_by = "default", as_html = TRUE, 
                                                      signif_fig = 2, na_display = "", na_level_display = "NA", 
                                                      weights = NULL, caption = NULL, result_names = NULL, 
                                                      percentage_type = "none", perc_total_columns = NULL, 
                                                      perc_total_factors = c(), perc_total_filter = NULL, 
                                                      perc_decimal = FALSE, margin_name = "(All)", 
                                                      additional_filter, ...) {
                            for(i in seq_along(x_col_names)) {
                              cat(x_col_names[i], "by", y_col_name, "\n")
                              print(data_book$summary_table(data_name = data_name, summaries = count_label, 
                                                            factors = c(x_col_names[i], y_col_name), 
                                                            n_column_factors = n_column_factors, 
                                                            store_results = store_results, drop = drop, 
                                                            na.rm = na.rm, summary_name = summary_name, 
                                                            include_margins = include_margins, 
                                                            return_output = return_output, 
                                                            treat_columns_as_factor = treat_columns_as_factor, 
                                                            page_by = page_by, as_html = as_html, 
                                                            signif_fig = signif_fig, na_display = na_display, 
                                                            na_level_display = na_level_display, weights = weights, 
                                                            caption = caption, result_names = result_names, 
                                                            percentage_type = percentage_type, 
                                                            perc_total_columns = perc_total_columns, 
                                                            perc_total_factors = perc_total_factors, 
                                                            perc_total_filter = perc_total_filter, 
                                                            perc_decimal = perc_decimal, margin_name = margin_name, 
                                                            additional_filter = additional_filter, ... = ...))
                              cat("\n")
                            }
                          },
                          
                          #' @description
                          #' Generate ANOVA tables for specified columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param x_col_names Names of columns for x-axis.
                          #' @param y_col_name Name of column for y-axis.
                          #' @param signif.stars Logical indicating if significance stars should be shown.
                          #' @param sign_level Logical indicating if significance level should be displayed.
                          #' @param means Logical indicating if means should be displayed.
                          anova_tables = function(data_name, x_col_names, y_col_name, signif.stars = FALSE, 
                                                  sign_level = FALSE, means = FALSE) {
                            self$get_data_objects(data_name)$anova_tables(x_col_names = x_col_names, 
                                                                          y_col_name = y_col_name, 
                                                                          signif.stars = signif.stars, 
                                                                          sign_level = sign_level, means = means)
                          },
                          
                          #' @description
                          #' Calculate correlation between specified columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param x_col_names Names of columns for x-axis.
                          #' @param y_col_name Name of column for y-axis.
                          #' @param use How to handle missing values.
                          #' @param method The method to use for correlation.
                          cor = function(data_name, x_col_names, y_col_name, use = "everything", 
                                         method = c("pearson", "kendall", "spearman")) {
                            self$get_data_objects(data_name)$cor(x_col_names = x_col_names, y_col_name = y_col_name, 
                                                                 use = use, method = method)
                          },
                          
                          #' @description
                          #' Remove specified columns from a data table.
                          #' @param data_name The name of the data table.
                          #' @param cols The columns to remove.
                          #' @param allow_delete_all Logical indicating if all columns can be deleted.
                          remove_columns_in_data = function(data_name, cols, allow_delete_all = FALSE) {
                            self$get_data_objects(data_name)$remove_columns_in_data(cols = cols, allow_delete_all = allow_delete_all)
                          },
                          
                          #' @description
                          #' Remove specified rows from a data table.
                          #' @param data_name The name of the data table.
                          #' @param row_names The names of the rows to remove.
                          remove_rows_in_data = function(data_name, row_names) {
                            self$get_data_objects(data_name)$remove_rows_in_data(row_names = row_names)
                          },
                          
                          #' @description
                          #' Get the next available default column name for a data table.
                          #' @param data_name The name of the data table.
                          #' @param prefix The prefix for the new column name.
                          #' @return The next available default column name.
                          get_next_default_column_name = function(data_name, prefix) {
                            if(missing(data_name)) {
                              out = list()
                              for(curr_obj in private$.data_sheets) {
                                out[[curr_obj$get_metadata(data_name_label)]] = curr_obj$get_next_default_column_name(prefix)
                              }
                              return(out)
                            }
                            if(!is.character(data_name)) stop("data_name must be of type character")
                            if(!data_name %in% names(private$.data_sheets)) stop("dataframe: ", data_name, " not found")
                            return(self$get_data_objects(data_name)$get_next_default_column_name(prefix))
                          },
                          
                          #' @description
                          #' Retrieve the column names of a data table.
                          #' @param data_name The name of the data table.
                          #' @param as_list A boolean indicating whether to return the names as a list.
                          #' @param include A list of column names to include.
                          #' @param exclude A list of column names to exclude.
                          #' @param excluded_items A vector of items to be excluded.
                          #' @param max_no The maximum number of column names to return.
                          #' @param use_current_column_selection A boolean indicating whether to use the current column selection.
                          get_column_names = function(data_name, as_list = FALSE, include = list(), exclude = list(), 
                                                      excluded_items = c(), max_no, use_current_column_selection = TRUE) {
                            if (missing(data_name)) {
                              # TODO: what to do with excluded items in this case?
                              return(lapply(self$get_data_objects(), function(x) x$get_column_names(include = include, exclude = exclude, max_no = max_no, use_current_column_selection = use_current_column_selection)))
                            } else {
                              return(self$get_data_objects(data_name)$get_column_names(as_list, include, exclude, excluded_items = excluded_items, max_no = max_no, use_current_column_selection = use_current_column_selection))
                            }
                          },
                          
                          #' @description
                          #' Reorder the columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param col_order A vector specifying the new order of columns.
                          reorder_columns_in_data = function(data_name, col_order) {
                            self$get_data_objects(data_name)$reorder_columns_in_data(col_order = col_order)
                          },
                          
                          #' @description
                          #' Insert rows into a data table.
                          #' @param data_name The name of the data table.
                          #' @param start_row The row number to start inserting at.
                          #' @param row_data A vector of data for the new row(s).
                          #' @param number_rows The number of rows to insert.
                          #' @param before A boolean indicating whether to insert before the start_row.
                          insert_row_in_data = function(data_name, start_row, row_data = c(), number_rows = 1, before = FALSE) {
                            self$get_data_objects(data_name)$insert_row_in_data(start_row = start_row, row_data = row_data, number_rows = number_rows, before = before)
                          },
                          
                          #' @description
                          #' Get the length of a data frame.
                          #' @param data_name The name of the data frame.
                          #' @param use_current_filter A boolean indicating whether to use the current filter.
                          get_data_frame_length = function(data_name, use_current_filter = FALSE) {
                            self$get_data_objects(data_name)$get_data_frame_length(use_current_filter)
                          },
                          
                          #' @description
                          #' Get the next default name for a data frame.
                          #' @param prefix The prefix for the new data frame name.
                          #' @param include_index A boolean indicating whether to include an index.
                          #' @param start_index The starting index for naming.
                          get_next_default_dataframe_name = function(prefix, include_index = TRUE, start_index = 1) {
                            instatExtras::next_default_item(prefix = prefix, existing_names = names(private$.data_sheets), include_index = include_index, start_index = start_index)
                          },
                          
                          #' @description
                          #' Delete specified data frames.
                          #' @param data_names A vector of data frame names to delete.
                          #' @param delete_graph_book A boolean indicating whether to delete the associated graph book.
                          delete_dataframes = function(data_names, delete_graph_book = TRUE) {
                            # TODO: need a set or append
                            for (name in data_names) {
                              private$.data_sheets[[name]] <- NULL
                              self$data_objects_changed <- TRUE
                              link_names <- c()
                              for (i in seq_along(private$.links)) {
                                if (private$.links[[i]]$from_data_frame == name || private$.links[[i]]$to_data_frame == name) {
                                  link_names <- c(link_names, names(private$.links)[i])
                                }
                              }
                              for (link_name in link_names) {
                                # TODO: Should we be able to disable links instead of deleting?
                                self$remove_link(link_name)
                              }
                              if (!is.null(private$.last_graph) && private$.last_graph[1] %in% data_names) private$.last_graph <- NULL
                            }
                            if (delete_graph_book && exists(".graph_data_book")) .graph_data_book$delete_dataframes(data_names = data_names, delete_graph_book = FALSE)
                          },
                          
                          #' @description
                          #' Remove a link by its name.
                          #' @param link_name The name of the link to remove.
                          remove_link = function(link_name) {
                            if (!link_name %in% names(private$.links)) stop(link_name, " not found.")
                            private$.links[[link_name]] <- NULL
                            cat("Link removed:", link_name)
                          },
                          
                          #' @description
                          #' Get the factor levels of a specified column in a data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column to check.
                          get_column_factor_levels = function(data_name, col_name = "") {
                            self$get_data_objects(data_name)$get_column_factor_levels(col_name)
                          },
                          
                          #' @description
                          #' Get the data frame for a specified factor column.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column to retrieve.
                          #' @param include_levels A boolean indicating whether to include levels.
                          #' @param include_NA_level A boolean indicating whether to include NA as a level.
                          get_factor_data_frame = function(data_name, col_name = "", include_levels = TRUE, include_NA_level = FALSE) {
                            self$get_data_objects(data_name)$get_factor_data_frame(col_name = col_name, include_levels = include_levels, include_NA_level = include_NA_level)
                          },
                          
                          #' @description
                          #' Sort a data frame by specified column(s).
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to sort by.
                          #' @param decreasing A boolean indicating whether to sort in decreasing order.
                          #' @param na.last A boolean indicating how to handle NA values.
                          #' @param by_row_names A boolean indicating whether to sort by row names.
                          #' @param row_names_as_numeric A boolean indicating whether row names should be treated as numeric.
                          sort_dataframe = function(data_name, col_names = c(), decreasing = FALSE, na.last = TRUE, by_row_names = FALSE, row_names_as_numeric = TRUE) {
                            self$get_data_objects(data_name)$sort_dataframe(col_names = col_names, decreasing = decreasing, na.last = na.last, by_row_names = by_row_names, row_names_as_numeric = row_names_as_numeric)
                          },
                          
                          #' @description
                          #' Rename a data frame and optionally update its label.
                          #' @param data_name The current name of the data frame.
                          #' @param new_value The new name for the data frame.
                          #' @param label An optional label for the data frame.
                          rename_dataframe = function(data_name, new_value = "", label = "") {
                            data_obj <- self$get_data_objects(data_name)
                            if (data_name != new_value) {
                              if (tolower(new_value) %in% tolower(names(private$.data_sheets)[-which(names(private$.data_sheets) == data_name)])) stop("Cannot rename data frame since ", new_value, " is an existing data frame.")
                              names(private$.data_sheets)[names(private$.data_sheets) == data_name] <- new_value
                              data_obj$append_to_metadata(data_name_label, new_value)
                              self$update_links_rename_data_frame(data_name, new_value)
                            }
                            if (label != "") {
                              data_obj$append_to_metadata(property = "label", new_val = label)
                            }
                            data_obj$set_data_changed(TRUE)
                            data_obj$set_metadata_changed(TRUE)
                            data_obj$set_variables_metadata_changed(TRUE)
                            if (exists(".graph_data_book")) .graph_data_book$rename_dataframe(data_name = data_name, new_value = new_value, label = label)
                          },
                          
                          #' @description
                          #' Convert specified columns to a different type.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to convert.
                          #' @param to_type The target data type.
                          #' @param factor_values Optional values for factors.
                          #' @param set_digits Number of digits to set.
                          #' @param set_decimals A boolean indicating whether to set decimals.
                          #' @param keep_attr A boolean indicating whether to keep attributes.
                          #' @param ignore_labels A boolean indicating whether to ignore labels.
                          #' @param keep.labels A boolean indicating whether to keep labels.
                          convert_column_to_type = function(data_name, col_names = c(), to_type, factor_values = NULL, set_digits, set_decimals = FALSE, keep_attr = TRUE, ignore_labels = FALSE, keep.labels = TRUE) {
                            self$get_data_objects(data_name)$convert_column_to_type(col_names = col_names, to_type = to_type, factor_values = factor_values, set_digits = set_digits, set_decimals = set_decimals, keep_attr = keep_attr, ignore_labels = ignore_labels, keep.labels = keep.labels)
                          },
                          
                          #' @description Appends a new property and its value to the metadata of specified columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to which the property should be appended.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @return None
                          append_to_variables_metadata  = function(data_name, col_names, property, new_val = "") {
                            self$get_data_objects(data_name)$append_to_variables_metadata(col_names, property, new_val)
                          },
                          
                          #' @description Appends a new property and its value to the metadata of a data table.
                          #' @param data_name The name of the data table.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @return None
                          append_to_dataframe_metadata  = function(data_name, property, new_val = "") {
                            self$get_data_objects(data_name)$append_to_metadata(property, new_val)
                          },
                          
                          #' @description Appends a new property and its value to the metadata of the current object.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @param allow_override_special Boolean flag to allow overriding special properties. Default is FALSE.
                          #' @return None
                          append_to_metadata  = function(property, new_val = "", allow_override_special = FALSE) {
                            if(missing(property)) stop("property and new_val arguments must be specified.")
                            if(!is.character(property)) stop("property must be of type character")
                            if(!allow_override_special && property %in% c("class")) message("Cannot override property: ", property, ". Specify allow_override_special = TRUE to replace this property.")
                            else {
                              attr(self, property) <- new_val
                              self$metadata_changed <- TRUE
                              self$append_to_changes(list(Added_metadata, property))
                            }
                          },
                          
                          #' @description Adds a new metadata field and its value to the specified data table or all data tables.
                          #' @param data_name The name of the data table. Use overall_label to apply to all data tables.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @return None
                          add_metadata_field  = function(data_name, property, new_val = "") {
                            if(missing(property)) stop("property and new_val arguments must be specified.")
                            if(data_name == overall_label) {
                              invisible(sapply(self$get_data_objects(), function(x) x$append_to_metadata(property, new_val)))
                            } else {
                              invisible(sapply(self$get_data_objects(data_name, as_list = TRUE), function(x) x$append_to_variables_metadata(property = property, new_val = new_val)))
                            }
                          },
                          
                          #' @description Reorders the dataframes in the object according to the specified order.
                          #' @param data_frames_order A vector specifying the new order of dataframes.
                          #' @return None
                          reorder_dataframes  = function(data_frames_order) {
                            if(length(data_frames_order) != length(names(private$.data_sheets))) stop("number data frames to order should be equal to number of dataframes in the object")
                            if(!setequal(data_frames_order, names(private$.data_sheets))) stop("data_frames_order must be a permutation of the dataframe names.")
                            self$set_data_objects(private$.data_sheets[data_frames_order])
                            self$data_objects_changed <- TRUE
                          },
                          
                          #' @description Copies specified columns from a data table to another location or clipboard.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to copy.
                          #' @param copy_to_clipboard Boolean flag to copy to clipboard. Default is FALSE.
                          #' @return None
                          copy_columns  = function(data_name, col_names = "", copy_to_clipboard = FALSE) {
                            if(copy_to_clipboard){
                              col_data_obj <- self$get_columns_from_data(data_name = data_name, col_names = col_names, force_as_data_frame = TRUE)
                              self$copy_to_clipboard(content = col_data_obj)
                            }else{
                              self$get_data_objects(data_name)$copy_columns(col_names = col_names)
                            }
                          },
                          
                          #' @description Drops unused levels from a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @return None
                          drop_unused_factor_levels  = function(data_name, col_name) {
                            self$get_data_objects(data_name)$drop_unused_factor_levels(col_name = col_name)
                          },
                          
                          #' @description Sets new levels for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_labels A vector of new labels for the factor levels.
                          #' @param new_levels A vector of new levels.
                          #' @param set_new_labels Boolean flag to set new labels. Default is TRUE.
                          #' @return None
                          set_factor_levels  = function(data_name, col_name, new_labels, new_levels, set_new_labels = TRUE) {
                            self$get_data_objects(data_name)$set_factor_levels(col_name = col_name, new_labels = new_labels, new_levels = new_levels, set_new_labels = set_new_labels)
                          },
                          
                          #' @description Edits a level in a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param old_level The old level to replace.
                          #' @param new_level The new level to set.
                          #' @return None
                          edit_factor_level  = function(data_name, col_name, old_level, new_level) {
                            self$get_data_objects(data_name)$edit_factor_level(col_name = col_name, old_level = old_level, new_level = new_level)
                          },
                          
                          #' @description Sets the reference level for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_ref_level The new reference level.
                          #' @return None
                          set_factor_reference_level  = function(data_name, col_name, new_ref_level) {
                            self$get_data_objects(data_name)$set_factor_reference_level(col_name = col_name, new_ref_level = new_ref_level)
                          },
                          
                          #' @description Returns the number of columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param use_column_selection Boolean flag to use column selection. Default is FALSE.
                          #' @return The number of columns.
                          get_column_count  = function(data_name, use_column_selection = FALSE) {
                            return(self$get_data_objects(data_name)$get_column_count(use_column_selection))
                          },
                          
                          #' @description Reorders the levels of a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_level_names A vector specifying the new order of factor levels.
                          #' @return None
                          reorder_factor_levels  = function(data_name, col_name, new_level_names) {
                            self$get_data_objects(data_name)$reorder_factor_levels(col_name = col_name, new_level_names = new_level_names)
                          },
                          
                          #' @description Returns the data type of the specified column in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @return The data type of the column.
                          get_data_type  = function(data_name, col_name) {
                            self$get_data_objects(data_name)$get_data_type(col_name = col_name)
                          },
                          
                          #' @description Copies a data frame to a new name or clipboard.
                          #' @param data_name The name of the data table.
                          #' @param new_name The new name for the copied data frame.
                          #' @param label A label for the new data frame. Default is an empty string.
                          #' @param copy_to_clipboard Boolean flag to copy to clipboard. Default is FALSE.
                          #' @return None
                          copy_data_frame  = function(data_name, new_name, label = "", copy_to_clipboard = FALSE) {
                            if(copy_to_clipboard){ 
                              self$copy_to_clipboard(content = self$get_data_frame(data_name))
                            }else{
                              if(new_name %in% names(private$.data_sheets)) stop("Cannot copy data frame since ", new_name, " is an existing data frame.")
                              curr_obj <- self$get_data_objects(data_name)$clone(deep = TRUE)
                              if(missing(new_name)) new_name <- instatExtras::next_default_item(data_name, self$get_data_names())
                              self$append_data_object(new_name, curr_obj)
                              new_data_obj <- self$get_data_objects(new_name)
                              new_data_obj$data_changed <- TRUE
                              new_data_obj$set_data_changed(TRUE)
                              if(label != "") {
                                new_data_obj$append_to_metadata(property = "label" , new_val = label)
                                new_data_obj$set_metadata_changed(TRUE)
                              }
                            }
                          },
                          
                          #' @description Copies the metadata of specified columns to the clipboard.
                          #' @param data_name The name of the data table.
                          #' @param property_names A vector of property names to copy. Default is all properties.
                          #' @return None
                          copy_col_metadata_to_clipboard  = function(data_name, property_names) {
                            if(missing(property_names)){
                              self$copy_to_clipboard(content = self$get_variables_metadata(data_name = data_name))
                            }else{
                              self$copy_to_clipboard(content = self$get_variables_metadata(data_name = data_name, property = property_names))
                            }
                          },
                          
                          #' @description Copies the metadata of the specified data table to the clipboard.
                          #' @param data_name The name of the data table.
                          #' @param property_names A vector of property names to copy. Default is all properties.
                          #' @return None
                          copy_data_frame_metadata_to_clipboard  = function(data_name, property_names) {
                            if(missing(property_names)){
                              self$copy_to_clipboard(content = self$get_data_frame_metadata(data_name = data_name))
                            }else{
                              self$copy_to_clipboard(content = self$get_data_frame_metadata(data_name = data_name, label = property_names))
                            }
                          },
                          
                          #' @description Copies the specified content to the clipboard.
                          #' @param content The content to copy to the clipboard.
                          #' @return None
                          copy_to_clipboard  = function(content) {
                            clipr::write_clip(content = content)
                          },
                          
                          #' @description Sets the specified columns as hidden in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to set as hidden.
                          #' @return None
                          set_hidden_columns  = function(data_name, col_names = c()) {
                            self$get_data_objects(data_name)$set_hidden_columns(col_names = col_names)
                          },
                          
                          #' @description Unhides all columns in the specified data table or all data tables if data_name is missing.
                          #' @param data_name The name of the data table. If missing, applies to all data tables.
                          #' @return None
                          unhide_all_columns  = function(data_name) {
                            if(missing(data_name)) {
                              invisible(sapply(self$get_data_objects(), function(obj) obj$unhide_all_columns()))
                            } else {
                              self$get_data_objects(data_name)$unhide_all_columns()
                            }
                          },
                          
                          #' @description Sets the specified data tables as hidden.
                          #' @param data_names A vector of data table names to set as hidden.
                          #' @return None
                          set_hidden_data_frames  = function(data_names = c()) {
                            invisible(sapply(data_names, function(x) self$append_to_dataframe_metadata(data_name = x, property = is_hidden_label, new_val = TRUE)))
                            unhide_data_names <- setdiff(self$get_data_names(), data_names)
                            invisible(sapply(unhide_data_names, function(x) self$append_to_dataframe_metadata(data_name = x, property = is_hidden_label, new_val = FALSE)))
                          },
                          
                          #' @description Returns a list of hidden data tables.
                          #' @return A vector of hidden data table names.
                          get_hidden_data_frames  = function() {
                            all_data_names <- names(private$.data_sheets)
                            visible_data_names <- all_data_names[sapply(all_data_names, function(x) !isTRUE(self$get_data_objects(x)$get_metadata(label = is_hidden_label)))]
                            hidden_data_names <- setdiff(all_data_names, visible_data_names)
                            return(hidden_data_names)
                          },
                          
                          #' @description Sets the row names for the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param row_names A vector of row names to set.
                          #' @return None
                          set_row_names  = function(data_name, row_names) {
                            self$get_data_objects(data_name)$set_row_names(row_names = row_names)
                          },
                          
                          #' @description Returns the row names of the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A vector of row names.
                          get_row_names  = function(data_name) {
                            self$get_data_objects(data_name)$get_row_names()
                          },
                          
                          #' @description Sets the specified columns as protected in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to set as protected.
                          #' @return None
                          set_protected_columns  = function(data_name, col_names) {
                            self$get_data_objects(data_name)$set_protected_columns(col_names = col_names)
                          },
                          
                          #' @description Returns the metadata fields of the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param include_overall Boolean flag to include overall metadata fields. Default is TRUE.
                          #' @param as_list Boolean flag to return the result as a list. Default is FALSE.
                          #' @param include A vector of metadata fields to include. Default is all fields.
                          #' @param exclude A vector of metadata fields to exclude. Default is none.
                          #' @param excluded_items A vector of metadata fields to exclude. Default is an empty vector.
                          #' @return A vector or list of metadata fields.
                          get_metadata_fields  = function(data_name, include_overall, as_list = FALSE, include, exclude, excluded_items = c()) {
                            if(!missing(data_name)) {
                              if(data_name == overall_label) {
                                out = names(self$get_combined_metadata())
                                if(length(excluded_items) > 0){
                                  ex_ind = which(out %in% excluded_items)
                                  if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of objects")
                                  if(length(ex_ind) > 0) out = out[-ex_ind]
                                }
                                if(as_list) {
                                  lst = list()
                                  lst[[data_name]] <- out
                                  return(lst)
                                }
                                else return(out)
                              } else {
                                return(self$get_data_objects(data_name)$get_variables_metadata_fields(as_list = as_list, include = include, exclude = exclude, excluded_items = excluded_items))
                              }
                            } else {
                              out = list()
                              if(include_overall) out[[overall_label]] <- names(self$get_combined_metadata())
                              for(data_obj_name in self$get_data_names()) {
                                out[[data_obj_name]] <- self$get_data_objects(data_obj_name)$get_variables_metadata_fields(as_list = FALSE, include = include, exclude = exclude)
                              }
                              return(out)
                            }
                          },
                          
                          #' @description Freezes the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param column A vector of column names to freeze.
                          #' @return None
                          freeze_columns  = function(data_name, column) {
                            self$get_data_objects(data_name)$freeze_columns(column = column)
                          },
                          
                          #' @description Unfreezes all columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return None
                          unfreeze_columns  = function(data_name) {
                            self$get_data_objects(data_name)$unfreeze_columns()
                          },
                          
                          #' @description Checks if the specified property is metadata for the given columns in the data table.
                          #' @param data_name The name of the data table.
                          #' @param property The name of the property to check.
                          #' @param column The name of the column.
                          #' @param return_vector Boolean flag to return the result as a vector. Default is FALSE.
                          #' @return A boolean value indicating if the property is metadata for the columns.
                          is_variables_metadata  = function(data_name, property, column, return_vector = FALSE) {
                            self$get_data_objects(data_name)$is_variables_metadata(property, column, return_vector)
                          },
                          
                          #' @description Checks if the specified data table exists.
                          #' @param data_name The name of the data table.
                          #' @return A boolean value indicating if the data table exists.
                          data_frame_exists  = function(data_name) {
                            return(data_name %in% names(private$.data_sheets))
                          },
                          
                          #' @description Adds a key to the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to add as keys.
                          #' @param key_name The name of the key.
                          #' @return None
                          add_key  = function(data_name, col_names, key_name) {
                            self$get_data_objects(data_name)$add_key(col_names, key_name)
                            names(col_names) <- col_names
                            self$add_link(data_name, data_name, col_names, keyed_link_label)
                            invisible(sapply(self$get_data_objects(), function(x) if(!x$is_metadata(is_linkable)) x$append_to_metadata(is_linkable, FALSE)))
                          },
                          
                          #' @description Checks if the specified columns are keys in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to check.
                          #' @return A boolean value indicating if the columns are keys.
                          is_key  = function(data_name, col_names) {
                            self$get_data_objects(data_name)$is_key(col_names)
                          },
                          
                          #' @description Checks if the specified data table has a key.
                          #' @param data_name The name of the data table.
                          #' @return A boolean value indicating if the data table has a key.
                          has_key  = function(data_name) {
                            self$get_data_objects(data_name)$has_key()
                          },
                          
                          #' @description Returns the keys of the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param key_name The name of the key. Default is all keys.
                          #' @return A list of keys.
                          get_keys  = function(data_name, key_name) {
                            self$get_data_objects(data_name)$get_keys(key_name)
                          },
                          
                          #' @description Adds a new comment to the specified row and column in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param row The name of the row.
                          #' @param column The name of the column.
                          #' @param comment The comment text.
                          #' @return None
                          add_new_comment  = function(data_name, row = "", column = "", comment) {
                            if (!self$has_key(data_name)) stop("A key must be defined in the data frame to add a comment. Use the Add Key dialog to define a key.")
                            if (!".comment" %in% self$get_data_names()) {
                              comment_df <- data.frame(sheet = character(0),
                                                       row = character(0),
                                                       column = character(0),
                                                       id = numeric(0),
                                                       comment = character(0),
                                                       time_stamp = as.POSIXct(c()))
                              self$import_data(data_tables = list(.comment = comment_df))
                              self$add_key(".comment", c("sheet", "row", "id"), "key1")
                            }
                            comment_df <- self$get_data_frame(".comment", use_current_filter = FALSE)
                            curr_df <- self$get_data_frame(data_name, use_current_filter = FALSE)
                            if(row != ""){
                              curr_row <- curr_df[row.names(curr_df) == row, ]
                              key <- self$get_keys(data_name)[[1]]
                              key_cols <- as.character(key)
                              key_vals <- paste(sapply(curr_row[, key_cols], as.character), collapse = "__")
                            } else {
                              key_vals <- ""
                            }
                            curr_comments <- comment_df[comment_df$sheet == data_name & comment_df$row == key_vals, ]
                            new_id <- 1
                            if (nrow(curr_comments) > 0) new_id <- max(curr_comments$id) + 1
                            comment_df[nrow(comment_df) + 1, ] <- list(sheet = data_name,
                                                                       row = key_vals,
                                                                       column = column,
                                                                       id = new_id,
                                                                       comment = comment,
                                                                       time_stamp = Sys.time())
                            self$get_data_objects(".comment")$set_data(new_data = comment_df)
                          },
                          
                          #' @description Returns the comments for the specified data table and comment ID.
                          #' @param data_name The name of the data table.
                          #' @param comment_id The ID of the comment.
                          #' @return A data frame of comments.
                          get_comments  = function(data_name, comment_id) {
                            self$get_data_objects(data_name)$get_comments(comment_id)
                          },
                          
                          #' @description Returns the links for the specified link name or all links.
                          #' @param link_name The name of the link. Default is all links.
                          #' @param ... Additional arguments passed to other methods.
                          #' @return A list of links.
                          get_links  = function(link_name, ...) {
                            if(!missing(link_name)) {
                              if(!link_name %in% names(private$.links)) stop(link_name, " not found.")
                              return(private$.links[[link_name]])
                            } else {
                              return(private$.links)
                            }
                          },
                          
                          #' @description Sets the structure columns for the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param struc_type_1 A vector of column names for the first structure type.
                          #' @param struc_type_2 A vector of column names for the second structure type.
                          #' @param struc_type_3 A vector of column names for the third structure type.
                          #' @return None
                          set_structure_columns  = function(data_name, struc_type_1 = c(), struc_type_2 = c(), struc_type_3 = c()) {
                            self$get_data_objects(data_name)$set_structure_columns(struc_type_1, struc_type_2, struc_type_3)
                          },
                          
                          #' @description Adds dependent columns to the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to add dependents to.
                          #' @param dependent_cols A vector of dependent column names.
                          #' @return None
                          add_dependent_columns  = function(data_name, columns, dependent_cols) {
                            self$get_data_objects(data_name)$add_dependent_columns(columns, dependent_cols)
                          },
                          
                          #' @description Sets the colours for the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to set colours for.
                          #' @param colours A vector of colours.
                          #' @return None
                          set_column_colours  = function(data_name, columns, colours) {
                            self$get_data_objects(data_name)$set_column_colours(columns, colours)
                          },
                          
                          #' @description Checks if the specified columns have colours in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to check.
                          #' @return A boolean value indicating if the columns have colours.
                          has_colours  = function(data_name, columns) {
                            self$get_data_objects(data_name)$has_colours(columns)
                          },
                          
                          #' @description Removes the colours from all columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return None
                          remove_column_colours  = function(data_name) {
                            self$get_data_objects(data_name)$remove_column_colours()
                          },
                          
                          #' @description Sets the colours for the specified columns based on metadata in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to set colours for.
                          #' @param property The metadata property to use for setting colours.
                          #' @return None
                          set_column_colours_by_metadata  = function(data_name, columns, property) {
                            self$get_data_objects(data_name)$set_column_colours_by_metadata(data_name, columns, property)
                          },
                          
                          #' @description Creates a graph for a single variable in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to graph.
                          #' @param numeric The type of graph for numeric columns. Default is "geom_boxplot".
                          #' @param categorical The type of graph for categorical columns. Default is "geom_bar".
                          #' @param character The type of graph for character columns. Default is "geom_bar".
                          #' @param output The output type for the graph. Default is "facets".
                          #' @param free_scale_axis Boolean flag to allow free scaling of axes. Default is FALSE.
                          #' @param ncol The number of columns in the output. Default is NULL.
                          #' @param coord_flip Boolean flag to flip coordinates. Default is FALSE.
                          #' @param ... Additional arguments passed to other methods.
                          #' @return None
                          graph_one_variable  = function(data_name, columns, numeric = "geom_boxplot", categorical = "geom_bar", character = "geom_bar", output = "facets", free_scale_axis = FALSE, ncol = NULL, coord_flip  = FALSE, ...) {
                            self$get_data_objects(data_name)$graph_one_variable(columns = columns, numeric = numeric, categorical = categorical, output = output, free_scale_axis = free_scale_axis, ncol = ncol, coord_flip = coord_flip, ... = ...)
                          },
                          
                          #' @description Creates a date column from year, month, and day columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param year The name of the year column.
                          #' @param month The name of the month column.
                          #' @param day The name of the day column.
                          #' @param f_year The format for the year column.
                          #' @param f_month The format for the month column.
                          #' @param f_day The format for the day column.
                          #' @param year_format The format for the year. Default is "%Y".
                          #' @param month_format The format for the month. Default is "%m".
                          #' @return None
                          make_date_yearmonthday  = function(data_name, year, month, day, f_year, f_month, f_day, year_format = "%Y", month_format = "%m") {
                            self$get_data_objects(data_name)$make_date_yearmonthday(year = year, month = month, day = day, f_year = f_year, f_month = f_month, f_day = f_day, year_format = year_format, month_format = month_format)
                          },
                          
                          #' @description Creates a date column from year and day of year columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param year The name of the year column.
                          #' @param doy The name of the day of year column.
                          #' @param base The base date for the day of year.
                          #' @param doy_typical_length The typical length of the day of year. Default is "366".
                          #' @return None
                          make_date_yeardoy  = function(data_name, year, doy, base, doy_typical_length = "366") {
                            self$get_data_objects(data_name)$make_date_yeardoy(year = year, doy = doy, base = base, doy_typical_length = doy_typical_length)
                          },
                          
                          #' @description Sets the contrasts for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_contrasts A vector of new contrasts.
                          #' @param defined_contr_matrix A defined contrast matrix.
                          #' @return None
                          set_contrasts_of_factor  = function(data_name, col_name, new_contrasts, defined_contr_matrix) {
                            self$get_data_objects(data_name)$set_contrasts_of_factor(col_name = col_name, new_contrasts = new_contrasts, defined_contr_matrix = defined_contr_matrix)
                          },
                          
                          #' @description Creates a new data frame for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param factor The name of the factor column.
                          #' @param factor_data_frame_name The name of the new data frame.
                          #' @param include_contrasts Boolean flag to include contrasts. Default is FALSE.
                          #' @param replace Boolean flag to replace the existing factor data frame. Default is FALSE.
                          #' @param summary_count Boolean flag to include summary count. Default is TRUE.
                          #' @return None
                          create_factor_data_frame  = function(data_name, factor, factor_data_frame_name, include_contrasts = FALSE, replace = FALSE, summary_count = TRUE) {
                            curr_data_obj <- self$get_data_objects(data_name)
                            if(!factor %in% names(curr_data_obj$get_data_frame())) stop(factor, " not found in the data")
                            if(!is.factor(curr_data_obj$get_columns_from_data(factor))) stop(factor, " is not a factor column.")
                            if(self$link_exists_from(data_name, factor)) {
                              message("Factor data frame already exists.")
                              if(replace) {
                                message("Current factor data frame will be replaced.")
                                factor_named <- factor
                                names(factor_named) <- factor
                                curr_factor_df_name <- self$get_linked_to_data_name(data_name, factor_named)
                                if(length(curr_factor_df_name) > 0) self$delete_dataframes(curr_factor_df_name[1])
                              } else {
                                warning("replace = FALSE so no action will be taken.")
                              }
                            }
                            data_frame_list <- list()
                            if(missing(factor_data_frame_name)) factor_data_frame_name <- paste0(data_name, "_", factor)
                            factor_data_frame_name <- make.names(factor_data_frame_name)
                            factor_data_frame_name <- instatExtras::next_default_item(factor_data_frame_name, self$get_data_names(), include_index = FALSE)
                            factor_column <- curr_data_obj$get_columns_from_data(factor)
                            factor_data_frame <- data.frame(levels(factor_column))
                            names(factor_data_frame) <- factor
                            if(include_contrasts) factor_data_frame <- cbind(factor_data_frame, contrasts(factor_column))
                            if(summary_count) factor_data_frame <- cbind(factor_data_frame, summary(factor_column))
                            row.names(factor_data_frame) <- 1:nrow(factor_data_frame)
                            names(factor_data_frame)[2:ncol(factor_data_frame)] <- paste0("C", 1:(ncol(factor_data_frame)-1))
                            if(summary_count) colnames(factor_data_frame)[ncol(factor_data_frame)] <- "Frequencies"
                            data_frame_list[[factor_data_frame_name]] <- factor_data_frame
                            self$import_data(data_frame_list)
                            factor_data_obj <- self$get_data_objects(factor_data_frame_name)
                            factor_data_obj$add_key(factor)
                            names(factor) <- factor
                            self$add_link(from_data_frame = data_name, to_data_frame = factor_data_frame_name, link_pairs = factor, type = keyed_link_label)
                          },
                          
                          #' @description Splits a date column into multiple date components in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the date column.
                          #' @param year_val Boolean flag to include year value. Default is FALSE.
                          #' @param year_name Boolean flag to include year name. Default is FALSE.
                          #' @param leap_year Boolean flag to include leap year. Default is FALSE.
                          #' @param month_val Boolean flag to include month value. Default is FALSE.
                          #' @param month_abbr Boolean flag to include month abbreviation. Default is FALSE.
                          #' @param month_name Boolean flag to include month name. Default is FALSE.
                          #' @param week_val Boolean flag to include week value. Default is FALSE.
                          #' @param week_abbr Boolean flag to include week abbreviation. Default is FALSE.
                          #' @param week_name Boolean flag to include week name. Default is FALSE.
                          #' @param weekday_val Boolean flag to include weekday value. Default is FALSE.
                          #' @param weekday_abbr Boolean flag to include weekday abbreviation. Default is FALSE.
                          #' @param weekday_name Boolean flag to include weekday name. Default is FALSE.
                          #' @param day Boolean flag to include day value. Default is FALSE.
                          #' @param day_in_month Boolean flag to include day in month. Default is FALSE.
                          #' @param day_in_year Boolean flag to include day in year. Default is FALSE.
                          #' @param day_in_year_366 Boolean flag to include day in year (366). Default is FALSE.
                          #' @param pentad_val Boolean flag to include pentad value. Default is FALSE.
                          #' @param pentad_abbr Boolean flag to include pentad abbreviation. Default is FALSE.
                          #' @param dekad_val Boolean flag to include dekad value. Default is FALSE.
                          #' @param dekad_abbr Boolean flag to include dekad abbreviation. Default is FALSE.
                          #' @param quarter_val Boolean flag to include quarter value. Default is FALSE.
                          #' @param quarter_abbr Boolean flag to include quarter abbreviation. Default is FALSE.
                          #' @param with_year Boolean flag to include with year. Default is FALSE.
                          #' @param s_start_month The start month. Default is 1.
                          #' @param s_start_day_in_month The start day in month. Default is 1.
                          #' @param days_in_month Boolean flag to include days in month. Default is FALSE.
                          #' @return None
                          split_date  = function(data_name, col_name = "", year_val = FALSE, year_name = FALSE, leap_year = FALSE,  month_val = FALSE, month_abbr = FALSE, month_name = FALSE, week_val = FALSE, week_abbr = FALSE, week_name = FALSE, weekday_val = FALSE, weekday_abbr = FALSE, weekday_name = FALSE,  day = FALSE, day_in_month = FALSE, day_in_year = FALSE, day_in_year_366 = FALSE, pentad_val = FALSE, pentad_abbr = FALSE, dekad_val = FALSE, dekad_abbr = FALSE, quarter_val = FALSE, quarter_abbr = FALSE, with_year = FALSE, s_start_month = 1, s_start_day_in_month = 1, days_in_month = FALSE) {
                            self$get_data_objects(data_name)$split_date(col_name = col_name , year_val = year_val, year_name = year_name, leap_year =  leap_year, month_val = month_val, month_abbr = month_abbr, month_name = month_name, week_val = week_val, week_abbr = week_abbr, week_name = week_name,  weekday_val = weekday_val, weekday_abbr = weekday_abbr,  weekday_name =  weekday_name, day = day,  day_in_month = day_in_month, day_in_year = day_in_year,   day_in_year_366 = day_in_year_366, pentad_val = pentad_val, pentad_abbr = pentad_abbr, dekad_val = dekad_val, dekad_abbr = dekad_abbr, quarter_val = quarter_val,  quarter_abbr = quarter_abbr, with_year = with_year, s_start_month = s_start_month, s_start_day_in_month = s_start_day_in_month, days_in_month = days_in_month)
                          },
                          
                          #' @description
                          #' Create an inventory plot based on the provided data.
                          #' @param data_name The name of the data table containing inventory data.
                          #' @param date_col The name of the column representing dates.
                          #' @param station_col Optional; the name of the column representing station identifiers.
                          #' @param year_col Optional; the name of the column representing years.
                          #' @param doy_col Optional; the name of the column representing day of the year.
                          #' @param element_cols Optional; a vector of column names representing different elements.
                          #' @param add_to_data Optional; a boolean indicating whether to add the plot to the existing data.
                          #' @param year_doy_plot Optional; a boolean indicating whether to plot by year and day of year.
                          #' @param coord_flip Optional; a boolean indicating whether to flip coordinates.
                          #' @param facet_by Optional; the variable to facet the plot by.
                          #' @param graph_title The title of the plot.
                          #' @param graph_subtitle Optional; the subtitle of the plot.
                          #' @param graph_caption Optional; the caption of the plot.
                          #' @param title_size Optional; the size of the title text.
                          #' @param subtitle_size Optional; the size of the subtitle text.
                          #' @param caption_size Optional; the size of the caption text.
                          #' @param labelXAxis Optional; the label for the x-axis.
                          #' @param labelYAxis Optional; the label for the y-axis.
                          #' @param xSize Optional; the size of the x-axis text.
                          #' @param ySize Optional; the size of the y-axis text.
                          #' @param Xangle Optional; the angle of the x-axis labels.
                          #' @param Yangle Optional; the angle of the y-axis labels.
                          #' @param scale_xdate Optional; a boolean indicating whether to scale x-axis by date.
                          #' @param fromXAxis Optional; the starting point for the x-axis.
                          #' @param toXAxis Optional; the ending point for the x-axis.
                          #' @param byXaxis Optional; the interval for the x-axis.
                          #' @param date_ylabels Optional; the labels for the y-axis dates.
                          #' @param legend_position Optional; the position of the legend.
                          #' @param xlabelsize Optional; the size of the x-axis label text.
                          #' @param ylabelsize Optional; the size of the y-axis label text.
                          #' @param scale Optional; scaling factor for the plot.
                          #' @param dir Optional; the directory to save the plot.
                          #' @param row_col_number The number of rows and columns for the plot layout.
                          #' @param nrow Optional; the number of rows for the plot layout.
                          #' @param ncol Optional; the number of columns for the plot layout.
                          #' @param key_colours A vector of colors for the keys in the plot.
                          #' @param display_rain_days Optional; a boolean indicating whether to display rain days.
                          #' @param facet_xsize Optional; the size of the x-axis facets.
                          #' @param facet_ysize Optional; the size of the y-axis facets.
                          #' @param facet_xangle Optional; the angle of the x-axis facet labels.
                          #' @param facet_yangle Optional; the angle of the y-axis facet labels.
                          #' @param scale_ydate Optional; a boolean indicating whether to scale y-axis by date.
                          #' @param date_ybreaks Optional; the breaks for y-axis dates.
                          #' @param step Optional; the step for the y-axis.
                          #' @param rain_cats A list defining categories for rainfall.
                          make_inventory_plot = function(data_name, date_col, station_col = NULL, year_col = NULL, doy_col = NULL, 
                                                         element_cols = NULL, add_to_data = FALSE, year_doy_plot = FALSE, 
                                                         coord_flip = FALSE, facet_by = NULL, graph_title = "Inventory Plot", 
                                                         graph_subtitle = NULL, graph_caption = NULL, title_size = NULL, 
                                                         subtitle_size = NULL, caption_size = NULL, labelXAxis, labelYAxis, 
                                                         xSize = NULL, ySize = NULL, Xangle = NULL, Yangle = NULL, 
                                                         scale_xdate, fromXAxis = NULL, toXAxis = NULL, byXaxis = NULL, 
                                                         date_ylabels, legend_position = NULL, xlabelsize = NULL, 
                                                         ylabelsize = NULL, scale = NULL, dir = "", row_col_number, 
                                                         nrow = NULL, ncol = NULL, key_colours = c("red", "grey"), 
                                                         display_rain_days = FALSE, facet_xsize = 9, facet_ysize = 9, 
                                                         facet_xangle = 90, facet_yangle = 90, scale_ydate = FALSE, 
                                                         date_ybreaks, step = 1, 
                                                         rain_cats = list(breaks = c(0, 0.85, Inf), 
                                                                          labels = c("Dry", "Rain"), 
                                                                          key_colours = c("tan3", "blue"))) {
                            self$get_data_objects(data_name)$make_inventory_plot(date_col = date_col, station_col = station_col, 
                                                                                 year_col = year_col, doy_col = doy_col, 
                                                                                 element_cols = element_cols, add_to_data = add_to_data, 
                                                                                 year_doy_plot = year_doy_plot, coord_flip = coord_flip, 
                                                                                 facet_by = facet_by, graph_title = graph_title, 
                                                                                 key_colours = key_colours, display_rain_days = display_rain_days, 
                                                                                 rain_cats = rain_cats, graph_subtitle = graph_subtitle, 
                                                                                 graph_caption = graph_caption, title_size = title_size, 
                                                                                 subtitle_size = subtitle_size, caption_size = caption_size, 
                                                                                 labelXAxis = labelXAxis, labelYAxis = labelYAxis, 
                                                                                 xSize = xSize, ySize = ySize, Xangle = Xangle, 
                                                                                 Yangle = Yangle, scale_xdate = scale_xdate, 
                                                                                 fromXAxis = fromXAxis, toXAxis = toXAxis, 
                                                                                 byXaxis = byXaxis, xlabelsize = xlabelsize, 
                                                                                 scale_ydate = scale_ydate, date_ybreaks = date_ybreaks, 
                                                                                 step = step, ylabelsize = ylabelsize, 
                                                                                 date_ylabels = date_ylabels, legend_position = legend_position, 
                                                                                 dir = dir, row_col_number = row_col_number, 
                                                                                 nrow = nrow, ncol = ncol, scale = scale, 
                                                                                 facet_xsize = facet_xsize, facet_ysize = facet_ysize, 
                                                                                 facet_xangle = facet_xangle, facet_yangle = facet_yangle)
                          },
                          
                          #' @description
                          #' Import NetCDF data and convert it into a data frame.
                          #' @param nc The NetCDF file object.
                          #' @param path Optional; the path to the NetCDF file.
                          #' @param name The name for the imported data table.
                          #' @param only_data_vars A boolean indicating whether to only include data variables.
                          #' @param keep_raw_time A boolean indicating whether to keep raw time data.
                          #' @param include_metadata A boolean indicating whether to include metadata.
                          #' @param boundary Optional; the boundary for the data.
                          #' @param lon_points Optional; specific longitude points to include.
                          #' @param lat_points Optional; specific latitude points to include.
                          #' @param id_points Optional; identifiers for the points to include.
                          #' @param show_requested_points A boolean indicating whether to show requested points.
                          #' @param great_circle_dist A boolean indicating whether to calculate great circle distances.
                          import_NetCDF = function(nc, path, name, only_data_vars = TRUE, keep_raw_time = TRUE, 
                                                   include_metadata = TRUE, boundary, lon_points = NULL, 
                                                   lat_points = NULL, id_points = NULL, show_requested_points = TRUE, 
                                                   great_circle_dist = FALSE) {
                            if (only_data_vars) {
                              all_var_names <- ncdf4.helpers::nc.get.variable.list(nc)
                            } else {
                              all_var_names <- names(nc$var)
                            }
                            remaining_var_names <- all_var_names
                            var_groups <- list()
                            dim_groups <- list()
                            
                            while (length(remaining_var_names) > 0) {
                              grp <- remaining_var_names[1]
                              dim_names <- ncdf4.helpers::nc.get.dim.names(nc, remaining_var_names[1])
                              dim_groups[[length(dim_groups) + 1]] <- dim_names
                              for (curr_var_name in remaining_var_names[-1]) {
                                if (setequal(ncdf4.helpers::nc.get.dim.names(nc, curr_var_name), dim_names)) {
                                  grp <- c(grp, curr_var_name)
                                }
                              }
                              remaining_var_names <- remaining_var_names[-which(remaining_var_names %in% grp)]
                              var_groups[[length(var_groups) + 1]] <- grp
                            }
                            
                            data_list <- list()
                            use_prefix <- (length(seq_along(var_groups)) > 1)
                            data_names <- c()
                            
                            for (i in seq_along(var_groups)) {
                              if (use_prefix) curr_name <- paste0(name, "_", i)
                              else curr_name <- name
                              
                              if (!missing(boundary)) curr_boundary <- boundary[names(boundary) %in% dim_groups[[i]]]
                              else curr_boundary <- NULL
                              
                              curr_name <- make.names(curr_name)
                              curr_name <- instatExtras::next_default_item(curr_name, self$get_data_names(), include_index = FALSE)
                              
                              if (!missing(path)) {
                                data_list[[curr_name]] <- instatExtras::multiple_nc_as_data_frame(path = path, vars = var_groups[[i]], 
                                                                                    keep_raw_time = keep_raw_time, 
                                                                                    include_metadata = include_metadata, 
                                                                                    boundary = curr_boundary, lon_points = lon_points, 
                                                                                    lat_points = lat_points, id_points = id_points, 
                                                                                    show_requested_points = show_requested_points, 
                                                                                    great_circle_dist = great_circle_dist)
                              } else {
                                data_list[[curr_name]] <- instatExtras::nc_as_data_frame(nc = nc, vars = var_groups[[i]], 
                                                                           keep_raw_time = keep_raw_time, 
                                                                           include_metadata = include_metadata, 
                                                                           boundary = curr_boundary, lon_points = lon_points, 
                                                                           lat_points = lat_points, id_points = id_points, 
                                                                           show_requested_points = show_requested_points, 
                                                                           great_circle_dist = great_circle_dist)
                              }
                              
                              tmp_list <- list()
                              tmp_list[[curr_name]] <- data_list[[curr_name]]
                              data_names <- c(data_names, curr_name)
                              self$import_data(data_tables = tmp_list)
                            }
                            
                            for (i in seq_along(data_names)) {
                              for (j in seq_along(data_names)) {
                                if (i != j && !self$link_exists_between(data_names[i], data_names[j]) && 
                                    all(dim_groups[[i]] %in% dim_groups[[j]])) {
                                  pairs <- dim_groups[[i]]
                                  names(pairs) <- pairs
                                  self$add_link(data_names[j], data_names[i], pairs, keyed_link_label)
                                }
                              }
                            }
                          },
                          
                          #' @description
                          #' Infill missing dates in the specified data.
                          #' @param data_name The name of the data table to process.
                          #' @param date_name The name of the column representing dates.
                          #' @param factors A vector of factors to use for infilling dates.
                          #' @param start_month The starting month for date infilling.
                          #' @param start_date The starting date for date infilling.
                          #' @param end_date The ending date for date infilling.
                          #' @param resort A boolean indicating whether to resort the data after infilling.
                          infill_missing_dates = function(data_name, date_name, factors, start_month, start_date, end_date, resort = TRUE) {
                            self$get_data_objects(data_name)$infill_missing_dates(date_name = date_name, factor = factors, 
                                                                                  start_month = start_month, start_date = start_date, 
                                                                                  end_date = end_date, resort = resort)
                          },
                          
                          #' @description
                          #' Retrieve key names from a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param include_overall A boolean indicating whether to include overall keys.
                          #' @param include A vector of specific keys to include.
                          #' @param exclude A vector of specific keys to exclude.
                          #' @param include_empty A boolean indicating whether to include empty keys.
                          #' @param as_list A boolean indicating whether to return the keys as a list.
                          #' @param excluded_items A vector of items to exclude from the results.
                          get_key_names = function(data_name, include_overall = TRUE, include, exclude, 
                                                   include_empty = FALSE, as_list = FALSE, 
                                                   excluded_items = c()) {
                            self$get_data_objects(data_name)$get_key_names(include_overall = include_overall, 
                                                                           include, exclude, include_empty = include_empty, 
                                                                           as_list = as_list, excluded_items = excluded_items)
                          },
                          
                          #' @description
                          #' Remove a specified key from a data table.
                          #' @param data_name The name of the data table.
                          #' @param key_name The name of the key to remove.
                          remove_key = function(data_name, key_name) {
                            self$get_data_objects(data_name)$remove_key(key_name = key_name)
                          },
                          
                          #' @description
                          #' Add climdex indices to a specified data table.
                          #' @param data_name The name of the data table.
                          #' @param climdex_output The output from climdex calculations.
                          #' @param freq A string indicating the frequency of the data ('annual' or 'monthly').
                          #' @param station The name of the station column (optional).
                          #' @param year The name of the year column.
                          #' @param month The name of the month column (optional for monthly frequency).
                          add_climdex_indices = function(data_name, climdex_output, freq = "annual", 
                                                         station, year, month) {
                            stopifnot(freq %in% c("annual", "monthly"))
                            if (missing(climdex_output)) stop("climdex_output is required.")
                            if (missing(year)) stop("year is required.")
                            if (freq == "monthly" && missing(month)) stop("month is required for freq = 'monthly'.")
                            
                            col_year <- self$get_columns_from_data(data_name = data_name, col_names = year)
                            if (!missing(station)) col_station <- self$get_columns_from_data(data_name = data_name, col_names = station)
                            if (freq == "monthly") col_month <- self$get_columns_from_data(data_name = data_name, col_names = month)
                            links_cols <- year
                            if (!missing(station)) links_cols <- c(station, links_cols)
                            if (freq == "monthly") links_cols <- c(links_cols, month)
                            linked_data_name <- self$get_linked_to_data_name(data_name, links_cols)
                            if (length(linked_data_name) == 0) {
                              # Class matching and data linking logic goes here...
                            } else {
                              # Handling existing linked data logic goes here...
                            }
                          },
                          
                          #' @description
                          #' Check if a specified string is part of the metadata for a data table.
                          #' @param data_name The name of the data table.
                          #' @param str The string to check in the metadata.
                          is_metadata = function(data_name, str) {
                            self$get_data_objects(data_name)$is_metadata(str = str)
                          },
                          
                          #' @description
                          #' Get the climatic column name from the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the climatic column to retrieve.
                          get_climatic_column_name = function(data_name, col_name) {
                            self$get_data_objects(data_name)$get_climatic_column_name(col_name = col_name)
                          },
                          
                          #' @description
                          #' Merge new data into the specified data table.
                          #' @param data_name The name of the existing data table.
                          #' @param new_data The new data to be merged.
                          #' @param by The column(s) to merge by.
                          #' @param type The type of merge (e.g., "left", "right", "inner").
                          #' @param match How to handle matches (e.g., "all" or "first").
                          merge_data = function(data_name, new_data, by = NULL, type = "left", match = "all") {
                            self$get_data_objects(data_name)$merge_data(new_data = new_data, by = by, type = type, match = match)
                          },
                          
                          #' @description
                          #' Retrieve names of data tables containing corruption data.
                          #' @return A vector of names of corruption data tables.
                          get_corruption_data_names = function() {
                            corruption_names <- c()
                            for(curr_name in self$get_data_names()) {
                              if(self$get_data_objects(curr_name)$is_metadata(corruption_data_label) && 
                                 self$get_data_objects(curr_name)$get_metadata(corruption_data_label)) {
                                corruption_names <- c(corruption_names, curr_name)
                              }
                            }
                            return(corruption_names)
                          },
                          
                          #' @description
                          #' Retrieve names of data tables containing corruption contract level data.
                          #' @return A vector of names of corruption contract data tables.
                          get_corruption_contract_data_names = function() {
                            corruption_names <- c()
                            for(curr_name in self$get_data_names()) {
                              if(self$get_data_objects(curr_name)$is_metadata(corruption_data_label) && 
                                 self$get_data_objects(curr_name)$get_metadata(corruption_data_label) == corruption_contract_level_label) {
                                corruption_names <- c(corruption_names, curr_name)
                              }
                            }
                            return(corruption_names)
                          },
                          
                          #' @description
                          #' Get variable names from a database based on a query.
                          #' @param query The SQL query to execute.
                          #' @param data_name The name of the data table.
                          #' @param include_overall A boolean indicating whether to include overall data.
                          #' @param include Additional items to include.
                          #' @param exclude Additional items to exclude.
                          #' @param include_empty A boolean indicating whether to include empty values.
                          #' @param as_list A boolean indicating whether to return results as a list.
                          #' @param excluded_items A vector of items to exclude from results.
                          #' @return A list or vector of variable names from the database.
                          get_database_variable_names = function(query, data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c()) {
                            if(self$has_database_connection()) {
                              temp_data <- DBI::dbGetQuery(self$get_database_connection(), query)
                              if(as_list) {
                                out <- list()
                                out[["database"]] <- temp_data[[1]]
                                return(out)
                              } else {
                                return(temp_data[[1]])
                              }
                            } else {
                              return(list())
                            }
                          },
                          
                          #' @description
                          #' Get variable names from a NetCDF file.
                          #' @param file The path to the NetCDF file.
                          #' @param as_list A boolean indicating whether to return results as a list.
                          #' @param ... Additional arguments passed to other methods.
                          #' @return A list or vector of variable names from the NetCDF file.
                          get_nc_variable_names = function(file = "", as_list = FALSE, ...) {
                            if(file == "") {
                              vars <- ""
                            } else {
                              nc_file <- nc_open(file)
                              vars <- names(nc_file$dim)
                            }
                            if(as_list) {
                              out <- list()
                              out[["dim variables"]] <- vars
                              return(out)
                            } else {
                              return(vars)
                            }
                          },
                          
                          #' @description
                          #' Check if there is an active database connection.
                          #' @return A boolean indicating whether a database connection exists.
                          has_database_connection = function() {
                            return(!is.null(self$get_database_connection()))
                          },
                          
                          #' @description
                          #' Establish a connection to a database.
                          #' @param dbname The name of the database.
                          #' @param user The username for database access.
                          #' @param host The host address of the database.
                          #' @param port The port number for database connection.
                          #' @param drv The database driver to use (default is MySQL).
                          database_connect = function(dbname, user, host, port, drv = RMySQL::MySQL()) {
                            password <- instatExtras::getPass(paste0(user, " password:"))
                            if(length(password) > 0) {
                              out <- DBI::dbConnect(drv = drv, dbname = dbname, user = user, password = password, host = host, port = port)
                              if(!is.null(out)) {
                                self$set_database_connection(out)
                              }
                            }
                          },
                          
                          #' @description
                          #' Retrieve the current database connection.
                          #' @return The active database connection object.
                          get_database_connection = function() {
                            return(private$.database_connection)
                          },
                          
                          #' @description
                          #' Set the database connection.
                          #' @param dbi_connection The database connection object to set.
                          set_database_connection = function(dbi_connection) {
                            private$.database_connection <- dbi_connection
                          },
                          
                          #' @description
                          #' Disconnect from the database if a connection exists.
                          database_disconnect = function() {
                            if(!is.null(self$get_database_connection())) {
                              DBI::dbDisconnect(private$.database_connection)
                              self$set_database_connection(NULL)
                            }
                          },
                          
                          #' @description
                          #' Get the row count of a specified table in the database.
                          #' @param tableName The name of the table to count rows in.
                          #' @param query_condition An optional SQL condition to filter the rows.
                          #' @return The count of rows in the table.
                          get_db_table_row_count = function(tableName, query_condition = NULL) {
                            con <- self$get_database_connection()
                            if(is.null(con)){
                              stop("No database connection")
                            }
                            
                            if(is.null(query_condition)){
                              query_condition <- ""
                            }
                            
                            out <- DBI::dbGetQuery(con, paste0("SELECT COUNT(*) as result FROM ",tableName," ", query_condition, ";" ))
                            return(out$result) 
                          },
                          
                          #' @description
                          #' Import Climsoft metadata, including stations, elements, and flags.
                          #' @param import_stations A boolean indicating whether to import station metadata.
                          #' @param import_elements A boolean indicating whether to import element metadata.
                          #' @param import_flags A boolean indicating whether to import flag metadata.
                          import_climsoft_metadata = function(import_stations = FALSE, import_elements = FALSE, import_flags = FALSE) {
                            if(!import_stations && !import_elements){
                              stop("No metadata selected for import")
                            }
                            
                            con <- self$get_database_connection()
                            if(is.null(con)){
                              stop("No database connection")
                            }
                            
                            #imports metadata
                            #--------------------------------
                            data_list <- list()
                            
                            if(import_stations){
                              # TODO.(22/03/2023) 2 fields have been intentionally left out because they are yet to be released to Climsoft users. Namely; wsi and gtsWSI
                              # include them once the new Climsoft release has been supplied to users
                              stations_df <- DBI::dbGetQuery(con, "SELECT stationId AS station_id, stationName AS station_name, wmoid, icaoid, latitude, longitude, elevation, qualifier, geoLocationMethod AS geo_location_method, geoLocationAccuracy AS geo_location_accuracy, openingDatetime AS opening_date_time, closingDatetime AS closing_date_time, wacaSelection AS waca_selection, cptSelection AS cpt_selection, stationOperational AS station_operational, drainageBasin AS drainage_basin, country AS country, authority, adminRegion AS admin_region_1, adminRegion2 AS admin_region_2, adminRegion3 AS admin_region_3, adminRegion4 AS admin_region_4 FROM station;")
                              
                              columns_to_convert <- c("station_id","station_name","qualifier", "station_operational", "drainage_basin", "country", "authority", "admin_region_1", "admin_region_2", "admin_region_3", "admin_region_4")
                              stations_df[columns_to_convert] <- lapply(stations_df[columns_to_convert], as.factor)
                              
                              stations_df_name <- instatExtras::next_default_item("stations_metadata", self$get_data_names(), include_index = FALSE)
                              data_list[[stations_df_name]] <- stations_df
                            }
                            
                            if(import_elements){
                              elements_df <- DBI::dbGetQuery(con, "SELECT elementId AS element_id, elementName AS element_name, abbreviation, description, elementtype AS element_type, upperLimit AS upper_limit , lowerLimit AS lower_limit, units FROM obselement;")
                              
                              columns_to_convert <- c("element_id","element_name","abbreviation","element_type")
                              elements_df[columns_to_convert] <- lapply(elements_df[columns_to_convert], as.factor)
                              
                              elements_df_name <- instatExtras::next_default_item("elements_metadata", self$get_data_names(), include_index = FALSE)
                              data_list[[elements_df_name]] <- elements_df
                            }
                            
                            if(import_flags){
                              flags_df <- DBI::dbGetQuery(con, "SELECT characterSymbol AS flag_name, description FROM flags;")
                              
                              flags_df$flag_name <- as.factor(flags_df$flag_name) 
                              
                              flags_df_name <- instatExtras::next_default_item("flags_metadata", self$get_data_names(), include_index = FALSE)
                              data_list[[flags_df_name]] <- flags_df
                            }
                            
                            # Import the data frames into the data book
                            self$import_data(data_tables = data_list)
                          },
                          
                          #' @description
                          #' Imports data from Climsoft observation tables, either initial or final.
                          #' This function also imports selected stations and elements metadata.
                          #' @param tableName The name of the Climsoft observation table.
                          #' @param station_filter_column The column name used to filter stations.
                          #' @param stations A vector of station identifiers to filter the data.
                          #' @param element_filter_column The column name used to filter elements.
                          #' @param elements A vector of element identifiers to filter the data.
                          #' @param qc_status A numeric status for quality control filtering; default is -1 (no filter).
                          #' @param start_date Optional; start date for filtering observations.
                          #' @param end_date Optional; end date for filtering observations.
                          #' @param unstack_data A boolean indicating whether to unstack the data.
                          #' @param include_element_id A boolean indicating whether to include element IDs in the output.
                          #' @param include_element_name A boolean indicating whether to include element names in the output.
                          #' @param include_acquisition_type A boolean indicating whether to include acquisition type in the output.
                          #' @param include_level A boolean indicating whether to include observation level in the output.
                          #' @param include_entry_form A boolean indicating whether to include entry form in the output.
                          #' @param include_captured_by A boolean indicating whether to include the name of the person who captured the data.
                          #' @param include_qc_status A boolean indicating whether to include quality control status in the output.
                          #' @param include_qc_log A boolean indicating whether to include the quality control log in the output.
                          #' @param include_flag A boolean indicating whether to include flags in the output.
                          #' @param import_selected_stations_metadata A boolean indicating whether to import metadata for selected stations.
                          #' @param import_selected_elements_metadata A boolean indicating whether to import metadata for selected elements.
                          import_climsoft_data = function(tableName,
                                                          station_filter_column, stations = c(), 
                                                          element_filter_column, elements = c(),
                                                          qc_status = -1, start_date = NULL, end_date = NULL, 
                                                          unstack_data = FALSE,
                                                          include_element_id = FALSE, include_element_name = FALSE, 
                                                          include_acquisition_type = FALSE, include_level = FALSE, 
                                                          include_entry_form = FALSE, include_captured_by = FALSE, 
                                                          include_qc_status = FALSE, include_qc_log = FALSE, 
                                                          include_flag = FALSE, 
                                                          import_selected_stations_metadata = FALSE, 
                                                          import_selected_elements_metadata = FALSE) {
                            
                            #connection and parameter checks
                            #--------------------------------
                            con <- self$get_database_connection()
                            if(is.null(con)){
                              stop("No database connection")
                            }
                            
                            if(missing(tableName) || missing(station_filter_column) || missing(element_filter_column) || length(stations) == 0  || length(elements) == 0){
                              stop("Missing parameters. tableName, station_filter_column, element_filter_column, stations and elements must be supplied")
                            }
                            
                            if (!is.null(start_date) && !lubridate::is.Date(start_date) ) {
                              stop("start_date must be of type Date.")
                            }
                            
                            if (!is.null(end_date) && !lubridate::is.Date(end_date) ) {
                              stop("start_date must be of type Date.")
                            }
                            #--------------------------------
                            
                            #selects
                            #--------------------------------
                            
                            sql_select<- paste0(tableName,".recordedFrom AS station_id",", station.stationName AS station_name") 
                            
                            if(include_element_id){
                              sql_select <-paste0(sql_select, ", ", tableName,".describedBy AS element_id") 
                            }
                            
                            sql_select <-paste0(sql_select,", obselement.abbreviation AS element_abbrv")
                            
                            if(include_element_name){
                              sql_select <-paste0(sql_select,", obselement.elementName AS element_name")
                            }
                            
                            if(include_acquisition_type){
                              sql_select <-paste0(sql_select,", ", tableName,".acquisitionType"," AS acquisition_type") 
                            }
                            
                            if(include_level){
                              sql_select <-paste0(sql_select,", ", tableName,".obsLevel"," AS level") 
                            }
                            
                            if(include_entry_form){
                              sql_select <-paste0(sql_select,", ", tableName,".dataForm"," AS entry_form") 
                            }
                            
                            if(include_captured_by){
                              sql_select <-paste0(sql_select,", ", tableName,".capturedBy"," AS captured_by") 
                            }
                            
                            if(include_qc_status){
                              sql_select <-paste0(sql_select,", ", tableName,".qcStatus"," AS qc_status") 
                            }
                            
                            sql_select <-paste0(sql_select,", ", tableName,".obsDatetime AS date_time") 
                            sql_select <-paste0(sql_select,", DATE(", tableName,".obsDatetime) AS date") 
                            
                            if(include_qc_log){
                              sql_select <-paste0(sql_select,", ", tableName,".qcTypeLog"," AS qc_log") 
                            }
                            
                            if(include_flag){
                              sql_select <-paste0(sql_select,", ", tableName,".flag"," AS flag") 
                            }
                            
                            sql_select <-paste0(sql_select,", ", tableName,".obsValue AS value") 
                            
                            sql_select<- paste0("SELECT ", sql_select, " FROM ", tableName,
                                                " INNER JOIN station ON ", tableName, ".recordedFrom = station.stationId",
                                                " INNER JOIN obselement ON ",tableName,".describedBy = obselement.elementId")
                            #--------------------------------
                            
                            #filters
                            #--------------------------------
                            stations <- gsub("'", "''", stations) # Escape any apostrophes
                            elements <- gsub("'", "''", elements) # Escape any apostrophes
                            sql_stations_filter <- paste0(" station.", station_filter_column, " IN ", paste0("(", paste0("'", stations, "'", collapse =  ", "), ")"))
                            sql_elements_filter <- paste0(" obselement.", element_filter_column, " IN ", paste0("(", paste0("'", elements, "'", collapse =  ", "), ")"))
                            
                            sql_filter <- sql_stations_filter
                            sql_filter <- paste0(sql_filter," AND ",sql_elements_filter)
                            
                            if(qc_status>-1){
                              sql_filter <- paste0(sql_filter," AND qcStatus = ", qc_status)
                            }
                            
                            if (!is.null(start_date)) {
                              sql_filter = paste0(sql_filter," AND obsDatetime >= ", sQuote(format(start_date, format = "%Y-%m-%d")))
                            }
                            
                            if (!is.null(end_date)) {
                              sql_filter <- paste0(sql_filter," AND obsDatetime <=", sQuote(format(end_date, format = "%Y-%m-%d")))
                            }
                            
                            sql_filter<- paste0(" WHERE ",sql_filter)
                            #--------------------------------
                            
                            #order by
                            #--------------------------------
                            sql_order_by <- paste0(" ORDER BY ",tableName,".recordedFrom, ",tableName, ".describedBy, ",tableName, ".obsDatetime",";")
                            #--------------------------------
                            
                            # Data list to store all the imported data frames
                            data_list <- list()
                            
                            #import metadata
                            #--------------------------------
                            
                            if(import_selected_stations_metadata){
                              stations_metadata_name <- instatExtras::next_default_item("stations_metadata", self$get_data_names(), include_index = FALSE)
                              data_list[[stations_metadata_name]] <- DBI::dbGetQuery(con, paste0("SELECT * FROM station WHERE ", sql_stations_filter))
                            }
                            
                            if(import_selected_elements_metadata){
                              elements_metadata_name <- instatExtras::next_default_item("elements_metadata", self$get_data_names(), include_index = FALSE)
                              data_list[[elements_metadata_name]] <- DBI::dbGetQuery(con, paste0("SELECT * FROM obselement WHERE ", sql_elements_filter))
                            }
                            
                            #--------------------------------
                            
                            # import and transform observations data data
                            # --------------------------------
                            
                            # Get observations data from database
                            observations_df <- DBI::dbGetQuery(con, paste0(sql_select, sql_filter, sql_order_by))
                            
                            # Convert station name and abbreviation columns to factor
                            columns_to_convert <- c("station_id", "station_name", "element_abbrv")
                            observations_df[columns_to_convert] <- lapply(observations_df[columns_to_convert], as.factor)
                            
                            # Convert the date_time column to POSIXct (date-time) format
                            observations_df$date_time <- as.POSIXct(observations_df$date_time, format = "%Y-%m-%d %H:%M:%S")
                            
                            # convert the date column to date format
                            observations_df$date <- as.Date(x = observations_df$date)
                            
                            if(include_element_id){
                              observations_df$element_id <- as.factor(observations_df$element_id)
                            }
                            
                            if(include_element_name){
                              observations_df$element_name <- as.factor(observations_df$element_name)
                            }
                            
                            if(include_qc_status){
                              observations_df$qc_status <- as.factor(observations_df$qc_status)
                            }
                            
                            if(include_acquisition_type){
                              observations_df$acquisition_type <- as.factor(observations_df$acquisition_type)
                            }
                            
                            if(include_level){
                              observations_df$level <- as.factor(observations_df$level)
                            }
                            
                            if(include_flag){
                              observations_df$flag <- as.factor(observations_df$flag)
                            }
                            
                            if(include_entry_form){
                              observations_df$entry_form <- as.factor(observations_df$entry_form)
                            }
                            
                            #--------------------------------
                            
                            # Add observations data to list of data to be imported
                            # --------------------------------
                            observations_data_name <- instatExtras::next_default_item("observations_data", self$get_data_names(), include_index = FALSE)
                            data_list[[observations_data_name]] <- observations_df
                            
                            if(unstack_data){
                              observations_unstacked_data_name <- instatExtras::next_default_item("observations_unstacked_data", self$get_data_names(), include_index = FALSE)
                              data_list[[observations_unstacked_data_name]] <- tidyr::pivot_wider(data = observations_df, names_from=element_abbrv, values_from=value)
                            }
                            
                            # Import list of data frames to data book
                            self$import_data(data_tables = data_list)
                          },
                          
                          #' @description
                          #' Export the current workspace to a file, including optional components.
                          #' @param data_names Names of the data frames to export.
                          #' @param file Destination file to save the workspace.
                          #' @param include_graphs Whether to include graphs (default is TRUE).
                          #' @param include_models Whether to include models (default is TRUE).
                          #' @param include_metadata Whether to include metadata (default is TRUE).
                          export_workspace = function(data_names, file, include_graphs = TRUE, include_models = TRUE, include_metadata = TRUE) {
                            e <- new.env()
                            for(temp_name in data_names) {
                              e[[temp_name]] <- self$get_data_frame(temp_name, use_current_filter = FALSE)
                              if(include_graphs) {
                                graphs <- self$get_objects(data_name = temp_name, object_type_label = "graph")
                                graph_names <- names(graphs)
                                for(i in seq_along(graphs)) {
                                  e[[paste(temp_name, graph_names[i], sep = "_")]] <- graphs[[i]]
                                }
                              }
                              if(include_models) {
                                models <- self$get_objects(data_name = temp_name, object_type_label = "model")
                                model_names <- names(models)
                                for(i in seq_along(models)) {
                                  e[[paste(temp_name, model_names[i], sep = "_")]] <- models[[i]]
                                }
                              }
                              if(include_metadata) {
                                var_metadata <- self$get_variables_metadata(temp_name)
                                e[[paste(temp_name, "variables_metadata", sep = "_")]] <- var_metadata
                              }
                            }
                            save(list = ls(all.names = TRUE, envir = e), envir = e, file = file)
                          },
                          
                          #' @description
                          #' Set new links in the data structure.
                          #' @param new_links A list of new links to be set.
                          set_links = function(new_links) {
                            private$.links <- new_links
                          },
                          
                          #' @description
                          #' Display a daily graph for specified climatic elements.
                          #' @param data_name Name of the data frame containing the data.
                          #' @param date_col Column name for the date.
                          #' @param station_col Column name for the station (optional).
                          #' @param year_col Column name for the year (optional).
                          #' @param doy_col Column name for the day of the year (optional).
                          #' @param climatic_element Name of the climatic element to display (optional).
                          #' @param upper_limit Maximum value for the graph (default is 100).
                          #' @param bar_colour Color for the bars in the graph (default is "blue").
                          #' @param rug_colour Color for the rug plot (default is "red").
                          display_daily_graph = function(data_name, date_col = NULL, station_col = NULL, year_col = NULL, doy_col = NULL, climatic_element = NULL, upper_limit = 100, bar_colour = "blue", rug_colour = "red") {
                            self$get_data_objects(data_name)$display_daily_graph(date_col = date_col, station_col = station_col, year_col = year_col, doy_col = doy_col, climatic_element = climatic_element, rug_colour = rug_colour, bar_colour = bar_colour, upper_limit = upper_limit)
                          },
                          
                          #' @description
                          #' Create a set of variables from specified columns in the data frame.
                          #' @param data_name Name of the data frame.
                          #' @param set_name Name for the new variable set.
                          #' @param columns Vector of column names to include in the set.
                          create_variable_set = function(data_name, set_name, columns) {
                            self$get_data_objects(data_name)$create_variable_set(set_name = set_name, columns = columns)
                          },
                          
                          #' @description
                          #' Update an existing variable set with new columns.
                          #' @param data_name Name of the data frame.
                          #' @param set_name Name of the variable set to update.
                          #' @param columns Vector of new column names to include.
                          #' @param new_set_name New name for the updated variable set.
                          update_variable_set = function(data_name, set_name, columns, new_set_name) {
                            self$get_data_objects(data_name)$update_variable_set(set_name = set_name, columns = columns, new_set_name = new_set_name)
                          },
                          
                          #' @description
                          #' Delete specified variable sets from the data frame.
                          #' @param data_name Name of the data frame.
                          #' @param set_names Vector of names of variable sets to delete.
                          delete_variable_sets = function(data_name, set_names) {
                            self$get_data_objects(data_name)$delete_variable_sets(set_names = set_names)
                          },
                          
                          #' @description
                          #' Retrieve the names of variable sets in the data frame.
                          #' @param data_name Name of the data frame.
                          #' @param include_overall Whether to include overall set (default is TRUE).
                          #' @param include Additional filters for inclusion.
                          #' @param exclude Exclusion filters.
                          #' @param include_empty Whether to include empty sets (default is FALSE).
                          #' @param as_list Whether to return as a list (default is FALSE).
                          #' @param excluded_items Items to exclude from the results.
                          get_variable_sets_names = function(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c()) {
                            self$get_data_objects(data_name)$get_variable_sets_names(include_overall = include_overall, include = include, exclude = exclude, include_empty = include_empty, as_list = as_list, excluded_items = excluded_items)
                          },
                          
                          #' @description
                          #' Get specific variable sets from the data frame.
                          #' @param data_name Name of the data frame.
                          #' @param set_names Names of the variable sets to retrieve.
                          #' @param force_as_list Whether to force the result as a list (default is FALSE).
                          get_variable_sets = function(data_name, set_names, force_as_list = FALSE) {
                            self$get_data_objects(data_name)$get_variable_sets(set_names = set_names, force_as_list = force_as_list)
                          },
                          
                          #' @description
                          #' Define crop conditions and create a new crop definition data frame.
                          #' @param data_name Name of the data frame containing the data.
                          #' @param year Name of the column representing the year.
                          #' @param station Name of the column for the station (optional).
                          #' @param rain Name of the column containing rainfall data.
                          #' @param day Name of the column containing day data.
                          #' @param rain_totals Column name for rain totals.
                          #' @param plant_days Column name for planting days.
                          #' @param plant_lengths Column name for planting lengths.
                          #' @param start_check Boolean indicating whether to check start day (default is TRUE).
                          #' @param season_data_name Name of the season data frame (optional).
                          #' @param start_day Column name for the start day.
                          #' @param end_day Column name for the end day.
                          #' @param return_crops_table Boolean indicating whether to return the full crops table (default is TRUE).
                          #' @param definition_props Boolean indicating whether to calculate properties (default is TRUE).
                          #' @param print_table Boolean indicating whether to print the table (default is TRUE).
                          crops_definitions = function(data_name, year, station, rain, day, rain_totals, plant_days, plant_lengths, start_check = c("both", "yes", "no"), season_data_name, start_day, end_day, return_crops_table = TRUE, definition_props = TRUE) {
                            
                            # Run checks
                            is_station <- !missing(station)
                            start_check <- match.arg(start_check)
                            
                            if(missing(year)) stop("Year column must be specified.")
                            if(!is_station) by <- year
                            else by <- c(year, station)
                            if(missing(season_data_name)) season_data_name <- data_name
                            if(season_data_name != data_name) {
                              season_by <- self$get_equivalent_columns(from_data_name = data_name, columns = by, to_data_name = season_data_name)
                              if(is.null(season_by)) stop("The data frames specified must be linked by the year/station columns.")
                            }
                            year_col <- self$get_columns_from_data(data_name, year)
                            unique_year <- na.omit(unique(year_col))
                            
                            # creating our combinations
                            # if there's a station, we only want to consider the year-station combinations that actually exist
                            if(is_station) {
                              expanded_df <- unique(self$get_data_frame(data_name) %>% dplyr::select(year, station))
                            } else {
                              expanded_df <- unique(self$get_data_frame(data_name) %>% dplyr::select(year))  
                            }
                            
                            # Set names
                            plant_day_name <- "plant_day"
                            plant_length_name <- "plant_length"
                            rain_total_name <- "rain_total"
                            
                            # Create all combinations of X and Y
                            condition_combinations <- expand.grid(rain_totals, plant_lengths, plant_days)
                            names_list <- c(rain_total_name, plant_length_name, plant_day_name)
                            condition_combinations <- setNames(condition_combinations, names_list)
                            
                            # Expand the df with xy_combinations
                            df <- merge(expanded_df, condition_combinations, by = NULL)
                            daily_data <- self$get_data_frame(data_name)
                            
                            if(season_data_name != data_name) {
                              join_by <- by
                              names(join_by) <- season_by
                              season_data <- self$get_data_frame(season_data_name)
                              vars <- c(season_by, start_day, end_day)
                              season_data <- season_data %>% dplyr::select(!!! rlang::syms(vars))
                              df <- dplyr::left_join(df, season_data, by = join_by)
                            } else {
                              col_names <- c(by, start_day, end_day)
                              season_data <- daily_data %>% 
                                dplyr::select(!!! rlang::syms(col_names)) %>%
                                dplyr::group_by(!!! rlang::syms(by)) %>%
                                dplyr::summarise(!! rlang::sym(start_day) := dplyr::first(!! rlang::sym(start_day)),
                                                 !! rlang::sym(end_day) := dplyr::first(!! rlang::sym(end_day)))
                              df <- dplyr::left_join(df, season_data, by = by)
                            }
                            
                            ## Onto the calculation
                            proportion_df <- NULL
                            crops_def_table <- NULL
                            i <- 1
                            
                            calculate_rain_condition <- function(data){
                              data <- data %>% dplyr::select(-rain_total_name) %>% unique()
                              
                              for (i in 1:nrow(data)) {
                                # Create a condition to filter the daily data based on the year, day, and plant day/length
                                ind <- daily_data[[year]] == data[[year]][i] &
                                  daily_data[[day]] >= data[[plant_day_name]][i] &
                                  daily_data[[day]] < (data[[plant_day_name]][i] + data[[plant_length_name]][i])
                                
                                if (is_station) {
                                  ind <- ind & (daily_data[[station]] == data[[station]][i])
                                }
                                
                                # Filter the daily data based on the condition
                                rain_values <- daily_data[[rain]][ind]
                                
                                # Calculate the sum of rain values and check conditions
                                sum_rain <- sum(rain_values, na.rm = TRUE)
                                
                                # Set as NA for certain cases: This anyNA is fixed later when we have the total_rainfall value of interest
                                if (anyNA(rain_values))  sum_rain <- -1 * sum_rain # as a way to tag the sum_rain value for later, we set as -ve value. 
                                #&& sum_rain < data[[rain_total_name]][i]){
                                if (length(rain_values) + 1 < data[[plant_length_name]][i]) sum_rain <- NA
                                if (all(is.na(rain_values))) sum_rain <- NA
                                
                                # Assign the calculated sum to the respective row in the result dataframe
                                data[["rain_total_actual"]][i] <- sum_rain
                              }
                              return(data)
                            }
                            
                            # run by plant day and plant_length
                            for (day_i in plant_days){
                              for (length_i in plant_lengths){
                                
                                # for each plant length and plant day combination, calculate the total rainfall in that period.
                                filtered_data_1 <- df %>% filter(plant_day == day_i) %>% filter(plant_length == length_i)
                                
                                # Now run to get the rain conditions
                                filtered_data_1 <- calculate_rain_condition(data = filtered_data_1)
                                
                                # so: filtered_data_1 contains the total rainfall that occurred in that period for all the plant_day and plant_length combinations
                                # we now split by our different rain_total_actual conditions.
                                # we do this here to avoid calculating it multiple times.
                                for (rain_i in rain_totals){
                                  filtered_data <- filtered_data_1 %>% dplyr::mutate(rain_total = rain_i)
                                  
                                  # take the rows < 0 and run a check. We want to check 
                                  # if (anyNA(rain_values) && sum_rain < data[[rain_total_name]][i]) { sum_rain <- NA 
                                  # we do this here because we want to avoid running rain_total in calculate_rain_condition for efficiency purposes.
                                  filtered_data <- filtered_data %>%
                                    dplyr::mutate(rain_total_actual = ifelse(rain_total_actual < 0, ifelse(-1*rain_total_actual < rain_total, NA, -1*rain_total_actual), rain_total_actual))
                                  
                                  if (!missing(station)) filtered_data <- filtered_data %>% dplyr::group_by(.data[[station]], .data[[year]])
                                  else filtered_data <- filtered_data %>% dplyr::group_by(.data[[year]])
                                  
                                  filtered_data <- filtered_data %>%
                                    # first add a column (T/F) that states that it is in the rainfall period or not. 
                                    dplyr::mutate(plant_day_cond = .data[[start_day]] <= plant_day,
                                                  length_cond = plant_day + plant_length <= .data[[end_day]],
                                                  rain_cond = rain_i <= rain_total_actual) %>%
                                    dplyr::ungroup()
                                  
                                  if (start_check == "both"){
                                    
                                    filtered_data <- filtered_data %>%
                                      dplyr::mutate(
                                        overall_cond_with_start = plant_day_cond & length_cond & rain_cond,
                                        overall_cond_no_start = length_cond & rain_cond)
                                    if (!missing(station)) filtered_data <- filtered_data %>% dplyr::group_by(.data[[station]])
                                    proportion_data <- filtered_data %>%
                                      dplyr::summarise(prop_success_with_start = sum(overall_cond_with_start, na.rm = TRUE)/length(na.omit(overall_cond_with_start)),
                                                       prop_success_no_start = sum(overall_cond_no_start, na.rm = TRUE)/length(na.omit(overall_cond_no_start)))
                                  } else {
                                    filtered_data <- filtered_data %>%
                                      dplyr::mutate(
                                        overall_cond = case_when(
                                          start_check == "yes" ~ plant_day_cond & length_cond & rain_cond,
                                          start_check == "no" ~ TRUE & length_cond & rain_cond)
                                      )
                                    if (!missing(station)) filtered_data <- filtered_data %>% dplyr::group_by(.data[[station]])
                                    proportion_data <- filtered_data %>%
                                      dplyr::summarise(prop_success = sum(overall_cond, na.rm = TRUE)/length(na.omit(overall_cond)))
                                  }
                                  
                                  if (return_crops_table){
                                    crops_def_table[[i]] <- filtered_data %>% dplyr::mutate(rain_total = rain_i,
                                                                                            plant_length = length_i,
                                                                                            plant_day = day_i)
                                  }
                                  if (definition_props){
                                    proportion_df[[i]] <- proportion_data %>% dplyr::mutate(rain_total = rain_i,
                                                                                            plant_length = length_i,
                                                                                            plant_day = day_i)
                                  }
                                  i <- i + 1
                                }
                              }
                            }
                            
                            if (!missing(station)) column_order <- c(station, plant_day_name, plant_length_name, rain_total_name)
                            else column_order <- c(plant_day_name, plant_length_name, rain_total_name)
                            
                            if (return_crops_table){
                              # here we get crop_def and import it as a new DF
                              crops_def_table <- dplyr::bind_rows(crops_def_table) %>% dplyr::select(c(all_of(column_order), everything())) %>% dplyr::arrange(dplyr::across(dplyr::all_of(column_order)))
                              crops_name <- "crop_def"
                              crops_name <- instatExtras::next_default_item(prefix = crops_name, existing_names = self$get_data_names(), include_index = FALSE)
                              data_tables <- list(crops_def_table) 
                              names(data_tables) <- crops_name
                              if(season_data_name != data_name) {
                                crops_by <- season_by
                                names(crops_by) <- by
                                self$add_link(crops_name, season_data_name, crops_by, keyed_link_label)
                              }
                              self$import_data(data_tables = data_tables)
                            } 
                            if (definition_props){
                              prop_data_frame <- dplyr::bind_rows(proportion_df) %>% dplyr::select(c(all_of(column_order), everything())) %>% dplyr::arrange(dplyr::across(dplyr::all_of(column_order)))
                              
                              prop_name <- "crop_prop"
                              prop_name <- instatExtras::next_default_item(prefix = prop_name, existing_names = self$get_data_names(), include_index = FALSE)
                              data_tables <- list(prop_data_frame) 
                              names(data_tables) <- prop_name
                              self$import_data(data_tables = data_tables)
                              
                              # Add Link
                              if (return_crops_table){
                                if (!missing(station)){
                                  self$add_link(from_data_frame = crops_name, to_data_frame = prop_name, link_pairs=c(station = station, rain_total = rain_total_name, plant_length = plant_length_name, plant_day = plant_day_name), type="keyed_link")
                                } else {
                                  self$add_link(from_data_frame = crops_name, to_data_frame = prop_name, link_pairs=c(rain_total = rain_total_name, plant_length = plant_length_name, plant_day = plant_day_name), type="keyed_link")
                                }
                              }
                            }
                           },
                          
                          #' @description
                          #' Tidy climatic data into a specified format.
                          #' @param x The input data frame containing climatic data.
                          #' @param format A character string indicating the format of the data; must be either 'days', 'months', or 'years'.
                          #' @param stack_cols A vector of column names to be stacked.
                          #' @param day Optional; the name of the day column.
                          #' @param month Optional; the name of the month column.
                          #' @param year Optional; the name of the year column.
                          #' @param stack_years Optional; a vector of years corresponding to the stack columns.
                          #' @param station Optional; the name of the station column.
                          #' @param element Optional; the name of the element column.
                          #' @param element_name The name to assign to the value column for the climatic element.
                          #' @param ignore_invalid A boolean indicating whether to ignore invalid dates.
                          #' @param silent A boolean indicating whether to suppress output messages.
                          #' @param unstack_elements A boolean indicating whether to unstack multiple elements.
                          #' @param new_name Optional; the name to assign to the resulting tidy data frame.
                          tidy_climatic_data = function(x, format, stack_cols, day, month, year, 
                                                        stack_years, station, element, 
                                                        element_name = "value", 
                                                        ignore_invalid = FALSE, 
                                                        silent = FALSE, 
                                                        unstack_elements = TRUE, 
                                                        new_name) {
                            
                            if(!format %in% c("days", "months", "years")) stop("format must be either 'days', 'months' or 'years'")
                            if(!all(stack_cols %in% names(x))) stop("Some of the stack_cols were not found in x.")
                            if(!missing(day) && !day %in% names(x)) stop("day column not found in x.")
                            if(!missing(month) && !month %in% names(x)) stop("month column not found in x.")
                            if(!missing(year) && !year %in% names(x)) stop("year column not found in x.")
                            if(!missing(station) && !station %in% names(x)) stop("station column not found in x.")
                            if(!missing(element) && !element %in% names(x)) stop("element column not found in x.")
                            # Default to FALSE and updated if format == "days"
                            flags <- FALSE
                            
                            # check day column is valid (if specified)
                            if(!missing(day)) {
                              day_data <- x[[day]]
                              if(anyNA(day_data)) stop("day column contains: ", sum(is.na(day_data)), " missing values")
                              if(!is.numeric(day_data)) stop("day column must be numeric")
                              invalid_day <- (day_data < 1 | day_data > 31 | (day_data %% 1) != 0)
                              if(any(invalid_day)) {
                                invalid_values <- unique(day_data[invalid_day])
                                stop("day column contains the following invalid values: ", paste(invalid_values, collapse = ",")) 
                              }
                            }
                            
                            # check month column is valid (if specified)
                            if(!missing(month)) {
                              month_data <- x[[month]]
                              # Initialise no month format
                              month_format <- ""
                              if(anyNA(month_data)) stop("month column contains: ", sum(is.na(month_data)), " missing values")
                              if(is.numeric(month_data)) {
                                invalid_month <- (month_data < 1 | month_data > 12 | (month_data %% 1) != 0)
                                if(any(invalid_month)) {
                                  invalid_values <- unique(month_data[invalid_month])
                                  stop("month column contains the following invalid values: ", paste(invalid_values, collapse = ",")) 
                                }
                                # Month format will be used in as.Date()
                                month_format <- "%m"
                              }
                              # This case is for numeric months but stored as character e.g. c("1", "2")
                              else if(all(!is.na(as.numeric(month_data)))) {
                                if(all(as.numeric(month_data) %in% 1:12)) {
                                  month_format <- "%m"
                                  # This ensures format is correct and removes any spaces etc. e.g. "1 " -> 1
                                  x[[month]] <- as.numeric(month_data)
                                }
                              }
                              else {
                                # Convert to title case to match month.name and month.abb
                                month_data_title <- stringr::str_to_title(month_data)
                                if(all(month_data_title %in% month.abb)) month_format <- "%b"
                                else if(all(month_data_title %in% month.name)) month_format <- "%B"
                                if(month_format == "") {
                                  invalid_short <- unique(month_data[!month_data_title %in% month.abb])
                                  invalid_long <- unique(month_data[!month_data_title %in% month.name])
                                  if(length(invalid_short) < 12) {
                                    stop("Some month values were not unrecognised.\nIf specifying short names the following are invalid: ", paste(invalid_short, collapse = ", "), "\nAlternatively use a numeric month column.")
                                  }
                                  else if(length(invalid_long) < 12) {
                                    stop("Some month values were not unrecognised.\nIf specifying full names the following are invalid: ", paste(invalid_long, collapse = ", "), "\nAlternatively use a numeric month column.")
                                  }
                                  else stop("No values in the month column were recognised.\nUse either\n short names: ", paste(month.abb, collapse = ", "), "\nfull names: ", paste(month.name, collapse = ", "), "\nor numbers 1 to 12.")
                                }
                                # Put title case months into the data as this will be needed to make the date column
                                x[[month]] <- month_data_title 
                              }
                            }
                            
                            # check year column is valid (if specified)
                            if(!missing(year)) {
                              year_data <- x[[year]]
                              if(anyNA(year_data)) stop("year column contains: ", sum(is.na(year_data)), " missing values")
                              year_format <- ""
                              if(!is.numeric(year_data)) {
                                if(all(!is.na(as.numeric(year_data)))) {
                                  x[[year]] <- as.numeric(year_data)
                                  year_data <- x[[year]]
                                }
                                else stop("Cannot recognise years from year column. Try using a numeric year column.")
                              }
                              if(all(stringr::str_length(year_data) == 4)) year_format <- "%Y"
                              else if(all(stringr::str_length(year_data) == 2)) year_format <- "%y"
                              else stop("Inconsistent values found in year column. Year column must be column of four digit years or column of two digit years")
                            }
                            
                            if(format == "days") {
                              ndays <- 31
                              # month column required in this case
                              if(missing(month)) stop("month column is required when format == 'days'")
                              
                              # year column required in this case
                              if(missing(year)) stop("year column is required when format == 'days'")
                              
                              # stack column checks
                              if(length(stack_cols) != ndays && length(stack_cols) != 2 * ndays) stop("You have specified: ", length(stack_cols), " stack columns\nThere must be exactly ", ndays, " or ", 2 * ndays, " stack columns when format == 'days'")
                              
                              # TRUE if flag columns are included
                              flags <- length(stack_cols) == 2 * ndays
                              if(flags) {
                                # We assume that value/flag columns alternate and are in correct order i.e. c(value1, flag1, value2, flag2, ..., value31, flag31)
                                val_col_names <- stack_cols[seq(1, 2 * ndays - 1, 2)]
                                flag_col_names <- stack_cols[seq(2, 2 * ndays, 2)]
                                # TODO This should be a more global function
                                if(!all(sapply(x[, val_col_names], function(col) is.numeric(col) || (is.logical(col) && all(is.na(col)))))) stop("Every other column must be numeric to represent values (starting with the first columns). \nThe following value columns are not numeric: ", paste(stack_cols[!sapply(x[, val_col_names], is.numeric)], collapse = ","))
                                # Name of flag column
                                flag_name <- "flag"
                              }
                              else {
                                if(!all(sapply(x[, stack_cols], function(col) is.numeric(col) || (is.logical(col) && all(is.na(col)))))) stop("All stack_cols must be numeric\nThe following stack_cols are not numeric: ", paste(stack_cols[!sapply(x[, stack_cols], is.numeric)], collapse = ","))
                              }
                              
                              # This ensures all other columns are dropped
                              y <- data.frame(year = x[[year]], month = x[[month]], x[ , stack_cols])
                              if(!missing(station)) y$station <- x[[station]]
                              if(!missing(element)) y$element <- x[[element]]
                              # In case element_name is the name of an existing column in y
                              if(element_name %in% names(y)) element_name <- instatExtras::next_default_item(prefix = element_name, existing_names = names(y))
                              if(flags) {
                                # renaming the stack_cols with a consistent pattern makes it possible for pivot_longer to stack both sets of columns together and construct the day column correctly
                                # This assumes stack_cols are in the correct order i.e. c(value1, flag1, value2, flag2, ..., value31, flag31)
                                new_stack_cols <- paste(c("value", "flag"), rep(1:ndays, each = 2), sep = "_")
                                names(y)[names(y) %in% stack_cols] <- new_stack_cols
                                # ".value" is a special sentinel used in names_to to ensure names of value columns come from the names of cols. See ?pivot_longer values_to section for details.
                                y <- tidyr::pivot_longer(y, cols = tidyselect::all_of(new_stack_cols), names_to = c(".value", "day"), names_sep = "_")
                              }
                              else {
                                # renaming the stack_cols so that the day column can be constructed correctly
                                # This assumes stack_cols are in the correct order i.e. 1 - 31
                                new_stack_cols <- paste0("day", 1:ndays)
                                names(y)[names(y) %in% stack_cols] <- new_stack_cols
                                y <- tidyr::pivot_longer(y, cols = tidyselect::all_of(new_stack_cols), names_to = "day", values_to = element_name)
                                # extract day number from e.g. "day10"
                                y$day <- substr(y$day, 4, 5)
                              }
                              
                              y$date <- as.Date(paste(y$year, y$month, y$day), format = paste(year_format, month_format, "%d"))
                            }
                            else if(format == "months") {
                              if(!all(sapply(x[, stack_cols], function(col) is.numeric(col) || (is.logical(col) && all(is.na(col)))))) stop("All stack_cols must be numeric\nThe following stack_cols are not numeric: ", paste(stack_cols[!sapply(x[, stack_cols], is.numeric)], collapse = ","))
                              
                              # month column required in this case
                              if(missing(day)) stop("day column is required when format == 'months'")
                              
                              # year column required in this case
                              if(missing(year)) stop("year column is required when format == 'months'")
                              
                              # stack column checks
                              if(length(stack_cols) != 12) stop("You have specified: ", length(stack_cols), " stack columns\nThere must be exactly 12 stack columns when format == 'months'")
                              
                              # This ensures all other columns are dropped
                              y <- data.frame(year = x[[year]], day = x[[day]], x[ , stack_cols])
                              if(!missing(station)) y$station <- x[[station]]
                              if(!missing(element)) y$element <- x[[element]]
                              # In case element_name is the name of an existing column in y
                              if(element_name %in% names(y)) element_name <- instatExtras::next_default_item(prefix = element_name, existing_names = names(y))
                              # renaming the stack_cols so that the day column can be constructed correctly
                              # This assumes stack_cols are in the correct order i.e. 1 - 12
                              new_stack_cols <- paste0("month", 1:12)
                              names(y)[names(y) %in% stack_cols] <- new_stack_cols
                              y <- tidyr::pivot_longer(y, cols = tidyselect::all_of(new_stack_cols), names_to = "month", values_to = element_name)
                              # extract month number from e.g. "month10"
                              y$month <- substr(y$month, 6, 7)
                              
                              y$date <- as.Date(paste(y$year, y$month, y$day), format = paste(year_format, "%m", "%d"))
                            }
                            else if(format == "years") {
                              if(!all(sapply(x[, stack_cols], function(col) is.numeric(col) || (is.logical(col) && all(is.na(col)))))) stop("All stack_cols must be numeric\nThe following stack_cols are not numeric: ", paste(stack_cols[!sapply(x[, stack_cols], is.numeric)], collapse = ","))
                              
                              by_cols <- c()
                              if(!missing(station)) by_cols <- c(by_cols, station)
                              if(!missing(element)) by_cols <- c(by_cols, element)
                              
                              if(length(by_cols) > 0) {
                                group_lengths <- x %>% dplyr::group_by(!!! rlang::syms(by_cols)) %>% dplyr::summarise(n = n())
                                if(any(group_lengths$n != 366)) stop("data must have exactly 366 rows per station per element when format = 'years'")
                              }
                              else if(nrow(x) != 366) stop("data must have exactly 366 rows for a single station and element when format = 'years'")
                              
                              if(!missing(stack_years) && length(year_list) != length(stack_cols)) stop("stack_years must be the same length as stack_cols")
                              
                              # stack_years allows to specify the years represented by stack_cols.
                              # If this is blank, attempt to infer stack_years by assuming stack_cols are in the format c("X1990", "X1991", ...)
                              if(missing(stack_years)) {
                                # Remove first character and convert to numeric
                                stack_years <- as.numeric(stringr::str_sub(stack_cols, 2))
                                invalid_ind <- is.na(stack_years) | stringr::str_length(stack_years) != 4
                                if(any(invalid_ind)) {
                                  cat("Unrecognised year columns:", paste(stack_years[invalid_ind], collapse = ", "))
                                  stop("Cannot determine year of some columns. Year columns must be named with format 'Xyyyy' where X is any character and yyyy is the year.")
                                }
                              }
                              x$doy <- 1:366
                              # This ensures all other columns are dropped
                              y <- data.frame(doy = x$doy, x[ , stack_cols])
                              if(!missing(station)) y$station <- x[[station]]
                              if(!missing(element)) y$element <- x[[element]]
                              # In case element_name is the name of an existing column in y
                              if(element_name %in% names(y)) element_name <- instatExtras::next_default_item(prefix = element_name, existing_names = names(y))
                              y <- tidyr::pivot_longer(y, cols = tidyselect::all_of(stack_cols), names_to = "year", values_to = element_name)
                              
                              # This assumes stack_cols and stack_years are in the same order
                              y$year <- plyr::mapvalues(y$year, stack_cols, stack_years)
                              
                              # Replacing day 60 with 0 for non-leap years. This will result in NA dates.
                              y$doy[(!lubridate::leap_year(as.numeric(y$year))) & y$doy == 60] <- 0
                              y$doy[(!lubridate::leap_year(as.numeric(y$year))) & y$doy > 60] <- y$doy[(!lubridate::leap_year(as.numeric(y$year))) & y$doy > 60] - 1
                              y$date <- as.Date(paste(y$year, y$doy), format = paste("%Y", "%j"))
                              # Put day 0 back as 60. Needed in error displaying only.
                              y$doy[y$doy == 0] <- 60
                            }
                            
                            continue <- TRUE
                            # check if there are any non missing values on missing dates
                            # this is a problem as missing dates are invalid dates so should not have values
                            invalid_ind <- is.na(y$date) & !is.na(y[[element_name]])
                            if(sum(invalid_ind) > 0) {
                              cat("There are:", sum(invalid_ind), "measurement values on invalid dates.\n")
                              if(!silent) {
                                cat("\n*** Invalid dates ***\n\n")
                                invalid_data <- dplyr::filter(y, invalid_ind)
                                if(format == "days" || format == "months") {
                                  invalid_data_display <- invalid_data %>% dplyr::select(year, month, day)
                                }
                                else {
                                  invalid_data_display <- invalid_data %>% dplyr::select(year, doy)
                                }
                                # Also make a data.frame (instead of tibble) so that display will show all rows.
                                if(!missing(station)) {
                                  invalid_data_display <- data.frame(station = invalid_data$station, invalid_data_display)
                                }
                                if(!missing(element)) {
                                  invalid_data_display <- data.frame(element = invalid_data$element, invalid_data_display)
                                }
                                invalid_data_display <- data.frame(invalid_data_display)
                                invalid_data_display[[element_name]] <- invalid_data[[element_name]]
                                print(invalid_data_display, row.names = FALSE)
                              }
                              if(ignore_invalid) cat("Warning: These rows have been removed.\n")
                              else {
                                # This should be a stop but then detailed output can't be displayed by R-Instat
                                cat("There are:", sum(invalid_ind), "measurement values on invalid dates. Correct these or specify ignore_invalid = TRUE to ignore them. See output for more details.\n")
                                continue <- FALSE
                              }
                            }
                            
                            # This should have been a stop above but then detailed output can't be displayed by R-Instat
                            if(!continue) return()
                            
                            # Standard format of slowest varying structure variables first (station then element then date) followed by measurements
                            if(!missing(station)) z <- data.frame(station = forcats::as_factor(y$station), date = y$date)
                            else z <- data.frame(date = y$date)
                            if(!missing(element)) z$element <- y$element
                            z[[element_name]] <- y[[element_name]]
                            if(flags) z[[flag_name]] <- y[[flag_name]]
                            
                            # Initialise id columns used for sorting data
                            id_cols <- c()
                            if(!missing(station)) id_cols <- c(id_cols, "station")
                            
                            z <- dplyr::filter(z, !is.na(date))
                            
                            # If data contains multiple elements, optionally unstack the element column
                            if(!missing(element)) {
                              if(unstack_elements) {
                                # pivot_wider allows unstacking multiple column sets, used when flags included.
                                values_from <- c(element_name)
                                if(flags) values_from <- c(values_from, flag_name)
                                # first check for unique combinations to ensure no duplicates
                                z_dup <- duplicated(z %>% dplyr::select(-tidyselect::all_of(values_from)))
                                if(any(z_dup > 0)) {
                                  # This should be a stop but then detailed output can't be displayed by R-Instat
                                  cat("\nError: Cannot tidy data as some elements have multiple values on the same date. Check and resolve duplicates first.\n")
                                  z_check <- z %>% filter(z_dup > 0)
                                  if(!silent) {
                                    cat("\n*** Duplicates ***\n\n")
                                    print(z_check, row.names = FALSE)
                                  }
                                  continue <- FALSE
                                }
                                else z <- tidyr::pivot_wider(z, names_from = element, values_from = tidyselect::all_of(values_from))
                              }
                              # If not unstacking then need to sort by element column
                              else id_cols <- c(id_cols, "element")
                            }
                            
                            # This should have been a stop above but then detailed output can't be displayed by R-Instat
                            if(!continue) return()
                            
                            # Add this last to ensure date varies fastest
                            id_cols <- c(id_cols, "date")
                            # TODO Find a better way to do this. Update if there could be more the 3 id cols.
                            if(length(id_cols) == 1) {
                              z <- z %>% dplyr::arrange(.data[[id_cols[1]]])
                            }
                            else if(length(id_cols) == 2) {
                              z <- z %>% dplyr::arrange(.data[[id_cols[1]]], .data[[id_cols[2]]])
                            }
                            else if(length(id_cols) == 3) {
                              z <- z %>% dplyr::arrange(.data[[id_cols[1]]], .data[[id_cols[2]]], .data[[id_cols[3]]])
                            }
                            if(missing(new_name) || new_name == "") new_name <- instatExtras::next_default_item("data", existing_names = self$get_data_names())
                            data_list <- list(z)
                            names(data_list) <- new_name
                            self$import_data(data_tables=data_list)
                          },
                          
                          #' @description
                          #' Retrieve the geometry column from a given data object.
                          #' @param data The data object from which to retrieve the geometry column.
                          #' @return The name of the geometry column if found, otherwise an empty string.
                          get_geometry = function(data) {
                            if (missing(data)) stop("data_name is required")
                            else if ("sf" %in% class(data)) return(attr(data, "sf_column"))
                            else if ("geometry" %in% colnames(data)) return("geometry")
                            else return("")
                          },
                          
                          #' @description
                          #' Check the installation status and version of a specified package.
                          #' @param package The name of the package to check.
                          #' @return A list containing the status of the package: 
                          #' 1 if installed and up to date, 2 if installed but outdated, 
                          #' and 0 if not installed or misspelled.
                          package_check = function(package) {
                            out <- list()
                            av_packs <- available.packages()
                            av_packs <- data.frame(av_packs)
                            if (package %in% rownames(installed.packages())) {
                              out[[1]] <- 1
                              v_machine <- as.character(packageVersion(package))
                              v_web <- as.character(av_packs[av_packs$Package == package, "Version"])
                              out[[2]] <- compareVersion(v_machine, v_web)
                              out[[3]] <- v_machine
                              out[[4]] <- v_web
                              return(out)
                            } else {
                              if (package %in% av_packs) {
                                out[[1]] <- 2
                                return(out)
                              } else {
                                out[[1]] <- 0
                                return(out)
                              }
                            }
                          },
                          
                          #' @description
                          #' Download data from the IRI database based on specified parameters.
                          #' @param source The source from which to download data.
                          #' @param data The specific data to download.
                          #' @param path The directory path for saving the downloaded file.
                          #' @param min_lon Minimum longitude for area selection.
                          #' @param max_lon Maximum longitude for area selection.
                          #' @param min_lat Minimum latitude for area selection.
                          #' @param max_lat Maximum latitude for area selection.
                          #' @param min_date Minimum date for the data.
                          #' @param max_date Maximum date for the data.
                          #' @param name The name to assign to the imported data.
                          #' @param download_type The type of download (Point or Area).
                          #' @param import Boolean indicating whether to import the downloaded data into the databook.
                          download_from_IRI = function(source, data, path = tempdir(), min_lon, max_lon, min_lat, max_lat, min_date, max_date, name, download_type = "Point", import = TRUE) {
                            init_URL <- "https://iridl.ldeo.columbia.edu/SOURCES/"
                            dim_x <- "X"
                            dim_y <- "Y"
                            dim_t <- "T"
                            if (source == "UCSB_CHIRPS") {
                              prexyaddress <- paste0(init_URL, ".UCSB/.CHIRPS/.v2p0")
                              
                              chirps_extensions <- c(
                                #"" = ".daily/.global/.0p05/.prcp",
                                #"" = ".daily/.global/.0p25/.prcp",
                                "daily_improved_global_0p05_prcp" = ".daily-improved/.global/.0p05/.prcp",
                                "daily_improved_global_0p25_prcp" = ".daily-improved/.global/.0p25/.prcp",
                                "dekad_prcp" = ".dekad/.prcp",
                                #"" = ".monthly/.global/.c8113/.precipitation",
                                #"" = ".monthly/.global/.deg1p0/.precipitation",
                                #"" = ".monthly/.global/.NMME_deg1p0/.precipitation",
                                "monthly_global_prcp" = ".monthly/.global/.precipitation"
                              )
                              extension <- chirps_extensions[data]
                              if (is.na(extension)){
                                stop("Data file does not exist for CHIRPS V2P0 data")
                              } 
                              
                            } else if (source == "TAMSAT_v3.0") {
                              dim_x <- "lon"
                              dim_y <- "lat"
                              prexyaddress <- paste0(init_URL, ".Reading/.Meteorology/.TAMSAT/.TARCAT/.v3p0")
                              
                              chirps_extensions <- c(
                                "daily_rfe" = ".daily/.rfe",
                                "dekadal_rfe" = ".dekadal/.rfe",
                                "monthly_rfe" = ".monthly/.rfe",
                                "monthly_rfe_calc" = ".monthly/.rfe_calc"
                              )
                              extension <- chirps_extensions[data]
                              if (is.na(extension)){
                                stop("Data file does not exist for TAMSAT_v3.0 data")
                              } 
                              
                              if (data %in% c("daily_rfe", "monthly_rfe", "monthly_rfe_calc")) {
                                dim_t <- "time"
                              } 
                            } else if (source == "TAMSAT_v3.1") {
                              prexyaddress <- paste0(init_URL, ".Reading/.Meteorology/.TAMSAT/.TARCAT/.v3p1")
                              
                              chirps_extensions <- c(
                                "daily_rfe" = ".daily/.rfe",
                                "daily_rfe_filled" = ".daily/.rfe_filled",
                                "dekadal_rfe" = ".dekadal/.rfe",
                                "dekadal_rfe_filled" = ".dekadal/.rfe_filled",
                                "monthly_rfe" = ".monthly/.rfe",
                                "monthly_rfe_filled" = ".monthly/.rfe_filled"
                              )
                              extension <- chirps_extensions[data]
                              if (is.na(extension)){
                                stop("Data file does not exist for TAMSAT_v3.1 data")
                              } 
                            } else if (source == "NOAA") {
                              prexyaddress <- paste0(init_URL, ".NOAA/.NCEP/.CPC/.FEWS/.Africa")
                              if (data == "daily_rfev2_est_prcp") {
                                extension <- ".DAILY/.RFEv2/.est_prcp"
                              } # (days since 2000-10-31 12:00:00) ordered (31 Oct 2000) to (12 Sep 2020)
                              else if (data == "10day_rfev2_est_prcp") {
                                extension <- ".TEN-DAY/.RFEv2/.est_prcp"
                              } # grid: /T (days since 1960-01-01) ordered [ (1-10 Dec 1999) (11-20 Dec 1999) (21-31 Dec 1999) ... (1-10 Sep 2020)] N= 748 pts :grid
                              else if (data == "daily_est_prcp") {
                                extension <- ".DAILY/.ARC2/.daily/.est_prcp"
                              } # (days since 1960-01-01 12:00:00) ordered (1 Jan 1983) to (12 Sep 2020)
                              else if (data == "monthly_est_prcp") {
                                extension <- ".DAILY/.ARC2/.monthly/.est_prcp"
                              } # (months since 1960-01-01) ordered (Jan 1983) to (Aug 2020)
                              else {
                                stop("Data file does not exist for NOAA data")
                              }
                            } else if (source == "NOAA_CMORPH_DAILY" || source == "NOAA_CMORPH_3HOURLY" || source == "NOAA_CMORPH_DAILY_CALCULATED") {
                              if (source == "NOAA_CMORPH_DAILY") {
                                prexyaddress <- paste0(init_URL, ".NOAA/.NCEP/.CPC/.CMORPH/.daily")
                              }
                              else if (source == "NOAA_CMORPH_3HOURLY") {
                                prexyaddress <- paste0(init_URL, ".NOAA/.NCEP/.CPC/.CMORPH/.3-hourly")
                              }
                              else if (source == "NOAA_CMORPH_DAILY_CALCULATED") {
                                prexyaddress <- paste0(init_URL, ".NOAA/.NCEP/.CPC/.CMORPH/.daily_calculated")
                              }
                              if (data == "mean_microwave_only_est_prcp") {
                                extension <- ".mean/.microwave-only/.comb"
                              }
                              else if (data == "mean_morphed_est_prcp") {
                                extension <- ".mean/.morphed/.cmorph"
                              }
                              else if (data == "orignames_mean_microwave_only_est_prcp") {
                                extension <- ".orignames/.mean/.microwave-only/.comb"
                              }
                              else if (data == "orignames_mean_morphed_est_prcp") {
                                extension <- ".orignames/.mean/.morphed/.cmorph"
                              }
                              else if (data == "renamed102015_mean_microwave_only_est_prcp") {
                                extension <- ".renamed102015/.mean/.microwave-only/.comb"
                              }
                              else if (data == "renamed102015_mean_morphed_est_prcp") {
                                extension <- ".renamed102015/.mean/.morphed/.cmorph"
                              }
                              else {
                                stop("Data file does not exist for NOAA CMORPH data")
                              }
                            } else if (source == "NASA") {
                              prexyaddress <- paste0(init_URL, ".NASA/.GES-DAAC/.TRMM_L3/.TRMM_3B42/.v7")
                              if (data == "daily_prcp") {
                                extension <- ".daily/.precipitation"
                              } # (days since 1998-01-01 00:00:00) ordered (1 Jan 1998) to (31 May 2015)
                              else if (data == "3_hourly_prcp") {
                                extension <- ".three-hourly/.precipitation"
                              } # (days since 1998-01-01 00:00:00) ordered (2230 31 Dec 1997 - 0130 1 Jan 1998) to (2230 30 May 2015 - 0130 31 May 2015)
                              else {
                                stop("Data file does not exist for NASA TRMM 3B42 data")
                              }
                            } else {
                              stop("Source not specified correctly.")
                            }
                            prexyaddress <- paste(prexyaddress, extension, sep = "/")
                            if (download_type == "Area") {
                              URL <- instatExtras::add_xy_area_range(path = prexyaddress, min_lon = min_lon, min_lat = min_lat, max_lon = max_lon, max_lat = max_lat, dim_x = dim_x, dim_y = dim_y)
                            } else if (download_type == "Point") {
                              URL <- instatExtras::add_xy_point_range(path = prexyaddress, min_lon = min_lon, min_lat = min_lat, dim_x = dim_x, dim_y = dim_y)
                            }
                            if (!missing(min_date) & !missing(max_date)) {
                              URL <- URL %>% instatExtras::add_t_range(min_date = min_date, max_date = max_date, dim_t = dim_t)
                            }
                            URL <- URL %>% instatExtras::add_nc()
                            file_name <- tempfile(pattern = tolower(source), tmpdir = path, fileext = ".nc")
                            result <- download.file(url = URL, destfile = file_name, method = "libcurl", mode = "wb", cacheOK = FALSE)
                            if (import && result == 0) {
                              nc <- ncdf4::nc_open(filename = file_name)
                              self$import_NetCDF(nc = nc, name = name)
                              ncdf4::nc_close(nc = nc)
                            } else if (result != 0) {
                              stop("No file downloaded please check your internet connection")
                            }
                            if (missing(path)) {
                              file.remove(file_name)
                            }
                          },
                          
                          #' @description
                          #' Patch a climate element in the specified data.
                          #' @param data_name The name of the data to patch.
                          #' @param date_col_name The name of the date column.
                          #' @param var The variable to patch.
                          #' @param vars A vector of variables to patch.
                          #' @param max_mean_bias Maximum allowable mean bias for the patching.
                          #' @param max_stdev_bias Maximum allowable standard deviation bias for the patching.
                          #' @param time_interval The time interval for the patching (default is "month").
                          #' @param column_name The name of the column to patch.
                          #' @param station_col_name The name of the station column.
                          patch_climate_element = function(data_name, date_col_name = "", var = "", vars = c(), max_mean_bias = NA, max_stdev_bias = NA, time_interval = "month", column_name, station_col_name = station_col_name) {
                            self$get_data_objects(data_name)$patch_climate_element(date_col_name = date_col_name, var = var, vars = vars, max_mean_bias = max_mean_bias, max_stdev_bias = max_stdev_bias, time_interval = time_interval, column_name = column_name, station_col_name = station_col_name)
                          }, 
                          
                          #' @description
                          #' Visualize the missing values in a specified element within a dataset.
                          #' @param data_name The name of the data table.
                          #' @param element_col_name The name of the column containing the element of interest.
                          #' @param element_col_name_imputed The name of the column for imputed values of the element.
                          #' @param station_col_name The name of the column representing the station.
                          #' @param x_axis_labels_col_name The name of the column for x-axis labels.
                          #' @param ncol The number of columns for visualization layout.
                          #' @param type The type of visualization (e.g., distribution).
                          #' @param xlab Label for the x-axis.
                          #' @param ylab Label for the y-axis.
                          #' @param legend Logical indicating whether to include a legend.
                          #' @param orientation Orientation of the plot (e.g., horizontal).
                          #' @param interval_size Size of intervals for the visualization.
                          #' @param x_with_truth Optional truth values for comparison.
                          #' @param measure Measurement type (e.g., percent).
                          visualize_element_na = function(data_name, element_col_name, element_col_name_imputed, 
                                                          station_col_name, x_axis_labels_col_name, ncol = 2, 
                                                          type = "distribution", xlab = NULL, ylab = NULL, 
                                                          legend = TRUE, orientation = "horizontal", 
                                                          interval_size = interval_size, x_with_truth = NULL, 
                                                          measure = "percent") {
                            self$get_data_objects(data_name)$visualize_element_na(
                              element_col_name = element_col_name,
                              element_col_name_imputed = element_col_name_imputed,
                              station_col_name = station_col_name,
                              x_axis_labels_col_name = x_axis_labels_col_name,
                              ncol = ncol, type = type, xlab = xlab,
                              ylab = ylab, legend = legend,
                              orientation = orientation, interval_size = interval_size,
                              x_with_truth = x_with_truth, measure = measure
                            )
                          },
                          
                          #' @description
                          #' Retrieve data entry for specified elements within a date range.
                          #' @param data_name The name of the data table.
                          #' @param station The station of interest.
                          #' @param date The date of interest.
                          #' @param elements The elements to retrieve.
                          #' @param view_variables Variables to view in the output.
                          #' @param station_name The name of the station.
                          #' @param type The type of data to retrieve.
                          #' @param start_date The start date of the data range.
                          #' @param end_date The end date of the data range.
                          get_data_entry_data = function(data_name, station, date, elements, 
                                                         view_variables, station_name, 
                                                         type, start_date, end_date) {
                            self$get_data_objects(data_name)$get_data_entry_data(
                              station = station, date = date, elements = elements, 
                              view_variables = view_variables, station_name = station_name, 
                              type = type, start_date = start_date, end_date = end_date
                            )
                          },
                          
                          #' @description
                          #' Save new data entries and associated comments to the dataset.
                          #' @param data_name The name of the data table.
                          #' @param new_data The new data to save.
                          #' @param rows_changed The rows that have been modified.
                          #' @param comments_list A list of comments for changes made.
                          #' @param add_flags Logical indicating whether to add flags.
                          #' @param ... Additional arguments passed to other methods.
                          save_data_entry_data = function(data_name, new_data, rows_changed, 
                                                          comments_list = list(), add_flags = FALSE, ...) {
                            if (!missing(comments_list)) {
                              for (i in seq_along(comments_list)) {
                                com <- comments_list[[i]]
                                if (!("row" %in% names(com))) {
                                  com[["row"]] <- ""
                                }
                                if (!("column" %in% names(com))) {
                                  com[["column"]] <- ""
                                }
                              }
                              if (length(comments_list) > 0) {
                                cat("Comments added:", length(comments_list), "\n")
                                self$add_new_comment(data_name = data_name, 
                                                     row = com$row, column = com$column, 
                                                     comment = com$comment)
                              }
                            }
                            self$get_data_objects(data_name)$save_data_entry_data(
                              new_data = new_data, rows_changed = rows_changed, 
                              add_flags = add_flags
                            )
                          },
                          
                          #' @description
                          #' Import data from CDS (Climate Data Store) for specified parameters.
                          #' @param user The user credentials for accessing CDS.
                          #' @param dataset The dataset to import.
                          #' @param elements The elements to retrieve from the dataset.
                          #' @param start_date The starting date for the data.
                          #' @param end_date The ending date for the data.
                          #' @param lon Longitude for area definition.
                          #' @param lat Latitude for area definition.
                          #' @param path The path to save the imported data.
                          #' @param import Logical indicating whether to import the data.
                          #' @param new_name Optional new name for the imported data.
                          import_from_cds = function(user, dataset, elements, start_date, 
                                                     end_date, lon, lat, path, import = FALSE, 
                                                     new_name) {
                            all_dates <- seq(start_date, end_date, by = 1)
                            all_periods <- unique(paste(lubridate::year(all_dates), 
                                                        sprintf("%02d", lubridate::month(all_dates)), sep = "-"))
                            area <- c(lat[2], lon[1], lat[1], lon[2])
                            is_win <- Sys.info()['sysname'] == "Windows"
                            if (is_win) pb <- winProgressBar(title = "Requesting data from CDS", 
                                                             min = 0, max = length(all_periods))
                            nc_files <- vector(mode = "character", length = length(all_periods))
                            for (i in seq_along(all_periods)) {
                              y <- substr(all_periods[i], 1, 4)
                              m <- substr(all_periods[i], 6, 7)
                              curr_dates <- all_dates[lubridate::month(all_dates) == as.numeric(m) & 
                                                        lubridate::year(all_dates) == as.numeric(y)]
                              d <- sprintf("%02d", lubridate::day(curr_dates))
                              request <- list(
                                dataset_short_name = dataset,
                                product_type = "reanalysis",
                                variable = elements,
                                year = y,
                                month = m,
                                day = d,
                                time = sprintf("%02d:00", 0:23),
                                format = "netcdf",
                                area = area,
                                target = paste0(dataset, "-", paste(elements, collapse = "_"), "-", 
                                                all_periods[i], ".nc")
                              )
                              info <- paste0("Requesting data for ", all_periods[i], " - ", 
                                             round(100 * i / length(all_periods)), "%")
                              if (is_win) setWinProgressBar(pb, value = i, title = info, label = info)
                              ncfile <- ecmwfr::wf_request(user = user, request = request,
                                                           transfer = TRUE, path = path,
                                                           time_out = 3 * 3600)
                              if (import) {
                                nc <- ncdf4::nc_open(filename = ncfile)
                                self$import_NetCDF(nc = nc, name = new_name)
                                ncdf4::nc_close(nc = nc)
                              }
                            }
                            if (is_win) close(pb)
                          },
                          
                          #' @description
                          #' Add flag fields to a specified dataset.
                          #' @param data_name The name of the data table.
                          #' @param col_names The names of the columns to flag.
                          #' @param key_column_names The names of key columns.
                          add_flag_fields = function(data_name, col_names, key_column_names) {
                            if (!self$has_key(data_name)) {
                              self$add_key(data_name, key_column_names)
                            }
                            self$get_data_objects(data_name)$add_flag_fields(col_names = col_names)
                          },
                          
                          #' @description
                          #' Remove empty rows or columns from a dataset.
                          #' @param data_name The name of the data table.
                          #' @param which The option to remove either "rows" or "cols".
                          remove_empty = function(data_name, which = c("rows", "cols")) {
                            self$get_data_objects(data_name)$remove_empty(which = which)
                          },
                          
                          #' @description
                          #' Replace specified values with NA in a dataset.
                          #' @param data_name The name of the data table.
                          #' @param row_index The index of the row to modify.
                          #' @param column_index The index of the column to modify.
                          replace_values_with_NA = function(data_name, row_index, column_index) {
                            self$get_data_objects(data_name)$replace_values_with_NA(row_index = row_index, column_index = column_index)
                          },
                          
                          #' @description
                          #' Check if specified columns in a dataset have labels.
                          #' @param data_name The name of the data table.
                          #' @param col_names The names of the columns to check.
                          has_labels = function(data_name, col_names) {
                            self$get_data_objects(data_name)$has_labels(col_names)
                          },
                          
                          #' @description
                          #' Wrap or unwrap data in a specified column of a dataset.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column to modify.
                          #' @param column_data The data in the column.
                          #' @param width The width for wrapping.
                          #' @param wrap Logical indicating whether to wrap or unwrap data.
                          wrap_or_unwrap_data = function(data_name, col_name, column_data, width, wrap = TRUE) {
                            original_type <- class(column_data)
                            desired_types <- c("factor", "numeric", "Date", "character", "integer", "list", "double")
                            if (original_type %in% desired_types) {
                              if (any(!is.na(stringr::str_detect(column_data, "\n")))) {
                                column_data <- stringr::str_replace_all(column_data, "\n", " ")
                              }
                              
                              if (!is.null(width) && wrap) {
                                column_data <- stringr::str_wrap(column_data, width = width)
                              }
                              curr_data <- self$get_data_frame(data_name = data_name, retain_attr = TRUE)
                              
                              if (original_type != class(column_data)) {
                                if (original_type %in% c("factor", "ordered_factor")) {
                                  column_data <- instatExtras::make_factor(column_data)
                                } else if (original_type == "list") {
                                  result <- curr_data %>%
                                    dplyr::mutate(list_column = lapply(column_data, instatExtras::convert_to_list))
                                  column_data <- result$list_column
                                } else {
                                  column_data <- as(column_data, original_type)
                                }
                              }
                              
                              attributes(column_data) <- attributes(curr_data[[col_name]])
                              self$add_columns_to_data(data_name = data_name, col_name = col_name, col_data = column_data, before = FALSE)
                            }
                          },
                          
                          #' @description 
                          #' Generate an ANOVA table for specified predictor and response variables.
                          #' Optionally includes totals, significance levels, and means.
                          #' @param data_name The name of the data frame to get the columns from.
                          #' @param x_col_names Character vector, the names of predictor variables.
                          #' @param y_col_name Character, the name of the response variable.
                          #' @param total Logical, whether to include a total row in the ANOVA table. Defaults to FALSE.
                          #' @param signif.stars Logical, whether to include significance stars. Defaults to FALSE.
                          #' @param sign_level Logical, whether to display significance levels. Defaults to FALSE.
                          #' @param means Logical, whether to include means or model coefficients. Defaults to FALSE.
                          #' @param interaction Logical, whether to include interaction terms for predictors. Defaults to FALSE.
                          #' @return A formatted ANOVA table with optional additional sections.
                          anova_tables2 = function(data_name, x_col_names, y_col_name, total = TRUE, signif.stars = FALSE, sign_level = FALSE, means = FALSE, interaction = FALSE) {
                            self$get_data_objects(data_name)$anova_tables2(x_col_names = x_col_names, y_col_name = y_col_name, total = total, signif.stars = signif.stars, sign_level = sign_level, means = means, interaction=interaction)
                          },
                          
                          #' @description
                          #' Display a daily summary table for a specified climatic data element.
                          #'
                          #' @param data_name A character string representing the name of the dataset.
                          #' @param climatic_element A vector specifying the climatic elements to be displayed (e.g., temperature, rainfall).
                          #' @param date_col The name of the column containing date information. Default is `date_col`.
                          #' @param year_col The name of the column containing year information. Default is `year_col`.
                          #' @param station_col The name of the column containing station information. If missing, assigns the `Station` column from metadata.
                          #' @param Misscode A value representing missing data in the dataset.
                          #' @param Tracecode A value representing trace amounts of the climatic element.
                          #' @param Zerocode A value representing zero values for the climatic element.
                          #' @param monstats A vector of summary statistics to calculate for monthly data. Options include `"min"`, `"mean"`, `"median"`, `"max"`, `"IQR"`, and `"sum"`.
                          #' 
                          #' @return A data frame displaying the daily summary table for the specified climatic element.
                          display_daily_table = function(data_name, climatic_element, date_col = date_col, year_col = year_col, station_col = station_col, Misscode, Tracecode, Zerocode, monstats = c("min", "mean", "median", "max", "IQR", "sum")) {
                            self$get_data_objects(data_name)$display_daily_table(data_name = data_name, climatic_element = climatic_element, date_col = date_col, year_col =year_col, station_col = station_col, Misscode = Misscode, Tracecode = Tracecode, Zerocode = Zerocode, monstats = monstats)
                          },
                          
                          #' @description Adds a new `instat_comment` object to the data sheet if the key is defined and valid.
                          #' @param new_comment An `instat_comment` object to be added to the data sheet.
                          #' @details This function first checks if a key is defined and valid for the data sheet.
                          #' It also verifies that `new_comment` is an `instat_comment` object and that the key columns in `new_comment` are valid keys in the data frame.
                          #' If the comment ID already exists, a warning is issued and the existing comment is replaced.
                          #' @return None. This function modifies the data sheet by adding or replacing a comment.
                          add_comment = function(new_comment) {
                            self$get_data_objects(data_name)$add_comment(new_comment)
                          },
                          
                          #' @description Deletes a comment from the data sheet based on the comment ID.
                          #' @param comment_id A character string representing the ID of the comment to be deleted.
                          #' @details If the specified comment ID does not exist in the data sheet, an error is thrown.
                          #' @return None. This function modifies the data sheet by removing the specified comment.
                          delete_comment = function(comment_id) {
                            self$get_data_objects(data_name)$delete_comment(comment_id)
                          },
                          
                          #' @description Retrieves all comment IDs currently stored in the data sheet.
                          #' @return A character vector containing the IDs of all comments in the data sheet.
                          get_comment_ids = function() {
                            return(self$get_data_objects(data_name)$get_comment_ids())
                          },
                          
                          #' @description Converts all comments in the data sheet to a data frame format for easier inspection and analysis.
                          #' @details This function collects various fields from each comment and returns them in a data frame.
                          #' The number of replies and attributes for each comment is also included.
                          #' Currently, nested comments (replies) and additional attributes are not displayed in detail.
                          #' @return A data frame with columns representing comment ID, key values, column, value, type, comment text, label, calculation, timestamp, number of replies, resolved status, active status, and number of attributes.
                          get_comments_as_data_frame = function() {
                            return(self$get_data_objects(data_name)$get_comments_as_data_frame())
                          }, 
                          
                          
                          #' @description
                          #' Define options by context for a specified dataset.
                          #' @param data_name The name of the data table.
                          #' @param obyc_types A named list of options by context types.
                          #' @param key_columns A vector of key columns relevant to the dataset.
                          define_as_options_by_context = function(data_name, obyc_types = NULL, key_columns = NULL) {
                            self$append_to_dataframe_metadata(data_name, is_obyc_label, TRUE)
                            for (curr_data_name in self$get_data_names()) {
                              if (!self$get_data_objects(data_name)$is_metadata(is_obyc_label)) {
                                self$append_to_dataframe_metadata(curr_data_name, is_obyc_label, FALSE)
                              }
                            }
                            self$get_data_objects(data_name)$set_options_by_context_types(obyc_types = obyc_types, key_columns = key_columns)
                          },
                          
                          #' @description This function updates all links that reference a data frame with a specified old name,
                          #' renaming it to a new name.
                          #' 
                          #' @param old_data_name The current name of the data frame in links
                          #' @param new_data_name The new name to replace the old data frame name in links
                          update_links_rename_data_frame = function(old_data_name, new_data_name) {
                            for(i in seq_along(private$.links)) {
                              private$.links[[i]]$rename_data_frame_in_link(old_data_name, new_data_name)
                            }
                          },
                          
                          #' Update links to rename a column
                          #' 
                          #' @description This function updates all links referencing a column in a data frame with a specified old column name,
                          #' renaming it to a new column name.
                          #' 
                          #' @param data_name The name of the data frame containing the column
                          #' @param old_column_name The current name of the column in links
                          #' @param new_column_name The new name to replace the old column name in links
                          update_links_rename_column = function(data_name, old_column_name, new_column_name) {
                            for(i in seq_along(private$.links)) {
                              private$.links[[i]]$rename_column_in_link(data_name, old_column_name, new_column_name)
                            }
                          },
                          
                          #' @description This function adds a new link between two data frames with the specified link pairs and type.
                          #' It will check if the link already exists or if the link columns are keys.
                          #' 
                          #' @param from_data_frame The name of the originating data frame in the link
                          #' @param to_data_frame The name of the target data frame in the link
                          #' @param link_pairs A named vector or list representing pairs of columns to link between data frames
                          #' @param type The type of the link (e.g., 'one-to-one', 'many-to-one')
                          #' @param link_name Optional; a name for the link. If not provided, a default name is assigned
                          add_link = function(from_data_frame, to_data_frame, link_pairs, type, link_name) {
                            if(length(names(link_pairs)) != length(link_pairs)) stop("link_pairs must be a named vector or list.")
                            if(!self$link_exists_between(from_data_frame, to_data_frame)) {
                              # This means when creating a link to single value data frame, there will be no key in to_data_frame
                              # Will this cause any issues?
                              if(length(link_pairs) > 0 && !self$is_key(to_data_frame, link_pairs)) {
                                message("link columns must be a key in the to_data_frame\nAttempting to create key...")
                                self$add_key(to_data_frame, as.character(link_pairs))
                                message("New key created")
                              }
                              new_link <- link$new(from_data_frame = from_data_frame, to_data_frame = to_data_frame, link_columns = list(link_pairs), type = type)
                              if(missing(link_name)) link_name <- instatExtras::next_default_item("link", names(private$.links))
                              if(link_name %in% names(private$.links)) warning("A link called ", link_name, " already exists. It wil be replaced.")
                              private$.links[[link_name]] <- new_link
                            }
                            else {
                              index <- integer(0)
                              for(i in 1:length(private$.links)) {
                                if(private$.links[[i]]$from_data_frame == from_data_frame && private$.links[[i]]$to_data_frame == to_data_frame) {
                                  index <- i
                                  from_on_left <- TRUE
                                  break
                                }
                                else if(private$.links[[i]]$from_data_frame == to_data_frame && private$.links[[i]]$to_data_frame == from_data_frame) {
                                  index <- i
                                  from_on_left <- FALSE
                                  break
                                }
                              }
                              # This should never happen because we are inside the Else of link_exists_between
                              if(length(index) == 0) stop("link not found")
                              
                              if(type != private$.links[[index]]$type) stop("Cannot add link of type ", type, ". These data frames are already linked by type: ", private$.links[[index]]$type)
                              curr_link_columns <- private$.links[[index]]$link_columns
                              curr_num_links <- length(curr_link_columns)
                              found <- FALSE
                              for(curr_link_pairs in curr_link_columns) {
                                # Are these the right checks on the link columns?
                                if(from_on_left && length(link_pairs) == length(curr_link_pairs) && setequal(names(link_pairs), names(curr_link_pairs))) {
                                  message("A link with these columns already exists. A new link will not be added.")
                                  found <- TRUE
                                  break
                                }
                                else if(!from_on_left && length(link_pairs) == length(curr_link_pairs) && (setequal(link_pairs, names(curr_link_pairs)))) {
                                  message("A link with these columns already exists. A new link will not be added.")
                                  found <- TRUE
                                  break
                                }
                              }
                              if(!found) {
                                if(!self$is_key(to_data_frame, link_pairs)) {
                                  message("link columns must be a key in the to_data_frame\nAttempting to create key...")
                                  self$add_key(to_data_frame, as.character(link_pairs))
                                  message("new key created")
                                }
                                if(from_on_left) private$.links[[index]]$link_columns[[curr_num_links + 1]] <- link_pairs
                                else {
                                  new_link_pairs <- names(link_pairs)
                                  names(new_link_pairs) <- link_pairs
                                  private$.links[[index]]$link_columns[[curr_num_links + 1]] <- new_link_pairs
                                }
                              }
                            }
                            if (from_data_frame != to_data_frame){
                              cat(paste("Link name:", link_name),
                                  paste("From data frame:", from_data_frame),
                                  paste("To data frame:", to_data_frame),
                                  paste("Link columns:", paste(names(link_pairs), "=", link_pairs, collapse = ", ")),
                                  sep = "\n")
                            }
                          },
                          
                          #' @description Retrieves the names of all links involving a specified data frame, with options to include or exclude specific types.
                          #' 
                          #' @param data_name The name of the data frame
                          #' @param include_overall Boolean; if TRUE, includes overall links
                          #' @param include Optional vector of link names to include
                          #' @param exclude Optional vector of link names to exclude
                          #' @param include_empty Boolean; if TRUE, includes links with no associated data
                          #' @param as_list Boolean; if TRUE, returns a list format
                          get_link_names = function(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE) {
                            if(exclude_self_links) {
                              out <- c()
                              i <- 1
                              for(link in private$.links) {
                                if(link$from_data_frame != link$to_data_frame) out <- c(out, names(private$.links)[i])
                                i <- i + 1
                              }
                            }
                            else out <- names(private$.links)
                            if(as_list) {
                              lst <- list()
                              lst[[overall_label]] <- out
                              return(lst)
                            }
                            else return(out)
                          },
                          
                          #' @description Verifies if a link exists from a specific data frame with given link pairs.
                          #' 
                          #' @param curr_data_frame The name of the originating data frame
                          #' @param link_pairs The link pairs to check for existence
                          link_exists_from = function(curr_data_frame, link_pairs) {
                            link_exists <- FALSE
                            for(curr_link in private$.links) {
                              if(curr_link$from_data_frame == curr_data_frame) {
                                for(curr_link_pairs in curr_link$link_columns) {
                                  if(length(link_pairs) == length(curr_link_pairs) && setequal(link_pairs, names(curr_link_pairs))) {
                                    return(TRUE)
                                    break
                                  }
                                }
                              }
                            }
                            return(FALSE)
                          },
                          
                          #' @description This function checks if there is an ordered or unordered link between two specified data frames.
                          #' 
                          #' @param from_data_frame The name of the originating data frame
                          #' @param to_data_frame The name of the target data frame
                          #' @param ordered Boolean; if TRUE, checks for an ordered link
                          link_exists_between = function(from_data_frame, to_data_frame, ordered = FALSE) {
                            # If ordered = TRUE then from_data_frame must be from_data_frame in the link
                            # otherwise from_data_frame could be to_data_frame in the link
                            if(ordered) {
                              return(any(sapply(private$.links, function(link) link$from_data_frame == from_data_frame && link$to_data_frame == to_data_frame)))
                            }
                            else {
                              return(any(sapply(private$.links, function(link) link$from_data_frame == from_data_frame && link$to_data_frame == to_data_frame))
                                     || any(sapply(private$.links, function(link) link$from_data_frame == to_data_frame && link$to_data_frame == from_data_frame)))
                            }
                          },
                          
                          #' @description Retrieves the link definition between two specified data frames.
                          #' 
                          #' @param from_data_frame The name of the originating data frame
                          #' @param to_data_frame The name of the target data frame
                          #' @param ordered Boolean; if TRUE, retrieves an ordered link
                          get_link_between = function(from_data_frame, to_data_frame, ordered = FALSE) {
                            if(ordered) {
                              for(curr_link in private$.links) {
                                if((curr_link$from_data_frame == from_data_frame && curr_link$to_data_frame == to_data_frame)) {
                                  return(curr_link)
                                }
                              }
                            }
                            else {
                              for(curr_link in private$.links) {
                                if((curr_link$from_data_frame == from_data_frame && curr_link$to_data_frame == to_data_frame) || (curr_link$from_data_frame == to_data_frame && curr_link$to_data_frame == from_data_frame)) {
                                  return(curr_link)
                                }
                              }
                            }
                            return(NULL)
                          },
                          
                          #' @description This function checks if a link exists from `first_data_frame` to `second_data_frame`
                          #' using the specified `link_pairs` columns.
                          #'
                          #' @param first_data_frame Name of the starting data frame.
                          #' @param link_pairs Named vector of columns used in the link.
                          #' @param second_data_frame Name of the target data frame.
                          #' @return Boolean indicating whether the specified link exists.
                          link_exists_from_by_to = function(first_data_frame, link_pairs, second_data_frame) {
                            link_exists <- FALSE
                            for(curr_link in private$.links) {
                              if(curr_link$from_data_frame == first_data_frame && curr_link$to_data_frame == second_data_frame) {
                                for(curr_link_pairs in curr_link$link_columns) {
                                  if(length(link_pairs) == length(curr_link_pairs) && setequal(link_pairs, names(curr_link_pairs))) {
                                    return(TRUE)
                                    break
                                  }
                                }
                              }
                            }
                            return(FALSE)
                          },
                          
                          #' @description This function returns the names of data frames linked to `from_data_frame`.
                          #' Optionally, includes `from_data_frame` itself in the output if `include_self` is TRUE.
                          #' Filters results by `link_cols`, if provided.
                          #'
                          #' @param from_data_frame Name of the source data frame.
                          #' @param link_cols Optional column names to filter links.
                          #' @param include_self Boolean indicating if `from_data_frame` should be included.
                          #' @return A character vector of data frame names.
                          get_linked_to_data_name = function(from_data_frame, link_cols = c(), include_self = FALSE) {
                            out <- c()
                            if(include_self) out <- c(out, from_data_frame)
                            for(curr_link in private$.links) {
                              if(curr_link$from_data_frame == from_data_frame) {
                                if(length(link_cols) == 0) {
                                  out <- c(out, curr_link$to_data_frame)
                                }
                                else {
                                  for(curr_link_pairs in curr_link$link_columns) {
                                    if(length(link_cols) == length(curr_link_pairs) && setequal(link_cols, names(curr_link_pairs))) {
                                      out <- c(out, curr_link$to_data_frame)
                                    }
                                  }
                                }
                              }
                            }
                            return(unique(out))
                          },
                          
                          #' @description This function returns a list of the target data frame and matched columns.
                          #'
                          #' @param from_data_frame Name of the source data frame.
                          #' @param link_pairs Named vector of link columns.
                          #' @return List with the target data frame name and matching column names.
                          get_linked_to_definition = function(from_data_frame, link_pairs) {
                            to_data_name <- self$get_linked_to_data_name(from_data_frame, link_pairs)
                            if(length(to_data_name) > 0) {
                              # TODO what happens if there is more than 1?
                              to_data_name <- to_data_name[1]
                              curr_link <- self$get_link_between(from_data_frame, to_data_name)
                              for(curr_link in private$.links) {
                                for(curr_link_pairs in curr_link$link_columns) {
                                  if(length(link_pairs) == length(curr_link_pairs) && setequal(link_pairs, names(curr_link_pairs))) {
                                    return(list(to_data_name, as.vector(curr_link_pairs[link_pairs])))
                                  }
                                }
                              }
                            }
                            return(list())
                          },
                          
                          #' @description This function attempts to find a linked data frame that matches `link_pairs`.
                          #' Recursively explores links between multiple data frames.
                          #'
                          #' @param from_data_frame Name of the starting data frame.
                          #' @param link_pairs Named vector of columns used in the link.
                          #' @return List with the name and columns of a matching linked data frame, or an empty list.
                          get_possible_linked_to_definition = function(from_data_frame, link_pairs) {
                            def <- self$get_linked_to_definition(from_data_frame, link_pairs)
                            if(length(def) != 0) return(def)
                            else {
                              prev_data_links <- list(list(from_data_frame, link_pairs))
                              continue <- TRUE
                              while(continue) {
                                curr_data_links <- prev_data_links
                                curr_data_names <- sapply(curr_data_links, function(x) x[[1]])
                                for(to_data_name in self$get_data_names()) {
                                  i = 1
                                  for(curr_from_data_frame in curr_data_names) {
                                    curr_link_cols <- self$link_between_containing(curr_from_data_frame, curr_data_links[[i]][[2]], to_data_name)
                                    # Is it enough to check unqiue data frames?
                                    if(length(curr_link_cols) != 0 && !(to_data_name %in% sapply(curr_data_links, function(x) x[[1]]))) {
                                      curr_data_links[[length(curr_data_links) + 1]] <- list(to_data_name, curr_link_cols)
                                    }
                                    i = i + 1
                                  }
                                }
                                if(length(prev_data_links) != length(curr_data_links)) {
                                  curr_data_names <- sapply(curr_data_links, function(x) x[[1]])
                                  prev_data_names <- sapply(prev_data_links, function(x) x[[1]])
                                  for(i in seq_along(curr_data_names)) {
                                    if(curr_data_names[i] %in% setdiff(curr_data_names, prev_data_names)) {
                                      def <- self$get_linked_to_definition(curr_data_names[i], curr_data_links[[i]][[2]])
                                      if(length(def) > 0) return(def)
                                    }
                                  }
                                  prev_data_links <- curr_data_links
                                }
                                else continue <- FALSE
                              }
                              return(c())
                            }
                          },
                          
                          #' @description This function returns columns in `to_data_name` equivalent to `columns` in `from_data_name`.
                          #' Recursively searches links between multiple data frames.
                          #'
                          #' @param from_data_name Name of the source data frame.
                          #' @param columns Columns to be matched.
                          #' @param to_data_name Name of the target data frame.
                          #' @return Character vector of equivalent column names in `to_data_name`, or an empty vector.
                          get_equivalent_columns = function(from_data_name, columns, to_data_name) {
                            if(from_data_name == to_data_name) equivalent_columns <- columns
                            else equivalent_columns <- self$link_between_containing(from_data_name, columns, to_data_name)
                            if(length(equivalent_columns) != 0) return(equivalent_columns)
                            else {
                              prev_data_links <- list(list(from_data_name, columns))
                              continue <- TRUE
                              while(continue) {
                                curr_data_links <- prev_data_links
                                curr_data_names <- sapply(curr_data_links, function(x) x[[1]])
                                for(temp_data_name in self$get_data_names()) {
                                  i = 1
                                  for(curr_from_data_frame in curr_data_names) {
                                    if(curr_from_data_frame == temp_data_name) curr_link_cols <- curr_data_links[[i]][[2]]
                                    curr_link_cols <- self$link_between_containing(curr_from_data_frame, curr_data_links[[i]][[2]], temp_data_name)
                                    if(length(curr_link_cols) != 0) {
                                      if(temp_data_name == to_data_name) {
                                        return(curr_link_cols)
                                      }
                                      else if(!(temp_data_name %in% sapply(curr_data_links, function(x) x[[1]]))) {
                                        curr_data_links[[length(curr_data_links) + 1]] <- list(temp_data_name, curr_link_cols)
                                      }
                                    }
                                    i = i + 1
                                  }
                                }
                                if(length(prev_data_links) == length(curr_data_links)) continue <- FALSE
                                else prev_data_links <- curr_data_links
                              }
                              return(c())
                            }
                          },
                          
                          #' @description This function returns columns in `to_data_frame` corresponding to `containing_columns` in `from_data_frame`
                          #' if a link exists between them.
                          #'
                          #' @param from_data_frame Name of the source data frame.
                          #' @param containing_columns Columns to search for in the link.
                          #' @param to_data_frame Name of the target data frame.
                          #' @return Character vector of columns in `to_data_frame` if a matching link is found, otherwise an empty vector.
                          link_between_containing = function(from_data_frame, containing_columns, to_data_frame) {
                            if(self$link_exists_between(from_data_frame, to_data_frame)) {
                              curr_link <- self$get_link_between(from_data_frame, to_data_frame)
                              for(curr_link_pairs in curr_link$link_columns) {
                                if(curr_link$from_data_frame == from_data_frame) {
                                  if(all(containing_columns %in% names(curr_link_pairs))) {
                                    out <- c()
                                    for(col in containing_columns) {
                                      ind <- which(names(curr_link_pairs) == col)
                                      out <- c(out, curr_link_pairs[[ind]])
                                    }
                                    return(out)
                                  }
                                }
                                else {
                                  if(all(containing_columns %in% curr_link_pairs)) {
                                    out <- c()
                                    for(col in containing_columns) {
                                      ind <- which(curr_link_pairs == col)
                                      out <- c(out, names(curr_link_pairs)[ind])
                                    }
                                    return(out)
                                  }
                                }
                              }
                            }
                            return(c())
                          },
                          
                          #' @description Displays the details of a specified link.
                          #' @param link_name The name of the link to view
                          view_link = function(link_name) {
                            temp_link <- self$get_links(link_name)
                            out <- ""
                            if(length(temp_link) > 0) {
                              out <- cat(paste(
                                paste("Link name:", link_name),
                                paste("From data frame:", temp_link$from_data_frame),
                                paste("To data frame:", temp_link$to_data_frame),
                                paste("Link columns:", paste(names(temp_link$link_columns), "=", temp_link$link_columns, collapse = ", ")), sep = "\n"))
                            }
                          },
                          
                          #' @description This method applies a given calculation to the data stored in the `DataBook` object. 
                          #' It supports various calculation types (e.g., "summary") and includes options for storing 
                          #' and returning results.
                          #'
                          #' @param calc A calculation object specifying the type of calculation and its parameters. 
                          #'             For a "summary" calculation, parameters should include:
                          #'             - `data_name`: The name of the data object to apply the calculation to.
                          #'             - `columns_to_summarise`: Columns to include in the summary.
                          #'             - `summaries`: The summary operations to perform.
                          #'             - `store_results`: Whether to store the results in the `DataBook`.
                          #'             - `return_output`: Whether to return the summary output.
                          #'
                          #' @return If `return_output = TRUE`, returns the calculation results as a data frame; otherwise, 
                          #'         returns `NULL`.
                          apply_calculation = function(calc) {
                            if(calc$type == "summary") {
                              out <- self$get_data_objects(calc[["parameters"]][["data_name"]])$calculate_summary(calc = calc, ... = calc[["parameters"]][["..."]])
                              if(calc[["parameters"]][["store_results"]]) self$append_summaries_to_data_object(out, calc[["parameters"]][["data_name"]], calc[["parameters"]][["columns_to_summarise"]], calc[["parameters"]][["summaries"]], calc[["parameters"]][["factors"]], calc[["parameters"]][["summary_name"]], calc)
                              if(calc[["parameters"]][["return_output"]]) return(out)
                              else return(NULL)
                            }
                          },
                          
                          #' @description This method saves a calculation to a specific data frame within the `DataBook` object. 
                          #' The calculation is stored in the designated data frame's calculation registry for 
                          #' future reference and reuse.
                          #'
                          #' @param end_data_frame A string specifying the name of the data frame where the calculation 
                          #'                       should be saved.
                          #' @param calc A calculation object or list that defines the calculation to be saved. 
                          #'             This object should include relevant parameters and metadata for the calculation.
                          #'
                          #' @return None. The method performs the operation in-place, saving the calculation to the 
                          #'         specified data frame.
                          #'
                          #' @details
                          #' - This method retrieves the `end_data_frame` from the `DataBook` object and invokes its 
                          #'   `save_calculation` method to store the calculation.
                          #' - The `calc` object typically includes details such as its `name`, `type`, and any parameters 
                          #'   or dependencies required to perform the calculation.
                          #'
                          #' @note This method delegates the actual saving of the calculation to the respective 
                          #'       data frame's `save_calculation` method, ensuring modularity and separation of concerns.
                          save_calculation = function(end_data_frame, calc) {
                            self$get_data_objects(end_data_frame)$save_calculation(calc)
                          },
                          
                          
                          #' @description This method performs a calculation or series of calculations (including sub-calculations) on data 
                          #' within the `DataBook` object. It supports recursive calls for managing dependencies between 
                          #' manipulations and sub-calculations.
                          #' This method is called recursively, and it would not be called by a user, another function would always handle the output and display
                          #' results to the user (usually only the $data part of the list)
                          #'
                          #' @param calc A calculation object
                          #' @param curr_data_list A list of data objects currently being used. Optional.
                          #' @param previous_manipulations A list of previously applied manipulations, used recursively. Default is `list()`.
                          #' @param param_list A list of additional parameters for the calculation. Default is `list()`.
                          #'
                          #' @return A list with four elements:
                          #'   - `$data`: A data frame containing the output from the calculation, usually not just the output but also other columns at the same "level"
                          #'   - `$link`: A link used to determine which data frame the output should be saved in.
                          #'   - `$has_summary`: Logical, whether a summary was performed.
                          #'   - `$has_filter`: Logical, whether a filter was applied.
                          #'
                          #' @details
                          #' - **Manipulations**: Applied sequentially, with the output of one manipulation passed to the next.
                          #' - **Sub-Calculations**: Performed independently, with their outputs combined or merged as needed.
                          #' - **Recursive Behavior**: The method is called recursively for handling dependencies and grouping.
                          #' 
                          apply_instat_calculation = function(calc, curr_data_list, previous_manipulations = list(), param_list = list()) {
                            # for our by calculation, read our drop parameter which is stored in param_list. This is read in
                            drop_value <- ifelse("drop" %in% names(param_list), param_list$drop, FALSE)
                            preserve_value <- ifelse("preserve" %in% names(param_list), param_list$preserve, FALSE)
                            
                            # apply each manipulation first, and recursively store the output and pass to the next manipulation
                            # because of this, manipulations are dependant on each other
                            for(manipulation in calc$manipulations) {
                              curr_data_list <- self$apply_instat_calculation(manipulation, curr_data_list, previous_manipulations, param_list = param_list)
                              previous_manipulations[[length(previous_manipulations) + 1]] <- manipulation
                            }
                            # If curr_data_list is not empty, (either an argument or from manipulations)
                            # then this is passed in to apply_instat_calculation for each sub_calculation
                            # sub_calculations are independant of each other (the order does not affect the output)
                            if(!missing(curr_data_list)) {
                              sub_calc_results <- curr_data_list
                              curr_groups <- dplyr::groups(curr_data_list[[c_data_label]])
                            }
                            else curr_groups <- c()
                            first_sub_calc <- TRUE
                            
                            for(sub_calc in calc$sub_calculations) {
                              curr_sub_calc <- self$apply_instat_calculation(sub_calc, curr_data_list, previous_manipulations, param_list = param_list)
                              if(first_sub_calc) {
                                sub_calc_results <- curr_sub_calc
                                first_sub_calc <- FALSE
                              }
                              else {
                                #### Set the require_merge logical
                                # Defined as variables as these are needed later 
                                #overall_merge_required <- sub_calc_results[[c_require_merge_label]]
                                #current_calc_merge_required <- curr_sub_calc[[c_require_merge_label]]
                                overall_has_summary <- sub_calc_results[[c_has_summary_label]]
                                overall_has_filter <- sub_calc_results[[c_has_filter_label]]
                                current_calc_has_summary <- curr_sub_calc[[c_has_summary_label]]
                                current_calc_has_filter <- curr_sub_calc[[c_has_filter_label]]
                                
                                # A merge is required if a merge was already required, or if the current sub_calculation requires a merge
                                #sub_calc_results[[c_require_merge_label]] <- overall_merge_required || current_calc_merge_required
                                # TODO how to set new values for has summary/filter
                                
                                #### Set the data and link
                                # Defined as variables as these are used throughout 
                                curr_calc_link_cols <- curr_sub_calc[[c_link_label]][["link_cols"]]
                                overall_calc_link_cols <- sub_calc_results[[c_link_label]][["link_cols"]]
                                curr_calc_from <- curr_sub_calc[[c_link_label]][["from_data_frame"]]
                                overall_calc_from <- sub_calc_results[[c_link_label]][["from_data_frame"]]
                                
                                # Warning if current sub calc result is already in the data
                                if(sub_calc$result_name %in% names(sub_calc_results[[c_data_label]])) warning(sub_calc$result_name, " is already a column in the existing data. The column will be replaced. This may have unintended consequences for the calculation")
                                
                                # If either calc is a single value summary we don't do a merge.
                                if((current_calc_has_summary && length(curr_calc_link_cols) == 0) || (overall_has_summary && length(overall_calc_link_cols) == 0)) {
                                  # Don't think this needs to be done separately now
                                  # If both calcs are single value summaries
                                  # if(current_calc_has_summary && length(curr_calc_link_cols) == 0 && overall_has_summary && length(overall_calc_link_cols) == 0) {
                                  #   sub_calc_results[[c_data_label]] <- mutate(sub_calc_results[[c_data_label]], curr_sub_calc[[c_data_label]])
                                  # }
                                  
                                  # If curr_calc is a single value, add this on to overall data as new column
                                  # QUESTION: Should there be checks here? This "works" with any two data frames
                                  #           because it's just adding a single value as a new column
                                  if(current_calc_has_summary && length(curr_calc_link_cols) == 0) {
                                    sub_calc_results[[c_data_label]][[sub_calc$result_name]] <- curr_sub_calc[[c_data_label]][[1]]
                                  }
                                  # If only overall is a single value, add this on to the current sub calc output
                                  # QUESTION: Should there be checks here? This "works" with any two data frames
                                  #           because it's just adding a single value as a new column
                                  else if(overall_has_summary && length(overall_calc_link_cols) == 0 && !(current_calc_has_summary && length(curr_calc_link_cols) == 0)) {
                                    temp_data <- curr_sub_calc[[c_data_label]]
                                    temp_data[[names(sub_calc_results[[c_data_label]])[1]]] <- sub_calc_results[[c_data_label]][[1]]
                                    sub_calc_results[[c_data_label]] <- temp_data
                                    sub_calc_results[[c_has_summary_label]] <- curr_sub_calc[[c_has_summary_label]]
                                    sub_calc_results[[c_has_filter_label]] <- curr_sub_calc[[c_has_filter_label]]
                                    sub_calc_results[[c_link_label]] <- curr_sub_calc[[c_link_label]]
                                    #TODO Multiple links needed
                                    #     Above changes the from_data_frame. Is that what we want?
                                  }
                                }
                                # In this case, both are simple calculations on the same data frame without filters
                                # So we just add a column instead of a merge.
                                else if(curr_calc_from == overall_calc_from && !overall_has_summary && !overall_has_filter && !current_calc_has_summary && !current_calc_has_filter) {
                                  sub_calc_results[[c_data_label]][[sub_calc$result_name]] <- curr_sub_calc[[c_data_label]][[sub_calc$result_name]]
                                }
                                # Otherwise we must do a merge.
                                # If we can't do a merge, we stop here.
                                else {
                                  # To be able to do a merge, a key in one of the DFs must be "equivalent" to a subset of a key in the other
                                  # If the DF is a summary, then the link columns define the only key
                                  if(overall_has_summary) {
                                    overall_links <- list()
                                    overall_links[[1]] <- overall_calc_link_cols
                                  }
                                  # Otherwise, there must be existing keys defined in the data frame
                                  else {
                                    if(!self$has_key(overall_calc_from))  stop("Cannot merge sub calculations as there is no key defined in ", overall_calc_from)
                                    overall_links <- self$get_keys(overall_calc_from)
                                  }
                                  if(current_calc_has_summary) {
                                    curr_calc_links <- list()
                                    curr_calc_links[[1]] <- curr_calc_link_cols
                                  }
                                  else {
                                    if(!self$has_key(curr_calc_from))  stop("Cannot merge sub calculations as there is no key defined in ", curr_calc_from)
                                    curr_calc_links <- self$get_keys(curr_calc_from)
                                  }
                                  by <- NULL
                                  for(temp_overall_link in overall_links) {
                                    for(temp_curr_link in curr_calc_links) {
                                      equ_overall_cols <- self$get_equivalent_columns(curr_calc_from, temp_curr_link, overall_calc_from)
                                      if(length(equ_overall_cols) > 0 && all(equ_overall_cols %in% temp_overall_link)) {
                                        by <- temp_curr_link
                                        names(by) <- equ_overall_cols
                                        join_into_overall <- TRUE
                                        break
                                      }
                                      equ_curr_cols <- self$get_equivalent_columns(overall_calc_from, temp_overall_link, curr_calc_from)
                                      if(length(equ_curr_cols) > 0 && all(equ_curr_cols %in% temp_curr_link)) {
                                        by <- temp_overall_link
                                        names(by) <- equ_curr_cols
                                        join_into_overall <- FALSE
                                        break
                                      }
                                    }
                                    if(length(by) > 0) break
                                  }
                                  if(length(by) == 0) {
                                    stop("Cannot find linking columns to merge output from sub calculations.")
                                  }
                                  
                                  # If the data frames are the same and filters have been used then need to subset before the join
                                  # so that we don't get duplicate columns
                                  joined <- FALSE
                                  if(curr_calc_from == overall_calc_from) {
                                    if(overall_has_filter && current_calc_has_filter) {
                                      # If both sub calcs have filter then the order of the rows in the output may not be sensible
                                      # if filters are different but this case should be rare
                                      # To avoid possibly losing data by subsetting columns we don't subset here and instead add to by columns
                                      additional_cols <- intersect(names(sub_calc_results[[c_data_label]]), names(curr_sub_calc[[c_data_label]]))
                                      additional_cols <- additional_cols[!additional_cols %in% by]
                                      if(length(additional_cols) > 0) by <- c(by, additional_cols)
                                      sub_calc_results[[c_data_label]] <- dplyr::full_join(curr_sub_calc[[c_data_label]], sub_calc_results[[c_data_label]], by = by)
                                      joined <- TRUE
                                    }
                                    else if(overall_has_filter) {
                                      # If the overall data has a filter and current does not, then we should merge the overall into the current
                                      # We subset the current data to only have by and the output columns so that merge doesn't produce duplicate columns
                                      # Overall sub data should be full data so we don't lose any data by subsetting the current sub calc
                                      sub_calc_results[[c_data_label]] <- dplyr::full_join(curr_sub_calc[[c_data_label]][c(as.vector(by), sub_calc$result_name)], sub_calc_results[[c_data_label]], by = by)
                                      # Current data has no filter so output now does not
                                      sub_calc_results[[c_has_filter_label]] <- FALSE
                                      joined <- TRUE
                                    }
                                    else if(current_calc_has_filter) {
                                      # If the current data has a filter and overall does not, then we should merge the current into the overall
                                      # We subset the current data to only have by and output columns so that merge doesn't produce duplicate columns
                                      # Overall sub data should be full data so we don't lose any data by subsetting the current sub calc
                                      sub_calc_cols <- as.vector(by)
                                      if(sub_calc$result_name != "") sub_calc_cols <- c(sub_calc_cols, sub_calc$result_name)
                                      sub_calc_results[[c_data_label]] <- dplyr::full_join(sub_calc_results[[c_data_label]], curr_sub_calc[[c_data_label]][sub_calc_cols], by = by)
                                      # Overall data has no filter so output does even though current does
                                      joined <- TRUE
                                    }
                                  }
                                  if(!joined) {
                                    if(join_into_overall) sub_calc_results[[c_data_label]] <- dplyr::full_join(sub_calc_results[[c_data_label]], curr_sub_calc[[c_data_label]], by = by)
                                    else {
                                      sub_calc_results[[c_data_label]] <- dplyr::full_join(curr_sub_calc[[c_data_label]], sub_calc_results[[c_data_label]], by = by)
                                      # The overall data will be joined into the current sub calc, so this becomes the new link
                                      sub_calc_results[[c_link_label]] <- curr_sub_calc[[c_link_label]]
                                    }
                                  }
                                }
                              }
                            }
                            
                            # If there were any sub_calculations then the input for the main calculation should be the output from the last sub_calculation
                            # Otherwise it is the output from the mainipulations
                            if(!first_sub_calc) curr_data_list <- sub_calc_results
                            
                            #TODO investigate better way to do this
                            #     Any case where we don't want this?
                            # we want param_list to read into them all, not just "by", otherwise we lose our parameters here.
                            for(var in curr_groups) {
                              curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::group_by(dplyr::across({{ var }}), .add = TRUE, .drop = drop_value)
                            }  
                            
                            # Names of the data frames required for the calculation
                            data_names <- unique(as.vector(names(calc$calculated_from)))
                            # If argument was missing and there were no manipulations or sub_calculations then it should be created.
                            if(missing(curr_data_list)) {
                              if(length(data_names) == 0) stop("No data specified for calculation.")
                              #else if(length(data_names) > 1) stop("Calculations from multiple data frame not yet implemented")
                              else {
                                curr_data_list <- list()
                                #TODO Add current filter as manipulation in calc definition if needed.
                                # The data is the data from the instat object based on data_names
                                curr_data_list[[c_data_label]] <- self$get_data_frame(data_names[[1]], use_current_filter = FALSE)
                                # The link has from_data_frame based on data_names and no current linking columns
                                link_list <- list(data_names[[1]], c())
                                names(link_list) <- c("from_data_frame", "link_cols")
                                curr_data_list[[c_link_label]] <- link_list
                                # By default, a summary or filter has not been done
                                #curr_data_list[[c_require_merge_label]] <- FALSE
                                curr_data_list[[c_has_summary_label]] <- FALSE
                                curr_data_list[[c_has_filter_label]] <- FALSE
                              }
                            }
                            
                            col_names_exp = c()
                            col_names_exp_2 <- c()
                            i = 1
                            # This checks that the columns specified in calculated_from appear in the current data
                            for(i in seq_along(calc$calculated_from)) {
                              col_name <- calc$calculated_from[[i]]
                              data_frame_name <- names(calc$calculated_from)[i]
                              overall_calc_from <- curr_data_list[[c_link_label]][["from_data_frame"]]
                              # TODO Is this a good check?
                              if(!(col_name %in% names(curr_data_list[[c_data_label]]))) {
                                if(curr_data_list[[c_has_summary_label]]) {
                                  overall_links <- list()
                                  overall_links[[1]] <- curr_data_list[[c_link_label]][["link_cols"]]
                                }
                                # Otherwise, there use the keys if they exist
                                else {
                                  if(self$has_key(overall_calc_from)) {
                                    overall_links <- self$get_keys(overall_calc_from)
                                  }
                                  else overall_links <- NULL
                                }
                                if(self$has_key(data_frame_name)) {
                                  new_data_links <- self$get_keys(data_frame_name)
                                }
                                else new_data_links <- NULL
                                #TODO Make this it's own method?
                                by <- NULL
                                # Search for linking columns from overall_links
                                for(temp_overall_link in overall_links) {
                                  equ_curr_cols <- self$get_equivalent_columns(overall_calc_from, temp_overall_link, data_frame_name)
                                  if(length(equ_curr_cols) > 0) { # && all(equ_curr_cols %in% temp_curr_link)) {
                                    by <- temp_overall_link
                                    names(by) <- equ_curr_cols
                                    join_into_overall <- FALSE
                                    break
                                  }
                                }
                                # If not found, search for linking columns from new_data_links
                                if(length(by) == 0) {
                                  for(temp_curr_link in new_data_links) {
                                    equ_overall_cols <- self$get_equivalent_columns(data_frame_name, temp_curr_link, overall_calc_from)
                                    if(length(equ_overall_cols) > 0) { #&& all(equ_overall_cols %in% temp_overall_link)) {
                                      by <- temp_curr_link
                                      names(by) <- equ_overall_cols
                                      join_into_overall <- TRUE
                                      break
                                    }
                                  }
                                }
                                if(length(by) == 0) {
                                  stop("Cannot find linking columns to merge output from sub calculations with data for calculated_from.")
                                }
                                if(join_into_overall){
                                  new_data_list <- self$get_data_frame(data_frame_name, use_current_filter = FALSE)
                                  by_col_attributes <- list()
                                  for(i in seq_along(by)) {
                                    # Collect column attributes
                                    by_col_attributes[[by[[i]]]] <- instatExtras::get_column_attributes(new_data_list[[by[[i]]]])
                                    
                                    # Check and align the data types for each "by" column
                                    if (class(new_data_list[[by[[i]]]]) != class(curr_data_list[[c_data_label]][[by[[i]]]])) {
                                      warning(paste0("Type is different for ", by[[i]], " in the two data frames. Setting as numeric in both data frames."))
                                      
                                      # Convert factors to numeric if necessary
                                      if (inherits(new_data_list[[by[[i]]]], "factor")) {
                                        new_data_list[[by[[i]]]] <- as.numeric(as.character(new_data_list[[by[[i]]]]))
                                      } else if (inherits(curr_data_list[[c_data_label]][[by[[i]]]], "factor")) {
                                        curr_data_list[[c_data_label]][[by[[i]]]] <- as.numeric(as.character(curr_data_list[[c_data_label]][[by[[i]]]]))
                                      } else {
                                        stop(paste0("Type is different for ", by[[i]], " in the two data frames and cannot be coerced."))
                                      }
                                    }
                                  }
                                  curr_data_list[[c_data_label]] <- dplyr::full_join(curr_data_list[[c_data_label]], self$get_data_frame(data_frame_name, use_current_filter = FALSE), by = by)
                                } else {
                                  curr_groups <- dplyr::groups(curr_data_list[[c_data_label]])
                                  curr_data_list[[c_data_label]] <- dplyr::full_join(self$get_data_frame(data_frame_name, use_current_filter = FALSE), curr_data_list[[c_data_label]], by = by)
                                  #TODO investigate better way to do this
                                  #     Any case where we don't want this?
                                  for(var in curr_groups) {
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::group_by(dplyr::across({{ var }}), .add = TRUE, .drop = drop_value)
                                  }
                                  # The overall data is joined into the current sub calc, so the curr_data_list is "reset" to default values
                                  curr_data_list[[c_link_label]] <- list(from_data_frame = data_frame_name, link_cols = c())
                                  curr_data_list[[c_has_summary_label]] <- FALSE
                                  curr_data_list[[c_has_filter_label]] <- FALSE
                                }
                              }
                              # This is a character vector containing the column names in a format that can be passed to dplyr functions using Standard Evalulation
                              col_names_exp[[i]] <- lazyeval::interp(~ var, var = as.name(col_name))
                              col_names_exp_2[i] <- col_name
                              i = i + 1
                            }
                            
                            # this type is adding a column to the data
                            # the data is at the same "level" so the link is unchanged
                            if(calc$type == "calculation") {
                              if(calc$result_name %in% names(curr_data_list[[c_data_label]])) warning(calc$result_name, " is already a column in the existing data. The column will be replaced. This may have unintended consequences for the calculation")
                              curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% 
                                #dplyr::mutate_(.dots = setNames(list(as.formula(paste0("~", calc$function_exp))), calc$result_name))
                                dplyr::mutate(!!as.name(calc$result_name) := !!rlang::parse_expr(calc$function_exp))
                              
                            }
                            # this type performs a summary
                            # the data is not at a different "level" so the link is changed and link columns are the groups of the data before summarising
                            # A merge is now required because the data is at a different "level"
                            else if(calc$type == "summary") {
                              curr_data_list[[c_link_label]][["link_cols"]] <- as.character(dplyr::groups(curr_data_list[[c_data_label]]))
                              calc_from_data_name <- curr_data_list[[c_link_label]][["from_data_frame"]]
                              formula_fn_exp <- as.formula(paste0("~", calc$function_exp))
                              # note: important that there is *no* space between | for grepl function
                              # and important there IS a psace in str_detect..!
                              
                              if (exists("col_name")){
                                # get the data type of the column
                                col_data_type <- self$get_variables_metadata(data_name = calc_from_data_name, column = col_name, property = "class")
                                # if it is a ordered factor...
                                if (any(stringr::str_detect("ordered", col_data_type))){
                                  
                                  # put in here the ones that DO work for ordered factor
                                  if (any(grepl("summary_count|summary_count_miss|summary_n_distinct|summary_count_all|summary_min|summary_max|summary_range|summary_median|summary_quantile|p10|p20|p25|p30|p33|p40|p60|p67|p70|p75|p80|p90|proportion_calc|count_calc", formula_fn_exp))){
                                    
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      dplyr::summarise(!!calc$result_name := !!rlang::parse_expr(calc$function_exp))
                                  } else {
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      #dplyr::summarise_(.dots = setNames(list(NA), calc$result_name))
                                      dplyr::summarise(!!calc$result_name := NA)
                                  }
                                  # if it is a factor or character, do not work for anything except...
                                } else if (any(stringr::str_detect("factor | character", col_data_type))){
                                  # put in here the ones that DO work for factor or character
                                  if (any(grepl("summary_count|summary_count_miss|summary_n_distinct|summary_count_all", formula_fn_exp))){
                                    
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      dplyr::summarise(!!calc$result_name := !!rlang::parse_expr(calc$function_exp)) 
                                  } else {
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      dplyr::summarise(!!calc$result_name := NA)
                                  }
                                } else if (any(stringr::str_detect("Date | POSIXct | POSIXt", col_data_type))){
                                  # put in here the ones that DO NOT work for date
                                  if (any(grepl("summary_sum", formula_fn_exp))){
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      dplyr::summarise(!!calc$result_name := NA)
                                  } else {
                                    curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>%
                                      dplyr::summarise(!!calc$result_name := !!rlang::parse_expr(calc$function_exp)) 
                                  }
                                } else {
                                  curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::summarise(!!calc$result_name := !!rlang::parse_expr(calc$function_exp))
                                  #curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::summarise_(.dots = setNames(list(as.formula(paste0("~", calc$function_exp))), calc$result_name))
                                }
                              } else{
                                curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::summarise(!!calc$result_name := !!rlang::parse_expr(calc$function_exp))
                              }
                              curr_data_list[[c_has_summary_label]] <- TRUE
                            }
                            # This type is grouping the data
                            # The data remains unchanged so link and require merge remain unchanged
                            else if(calc$type == "by") {
                              curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::group_by(dplyr::across({{ col_names_exp_2 }}), .add = TRUE, .drop = drop_value)
                              
                              #curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::group_by_(.dots = col_names_exp, add = TRUE, .drop = FALSE)
                            }
                            # This type is sorting the data
                            # The rows are now in a different order so a merge is required
                            else if(calc$type == "sort") {
                              curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::arrange(across({{ col_names_exp_2 }}))
                              #curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::arrange_(.dots = col_names_exp)
                              curr_data_list[[c_has_filter_label]] <- TRUE
                            }
                            # This type is filtering the data
                            # The data is at the same "level" so the link is unchanged
                            # The rows are now different so a merge is required
                            else if(calc$type == "filter") {
                              curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::filter(!!rlang::parse_expr(calc$function_exp), .preserve = preserve_value)
                              #curr_data_list[[c_data_label]] <- curr_data_list[[c_data_label]] %>% dplyr::filter_(.dots = as.formula(paste0("~", calc$function_exp)))
                              curr_data_list[[c_has_filter_label]] <- TRUE
                            }
                            # This type is when there is no main calculation but some sub_calculations
                            # There is no change to the data
                            else if(calc$type == "combination") {}
                            else stop("Cannot detect calculation type: ", calc$type)
                            
                            # This is done to clear the column attributes which are carried from the calculated columns
                            # TODO test this to check for any unintended side effects
                            # Seems only safe way to do this, as.vector can't be used on factor, Date etc.
                            if(calc$type == "calculation" || calc$type == "summary") {
                              result_col <- curr_data_list[[c_data_label]][[calc$result_name]]
                              for(att in names(attributes(result_col))[!names(attributes(result_col)) %in% c("levels", "class")]) {
                                attr(curr_data_list[[c_data_label]][[calc$result_name]], att) <- NULL
                              }
                            }
                            # if calc$save == 2 then column generated by calculation is saved into instat object and calc saved in to_data_frame
                            if(calc$save == 2) self$save_calc_output(calc, curr_data_list, previous_manipulations)
                            # if output is not saved the calculation can still be saved but now it is saved with the from_data_frame
                            # (to_data_frame may not exist)
                            else if(calc$save == 1) self$save_calculation(data_names, calc)
                            # list is returned so it can be used recursively for manipulations, sub_calculations etc.
                            return(curr_data_list)
                          },
                          
                          
                          #' @description This method runs a specified calculation using `apply_instat_calculation` and 
                          #' displays the results if required. It serves as the primary interface for 
                          #' triggering calculations within the `DataBook`.
                          #'
                          #' @param calc A calculation object to be applied.
                          #' @param display Logical, whether to display the calculation output. Default is `TRUE`.
                          #' @param param_list A list of parameters to pass to the calculation. Default is `list()`.
                          #'
                          #' @return The `data` component of the calculation result if `display = TRUE`, otherwise `NULL`.
                          run_instat_calculation = function(calc, display = TRUE, param_list = list()) {
                            # param list has to be read in separately because of recursive nature of apply_instat_function. We want to ensure our param_list are in all calc()'s.
                            out <- self$apply_instat_calculation(calc, param_list = param_list)
                            if(display) return(out$data)
                          },
                          
                          #' @description This function identifies corresponding link columns between two data frames 
                          #' within the `DataBook` object. It checks for existing links and maps column 
                          #' names between the two data frames based on their relationship.
                          #'
                          #' @param first_data_frame_name A string specifying the name of the first data frame.
                          #' @param first_data_frame_columns A vector of column names from the first data frame 
                          #'                                 to be mapped.
                          #' @param second_data_frame_name A string specifying the name of the second data frame.
                          #'
                          #' @return A named vector where the names represent the columns in the first data frame 
                          #'         and the values represent the corresponding columns in the second data frame.
                          #'
                          #' @details
                          #' - If a direct link exists between the two data frames, the corresponding columns 
                          #'   are determined based on the `link_columns` of the existing link.
                          #' - If no direct link exists, it defaults to a one-to-one mapping of the input columns 
                          #'   (`first_data_frame_columns`) in the first data frame.
                          #'
                          #' @note If the two data frames are not directly linked, the function assumes the columns 
                          #'       in the first data frame map directly to columns with the same names in the second data frame.
                          get_corresponding_link_columns = function(first_data_frame_name, first_data_frame_columns, second_data_frame_name) {
                            # TODO: Needs to update to not just look at direct links
                            by <- c()
                            if(self$link_exists_between(first_data_frame_name, second_data_frame_name)) {
                              existing_link <- self$get_link_between(first_data_frame_name, second_data_frame_name)
                              link_pairs <- unlist(existing_link$link_columns)
                              for(link_column in first_data_frame_columns) {
                                if(existing_link$from_data_frame == first_data_frame_name && existing_link$to_data_frame == second_data_frame_name) {
                                  if(link_column %in% names(link_pairs)) {
                                    by[link_column] <- link_pairs[which(names(link_pairs) == link_column)][1]
                                  }
                                  else by[link_column] <- link_column
                                }
                                else if(existing_link$from_data_frame == second_data_frame_name && existing_link$to_data_frame == first_data_frame_name) {
                                  if(link_column %in% link_pairs) {
                                    by[link_column] <- names(link_pairs)[which(link_pairs == link_column)][1]
                                  }
                                  else by[link_column] <- link_column
                                }
                              }
                            }
                            # If no link then do by by columns in first data frame
                            else {
                              by <- first_data_frame_columns
                              names(by) <- first_data_frame_columns
                            }
                            return(by)
                          },
                          
                          #' @description This function finds a link between two data frames within the `DataBook` object and 
                          #' returns the corresponding columns to use for linking. It ensures the link is valid 
                          #' by checking that the columns exist in both data frames.
                          #'
                          #' @param first_data_frame_name A string specifying the name of the first data frame.
                          #' @param first_data_frame_columns A vector of column names from the first data frame to 
                          #'                                 be linked.
                          #' @param second_data_frame_name A string specifying the name of the second data frame.
                          #' @param second_data_frame_columns A vector of column names from the second data frame to 
                          #'                                  be linked.
                          #'
                          #' @return A named vector where the names represent the columns in the first data frame 
                          #'         and the values represent the corresponding columns in the second data frame.
                          #'
                          #' @details
                          #' - If a direct link exists between the data frames, the function checks for valid `link_columns` 
                          #'   in the `existing_link` object.
                          #' - A link is established if all columns in the specified `link_columns` exist in their 
                          #'   respective data frames.
                          #' - If no valid link is found, an empty vector is returned.
                          #' 
                          #' @note This function ensures that the linking columns are valid by verifying 
                          #'       their existence in both data frames.
                          get_link_columns_from_data_frames = function(first_data_frame_name, first_data_frame_columns, second_data_frame_name, second_data_frame_columns) {
                            # finds a link between two data frames and returns named list used for by
                            # also checks link columns still are in both data frames
                            by = c()
                            if(self$link_exists_between(first_data_frame_name, second_data_frame_name)) {
                              existing_link <- self$get_link_between(first_data_frame_name, second_data_frame_name)
                              found <- FALSE
                              for(curr_link_set in existing_link$link_columns) {
                                if(existing_link$from_data_frame == first_data_frame_name && existing_link$to_data_frame == second_data_frame_name) {
                                  if(all(curr_link_set %in% first_data_frame_columns) && all(names(curr_link_set) %in% second_data_frame_columns)) {
                                    by <- curr_link_set
                                    break
                                  }
                                }
                                else if(existing_link$from_data_frame == second_data_frame_name && existing_link$to_data_frame == first_data_frame_name) {
                                  if(all(curr_link_set %in% second_data_frame_columns) && all(names(curr_link_set) %in% first_data_frame_columns)) {
                                    by <- names(curr_link_set)
                                    names(by) <- curr_link_set
                                    break
                                  }
                                }
                              }
                            }
                            return(by)
                          },
                          
                          #' @description This method saves the output of a calculation to the appropriate data frame 
                          #' within the `DataBook` object. It manages links and metadata associated with 
                          #' the calculation.
                          #'
                          #' @param calc The calculation object.
                          #' @param curr_data_list The list of data objects containing the calculation output.
                          #' @param previous_manipulations A list of previous manipulations applied to the data.
                          #'
                          #' @details
                          #' - If the output data has a summary or filter applied, appropriate links are created or updated.
                          #' - Metadata is added to indicate that the column or data frame is the result of a calculation.
                          #' - Dependencies between columns are updated based on the calculation.
                          #'
                          #' @return None.
                          #' 
                          save_calc_output = function(calc, curr_data_list, previous_manipulations) {
                            # Called from apply_instat_calculation if calc$save_calc == TRUE
                            
                            # Add previous manipulations to calc so that it can be rerun on its own (it may have been a sub calculation)
                            calc$manipulations <- c(previous_manipulations, calc$manipulations)
                            calc_dependencies <- calc$get_dependencies()
                            # Variables used throughout method
                            calc_from_data_name <- curr_data_list[[c_link_label]][["from_data_frame"]]
                            calc_link_cols <- curr_data_list[[c_link_label]][["link_cols"]]
                            
                            # Not sure this is correct. What if result is going into a differennt data frame?
                            if(calc$result_name %in% names(self$get_data_frame(calc_from_data_name))) warning(calc$result_name, " is already a column in the existing data. The column will be replaced by the output from the calculation. This may have unintended consequences for the calculation")
                            if(calc$result_data_frame != "") {
                              to_data_name <- calc$result_data_frame
                              if(to_data_name %in% names(self$get_data_names())) {
                                #TODO
                              }
                              else {
                                to_data_list <- list()
                                # Ensures that the to_data_name is a valid name
                                to_data_name <- calc$result_data_frame
                                to_data_name <- make.names(to_data_name)
                                to_data_name <- instatExtras::next_default_item(to_data_name, self$get_data_names(), include_index = FALSE)
                                # Subset to only get linking columns and result (don't want sub calcs as well, saved separately)
                                to_data_list[[to_data_name]] <- curr_data_list[[c_data_label]]
                                self$import_data(to_data_list)
                                to_data_exists <- TRUE
                                if(length(calc_link_cols) > 0) {
                                  # Add the link to the new to_data_name
                                  new_key <- calc_link_cols
                                  names(new_key) <- calc_link_cols
                                  self$add_link(calc_from_data_name, to_data_name, new_key, keyed_link_label)
                                  # Add metadata to the linking columns 
                                  # This adds metadata: is_calculated = TRUE to the linking columns, which indicates that the column has been created by a calculation
                                  self$append_to_variables_metadata(to_data_name, calc_link_cols, is_calculated_label, TRUE)
                                }
                                
                                # Adds metadata at data frame level to indicate that the data frame is calculated
                                # Note: all columns do not have to be calculated for data frame to be set as calculated
                                self$append_to_dataframe_metadata(to_data_name, is_calculated_label, TRUE)
                              }
                            }
                            else {
                              if(curr_data_list[[c_has_summary_label]]) {
                                # If there has been a summary, we look for an existing data frame that this could be linked to
                                link_def <- self$get_possible_linked_to_definition(calc_from_data_name, calc_link_cols)
                                # If this is not empty then it is a list of two items: 1. the data frame to link to 2. the columns to link to
                                if(length(link_def) > 0) {
                                  to_data_exists <- TRUE
                                  to_data_name <- link_def[[1]]
                                  # The check above only confirms it is possible to have a direct link to link_def[[1]]
                                  # If there is not already a direct link between the data frames, we add one
                                  if(!self$link_exists_from(calc_from_data_name, calc_link_cols)) {
                                    link_pairs <- link_def[[2]]
                                    names(link_pairs) <- calc_link_cols
                                    self$add_link(calc_from_data_name, to_data_name, link_pairs, keyed_link_label)
                                  }
                                  # This is done so that calc$name can be used later and we know it won't be changed
                                  # We can only do this check once we know the to_data_frame as this is where the calc is stored
                                  if(calc$name %in% self$get_calculation_names(to_data_name)) {
                                    calc$name <- instatExtras::next_default_item(calc$name, self$get_calculation_names(to_data_name))
                                  }
                                  if(calc$result_name %in% self$get_column_names(to_data_name)) {
                                    #     Delete is needed because merge will not replace
                                    #     If not wanting to replace, this should be checked when calculation is defined.
                                    warning("A column named ", calc$result_name, " already exists in ", to_data_name, ". It will be replaced by the output from the calculation.")
                                    suppressWarnings(self$remove_columns_in_data(to_data_name, calc$result_name, TRUE))
                                  }
                                  if(length(calc_link_cols) > 0) {
                                    # merge_data merges into to_data_frame in instat object
                                    # method takes care of data frame attributes correctly
                                    # need to subset so that only the new column from this calc is added (not sub_calc columns as well as they have already been added if saved)
                                    # type = "full" so that we do not lose any data from either part of the merge
                                    by <- calc_link_cols
                                    names(by) <- link_def[[2]]
                                    self$get_data_objects(to_data_name)$merge_data(curr_data_list[[c_data_label]][c(calc_link_cols, calc$result_name)], by = by, type = "full")
                                  }
                                  else {
                                    self$get_data_objects(to_data_name)$add_columns_to_data(calc$result_name, curr_data_list[[c_data_label]][calc$result_name], before = calc$before, adjacent_column = calc$adjacent_column)
                                  }
                                }
                                else {
                                  # If no link exists then the to_data_frame doesn't exist so output from calc becomes new to_data_frame
                                  # and a link will be added to new to_data_frame
                                  to_data_list <- list()
                                  # Ensures that the to_data_name is a valid name that doesn't exist in list of current data frame names
                                  to_data_name <- paste(calc_from_data_name, "by", paste(calc_link_cols, collapse = "_"), sep="_")
                                  to_data_name <- make.names(to_data_name)
                                  to_data_name <- instatExtras::next_default_item(to_data_name, self$get_data_names(), include_index = FALSE)
                                  # Subset to only get linking columns and result (don't want sub calcs as well, saved separately)
                                  to_data_list[[to_data_name]] <- curr_data_list[[c_data_label]][c(calc_link_cols, calc$result_name)]
                                  self$import_data(to_data_list)
                                  to_data_exists <- TRUE
                                  # Add the link to the new to_data_frame
                                  new_key <- calc_link_cols
                                  names(new_key) <- calc_link_cols
                                  self$add_link(calc_from_data_name, to_data_name, new_key, keyed_link_label)
                                  
                                  if(length(calc_link_cols) > 0) {
                                    # Add metadata to the linking columns 
                                    # This adds metadata: is_calculated = TRUE to the linking columns, which indicates that the column has been created by a calculation
                                    self$append_to_variables_metadata(to_data_name, calc_link_cols, is_calculated_label, TRUE)
                                  }
                                  
                                  # Adds metadata at data frame level to indicate that the data frame is calculated
                                  # Note: all columns do not have to be calculated for data frame to be set as calculated
                                  self$append_to_dataframe_metadata(to_data_name, is_calculated_label, TRUE)
                                }
                              }
                              else if(curr_data_list[[c_has_filter_label]]) {
                                # If filter done and no summary done then to_data_frame == from_data_frame
                                # to do the join there must be a key defined in from dataframe because output may have a subset of rows of original data
                                # TODO should we still add a link in this case?
                                to_data_name <- calc_from_data_name
                                # If the data frame has keys defined then we use get_link_columns_from_data_frames to find the by
                                if(self$has_key(calc_from_data_name)) {
                                  by <- self$get_link_columns_from_data_frames(calc_from_data_name, names(curr_data_list[[c_data_label]]), calc_from_data_name, self$get_column_names(calc_from_data_name))
                                  # subset to only get output and key columns, do not want sub_calculation or extra columns to be merged as well
                                  #TODO If by = NULL should we try the merge with a warning or just stop?
                                  if(length(by) == 0) stop("Cannot save output because the key columns are not present in the calculation output")
                                  self$get_data_objects(calc_from_data_name)$merge_data(curr_data_list[[c_data_label]][c(as.vector(by), calc$result_name)], by = by, type = "full")
                                }
                                # Cannot do merge if the data frame has no keys defined
                                else {
                                  #TODO Should we try the merge?
                                  stop("Cannot save output from this calculation because the data frame does not have any defined keys.")
                                }
                              }
                              else {
                                # If no summary or join, then simply add result as new column
                                # Because no join was required, the rows should match 1-1 in both data frames
                                self$add_columns_to_data(data_name = calc_from_data_name, col_name =  calc$result_name, col_data = curr_data_list[[c_data_label]][[calc$result_name]], before = calc$before, adjacent_column = calc$adjacent_column)
                                to_data_name <- calc_from_data_name
                                if(calc$name %in% self$get_calculation_names(to_data_name)) {
                                  calc$name <- instatExtras::next_default_item(calc$name, self$get_calculation_names(to_data_name))
                                }
                              }
                            }
                            
                            # Add metadata for the new column
                            output_column <- calc$result_name
                            names(output_column) <- to_data_name
                            # Add metadata to calculated_from columns
                            # for example, calculated_from may include sub_calculation columns which were not saved and so don't appear in the instat object data
                            for(i in seq_along(calc_dependencies)) {
                              # This adds metadata: has_dependants = TRUE which indicates that the calculated_from columns have columns that depend on them 
                              self$append_to_variables_metadata(names(calc_dependencies[i]), calc_dependencies[[i]], has_dependants_label, TRUE)
                              # This adds the output_column to the calculated_from columns' list of dependent columns
                              self$add_dependent_columns(names(calc_dependencies[i]), calc_dependencies[[i]], output_column)
                            }
                            # This adds metadata: is_calculated = TRUE to the output column, which indicates that the column has been created by a calculation
                            if(calc$result_name != "") {
                              self$append_to_variables_metadata(to_data_name, calc$result_name, is_calculated_label, TRUE)
                              
                              # This adds metadata: dependencies to the output column with value, a list of the calculated_from columns
                              if(length(calc_dependencies) > 0) self$append_to_variables_metadata(to_data_name, calc$result_name, dependencies_label, calc_dependencies)
                              # This adds metadata: calculated_by to the output column, with value as the name of the calculation
                              self$append_to_variables_metadata(to_data_name, calc$result_name, calculated_by_label, calc$name)
                            }
                            self$save_calculation(to_data_name, calc)
                          },
                          
                          #' @description This method appends the results of a summary calculation to a data object 
                          #' in the `DataBook`. If a corresponding summary data object exists, the method 
                          #' merges the new summary into it. Otherwise, it creates a new summary data object.
                          #'
                          #' @param out A data frame containing the summary calculation results.
                          #' @param data_name A string specifying the name of the data object to which the summaries relate.
                          #' @param columns_to_summarise A character vector of columns included in the summary.
                          #' @param summaries A character vector of summary operations performed (e.g., `"mean"`, `"sum"`).
                          #' @param factors A character vector of grouping factors used in the summary. Default is `c()`.
                          #' @param summary_name A string specifying the name of the summary data object. Default is generated dynamically.
                          #' @param calc The calculation object containing metadata about the calculation.
                          #' @param calc_name Optional. The name of the calculation. Default is an empty string.
                          #'
                          #' @details
                          #' - If a summary data object with the specified `factors` already exists, this method merges the new summary into it.
                          #' - If no such data object exists, it creates a new one and links it to the original data object via the specified `factors`.
                          #' - Metadata is updated to track dependencies and indicate calculated columns.
                          #'
                          #' @return None. The operation is performed in place.
                          append_summaries_to_data_object = function(out, data_name, columns_to_summarise, summaries, factors = c(), summary_name, calc, calc_name = "") {
                            if(!is.character(data_name)) stop("data_name must be of type character")
                            
                            exists = FALSE
                            if(self$link_exists_from(data_name, factors)) {
                              #TODO what happens if there is more than 1?
                              summary_name <- self$get_linked_to_data_name(data_name, factors)[1]
                              summary_obj <- self$get_data_objects(summary_name)
                              exists <- TRUE
                            }
                            if(exists) {
                              #temp fix to avoid error merging data with overlapping names
                              curr_data <- summary_obj$get_data_frame(use_current_filter = FALSE)
                              for(i in 1:length(names(out))) {
                                curr_col_name <- names(out)[[i]]
                                if((!curr_col_name %in% factors) && curr_col_name %in% names(curr_data)) {
                                  names(out)[[i]] <- instatExtras::next_default_item(curr_col_name, names(curr_data))
                                }
                              }
                              summary_obj$merge_data(out, by = factors, type = "inner", match = "first")
                            }
                            else {
                              summary_data <- list()
                              if(missing(summary_name) || is.na(summary_name)) summary_name <- paste(data_name, "by", paste(factors, collapse = "_"), sep="_")
                              summary_name <- make.names(summary_name)
                              summary_name <- instatExtras::next_default_item(summary_name, self$get_data_names(), include_index = FALSE)
                              summary_data[[summary_name]] <- out
                              self$import_data(summary_data)
                              summary_obj <- self$get_data_objects(summary_name)
                              # TODO Should the be done here or in add_link?
                              #summary_obj$add_key(factors)
                              names(factors) <- factors
                              self$add_link(data_name, summary_name, factors, keyed_link_label)
                            }
                            
                            calc_out_columns <- names(out)[-(1:length(factors))]
                            dependent_cols <- list(calc_out_columns)
                            names(dependent_cols) <- summary_name
                            dependencies_cols <- list(columns_to_summarise)
                            names(dependencies_cols) <- data_name
                            calc_name <- self$save_calculation(summary_name, calc)
                            self$append_to_variables_metadata(data_name, columns_to_summarise, has_dependants_label, TRUE)
                            self$add_dependent_columns(data_name, columns_to_summarise, dependent_cols)
                            self$append_to_variables_metadata(summary_name, calc_out_columns, is_calculated_label, TRUE)
                            self$append_to_variables_metadata(summary_name, calc_out_columns, calculated_by_label, calc_name)
                            if(!exists) {
                              self$append_to_variables_metadata(summary_name, names(out)[1:length(factors)], is_calculated_label, TRUE)
                              self$append_to_variables_metadata(summary_name, names(out)[1:length(factors)], calculated_by_label, calc_name)
                            }
                            self$append_to_variables_metadata(summary_name, calc_out_columns, dependencies_label, dependencies_cols)
                          },
                        
                          #' @description Computes summary statistics for a dataset based on specified columns, summaries, and grouping factors. 
                          #' Supports flexible percentage calculations, handling of missing values, and result storage.
                          #'
                          #' @param data_name A character string representing the name of the dataset to summarize.
                          #' @param columns_to_summarise Optional. A character vector of column names to summarize. Defaults to `NULL`.
                          #' @param summaries A vector of summary functions to apply to the data.
                          #' @param factors A character vector of factor column names for grouping. Defaults to an empty vector.
                          #' @param store_results Logical. If `TRUE`, stores intermediate results. Defaults to `TRUE`.
                          #' @param drop Logical. If `TRUE`, drops unused factor levels. Defaults to `TRUE`.
                          #' @param return_output Logical. If `TRUE`, returns the summary output. Defaults to `FALSE`.
                          #' @param summary_name A character string for naming the summary. Defaults to `NA`.
                          #' @param result_names Optional. A character vector for naming summary results. Defaults to `NULL`.
                          #' @param percentage_type Character. Type of percentages to calculate ("none", "factors", "columns", "filter"). Defaults to `"none"`.
                          #' @param perc_total_columns Optional. Columns to use for total percentage calculations. Defaults to `NULL`.
                          #' @param perc_total_factors A character vector of factors to use for total percentage calculations. Defaults to an empty vector.
                          #' @param perc_total_filter Optional. A filter condition for percentage calculations. Defaults to `NULL`.
                          #' @param perc_decimal Logical. If `TRUE`, displays percentages in decimal format. Defaults to `FALSE`.
                          #' @param perc_return_all Logical. If `TRUE`, returns all percentage-related columns. Defaults to `FALSE`.
                          #' @param include_counts_with_percentage Logical. If `TRUE`, includes counts alongside percentages. Defaults to `FALSE`.
                          #' @param silent Logical. If `TRUE`, suppresses warnings. Defaults to `FALSE`.
                          #' @param additional_filter Optional. Additional filtering conditions for the calculation.
                          #' @param original_level Logical. If `TRUE`, uses the original level for calculations. Defaults to `FALSE`.
                          #' @param signif_fig Numeric. Number of significant figures for rounding numeric values. Defaults to `2`.
                          #' @param sep Character. Separator used in result names. Defaults to `"_"`.
                          #' @param ... Additional arguments passed to other methods.
                          #' @return A data frame containing the calculated summary statistics.
                          calculate_summary = function(data_name, columns_to_summarise = NULL, summaries, factors = c(), store_results = TRUE, drop = TRUE, return_output = FALSE, summary_name = NA, result_names = NULL, percentage_type = "none", perc_total_columns = NULL, perc_total_factors = c(), perc_total_filter = NULL, perc_decimal = FALSE, perc_return_all = FALSE, include_counts_with_percentage = FALSE, silent = FALSE, additional_filter, original_level = FALSE, signif_fig = 2, sep = "_", ...) {
                          if(original_level) type <- "calculation"
                          else type <- "summary"
                          include_columns_to_summarise <- TRUE
                          if(is.null(columns_to_summarise) || length(columns_to_summarise) == 0) {
                            # temporary fix for doing counts of a data frame
                            # dplyr cannot count data frame groups without passing a column (https://stackoverflow.com/questions/44217265/passing-correct-data-frame-from-within-dplyrsummarise)
                            # This is a known issue (https://github.com/tidyverse/dplyr/issues/2752)
                            if(length(summaries) != 1 || summaries != count_label) {
                              mes <- "When there are no columns to summarise can only use count function as summary"
                              if(silent) {
                                warning(mes, "Continuing summaries by using count only.")
                                columns_to_summarise <- self$get_column_names(data_name)[1]
                                summaries <- count_label
                              }
                              else {
                                stop(mes)
                              }
                            }
                            else columns_to_summarise <- self$get_column_names(data_name)[1]
                            include_columns_to_summarise <- FALSE
                          }
                          if(!percentage_type %in% c("none", "factors", "columns", "filter")) stop("percentage_type: ", percentage_type, " not recognised.")
                          if(percentage_type == "columns") {
                            if(!(length(perc_total_columns) == 1 || length(perc_total_columns) == length(columns_to_summarise))) stop("perc_total_columns must either be of length 1 or the same length as columns_to_summarise")
                          }
                          if(!store_results) save <- 0
                          else save <- 2
                          summaries_display <- as.vector(sapply(summaries, function(x) ifelse(startsWith(x, "summary_"), substring(x, 9), x)))
                          if(percentage_type == "factors") {
                            manip_factors <- intersect(factors, perc_total_factors)
                          }
                          else manip_factors <- factors
                          if(length(manip_factors) > 0) {
                            calculated_from <- as.list(manip_factors)
                            names(calculated_from) <- rep(data_name, length(manip_factors))
                            calculated_from <- as.list(calculated_from)
                            factor_by <- instatCalculations::instat_calculation$new(type = "by", calculated_from = calculated_from, param_list = list(drop = drop))
                            manipulations <- list(factor_by)
                          }
                          else manipulations <- list()
                          if(percentage_type == "factors") {
                            value_factors <- setdiff(factors, manip_factors)
                            if(length(value_factors) > 0) {
                              calculated_from <- as.list(value_factors)
                              names(calculated_from) <- rep(data_name, length(value_factors))
                              calculated_from <- as.list(calculated_from)
                              factor_by <- instatCalculations::instat_calculation$new(type = "by", calculated_from = calculated_from, param_list = list(drop = drop))
                              value_manipulations <- list(factor_by)
                            }
                            else value_manipulations <- list()
                          }
                          sub_calculations <- list()
                          
                          i <- 0
                          for(column_names in columns_to_summarise) {
                            i <- i + 1
                            # In the case of counting without columns, the first column column will be the "calculated from"
                            # which will add unwanted column metadata
                            calculated_from <- list(column_names)
                            names(calculated_from) <- rep(data_name, length(calculated_from))
                            j <- 0
                            for(summary_type in summaries) {
                              j <- j + 1
                              function_exp <- ""
                              # if(!is.null(weights)) {
                              #   function_exp <- paste0(function_exp, ", weights = ", weights)
                              # }
                              extra_args <- list(...)
                              for(i in seq_along(extra_args)) {
                                function_exp <- paste0(function_exp, ", ", names(extra_args)[i], " = ", extra_args[i])
                              }
                              function_exp <- paste0(function_exp, ")")
                              # function_exp <- paste0(function_exp, ", na.rm =", na.rm, ")")
                              if(is.null(result_names)) {
                                result_name = summaries_display[j]
                                if(include_columns_to_summarise){
                                  if (!is.null(extra_args$y)) result_name <- paste0(result_name, sep, extra_args$y, sep, column_names)
                                  else result_name <- paste0(result_name, sep, column_names)
                                }
                              }
                              #TODO result_names could be horizontal/vertical vector, matrix or single value
                              else result_name <- result_names[i,j]
                              if(percentage_type == "none") {
                                summary_function_exp <- paste0(summary_type, "(x = ", column_names, function_exp)
                                summary_calculation <- instatCalculations::instat_calculation$new(type = type, result_name = result_name,
                                                                              function_exp = summary_function_exp,
                                                                              calculated_from = calculated_from, save = save)
                              }
                              else {
                                values_calculation <- instatCalculations::instat_calculation$new(type = type, result_name = result_name,
                                                                             function_exp = paste0(summary_type, "(x = ", column_names, function_exp),
                                                                             calculated_from = calculated_from, save = save)
                                if(percentage_type == "columns") {
                                  if(length(perc_total_columns) == 1) perc_col_name <- perc_total_columns
                                  else perc_col_name <- perc_total_columns[i]
                                  totals_calculation <- instatCalculations::instat_calculation$new(type = type, result_name = paste0(summaries_display[j], sep, perc_total_columns, "_totals"),
                                                                               function_exp = paste0(summary_type, "(x = ", perc_col_name, function_exp),
                                                                               calculated_from = calculated_from, save = save)
                                }
                                else if(percentage_type == "filter") {
                                  #TODO
                                }
                                else if(percentage_type == "factors") {
                                  values_calculation$manipulations <- value_manipulations
                                  totals_calculation <- instatCalculations::instat_calculation$new(type = "summary", result_name = paste0(result_name, "_totals"),
                                                                               function_exp = paste0(summary_type, "(x = ", column_names, function_exp),
                                                                               calculated_from = calculated_from, save = save)
                                }
                                function_exp <- paste0(values_calculation$result_name, "/", totals_calculation$result_name)
                                if(!perc_decimal) {
                                  function_exp <- paste0("(", function_exp, ") * 100")
                                }
                                perc_result_name <- paste0("perc_", result_name)
                                summary_calculation <- instatCalculations::instat_calculation$new(type = "calculation", result_name = perc_result_name,
                                                                              function_exp = function_exp,
                                                                              calculated_from = list(), save = save, sub_calculations = list(totals_calculation, values_calculation))
                              }
                              sub_calculations[[length(sub_calculations) + 1]] <- summary_calculation
                            }
                          }
                          if(self$filter_applied(data_name)) {
                            curr_filter <- self$get_current_filter(data_name)
                            curr_filter_name <- curr_filter[["name"]]
                            curr_filter_calc <- self$get_filter_as_instat_calculation(data_name, curr_filter_name)
                            manipulations <- c(curr_filter_calc, manipulations)
                          } 
                          if(!missing(additional_filter)) {
                            manipulations <- c(additional_filter, manipulations)
                          }
                          combined_calc_sum <- instatCalculations::instat_calculation$new(type="combination", sub_calculations = sub_calculations, manipulations = manipulations)
                          
                          # setting up param_list. Here we read in .drop and .preserve
                          param_list <- list()
                          if (length(combined_calc_sum$manipulations) > 0){
                            for (i in 1:length(combined_calc_sum$manipulations)){
                              if (combined_calc_sum$manipulations[[i]]$type %in% c("by", "filter")){
                                param_list <- c(param_list, combined_calc_sum$manipulations[[i]]$param_list)
                              }
                            }
                          }
                          out <- self$apply_instat_calculation(combined_calc_sum, param_list = param_list)
                          # relocate so that the factors are first still for consistency	
                          if (percentage_type != "none"){	
                            out$data <- (out$data %>% dplyr::select(c(tidyselect::all_of(factors), tidyselect::all_of(manip_factors)), tidyselect::everything()))	
                          }
                          if(return_output) {
                            dat <- out$data
                            if(percentage_type == "none" || perc_return_all) return(out$data)
                            else {
                              #This is a temp fix to only returning final percentage columns.
                              #Depends on result name format used above for summary_calculation in percentage case
                              if (percentage_type != "none" && include_counts_with_percentage){
                                dat <- dat %>% dplyr::mutate(dplyr::across(where(is.numeric), round, signif_fig))
                                dat <- dat %>% dplyr::mutate(perc_count = paste0(count, " (", perc_count, "%)")) %>% dplyr::select(-c("count", "count_totals"))
                              } else {
                                dat[c(which(names(dat) %in% factors), which(startsWith(names(dat), "perc_")))]
                              }
                            }
                          }
                        },
                        
                        #' @description Computes summary statistics for specified columns in a dataset, optionally grouped by factors. 
                        #' Handles multiple summaries, data types, and error conditions gracefully.
                        #'
                        #' @param data_name A character string representing the name of the dataset to summarize.
                        #' @param columns_to_summarise A character vector of column names to summarize.
                        #' @param summaries A vector of summary function names to apply to the columns.
                        #' @param factors A character vector of factor column names for grouping. Defaults to an empty vector.
                        #' @param store_results Logical. If `TRUE`, stores the summary results. Defaults to `FALSE`.
                        #' @param drop Logical. If `TRUE`, drops unused factor levels. Defaults to `FALSE`.
                        #' @param return_output Logical. If `TRUE`, returns the summary output. Defaults to `FALSE`.
                        #' @param summary_name Optional. A character string to name the summary. Defaults to `NA`.
                        #' @param add_cols Optional. Additional columns to include in the output. Defaults to an empty vector.
                        #' @param filter_names A character vector of filter names to apply during the calculation. Defaults to an empty vector.
                        #' @param ... Additional arguments passed to other methods or functions.
                        #' @return A data frame or list containing the computed summary statistics. If no grouping factors are provided, the result is a table with row names corresponding to the summary functions.
                        summary = function(data_name, columns_to_summarise, summaries, factors = c(), store_results = FALSE, drop = FALSE, return_output = FALSE, summary_name = NA, add_cols = c(), filter_names = c(), ...) {
                          calculated_from = list()
                          calculated_from[[1]] <- list(data_name = data_name, columns = columns_to_summarise)
                          summaries <- unique(summaries)
                          summaries <- summaries[order(match(summaries, all_summaries))]
                          summaries_count <- summaries[startsWith(summaries, "summary_count_all")]
                          summaries_other <- setdiff(summaries, summaries_count)
                          summaries <- c(summaries_count, summaries_other)
                          count_summaries_max <- length(summaries_count)
                          summaries_max <- length(summaries)
                          
                          summary_names <- ifelse(startsWith(summaries, "summary_"), substr(summaries, 9, nchar(summaries)), summaries)
                          summary_names <- gsub("_", "__", summary_names)
                          summary_names <- make.unique(summary_names)
                          summary_count_names <- summary_names[1:count_summaries_max]
                          summary_other_names <- summary_names[(count_summaries_max + 1):summaries_max]
                          
                          col_data_type <- self$get_variables_metadata(data_name = data_name, column = columns_to_summarise, property = data_type_label)
                          
                          factors_disp <- dplyr::if_else(length(factors) == 0, ".id", factors)
                          factors_levels <- lapply(factors, function(x) {
                            fac_col <- self$get_columns_from_data(data_name, x)
                            if(is.factor(fac_col)) return(levels(fac_col))
                            else return(sort(unique(fac_col)))
                          })
                          factors_levels <- expand.grid(factors_levels)
                          names(factors_levels) <- factors
                          
                          results <- list()
                          i <- 1
                          for(col_new in columns_to_summarise) {
                            results_temp_count <- list()
                            results_temp_other <- list()
                            for(j in seq_along(summaries)) {
                              calc <- instatCalculations::calculation$new(type = "summary", parameters = list(data_name = data_name, columns_to_summarise = col_new, summaries = summaries[j], factors = factors, store_results = store_results, drop = drop, return_output = return_output, summary_name = summary_name, add_cols = add_cols, ... = ...),  filters = filter_names, calculated_from = calculated_from)
                              calc_apply <- tryCatch(self$apply_calculation(calc), 
                                                     error = function(c) {
                                                       if(length(factors) == 0) {
                                                         x <- data.frame(NA, NA)
                                                         names(x) <- c(".id", summary_names[j])
                                                         return(x)
                                                       }
                                                       else {
                                                         x <- factors_levels
                                                         x[[summary_names[j]]] <- NA
                                                         return(x)
                                                       }
                                                     })
                              names(calc_apply)[length(factors_disp) + 1] <- col_new
                              calc_apply$summary <- summary_names[j]
                              names(calc_apply) <- make.names(names(calc_apply), unique = TRUE)
                              if(j <= count_summaries_max) results_temp_count[[length(results_temp_count) + 1]] <- calc_apply
                              else results_temp_other[[length(results_temp_other) + 1]] <- calc_apply
                            }
                            if(length(results_temp_count) > 0) {
                              results_temp_count <- dplyr::bind_rows(results_temp_count)
                              results_temp_count <- format(results_temp_count, scientific = FALSE)
                            }
                            if(length(results_temp_other) > 0) {
                              results_temp_other <- dplyr::bind_rows(results_temp_other)
                              results_temp_other <- format(results_temp_other, scientific = FALSE)
                              # Convert summaries which have been coerced to numeric but should be dates
                              if("Date" %in% col_data_type[i]) {
                                results_temp_other[[col_new]] <- dplyr::if_else(summaries_other[match(results_temp_other$summary, summary_other_names)] %in% date_summaries,
                                                                                as.character(as.Date(as.numeric(results_temp_other[[col_new]]), origin = "1970/1/1")),
                                                                                dplyr::if_else(stringr::str_trim(results_temp_other[[col_new]]) == "NA", NA_character_, paste(results_temp_other[[col_new]], "days")))
                              }
                            }
                            results_temp <- dplyr::bind_rows(results_temp_count, results_temp_other)
                            if(i == 1) results <- results_temp
                            else results <- dplyr::full_join(results, results_temp, by = c(factors_disp, "summary"))
                            i <- i + 1
                          }
                          results <- results %>% select(c(factors_disp, "summary"), everything())
                          if(length(factors) == 0) {
                            results$.id <- NULL
                            results$summary <- NULL
                            row.names(results) <- summary_names
                          }
                          return(results)
                        },
                        
                        #' Convert Linked Variable to Matching Class
                        #'
                        #' This function converts the variables in the linked "to data frame" to match the class of the corresponding variables in the "from data frame".
                        #'
                        #' @param from_data_frame A character string specifying the name of the source data frame.
                        #' @param link_cols A character vector specifying the columns that define the link between the data frames.
                        #' @return No explicit return value. The function modifies the linked data frame in place.
                        convert_linked_variable = function(from_data_frame, link_cols) {
                          to_data_name <- self$get_linked_to_data_name(from_data_frame, link_cols=c(link_cols))
                          if (!is.null(to_data_name)){
                            linked_variable_name <- self$get_link_between(from_data_frame, to_data_name)$link_columns[[1]]
                            
                            for (i in seq_along(linked_variable_name)){
                              variable_type <- self$get_column_data_types(data_name = from_data_frame, columns = names(linked_variable_name[i]))
                              linked_variable_type <- self$get_column_data_types(data_name = to_data_name, columns=linked_variable_name[i])
                              
                              if (variable_type != linked_variable_type){
                                self$convert_column_to_type(data_name=to_data_name, col_names=linked_variable_name[i], to_type=variable_type)
                              }
                            }
                          }
                        },
                        
                        #' Remove Unused Station-Year Combinations
                        #'
                        #' This function removes station-year combinations that are not used in the linked data.
                        #'
                        #' @param data_name A character string specifying the name of the data frame.
                        #' @param year A character string specifying the column name representing the year.
                        #' @param station A character string specifying the column name representing the station.
                        #' @return No explicit return value. The function modifies the linked data frame in place.
                        remove_unused_station_year_combinations = function(data_name, year, station){
                          linked_data_name <- self$get_linked_to_data_name(data_name, link_cols=c(year, station))
                          
                          self$calculate_summary(data_name = data_name,
                                                 store_results=TRUE,
                                                 factors=c(year, station), 
                                                 summaries=c("summary_count"),
                                                 silent=TRUE)
                          
                          self$rename_column_in_data(data_name = linked_data_name, column_name="count_all", new_val="count_year_station_combination_for_linking", label="")
                          
                          self$add_filter(filter=list(C0=list(column="count_year_station_combination_for_linking", operation="! is.na")), data_name = linked_data_name, filter_name = "removing_additional_years")
                          
                          self$copy_data_object(data_name = linked_data_name, new_name = linked_data_name, filter_name="removing_additional_years")
                          
                          self$remove_columns_in_data(data_name=linked_data_name, cols="count_year_station_combination_for_linking")
                        },

                        #' @description Creates a summary table for a dataset based on specified columns, summaries, and factors. 
                        #' Provides options for margins, percentages, and various customization settings.
                        #'
                        #' @param data_name A character string representing the name of the dataset to summarize.
                        #' @param columns_to_summarise Optional. A character vector of column names to summarize. Defaults to `NULL`.
                        #' @param summaries A vector of summary functions to apply to the data.
                        #' @param factors A character vector of factor column names for grouping. Defaults to an empty vector.
                        #' @param store_table Logical. If `TRUE`, stores the resulting table in the data book. Defaults to `FALSE`.
                        #' @param store_results Logical. If `TRUE`, stores intermediate results. Defaults to `FALSE`.
                        #' @param drop Logical. If `TRUE`, drops unused factor levels. Defaults to `TRUE`.
                        #' @param na.rm Logical. If `TRUE`, removes missing values. Defaults to `FALSE`.
                        #' @param summary_name A character string for naming the summary. Defaults to `NA`.
                        #' @param include_margins Logical. If `TRUE`, includes margin summaries. Defaults to `FALSE`.
                        #' @param margins Character. Type of margins to include ("outer", "summary"). Defaults to `"outer"`.
                        #' @param return_output Logical. If `TRUE`, returns the summary output. Defaults to `FALSE`.
                        #' @param treat_columns_as_factor Logical. If `TRUE`, treats columns to summarize as factors. Defaults to `FALSE`.
                        #' @param page_by Optional. A character vector for paginating results. Defaults to `NULL`.
                        #' @param signif_fig Numeric. Number of significant figures for rounding numeric values. Defaults to `2`.
                        #' @param na_display Character. String to represent missing values in the output. Defaults to an empty string.
                        #' @param na_level_display Character. String to represent missing factor levels in the output. Must be non-empty.
                        #' @param weights Optional. A numeric vector of weights for weighted summaries. Defaults to `NULL`.
                        #' @param caption Optional. A character string for table captions. Defaults to `NULL`.
                        #' @param result_names Optional. A character vector for naming summary results. Defaults to `NULL`.
                        #' @param percentage_type Character. Type of percentages to calculate ("none", "row", "column", etc.). Defaults to `"none"`.
                        #' @param perc_total_columns Optional. Columns to use for total percentage calculations. Defaults to `NULL`.
                        #' @param perc_total_factors A character vector of factors to use for total percentage calculations. Defaults to an empty vector.
                        #' @param perc_total_filter Optional. A filter condition for percentage calculations. Defaults to `NULL`.
                        #' @param perc_decimal Logical. If `TRUE`, displays percentages in decimal format. Defaults to `FALSE`.
                        #' @param include_counts_with_percentage Logical. If `TRUE`, includes counts alongside percentages. Defaults to `FALSE`.
                        #' @param margin_name Character. Name for margin rows/columns in the output. Defaults to `"(All)"`.
                        #' @param additional_filter Optional. An additional filter for data summarization.
                        #' @param ... Additional arguments passed to other methods.
                        #' @return A `tibble` containing the summarised data table.
                        #' @export
                        summary_table = function(data_name, columns_to_summarise = NULL, summaries, factors = c(), store_table = FALSE, store_results = FALSE, drop = TRUE, na.rm = FALSE, summary_name = NA, include_margins = FALSE, margins = "outer", return_output = FALSE, treat_columns_as_factor = FALSE, page_by = NULL, signif_fig = 2, na_display = "", na_level_display = "NA", weights = NULL, caption = NULL, result_names = NULL, percentage_type = "none", perc_total_columns = NULL, perc_total_factors = c(), perc_total_filter = NULL, perc_decimal = FALSE, include_counts_with_percentage = FALSE, margin_name = "(All)", additional_filter, ...) {
                          # TODO: write in errors
                          if (na_level_display == "") stop("na_level_display must be a non empty string")
                          # removes "summary_" from beginning of summary function names so that display is nice
                          summaries_display <- sapply(summaries, function(x) ifelse(startsWith(x, "summary_"), substring(x, 9), x))
                          
                          # todo: add in code to store results if store_results = TRUE on the dialog
                          # only give this option if there is 1 column factor.
                          if (!store_results) {
                            save <- 0
                          } else {
                            save <- 2
                          }
                          
                          cell_values <- self$calculate_summary(data_name = data_name, columns_to_summarise = columns_to_summarise, summaries = summaries, factors = factors, store_results = FALSE, drop = drop, na.rm = na.rm, return_output = TRUE, weights = weights, result_names = result_names, percentage_type = percentage_type, perc_total_columns = perc_total_columns, perc_total_factors = perc_total_factors, perc_total_filter = perc_total_filter, perc_decimal = perc_decimal, include_counts_with_percentage = include_counts_with_percentage, margin_name = margin_name, additional_filter = additional_filter, perc_return_all = FALSE, signif_fig = signif_fig, sep = "__", ...)
                          for (i in seq_along(factors)) {
                            levels(cell_values[[i]]) <- c(levels(cell_values[[i]]), na_level_display)
                            cell_values[[i]][is.na(cell_values[[i]])] <- na_level_display
                          }
                          cell_values <- cell_values %>% dplyr::mutate(dplyr::across(where(is.numeric), round, signif_fig))
                          cell_values <- cell_values %>%
                            tidyr::pivot_longer(cols = !factors, names_to = "summary-variable", values_to = "value", values_transform = list(value = as.character))
                          if (treat_columns_as_factor && !is.null(columns_to_summarise)) {
                            cell_values <- cell_values %>%
                              tidyr::separate(col = "summary-variable", into = c("summary", "variable"), sep = "__")
                          }
                          shaped_cell_values <- cell_values %>% dplyr::relocate(value, .after = last_col())
                          
                          for (i in seq_along(factors)) {
                            levels(shaped_cell_values[[i]]) <- c(levels(shaped_cell_values[[i]]), margin_name) 
                          }
                          
                          # If margins ---------------------------------------------------------------------------
                          if (include_margins) {
                            margin_tables <- list()
                            power_sets <- rje::powerSet(factors)
                            # We could need last set if only have row or column factors
                            power_sets_outer <- power_sets[-(c(length(power_sets)))]
                            if (treat_columns_as_factor && !is.null(columns_to_summarise)) {
                              order_names <- unique(paste(shaped_cell_values$summary, shaped_cell_values$variable, sep = "__"))
                            } else {
                              order_names <- unique(shaped_cell_values$summary)
                            }
                            for (facts in power_sets_outer) {
                              if (length(facts) == 0) facts <- c()
                              margin_tables[[length(margin_tables) + 1]] <- self$calculate_summary(data_name = data_name, columns_to_summarise = columns_to_summarise, summaries = summaries, factors = facts, store_results = FALSE, drop = drop, na.rm = na.rm, return_output = TRUE, weights = weights, result_names = result_names, percentage_type = percentage_type, perc_total_columns = perc_total_columns, perc_total_factors = perc_total_factors, perc_total_filter = perc_total_filter, perc_decimal = perc_decimal, include_counts_with_percentage = include_counts_with_percentage, margin_name = margin_name, additional_filter = additional_filter, perc_return_all = FALSE, signif_fig = signif_fig, sep = "__", ...)
                            }
                            # for outer margins
                            margin_item <- length(summaries) * length(columns_to_summarise)
                            
                            if (("outer" %in% margins) && (length(factors) > 0)) {
                              # to prevent changing all variables to dates/converting dates to numeric
                              for (i in 1:length(margin_tables)){
                                margin_tables[[i]] <- margin_tables[[i]] %>% dplyr::mutate(dplyr::across(where(is.numeric), round, signif_fig))
                                margin_tables[[i]] <- margin_tables[[i]] %>% purrr::modify_if(lubridate::is.Date, as.character)
                              }
                              outer_margins <- plyr::ldply(margin_tables)
                              # Change shape
                              if (length(margin_tables) == 1) {
                                outer_margins <- plyr::ldply(margin_tables[[1]])
                                names(outer_margins) <- c("summary-variable", "value")
                              } else {
                                outer_margins <- outer_margins %>%
                                  tidyr::pivot_longer(cols = 1:margin_item, values_to = "value", names_to = "summary-variable", values_transform = list(value = as.character))
                              }
                              if (treat_columns_as_factor && !is.null(columns_to_summarise)) {
                                outer_margins <- outer_margins %>%
                                  tidyr::separate(col = "summary-variable", into = c("summary", "variable"), sep = "__")
                              }
                            } else {
                              outer_margins <- NULL
                            }
                            if ("summary" %in% margins || ("outer" %in% margins && length(factors) == 0)) {
                              summary_margins <- NULL
                              if (is.null(columns_to_summarise)){
                                power_sets_summary <- power_sets[-(length(power_sets))]
                              } else {
                                if ("outer" %in% margins) {
                                  power_sets_summary <- power_sets
                                } else {
                                  power_sets_summary <- power_sets[(c(length(power_sets)))]
                                }
                              }
                              
                              for (facts in power_sets_summary) {
                                if (length(facts) == 0) facts <- c()
                                if (is.null(columns_to_summarise)){
                                  summary_margins_df <- data_book$get_data_frame(data_name = data_name) %>%
                                    dplyr::select(c(tidyselect::all_of(factors)))
                                  data_book$import_data(data_tables = list(summary_margins_df = summary_margins_df))
                                  summary_margins[[length(summary_margins) + 1]] <- data_book$calculate_summary(data_name = "summary_margins_df", columns_to_summarise = NULL, summaries = summaries, factors = facts, store_results = FALSE, drop = drop, na.rm = na.rm, return_output = TRUE, weights = weights, result_names = result_names, percentage_type = percentage_type, perc_total_columns = perc_total_columns, perc_total_factors = perc_total_factors, perc_total_filter = perc_total_filter, perc_decimal = perc_decimal, include_counts_with_percentage = include_counts_with_percentage, margin_name = margin_name, additional_filter = additional_filter, perc_return_all = FALSE, signif_fig = signif_fig, ...)
                                } else {
                                  summary_margins_df <- data_book$get_data_frame(data_name = data_name) %>%
                                    dplyr::select(c(tidyselect::all_of(factors), tidyselect::all_of(columns_to_summarise))) %>%
                                    tidyr::pivot_longer(cols = columns_to_summarise, values_transform = list(value = as.character))
                                  data_book$import_data(data_tables = list(summary_margins_df = summary_margins_df))
                                  summary_margins[[length(summary_margins) + 1]] <- data_book$calculate_summary(data_name = "summary_margins_df", columns_to_summarise = "value", summaries = summaries, factors = facts, store_results = FALSE, drop = drop, na.rm = na.rm, return_output = TRUE, weights = weights, result_names = result_names, percentage_type = percentage_type, perc_total_columns = perc_total_columns, perc_total_factors = perc_total_factors, perc_total_filter = perc_total_filter, perc_decimal = perc_decimal, include_counts_with_percentage = include_counts_with_percentage, margin_name = margin_name, additional_filter = additional_filter, perc_return_all = FALSE, signif_fig = signif_fig, ...)
                                  
                                }
                                data_book$delete_dataframes(data_names = "summary_margins_df")
                              }
                              summary_margins <- plyr::ldply(summary_margins)
                              if (treat_columns_as_factor && !is.null(columns_to_summarise)) {
                                # remove "_value" in them
                                for (col in 1:ncol(summary_margins)) {
                                  colnames(summary_margins)[col] <- sub("_value", "", colnames(summary_margins)[col])
                                }
                                summary_margins <- summary_margins %>%
                                  tidyr::pivot_longer(cols = !factors, names_to = "summary", values_to = "value", values_transform = list(value = as.character))
                              } else {
                                if (length(summary_margins) == 1) {
                                  summary_margins <- data.frame(summary_margins, `summary-variable` = "count", factors = NA)
                                  names(summary_margins) <- c("value", "summary-variable", factors)
                                }else {
                                  for (col in 1:ncol(summary_margins)) {
                                    # TODO: if the colname is the same as a factor, then do nothing
                                    colnames(summary_margins)[col] <- sub("_value", "_all", colnames(summary_margins)[col])
                                  }
                                  summary_margins <- summary_margins %>% dplyr::mutate(dplyr::across(where(is.numeric), round, signif_fig))
                                  summary_margins <- summary_margins %>%
                                    tidyr::pivot_longer(cols = !factors, names_to = "summary-variable", values_to = "value", values_transform = list(value = as.character))
                                }
                              }
                            } else {
                              summary_margins <- NULL
                            }
                            if (!is.null(summary_margins) || !is.null(outer_margins)) {
                              margin_tables_all <- (dplyr::bind_rows(summary_margins, outer_margins))
                              margin_tables_all <- margin_tables_all %>%
                                dplyr::mutate_at(vars(-value), ~ replace(., is.na(.), margin_name)) %>%
                                dplyr::mutate(value = as.character(value))
                              
                              # if there is one factor, then we do not yet have the factor name in the df
                              # (this will be added in by dplyr::bind_rows(s_c_v, m_t_a))
                              # by introducing it in the outer_margins bit, we have to add it in "manually"
                              # this then loses the class of it, creating issues for ordered vs non-ordered factors
                              # so we do these changes here.
                              if (length(factors) > 1){
                                for (i in factors){
                                  shaped_cell_values_levels <- levels(shaped_cell_values[[i]])
                                  margin_tables_all <- margin_tables_all %>%
                                    dplyr::mutate_at(i, ~ forcats::fct_expand(., shaped_cell_values_levels),
                                                     i, ~ forcats::fct_relevel(., shaped_cell_values_levels))
                                }     
                              }
                              shaped_cell_values <- dplyr::bind_rows(shaped_cell_values, margin_tables_all) %>%
                                dplyr::mutate_at(vars(-c(value)), tidyr::replace_na, margin_name) %>%
                                dplyr::mutate_at(vars(-c(value)), ~forcats::as_factor(forcats::fct_relevel(.x, margin_name, after = Inf)))
                            }
                          }
                          # To all data --------------------------------------------------------------------------
                          # Used to make all values numeric, but stopped because of issues with ordered factors/dates.
                          # I don't think this line is needed anymore, but will keep it commented for now in case it becomes more apparent in the future
                          #if (percentage_type == "none" || include_counts_with_percentage == FALSE){
                          #  shaped_cell_values <- shaped_cell_values %>% dplyr::mutate(value = as.numeric(as.character(value)),
                          #                                                             value = round(value, signif_fig))
                          #}
                          if (treat_columns_as_factor && !is.null(columns_to_summarise)){
                            shaped_cell_values <- shaped_cell_values %>%
                              dplyr::mutate(summary = as.factor(summary)) %>% dplyr::mutate(summary = forcats::fct_relevel(summary, summaries_display)) %>%
                              dplyr::mutate(variable = as.factor(variable)) %>% dplyr::mutate(variable= forcats::fct_relevel(variable, columns_to_summarise))
                          }
                          if (!treat_columns_as_factor && !is.null(columns_to_summarise)){
                            shaped_cell_values <- shaped_cell_values %>%
                              dplyr::mutate(`summary-variable` = forcats::as_factor(`summary-variable`))
                          }
                          if (store_table) {
                            data_book$import_data(data_tables = list(shaped_cell_values = shaped_cell_values))
                          }
                          return(tibble::as_tibble(shaped_cell_values))
                        },
                          
                          #' @description Imports SST data and adds keys and links to the specified data tables.
                          #' @param dataset The SST dataset.
                          #' @param data_from The source of the data. Default is 5.
                          #' @param data_names A vector of data table names.
                          #' @return None
                          import_SST = function(dataset, data_from = 5, data_names = c()) {
                            data_list <- instatExtras::convert_SST(dataset, data_from)
                            if(length(data_list) != length(data_names)) stop("data_names vector should be of length 2")
                            names(data_list) = data_names
                            self$import_data(data_list)
                            self$add_key(data_names[1], c("Lon", "Lat", "Year", "Month", "Day"), "key1")
                            self$add_key(data_names[2], c("Lon", "Lat"), "key2")
                            link_pairs = c("Lon", "Lat")
                            names(link_pairs) = c("Lon", "Lat")
                            self$add_link(from_data_frame = data_names[1], to_data_frame = data_names[2], link_pairs = link_pairs, type = keyed_link_label)
                          }
                          
                        ),
                        private = list(
                          .data_sheets = list(),
                          .metadata = list(),
                          .objects = list(),
                          .scalars = list(),
                          .undo_history = list(),
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
