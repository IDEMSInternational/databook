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
#'   \item{\code{import_data(data_tables = list(), data_tables_variables_metadata = rep(list(data.frame()),length(data_tables)), data_tables_metadata = rep(list(list()),length(data_tables)), data_tables_filters = rep(list(list()),length(data_tables)), data_tables_column_selections = rep(list(list()),length(data_tables)), imported_from = as.list(rep("",length(data_tables))), data_names = NULL, messages=TRUE, convert=TRUE, create=TRUE, prefix=TRUE, add_to_graph_book = TRUE)}}{Imports data into the DataBook from a list of data tables and their metadata.}
#'   \item{\code{replace_instat_object(new_instat_object)}}{Replaces the current instat object with a new one.}
#'   \item{\code{set_data_objects(new_data_objects)}}{Sets the data objects for the DataBook.}
#'   \item{\code{copy_data_object(data_name, new_name, filter_name = "", column_selection_name = "", reset_row_names = TRUE)}}{Copies a data object with optional filtering and column selection.}
#'   \item{\code{import_RDS(data_RDS, keep_existing = TRUE, overwrite_existing = FALSE, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE)}}{Imports data from an RDS file into the DataBook.}
#'   \item{\code{clone_data_object(curr_data_object, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, ...)}}{Clones a data object with options to include various components.}
#'   \item{\code{clone_instat_calculation(curr_instat_calculation, ...)}}{Clones an instat calculation.}
#'   \item{\code{import_from_ODK(username, form_name, platform)}}{Imports data from ODK (Open Data Kit).}
#'   \item{\code{set_meta(new_meta)}}{Sets the metadata for the DataBook.}
#'   \item{\code{set_objects(new_objects)}}{Sets the objects for the DataBook.}
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
#'   \item{\code{make_date_yearmonthday(data_name, year, month, day, f_year, f_month, f_day, year_format = "%Y", month_format = "%m")}}{Creates a date column from the specified year, month, and day columns in the given data table, with options for formatting.}
#'   \item{\code{make_date_yeardoy(data_name, year, doy, base, doy_typical_length = "366")}}{Creates a date column from the specified year and day of year columns in the given data table.}
#'   \item{\code{set_contrasts_of_factor(data_name, col_name, new_contrasts, defined_contr_matrix)}}{Sets the contrasts for the specified factor column in the given data table.}
#'   \item{\code{create_factor_data_frame(data_name, factor, factor_data_frame_name, include_contrasts = FALSE, replace = FALSE, summary_count = TRUE)}}{Creates a new data frame for the specified factor column in the given data table, with options to include contrasts and summary counts.}
#'   \item{\code{split_date(data_name, col_name = "", year_val = FALSE, year_name = FALSE, leap_year = FALSE,  month_val = FALSE, month_abbr = FALSE, month_name = FALSE, week_val = FALSE, week_abbr = FALSE, week_name = FALSE, weekday_val = FALSE, weekday_abbr = FALSE, weekday_name = FALSE,  day = FALSE, day_in_month = FALSE, day_in_year = FALSE, day_in_year_366 = FALSE, pentad_val = FALSE, pentad_abbr = FALSE, dekad_val = FALSE, dekad_abbr = FALSE, quarter_val = FALSE, quarter_abbr = FALSE, with_year = FALSE, s_start_month = 1, s_start_day_in_month = 1, days_in_month = FALSE)}}{Splits the specified date column into multiple components such as year, month, day, etc. in the given data table.}
#'   \item{\code{import_SST(dataset, data_from = 5, data_names = c())}}{Imports SST data from the specified dataset and data source, creating data tables with the specified names.}

# dont have from here
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
#'   \item{\code{import_from_iri(download_from, data_file, data_frame_name, location_data_name, path, X1, X2 = NA, Y1, Y2 = NA, get_area_point = "area")}}{Imports data from IRI using the specified parameters for download, file path, coordinates, and area type.}
#'   \item{\code{export_workspace(data_names, file, include_graphs = TRUE, include_models = TRUE, include_metadata = TRUE)}}{Exports the workspace to a file, including the specified data tables, graphs, models, and metadata.}
#'   \item{\code{set_links(new_links)}}{Sets the links in the object to the specified new links.}
#'   \item{\code{display_daily_graph(data_name, date_col = NULL, station_col = NULL, year_col = NULL, doy_col = NULL, climatic_element = NULL, upper_limit = 100, bar_colour = "blue", rug_colour = "red")}}{Displays a daily graph for the specified data table with options for columns, element, colors, and limits.}
#'   \item{\code{create_variable_set(data_name, set_name, columns)}}{Creates a variable set with the specified name and columns in the given data table.}
#'   \item{\code{update_variable_set(data_name, set_name, columns, new_set_name)}}{Updates the specified variable set with new columns and optionally a new name in the given data table.}
#'   \item{\code{delete_variable_sets(data_name, set_names)}}{Deletes the specified variable sets from the given data table.}
#'   \item{\code{get_variable_sets_names(data_name, include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Returns the names of variable sets for the specified data table, with options to include overall sets, exclude specific sets, and return as a list.}
#'   \item{\code{get_variable_sets(data_name, set_names, force_as_list = FALSE)}}{Returns the specified variable sets from the given data table, with an option to force the result as a list.}
#'   \item{\code{crops_definitions(data_name, year, station, rain, day, rain_totals, plant_days, plant_lengths, start_check = TRUE, season_data_name, start_day, end_day, definition_props = TRUE, print_table = TRUE)}}{Defines crop parameters for the specified data table using the provided columns and options for seasons, days, and properties.}
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
                                    curr_name <- next_default_item(tolower(curr_name), tolower(names(private$.data_sheets)))
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
                                    new_name <- next_default_item(tolower(data_obj_name), tolower(self$get_data_names()))
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
                          clone_data_object = function(curr_data_object, include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, include_scalars = TRUE, ...) {
                            curr_names <- names(curr_data_object)
                            if("get_data_frame" %in% curr_names) new_data <- curr_data_object$get_data_frame(use_current_filter = FALSE)
                            else stop("Cannot import data. No 'get_data_frame' method.")
                            if("get_metadata" %in% curr_names) new_data_name <- curr_data_object$get_metadata(data_name_label)
                            if(include_objects && "get_objects" %in% curr_names) new_objects <- curr_data_object$get_objects()
                            else new_objects <- list()
                            if(include_scalars && "get_scalars" %in% curr_names) new_scalars <- curr_data_object$get_scalars()
                            else new_scalars <- list()
                            if(include_filters && "get_filter" %in% curr_names) {
                              new_filters <- lapply(curr_data_object$get_filter(), function(x) x$data_clone())
                              new_filters <- lapply(new_filters, function(x) check_filter(x))
                            } else new_filters <- list()
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
                          clone_instat_calculation = function(curr_instat_calculation, ...) {
                            new_manips <- lapply(curr_instat_calculation$manipulations, function(x) self$clone_instat_calculation(x))
                            new_subs <- lapply(curr_instat_calculation$sub_calculations, function(x) self$clone_instat_calculation(x))
                            new_instat_calculation <- instat_calculation$new(function_exp = curr_instat_calculation$function_exp, 
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
                            out <- import_from_ODK(username, form_name, platform)
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
                          #' Sets scalar values in the DataBook.
                          #' @param new_scalars A list of scalar values to be set.
                          set_scalars = function(new_scalars) {
                            if(!is.list(new_scalars)) stop("new_scalars must be of type: list")
                            private$.scalars <- new_scalars
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
                          #' @param ... Additional arguments.
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
                          #' @param ... Additional arguments.
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
                          #' @param ... Additional arguments.
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
                                    templist[[j]] <- paste(names(templist[[j]]), " = ", templist[[j]], collapse = ", ")
                                  } else {
                                    next
                                  }
                                }
                                retlist[i, names(templist[j])] = templist[[j]]
                              }
                              i = i + 1
                            }
                            if (convert_to_character) return(convert_to_character_matrix(retlist, FALSE))
                            else return(retlist)
                          },
                          
                          #' @description
                          #' Retrieve metadata for a specific property.
                          #' @param name The name of the metadata to retrieve.
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
                          #' Retrieve scalars for a specific data table.
                          #' @param data_name The name of the data table.
                          get_scalars = function(data_name) {
                            if(is.null(data_name) || identical(data_name, overall_label)) {
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
                          #' Retrieve the value of a specific scalar for a data table.
                          #' @param data_name The name of the data table.
                          #' @param scalar_name The name of the scalar.
                          get_scalar_value = function(data_name, scalar_name) {
                            self$get_data_objects(data_name)$get_scalar_value(scalar_name)
                          },
                          
                          #' @description
                          #' Add a scalar to a data table.
                          #' @param data_name The name of the data table.
                          #' @param scalar_name The name of the scalar (optional).
                          #' @param scalar_value The value of the scalar.
                          add_scalar = function(data_name, scalar_name = "", scalar_value) {
                            if (is.null(data_name) || identical(data_name, overall_label)) {
                              if (missing(scalar_name))
                                scalar_name <- next_default_item("scalar", names(private$.scalars))
                              if (scalar_name %in% names(private$.scalars))
                                warning("A scalar called ",
                                        scalar_name,
                                        " already exists. It will be replaced.")
                              
                              # Add the scalar
                              private$.scalars[[scalar_name]] <- scalar_value
                            } else {
                              self$get_data_objects(data_name)$add_scalar(scalar_name, scalar_value)
                            }
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
                                object_name <- next_default_item("object", names(private$.objects))
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
                              out <- view_object_data(object = out$object, object_format = out$object_format)
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
                          #' @param ... Additional parameters.
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
                            next_default_item(prefix = prefix, existing_names = names(private$.data_sheets), include_index = include_index, start_index = start_index)
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
                          
                          #' @title Append Property to Variables Metadata
                          #' @description Appends a new property and its value to the metadata of specified columns in a data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to which the property should be appended.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @return None
                          append_to_variables_metadata  = function(data_name, col_names, property, new_val = "") {
                            self$get_data_objects(data_name)$append_to_variables_metadata(col_names, property, new_val)
                          },
                          
                          #' @title Append Property to Dataframe Metadata
                          #' @description Appends a new property and its value to the metadata of a data table.
                          #' @param data_name The name of the data table.
                          #' @param property The name of the property to append.
                          #' @param new_val The value of the property to append. Default is an empty string.
                          #' @return None
                          append_to_dataframe_metadata  = function(data_name, property, new_val = "") {
                            self$get_data_objects(data_name)$append_to_metadata(property, new_val)
                          },
                          
                          #' @title Append Property to Metadata
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
                          
                          #' @title Add Metadata Field
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
                          
                          #' @title Reorder Dataframes
                          #' @description Reorders the dataframes in the object according to the specified order.
                          #' @param data_frames_order A vector specifying the new order of dataframes.
                          #' @return None
                          reorder_dataframes  = function(data_frames_order) {
                            if(length(data_frames_order) != length(names(private$.data_sheets))) stop("number data frames to order should be equal to number of dataframes in the object")
                            if(!setequal(data_frames_order, names(private$.data_sheets))) stop("data_frames_order must be a permutation of the dataframe names.")
                            self$set_data_objects(private$.data_sheets[data_frames_order])
                            self$data_objects_changed <- TRUE
                          },
                          
                          #' @title Copy Columns
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
                          
                          #' @title Drop Unused Factor Levels
                          #' @description Drops unused levels from a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @return None
                          drop_unused_factor_levels  = function(data_name, col_name) {
                            self$get_data_objects(data_name)$drop_unused_factor_levels(col_name = col_name)
                          },
                          
                          #' @title Set Factor Levels
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
                          
                          #' @title Edit Factor Level
                          #' @description Edits a level in a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param old_level The old level to replace.
                          #' @param new_level The new level to set.
                          #' @return None
                          edit_factor_level  = function(data_name, col_name, old_level, new_level) {
                            self$get_data_objects(data_name)$edit_factor_level(col_name = col_name, old_level = old_level, new_level = new_level)
                          },
                          
                          #' @title Set Factor Reference Level
                          #' @description Sets the reference level for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_ref_level The new reference level.
                          #' @return None
                          set_factor_reference_level  = function(data_name, col_name, new_ref_level) {
                            self$get_data_objects(data_name)$set_factor_reference_level(col_name = col_name, new_ref_level = new_ref_level)
                          },
                          
                          #' @title Get Column Count
                          #' @description Returns the number of columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param use_column_selection Boolean flag to use column selection. Default is FALSE.
                          #' @return The number of columns.
                          get_column_count  = function(data_name, use_column_selection = FALSE) {
                            return(self$get_data_objects(data_name)$get_column_count(use_column_selection))
                          },
                          
                          #' @title Reorder Factor Levels
                          #' @description Reorders the levels of a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_level_names A vector specifying the new order of factor levels.
                          #' @return None
                          reorder_factor_levels  = function(data_name, col_name, new_level_names) {
                            self$get_data_objects(data_name)$reorder_factor_levels(col_name = col_name, new_level_names = new_level_names)
                          },
                          
                          #' @title Get Data Type
                          #' @description Returns the data type of the specified column in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @return The data type of the column.
                          get_data_type  = function(data_name, col_name) {
                            self$get_data_objects(data_name)$get_data_type(col_name = col_name)
                          },
                          
                          #' @title Copy Data Frame
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
                              if(missing(new_name)) new_name <- next_default_item(data_name, self$get_data_names())
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
                          
                          #' @title Copy Column Metadata to Clipboard
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
                          
                          #' @title Copy Data Frame Metadata to Clipboard
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
                          
                          #' @title Copy to Clipboard
                          #' @description Copies the specified content to the clipboard.
                          #' @param content The content to copy to the clipboard.
                          #' @return None
                          copy_to_clipboard  = function(content) {
                            clipr::write_clip(content = content)
                          },
                          
                          #' @title Set Hidden Columns
                          #' @description Sets the specified columns as hidden in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to set as hidden.
                          #' @return None
                          set_hidden_columns  = function(data_name, col_names = c()) {
                            self$get_data_objects(data_name)$set_hidden_columns(col_names = col_names)
                          },
                          
                          #' @title Unhide All Columns
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
                          
                          #' @title Set Hidden Data Frames
                          #' @description Sets the specified data tables as hidden.
                          #' @param data_names A vector of data table names to set as hidden.
                          #' @return None
                          set_hidden_data_frames  = function(data_names = c()) {
                            invisible(sapply(data_names, function(x) self$append_to_dataframe_metadata(data_name = x, property = is_hidden_label, new_val = TRUE)))
                            unhide_data_names <- setdiff(self$get_data_names(), data_names)
                            invisible(sapply(unhide_data_names, function(x) self$append_to_dataframe_metadata(data_name = x, property = is_hidden_label, new_val = FALSE)))
                          },
                          
                          #' @title Get Hidden Data Frames
                          #' @description Returns a list of hidden data tables.
                          #' @return A vector of hidden data table names.
                          get_hidden_data_frames  = function() {
                            all_data_names <- names(private$.data_sheets)
                            visible_data_names <- all_data_names[sapply(all_data_names, function(x) !isTRUE(self$get_data_objects(x)$get_metadata(label = is_hidden_label)))]
                            hidden_data_names <- setdiff(all_data_names, visible_data_names)
                            return(hidden_data_names)
                          },
                          
                          #' @title Set Row Names
                          #' @description Sets the row names for the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param row_names A vector of row names to set.
                          #' @return None
                          set_row_names  = function(data_name, row_names) {
                            self$get_data_objects(data_name)$set_row_names(row_names = row_names)
                          },
                          
                          #' @title Get Row Names
                          #' @description Returns the row names of the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return A vector of row names.
                          get_row_names  = function(data_name) {
                            self$get_data_objects(data_name)$get_row_names()
                          },
                          
                          #' @title Set Protected Columns
                          #' @description Sets the specified columns as protected in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to set as protected.
                          #' @return None
                          set_protected_columns  = function(data_name, col_names) {
                            self$get_data_objects(data_name)$set_protected_columns(col_names = col_names)
                          },
                          
                          #' @title Get Metadata Fields
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
                          
                          #' @title Freeze Columns
                          #' @description Freezes the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param column A vector of column names to freeze.
                          #' @return None
                          freeze_columns  = function(data_name, column) {
                            self$get_data_objects(data_name)$freeze_columns(column = column)
                          },
                          
                          #' @title Unfreeze Columns
                          #' @description Unfreezes all columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return None
                          unfreeze_columns  = function(data_name) {
                            self$get_data_objects(data_name)$unfreeze_columns()
                          },
                          
                          #' @title Is Variables Metadata
                          #' @description Checks if the specified property is metadata for the given columns in the data table.
                          #' @param data_name The name of the data table.
                          #' @param property The name of the property to check.
                          #' @param column The name of the column.
                          #' @param return_vector Boolean flag to return the result as a vector. Default is FALSE.
                          #' @return A boolean value indicating if the property is metadata for the columns.
                          is_variables_metadata  = function(data_name, property, column, return_vector = FALSE) {
                            self$get_data_objects(data_name)$is_variables_metadata(property, column, return_vector)
                          },
                          
                          #' @title Data Frame Exists
                          #' @description Checks if the specified data table exists.
                          #' @param data_name The name of the data table.
                          #' @return A boolean value indicating if the data table exists.
                          data_frame_exists  = function(data_name) {
                            return(data_name %in% names(private$.data_sheets))
                          },
                          
                          #' @title Add Key
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
                          
                          #' @title Is Key
                          #' @description Checks if the specified columns are keys in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param col_names A vector of column names to check.
                          #' @return A boolean value indicating if the columns are keys.
                          is_key  = function(data_name, col_names) {
                            self$get_data_objects(data_name)$is_key(col_names)
                          },
                          
                          #' @title Has Key
                          #' @description Checks if the specified data table has a key.
                          #' @param data_name The name of the data table.
                          #' @return A boolean value indicating if the data table has a key.
                          has_key  = function(data_name) {
                            self$get_data_objects(data_name)$has_key()
                          },
                          
                          #' @title Get Keys
                          #' @description Returns the keys of the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param key_name The name of the key. Default is all keys.
                          #' @return A list of keys.
                          get_keys  = function(data_name, key_name) {
                            self$get_data_objects(data_name)$get_keys(key_name)
                          },
                          
                          #' @title Add New Comment
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
                          
                          #' @title Get Comments
                          #' @description Returns the comments for the specified data table and comment ID.
                          #' @param data_name The name of the data table.
                          #' @param comment_id The ID of the comment.
                          #' @return A data frame of comments.
                          get_comments  = function(data_name, comment_id) {
                            self$get_data_objects(data_name)$get_comments(comment_id)
                          },
                          
                          #' @title Get Links
                          #' @description Returns the links for the specified link name or all links.
                          #' @param link_name The name of the link. Default is all links.
                          #' @return A list of links.
                          get_links  = function(link_name, ...) {
                            if(!missing(link_name)) {
                              if(!link_name %in% names(private$.links)) stop(link_name, " not found.")
                              return(private$.links[[link_name]])
                            } else {
                              return(private$.links)
                            }
                          },
                          
                          #' @title Set Structure Columns
                          #' @description Sets the structure columns for the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param struc_type_1 A vector of column names for the first structure type.
                          #' @param struc_type_2 A vector of column names for the second structure type.
                          #' @param struc_type_3 A vector of column names for the third structure type.
                          #' @return None
                          set_structure_columns  = function(data_name, struc_type_1 = c(), struc_type_2 = c(), struc_type_3 = c()) {
                            self$get_data_objects(data_name)$set_structure_columns(struc_type_1, struc_type_2, struc_type_3)
                          },
                          
                          #' @title Add Dependent Columns
                          #' @description Adds dependent columns to the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to add dependents to.
                          #' @param dependent_cols A vector of dependent column names.
                          #' @return None
                          add_dependent_columns  = function(data_name, columns, dependent_cols) {
                            self$get_data_objects(data_name)$add_dependent_columns(columns, dependent_cols)
                          },
                          
                          #' @title Set Column Colours
                          #' @description Sets the colours for the specified columns in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to set colours for.
                          #' @param colours A vector of colours.
                          #' @return None
                          set_column_colours  = function(data_name, columns, colours) {
                            self$get_data_objects(data_name)$set_column_colours(columns, colours)
                          },
                          
                          #' @title Has Colours
                          #' @description Checks if the specified columns have colours in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to check.
                          #' @return A boolean value indicating if the columns have colours.
                          has_colours  = function(data_name, columns) {
                            self$get_data_objects(data_name)$has_colours(columns)
                          },
                          
                          #' @title Remove Column Colours
                          #' @description Removes the colours from all columns in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @return None
                          remove_column_colours  = function(data_name) {
                            self$get_data_objects(data_name)$remove_column_colours()
                          },
                          
                          #' @title Set Column Colours by Metadata
                          #' @description Sets the colours for the specified columns based on metadata in the given data table.
                          #' @param data_name The name of the data table.
                          #' @param columns A vector of column names to set colours for.
                          #' @param property The metadata property to use for setting colours.
                          #' @return None
                          set_column_colours_by_metadata  = function(data_name, columns, property) {
                            self$get_data_objects(data_name)$set_column_colours_by_metadata(data_name, columns, property)
                          },
                          
                          #' @title Graph One Variable
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
                          #' @param ... Additional arguments passed to the graph function.
                          #' @return None
                          graph_one_variable  = function(data_name, columns, numeric = "geom_boxplot", categorical = "geom_bar", character = "geom_bar", output = "facets", free_scale_axis = FALSE, ncol = NULL, coord_flip  = FALSE, ...) {
                            self$get_data_objects(data_name)$graph_one_variable(columns = columns, numeric = numeric, categorical = categorical, output = output, free_scale_axis = free_scale_axis, ncol = ncol, coord_flip = coord_flip, ... = ...)
                          },
                          
                          #' @title Make Date YearMonthDay
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
                          
                          #' @title Make Date YearDoY
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
                          
                          #' @title Set Contrasts of Factor
                          #' @description Sets the contrasts for a factor column in the specified data table.
                          #' @param data_name The name of the data table.
                          #' @param col_name The name of the column.
                          #' @param new_contrasts A vector of new contrasts.
                          #' @param defined_contr_matrix A defined contrast matrix.
                          #' @return None
                          set_contrasts_of_factor  = function(data_name, col_name, new_contrasts, defined_contr_matrix) {
                            self$get_data_objects(data_name)$set_contrasts_of_factor(col_name = col_name, new_contrasts = new_contrasts, defined_contr_matrix = defined_contr_matrix)
                          },
                          
                          #' @title Create Factor Data Frame
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
                            factor_data_frame_name <- next_default_item(factor_data_frame_name, self$get_data_names(), include_index = FALSE)
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
                          
                          #' @title Split Date
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
                          
                          #' @title Import SST
                          #' @description Imports SST data and adds keys and links to the specified data tables.
                          #' @param dataset The SST dataset.
                          #' @param data_from The source of the data. Default is 5.
                          #' @param data_names A vector of data table names.
                          #' @return None
                          import_SST  = function(dataset, data_from = 5, data_names = c()) {
                            data_list <- convert_SST(dataset, data_from)
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
