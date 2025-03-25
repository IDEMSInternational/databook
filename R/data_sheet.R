#' DataSheet Class
#'
#' @description An R6 class to handle and manage a data frame with associated metadata, filters, and various settings.
#' 
#' @name DataSheet
#' @docType class
#' @format An R6 class object.
#' @aliases DataSheet
#'
#' @usage NULL
#'
#' @param data A data frame to be managed by the DataSheet object. Default is an empty data frame.
#' @param data_name A character string for the name of the data set. Default is an empty string.
#' @param variables_metadata A data frame containing metadata for the variables. Default is an empty data frame.
#' @param metadata A list containing additional metadata. Default is an empty list.
#' @param imported_from A character string indicating the source of the data import. Default is an empty string.
#' @param messages Logical, if TRUE messages will be shown during the setup. Default is TRUE.
#' @param convert Logical, if TRUE data will be converted. Default is TRUE.
#' @param create Logical, if TRUE the data will be created. Default is TRUE.
#' @param start_point Numeric, the starting point for default naming. Default is 1.
#' @param filters A list of filters to be applied to the data. Default is an empty list.
#' @param column_selections A list of column selections. Default is an empty list.
#' @param objects A list of objects associated with the data. Default is an empty list.
#' @param calculations A list of calculations to be performed on the data. Default is an empty list.
#' @param keys A list of keys for the data. Default is an empty list.
#' @param scalars A list of scalars on the data. Default is an empty list.
#' @param comments A list of comments associated with the data. Default is an empty list.
#' @param keep_attributes Logical, if TRUE attributes will be kept. Default is TRUE.
#' @param undo_history A list containing a history of data frames which will be replaced with the current data frame if the user presses undo.
#' @param redo_undo_history A list containing the undo history to redo.
#' @param disable_undo Logical, if TRUE undo option is disabled. Default is FALSE.
#' 
#' @section Methods:
#' \describe{
#'   \item{\code{set_data(new_data, messages, check_names)}}{Sets the data for the DataSheet object.}
#'   \item{\code{set_changes(new_changes)}}{Sets the changes for the DataSheet object.}
#'   \item{\code{set_filters(new_filters)}}{Sets the filters for the DataSheet object.}
#'   \item{\code{set_column_selections(new_column_selections)}}{Sets the column selections for the DataSheet object.}
#'   \item{\code{set_meta(new_meta)}}{Sets the metadata for the DataSheet object.}
#'   \item{\code{clear_metadata()}}{Clears the metadata for the DataSheet object.}
#'   \item{\code{clear_variables_metadata()}}{Clears the variables metadata for the DataSheet object.}
#'   \item{\code{add_defaults_meta()}}{Adds default metadata to the DataSheet object.}
#'   \item{\code{add_defaults_variables_metadata(column_names)}}{Adds default variables metadata to the DataSheet object.}
#'   \item{\code{set_objects(new_objects)}}{Sets the objects for the DataSheet object.}
#'   \item{\code{set_calculations(new_calculations)}}{Sets the calculations for the DataSheet object.}
#'   \item{\code{set_keys(new_keys)}}{Sets the keys for the DataSheet object.}
#'   \item{\code{set_comments(new_comments)}}{Sets the comments for the DataSheet object.}
#'   \item{\code{append_to_metadata(label, value)}}{Appends to the metadata of the DataSheet object.}
#'   \item{\code{is_metadata(label)}}{Checks if a label is in the metadata of the DataSheet object.}
#'   \item{\code{set_data_changed(new_val)}}{Set the data_changed flag.}
#'   \item{\code{set_variables_metadata_changed(new_val)}}{Set the variables_metadata_changed flag.}
#'   \item{\code{set_metadata_changed(new_val)}}{Set the metadata_changed flag.}
#'   \item{\code{set_enable_disable_undo(disable_undo)}}{Set whether undo functionality is enabled or disabled.}
#'   \item{\code{save_state_to_undo_history()}}{Save the current state to the undo history.}
#'   \item{\code{is_undo()}}{Check if undo functionality is currently disabled.}
#'   \item{\code{has_undo_history()}}{Check if there are any actions available to undo.}
#'   \item{\code{undo_last_action()}}{Undo the last action by restoring the previous state. Removes the last saved state from the undo history.}
#'   \item{\code{redo_last_action()}}{Redo the last undone action by restoring the next state.}
#'   \item{\code{set_scalars(new_scalars)}}{Set the scalars property.}
#'   \item{\code{set_undo_history(new_data, attributes = list())}}{Set the undo history with memory management.}
#'   \item{\code{get_scalars()}}{Retrieve the current scalars.}
#'   \item{\code{get_scalar_names(as_list = FALSE, excluded_items = c(), ...)}}{Get the names of the scalars.}
#'   \item{\code{get_scalar_value(scalar_name)}}{Retrieve the value of a specific scalar by name.}
#'   \item{\code{add_scalar(scalar_name = "", scalar_value)}}{Add a scalar to the scalars property. Replaces an existing scalar if one with the same name already exists.}
#'   \item{\code{get_data_frame(convert_to_character, include_hidden_columns, use_current_filter, use_column_selection, filter_name, column_selection_name, stack_data, remove_attr, retain_attr, max_cols, max_rows, drop_unused_filter_levels, start_row, start_col, ...)}}{Get the data frame with various options for filtering, column selection, and attribute handling.}
#'   \item{\code{get_variables_metadata(data_type, convert_to_character, property, column, error_if_no_property, direct_from_attributes, use_column_selection)}}{Get the metadata for the variables in the data frame.}
#'   \item{\code{get_column_data_types(columns)}}{Get the data types of the specified columns.}
#'   \item{\code{get_column_labels(columns)}}{Get the labels of the specified columns.}
#'   \item{\code{get_data_frame_label(use_current_filter)}}{Get the label of the data frame.}
#'   \item{\code{clear_variables_metadata()}}{Clear the variables metadata.}
#'   \item{\code{get_metadata(label, include_calculated, excluded_not_for_display)}}{Get the metadata for the data frame.}
#'   \item{\code{get_changes()}}{Get the changes made to the data frame.}
#'   \item{\code{get_calculations()}}{Get the calculations applied to the data frame.}
#'   \item{\code{get_calculation_names(as_list, excluded_items)}}{Get the names of the calculations applied to the data frame.}
#'   \item{\code{add_columns_to_data(col_name, col_data, use_col_name_as_prefix, hidden, before, adjacent_column, num_cols, require_correct_length, keep_existing_position)}}{Add new columns to the data frame.}
#'   \item{\code{get_columns_from_data(col_names, force_as_data_frame, use_current_filter, use_column_selection, remove_labels, drop_unused_filter_levels)}}{Get the data for the specified columns.}
#'   \item{\code{anova_tables(x_col_names, y_col_name, signif.stars, sign_level, means)}}{Generate ANOVA tables for the specified columns.}
#'   \item{\code{cor(x_col_names, y_col_name, use, method)}}{Calculate the correlation between specified columns.}
#'   \item{\code{rename_column_in_data(curr_col_name, new_col_name, label, type, .fn, .cols, new_column_names_df, new_labels_df, ...)}}{Renames a column in the data.}
#'   \item{\code{remove_columns_in_data(cols, allow_delete_all)}}{Removes specified columns from the data.}
#'   \item{\code{replace_value_in_data(col_names, rows, old_value, old_is_missing, start_value, end_value, new_value, new_is_missing, closed_start_value, closed_end_value, locf, from_last)}}{Replaces values in the specified columns and rows.}
#'   \item{\code{paste_from_clipboard(col_names, start_row_pos, first_clip_row_is_header, clip_board_text)}}{Pastes data from the clipboard into the specified columns and rows.}
#'   \item{\code{append_to_metadata(property, new_value)}}{Appends a new value to the metadata of the data.}
#'   \item{\code{append_to_variables_metadata(col_names, property, new_val)}}{Appends a new value to the variables metadata.}
#'   \item{\code{append_to_changes(value)}}{Appends a value to the changes list.}
#'   \item{\code{is_metadata(str)}}{Checks if a string is in the metadata.}
#'   \item{\code{is_variables_metadata(str, col, return_vector)}}{Checks if a string is in the variables metadata.}
#'   \item{\code{add_defaults_meta()}}{Adds default values to the metadata.}
#'   \item{\code{add_defaults_variables_metadata(column_names)}}{Adds default values to the variables metadata for the specified columns.}
#'   \item{\code{remove_rows_in_data(row_names)}}{Removes the specified rows from the data.}
#'   \item{\code{get_next_default_column_name(prefix)}}{Gets the next default column name based on the given prefix.}
#'   \item{\code{reorder_columns_in_data(col_order)}}{Reorders the columns in the data based on the given order.}
#'   \item{\code{insert_row_in_data(start_row, row_data, number_rows, before)}}{Inserts new rows into the data at the specified position.}
#'   \item{\code{get_data_frame_length(use_current_filter)}}{Gets the length of the data frame.}
#'   \item{\code{get_factor_data_frame(col_name, include_levels, include_NA_level)}}{Gets the data frame for a factor column with optional inclusion of levels and NA level.}
#'   \item{\code{get_column_factor_levels(col_name)}}{Gets the factor levels for the specified column.}
#'   \item{\code{sort_dataframe(col_names, decreasing, na.last, by_row_names, row_names_as_numeric)}}{Sorts the data frame based on the specified columns.}
#'   \item{\code{convert_column_to_type(col_names, to_type, factor_values, set_digits, set_decimals, keep_attr, ignore_labels, keep.labels)}}{Converts the specified columns to the given type.}
#'   \item{\code{copy_columns(col_names)}}{Copies the specified columns in the data.}
#'   \item{\code{drop_unused_factor_levels(col_name)}}{Drops unused factor levels in the specified column.}
#'   \item{\code{set_factor_levels(col_name, new_labels, new_levels, set_new_labels)}}{Sets the factor levels for the specified column.}
#'   \item{\code{edit_factor_level(col_name, old_level, new_level)}}{Edits a factor level in the specified column.}
#'   \item{\code{set_factor_reference_level(col_name, new_ref_level)}}{Sets the reference level for a factor column.}
#'   \item{\code{reorder_factor_levels(col_name, new_level_names)}}{Reorders the factor levels for the specified column.}
#'   \item{\code{get_column_count(use_column_selection)}}{Gets the count of columns in the data frame.}
#'   \item{\code{get_column_names(as_list, include, exclude, excluded_items, max_no, use_current_column_selection)}}{Gets the names of the columns in the data frame.}
#'   \item{\code{get_data_type(col_name)}}{Gets the data type of the specified column.}
#'   \item{\code{set_hidden_columns(col_names)}}{Sets the specified columns as hidden.}
#'   \item{\code{unhide_all_columns()}}{Unhides all columns.}
#'   \item{\code{set_row_names(row_names)}}{Sets the row names of the data.}
#'   \item{\code{set_col_names(col_names)}}{Sets the column names of the data.}
#'   \item{\code{get_row_names()}}{Gets the row names of the data.}
#'   \item{\code{get_dim_dataframe()}}{Gets the dimensions of the data frame.}
#'   \item{\code{set_protected_columns(col_names)}}{Sets the specified columns as protected.}
#'   \item{\code{add_filter(filter, filter_name, replace, set_as_current, na.rm, is_no_filter, and_or, inner_not, outer_not)}}{Adds a filter to the data.}
#'   \item{\code{add_filter_as_levels(filter_levels, column)}}{Adds multiple filters based on the levels of a specified column.}
#'   \item{\code{get_current_filter()}}{Gets the current filter applied to the data.}
#'   \item{\code{set_current_filter(filter_name)}}{Sets the current filter for the data.}
#'   \item{\code{get_filter_names(as_list, include, exclude, excluded_items)}}{Gets the names of all filters.}
#'   \item{\code{get_filter(filter_name)}}{Gets a specific filter by name.}
#'   \item{\code{get_filter_as_logical(filter_name)}}{Gets the logical vector of a filter.}
#'   \item{\code{get_filter_column_names(filter_name)}}{Gets the column names used in a filter.}
#'   \item{\code{get_current_filter_column_names()}}{Gets the column names used in the current filter.}
#'   \item{\code{filter_applied()}}{Checks if a filter is applied.}
#'   \item{\code{remove_current_filter()}}{Remove the current filter.}
#'   \item{\code{filter_string(filter_name)}}{Returns the string representation of a filter.}
#'   \item{\code{get_filter_as_instat_calculation(filter_name)}}{Returns the filter as an instat calculation object.}
#'   \item{\code{add_column_selection(column_selection, name, replace, set_as_current, is_everything, and_or)}}{Adds a column selection to the data.}
#'   \item{\code{get_current_column_selection()}}{Gets the current column selection applied to the data.}
#'   \item{\code{set_current_column_selection(name)}}{Sets the current column selection for the data.}
#'   \item{\code{get_column_selection_names(as_list, include, exclude, excluded_items)}}{Gets the names of all column selections.}
#'   \item{\code{get_column_selection(name)}}{Gets a specific column selection by name.}
#'   \item{\code{get_column_selection_column_names(name)}}{Gets the column names used in a column selection.}
#'   \item{\code{get_column_selected_column_names(column_selection_name)}}{Gets the selected column names for a given column selection name.}
#'   \item{\code{column_selection_applied()}}{Checks if a column selection is applied.}
#'   \item{\code{remove_current_column_selection()}}{Removes the current column selection.}
#'   \item{\code{get_variables_metadata_fields(as_list, include, exclude, excluded_items)}}{Gets the fields of the variables metadata.}
#'   \item{\code{add_object(object_name, object_type_label, object_format, object)}}{Adds an object with its metadata to the list of objects.}
#'   \item{\code{get_object_names(object_type_label, as_list)}}{Gets the names of objects of a specified type.}
#'   \item{\code{get_objects(object_type_label)}}{Gets objects of a specified type.}
#'   \item{\code{get_object(object_name)}}{Gets a specific object by name.}
#'   \item{\code{rename_object(object_name, new_name, object_type)}}{Renames an object.}
#'   \item{\code{delete_objects(data_name, object_names, object_type)}}{Deletes specified objects.}
#'   \item{\code{reorder_objects(new_order)}}{Reorders the objects.}
#'   \item{\code{data_clone(include_objects, include_metadata, include_logs, include_filters, include_column_selections, include_calculations, include_comments, ...)}}{Clones the data with specified attributes included or excluded.}
#'   \item{\code{freeze_columns(column)}}{Freezes the specified columns.}
#'   \item{\code{unfreeze_columns()}}{Unfreezes all columns.}
#'   \item{\code{add_key(col_names, key_name)}}{Adds a key with specified columns.}
#'   \item{\code{is_key(col_names)}}{Checks if specified columns form a key.}
#'   \item{\code{has_key()}}{Checks if there is a key in the data.}
#'   \item{\code{get_keys(key_name)}}{Gets the keys of the data.}
#'   \item{\code{remove_key(key_name)}}{Removes a specified key.}
#'   \item{\code{get_comments(comment_id)}}{Gets the comments for the data.}
#'   \item{\code{remove_comment(key_name)}}{Removes a comment.}
#'   \item{\code{set_structure_columns(struc_type_1, struc_type_2, struc_type_3)}}{Sets the structure columns of the data.}
#'   \item{\code{add_dependent_columns(columns, dependent_cols)}}{Adds dependent columns to the specified columns.}
#'   \item{\code{set_column_colours(columns, colours)}}{Sets the colours of the specified columns.}
#'   \item{\code{has_colours(columns)}}{Checks if the specified columns have colours.}
#'   \item{\code{set_column_colours_by_metadata(data_name, columns, property)}}{Sets the colours of columns based on metadata property.}
#'   \item{\code{remove_column_colours()}}{Removes the colours of the columns.}
#'   \item{\code{graph_one_variable(columns, numeric, categorical, output, free_scale_axis, ncol, coord_flip, ...)}}{Creates a graph for a single variable.}
#'   \item{\code{make_date_yearmonthday(year, month, day, f_year, f_month, f_day, year_format, month_format)}}{Creates a date from year, month, and day columns.}
#'   \item{\code{make_date_yeardoy(year, doy, base, doy_typical_length)}}{Creates a date from year and day of year columns.}
#'   \item{\code{set_contrasts_of_factor(col_name, new_contrasts, defined_contr_matrix)}}{Sets contrasts for a factor column in the data.}
#'   \item{\code{split_date(col_name = "", year_val = FALSE, year_name = FALSE, leap_year = FALSE, month_val = FALSE, month_abbr = FALSE, month_name = FALSE, week_val = FALSE, week_abbr = FALSE, week_name = FALSE, weekday_val = FALSE, weekday_abbr = FALSE, weekday_name = FALSE, day = FALSE, day_in_month = FALSE, day_in_year = FALSE, day_in_year_366 = FALSE, pentad_val = FALSE, pentad_abbr = FALSE, dekad_val = FALSE, dekad_abbr = FALSE, quarter_val = FALSE, quarter_abbr = FALSE, with_year = FALSE, s_start_month = 1, s_start_day_in_month = 1, days_in_month = FALSE)}}{Extracts components such as year, month, week, weekday, etc., from a date column and creates respective new columns.}
#'   \item{\code{set_climatic_types(types)}}{Sets the climatic types for columns in the data.}
#'   \item{\code{append_climatic_types(types)}}{Appends climatic types to columns in the data.}
#'   \item{\code{make_inventory_plot(date_col, station_col = NULL, year_col = NULL, doy_col = NULL, element_cols = NULL, add_to_data = FALSE, year_doy_plot = FALSE, coord_flip = FALSE, facet_by = NULL, facet_xsize = 9, facet_ysize = 9, facet_xangle = 90, facet_yangle = 90, graph_title = "Inventory Plot", graph_subtitle = NULL, graph_caption = NULL, title_size = NULL, subtitle_size = NULL, caption_size = NULL, labelXAxis, labelYAxis, xSize = NULL, ySize = NULL, Xangle = NULL, Yangle = NULL, scale_xdate, fromXAxis = NULL, toXAxis = NULL, byXaxis = NULL, date_ylabels, legend_position = NULL, xlabelsize = NULL, ylabelsize = NULL, scale = NULL, dir = "", row_col_number, nrow = NULL, ncol = NULL, scale_ydate = FALSE, date_ybreaks, step = 1, key_colours = c("red", "grey"), display_rain_days = FALSE, rain_cats = list(breaks = c(0, 0.85, Inf), labels = c("Dry", "Rain"), key_colours = c("tan3", "blue")))}}{Creates an inventory plot for specified date and element columns.}
#'   \item{\code{infill_missing_dates(date_name, factors, start_month, start_date, end_date, resort = TRUE)}}{Infills missing dates in the data for a specified date column, with optional factors, start and end dates.}
#'   \item{\code{get_key_names(include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Retrieves key names from the data, with options to include overall, include or exclude specific keys, and return as a list.}
#'   \item{\code{define_corruption_outputs(output_columns = c())}}{Defines the specified output columns as corruption outputs and updates metadata accordingly.}
#'   \item{\code{define_red_flags(red_flags = c())}}{Defines the specified columns as red flags and updates metadata accordingly.}
#'   \item{\code{define_as_procurement_country_level_data(types = c(), auto_generate = TRUE)}}{Defines the data as procurement country-level data with specified types and optionally auto-generates columns.}
#'   \item{\code{is_corruption_type_present(type)}}{Checks if the specified corruption type is present in the data.}
#'   \item{\code{get_CRI_component_column_names()}}{Retrieves the column names that are components of the Corruption Risk Index (CRI).}
#'   \item{\code{get_red_flag_column_names()}}{Retrieves the column names that are defined as red flags.}
#'   \item{\code{get_CRI_column_names()}}{Retrieves the column names that start with "CRI".}
#'   \item{\code{get_corruption_column_name(type)}}{Gets the column name associated with the specified corruption type.}
#'   \item{\code{set_procurement_types(primary_types = c(), calculated_types = c(), auto_generate = TRUE)}}{Sets the specified primary and calculated procurement types, and optionally auto-generates columns.}
#'   \item{\code{generate_award_year()}}{Generates and appends the award year column to the data.}
#'   \item{\code{generate_procedure_type()}}{Generates and appends the procedure type column to the data.}
#'   \item{\code{generate_procuring_authority_id()}}{Generates and appends the procuring authority ID column to the data.}
#'   \item{\code{generate_winner_id()}}{Generates and appends the winner ID column to the data.}
#'   \item{\code{generate_foreign_winner()}}{Generates and appends the foreign winner column to the data.}
#'   \item{\code{generate_procurement_type_categories()}}{Generates and appends the procurement type categories column to the data.}
#'   \item{\code{generate_procurement_type_2()}}{Generates and appends the procurement type 2 column to the data.}
#'   \item{\code{generate_procurement_type_3()}}{Generates and appends the procurement type 3 column to the data.}
#'   \item{\code{generate_signature_period()}}{Generates and appends the signature period column to the data.}
#'   \item{\code{generate_signature_period_corrected()}}{Generates and appends the corrected signature period column to the data.}
#'   \item{\code{generate_signature_period_5Q()}}{Generates and appends the signature period 5 quantiles column to the data.}
#'   \item{\code{generate_signature_period_25Q()}}{Generates and appends the signature period 25 quantiles column to the data.}
#'   \item{\code{generate_rolling_contract_no_winners()}}{Generates and appends the rolling contract number of winners column to the data.}
#'   \item{\code{generate_rolling_contract_no_issuer()}}{Generates and appends the rolling contract number of issuers column to the data.}
#'   \item{\code{generate_rolling_contract_value_sum_issuer()}}{Generates and appends the rolling contract value sum of issuers column to the data.}
#'   \item{\code{generate_rolling_contract_value_sum_winner()}}{Generates and appends the rolling contract value sum of winners column to the data.}
#'   \item{\code{generate_rolling_contract_value_share_winner()}}{Generates and appends the rolling contract value share of winners column to the data.}
#'   \item{\code{generate_single_bidder()}}{Generates and appends the single bidder column to the data.}
#'   \item{\code{generate_contract_value_share_over_threshold()}}{Generates and appends the contract value share over threshold column to the data.}
#'   \item{\code{generate_all_bids()}}{Generates and appends the all bids column to the data.}
#'   \item{\code{generate_all_bids_trimmed()}}{Generates and appends the all bids trimmed column to the data.}
#'   \item{\code{standardise_country_names(country_columns = c())}}{Standardises the country names in the specified columns.}
#'   \item{\code{get_climatic_column_name(col_name)}}{Gets the climatic column name from the data.}
#'   \item{\code{is_climatic_data()}}{Checks if the data is defined as climatic.}
#'   \item{\code{append_column_attributes(col_name, new_attr)}}{Appends attributes to the specified column.}
#'   \item{\code{display_daily_graph(data_name, date_col = NULL, station_col = NULL, year_col = NULL, doy_col = NULL, climatic_element = NULL, rug_colour = "red", bar_colour = "blue", upper_limit = 100)}}{Creates and displays daily graphs for the specified climatic element.}
#'   \item{\code{get_variables_metadata_names(columns)}}{Gets the names of the metadata attributes for the specified columns.}
#'   \item{\code{create_variable_set(set_name, columns)}}{Creates a variable set with the specified name and columns.}
#'   \item{\code{update_variable_set(set_name, columns, new_set_name)}}{Updates the variable set with the specified columns and new set name.}
#'   \item{\code{delete_variable_sets(set_names)}}{Deletes the specified variable sets.}
#'   \item{\code{get_variable_sets_names(include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c())}}{Gets the names of the variable sets.}
#'   \item{\code{get_variable_sets(set_names, force_as_list)}}{Gets the specified variable sets.}
#'   \item{\code{patch_climate_element(date_col_name = "", var = "", vars = c(), max_mean_bias = NA, max_stdev_bias = NA, column_name, station_col_name, time_interval = "month")}}{Patches the specified climate element with the given parameters.}
#'   \item{\code{visualize_element_na(element_col_name, element_col_name_imputed, station_col_name, x_axis_labels_col_name, ncol = 2, type = "distribution", xlab = NULL, ylab = NULL, legend = TRUE, orientation = "horizontal", interval_size = 1461, x_with_truth = NULL, measure = "percent")}}{Visualizes the NA values in the specified element column with the given parameters.}
#'   \item{\code{get_data_entry_data(station, date, elements, view_variables, station_name, type, start_date, end_date)}}{Gets the data entry data for the specified parameters.}
#'   \item{\code{save_data_entry_data(new_data, rows_changed, add_flags = FALSE, ...)}}{Saves the data entry data with the specified parameters.}
#'   \item{\code{add_flag_fields(col_names)}}{Adds flag fields to the specified columns.}
#'   \item{\code{remove_empty(which = c("rows", "cols"))}}{Removes empty rows or columns from the data.}
#'   \item{\code{replace_values_with_NA(row_index, column_index)}}{Replaces values with NA in the specified rows and columns.}
#'   \item{\code{set_options_by_context_types(obyc_types = NULL, key_columns = NULL)}}{Set options by context types for the current data sheet.}
#'   \item{\code{has_labels(col_names)}}{Checks if the specified columns have labels.}
#'   \item{\code{display_daily_table(data_name, climatic_element, date_col = date_col, year_col = year_col, station_col = station_col, Misscode, Tracecode, Zerocode, monstats = c("min", "mean", "median", "max", "IQR", "sum"))}}{Display a daily summary table for a specified climatic data element.}
#'  
#'   \item{\code{add_comment(new_comment)}}{Adds a new `instat_comment` object to the data sheet if the key is defined and valid.}
#'   \item{\code{delete_comment(comment_id)}}{Deletes a comment from the data sheet based on the comment ID.}
#'   \item{\code{get_comment_ids()}}{Retrieves all comment IDs currently stored in the data sheet.}
#'   \item{\code{get_comments_as_data_frame()}}{Converts all comments in the data sheet to a data frame format for easier inspection and analysis.}
#'
#'   \item{\code{save_calculation(calc)}}{Save a Calculation to the DataSheet.}
#'   
#'   \item{\code{merge_data(new_data, by = NULL, type = "left", match = "all")}}{Merge New Data with Existing Data}
#'   \item{\code{calculate_summary(calc, ...)}}{Calculate Summaries for Specified Columns}
#'   \item{\code{get_column_climatic_type(col_name, attr_name)}}{Retrieve the climatic type attribute for a specific column.}
#'   \item{\code{update_selection(new_values, column_selection_name = NULL)}}{Update Column Selection.}
#'   \item{\code{anova_tables2(x_col_names, y_col_name, total = FALSE, signif.stars = FALSE, sign_level = FALSE, means = FALSE, interaction = FALSE)}}{Generate an ANOVA table for specified predictor and response variables. Optionally includes totals, significance levels, and means.}
#'   
#'   \item{\code{set_tricot_types(types)}}{Sets the tricot types for columns in the data.}
#'   \item{\code{get_tricot_column_name(col_name)}}{Gets the tricot column name from the data.}
#'   \item{\code{is_tricot_data()}}{Checks if the data is defined as tricot.}
#'   \item{\code{get_column_tricot_type(col_name, attr_name)}}{Retrieve the tricot type attribute for a specific column.}
#'   
#' }
#'
#' @section Active bindings:
#' \describe{
#'   \item{\code{data_changed}}{Logical, indicates if the data has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{metadata_changed}}{Logical, indicates if the metadata has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{variables_metadata_changed}}{Logical, indicates if the variables metadata has changed. If setting a value, \code{new_value} must be \code{TRUE} or \code{FALSE}.}
#'   \item{\code{current_filter}}{A list representing the current filter. If setting a value, \code{filter} must be a list.}
#'   \item{\code{current_column_selection}}{A list representing the current column selection. If setting a value, \code{column_selection} must be a list.}
#' }
#'
#' @export
DataSheet <- R6::R6Class(
  "DataSheet",
  public = list(
    #' @description
    #' Create a new DataSheet object.
    #' 
    #' @param data A data frame to be managed by the DataSheet object. Default is an empty data frame.
    #' @param data_name A character string for the name of the data set. Default is an empty string.
    #' @param variables_metadata A data frame containing metadata for the variables. Default is an empty data frame.
    #' @param metadata A list containing additional metadata. Default is an empty list.
    #' @param imported_from A character string indicating the source of the data import. Default is an empty string.
    #' @param messages Logical, if TRUE messages will be shown during the setup. Default is TRUE.
    #' @param convert Logical, if TRUE data will be converted. Default is TRUE.
    #' @param create Logical, if TRUE the data will be created. Default is TRUE.
    #' @param start_point Numeric, the starting point for default naming. Default is 1.
    #' @param filters A list of filters to be applied to the data. Default is an empty list.
    #' @param column_selections A list of column selections. Default is an empty list.
    #' @param objects A list of objects associated with the data. Default is an empty list.
    #' @param calculations A list of calculations to be performed on the data. Default is an empty list.
    #' @param keys A list of keys for the data. Default is an empty list.
    #' @param scalars A list of scalars on the data. Default is an empty list.
    #' @param comments A list of comments associated with the data. Default is an empty list.
    #' @param keep_attributes Logical, if TRUE attributes will be kept. Default is TRUE.
    #' @param undo_history A list containing a history of data frames which will be replaced with the current data frame if the user presses undo.
    #' @param redo_undo_history A list containing the undo history to redo.
    #' @param disable_undo Logical, if TRUE undo option is disabled. Default is FALSE.
    #' @return A new `DataSheet` object.
    initialize = function(data = data.frame(), data_name = "", 
                          variables_metadata = data.frame(), metadata = list(), 
                          imported_from = "", 
                          messages = TRUE, convert = TRUE, create = TRUE, 
                          start_point = 1, filters = list(), column_selections = list(), objects = list(),
                          calculations = list(), scalars = list(), keys = list(), comments = list(), keep_attributes = TRUE,
                          undo_history = list(), redo_undo_history = list(), disable_undo = FALSE) {
      # Set up the data object
      self$set_data(data, messages)
      self$set_changes(list())
      #removed until this can be fixed.
      #self$set_variables_metadata(variables_metadata)
      
      # Set first so that "no_filter" is added
      self$set_filters(filters)
      self$set_column_selections(column_selections)
      if (keep_attributes) {
        self$set_meta(c(attributes(private$data), metadata))
      } else {
        self$set_meta(metadata)
        self$clear_variables_metadata()
      }
      self$add_defaults_meta()
      self$add_defaults_variables_metadata(self$get_column_names())
      #self$update_variables_metadata()
      self$set_objects(objects)
      self$set_calculations(calculations)
      self$set_scalars(scalars)
      self$set_keys(keys)
      self$set_comments(comments)
      
      # If no name for the data.frame has been given in the list we create a default one.
      # Decide how to choose default name index
      if (!(is.null(data_name) || data_name == "" || missing(data_name))) {
        if (data_name != make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))) {
          message("data_name is invalid. It will be made valid automatically.")
          data_name <- make.names(iconv(data_name, to = "ASCII//TRANSLIT", sub = "."))
        }
        self$append_to_metadata(data_name_label, data_name)
      } else if (!self$is_metadata(data_name_label)) {
        if ((is.null(data_name) || data_name == "" || missing(data_name))) {
          self$append_to_metadata(data_name_label, paste0("data_set_", sprintf("%03d", start_point)))
          if (messages) {
            message(paste0("No name specified in data_tables list for data frame ", start_point, ". 
                       Data frame will have default name: ", "data_set_", sprintf("%03d", start_point)))
          }
        } else {
          self$append_to_metadata(data_name_label, data_name)     
        }
      }
    },
    #' @description 
    #' Sets the data for the DataSheet object. Accepts various data types and converts them to a data frame.
    #' 
    #' @param new_data The new data to be set. It can be a matrix, tibble, data.table, ts object, array, or vector.
    #' @param messages Logical, if TRUE, messages will be shown during the data setup. Default is TRUE.
    #' @param check_names Logical, if TRUE, column names will be checked and made valid if necessary. Default is TRUE.
    #' 
    #' @return The DataSheet object with the updated data.
    set_data = function(new_data, messages = TRUE, check_names = TRUE) {
      if (is.matrix(new_data)) new_data <- as.data.frame(new_data)
      # This case could happen when removing rows
      # as.data.frame preserves column and data frame attributes so no issue with this
      else if (tibble::is_tibble(new_data) || data.table::is.data.table(new_data)) new_data <- as.data.frame(new_data)
      # TODO convert ts objects correctly
      else if (is.ts(new_data)) {
        ind <- zoo::index(new_data)
        new_data <- data.frame(index = ind, value = new_data)
      }
      else if (is.array(new_data)) {
        new_data <- as.data.frame(new_data)
      }
      else if (is.vector(new_data) && !is.list(new_data)) {
        new_data <- as.data.frame(new_data)
      }
      
      if (!is.data.frame(new_data)) {
        stop("Data set must be of type: data.frame")
      }
      else {
        if (length(new_data) == 0 && messages) {
          message("data is empty. Data will be an empty data frame.")
        }
        if (check_names) {
          # "T" should be avoided as a column name but is not checked by make.names()
          if ("T" %in% names(new_data)) names(new_data)[names(new_data) == "T"] <- ".T"
          valid_names <- make.names(iconv(names(new_data), to = "ASCII//TRANSLIT", sub = "."), unique = TRUE)
          if (!all(names(new_data) == valid_names)) {
            warning("Not all column names are syntactically valid or unique. make.names() and iconv() will be used to force them to be valid and unique.")
            names(new_data) <- valid_names
          }
        }
        private$data <- new_data
        self$append_to_changes(list(Set_property, "data"))
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      }
    },
    
    #' @description 
    #' Sets the metadata for the DataSheet object.
    #' @param new_meta A list containing the new metadata.
    set_meta = function(new_meta) {
      meta_data_copy <- new_meta
      self$clear_metadata()
      if (!is.list(meta_data_copy)) stop("new_meta must be of type: list")
      for (name in names(meta_data_copy)) {
        self$append_to_metadata(name, meta_data_copy[[name]])
      }
      self$metadata_changed <- TRUE
      self$append_to_changes(list(Set_property, "meta data"))
    },
    
    #' @description 
    #' Clears the metadata for the DataSheet object.
    clear_metadata = function() {
      for (name in names(attributes(private$data))) {
        if (!name %in% c(data_type_label, data_name_label, "row.names", "names")) attr(private$data, name) <- NULL
      }
      self$add_defaults_meta()
      self$metadata_changed <- TRUE
      self$append_to_changes(list(Set_property, "meta data"))
    },
    
    #' @description 
    #' Sets the changes for the DataSheet object.
    #' @param new_changes A list containing the new changes.
    set_changes = function(new_changes) {
      if (!is.list(new_changes)) stop("Changes must be of type: list")
      private$changes <- new_changes
      self$append_to_changes(list(Set_property, "changes"))  
    },
    
    #' @description 
    #' Sets the filters for the DataSheet object.
    #' @param new_filters A list containing the new filters.
    set_filters = function(new_filters) {
      if (!is.list(new_filters)) stop("Filters must be of type: list")
      self$append_to_changes(list(Set_property, "filters"))  
      private$filters <- new_filters
      if (!"no_filter" %in% names(private$filters)) {
        self$add_filter(filter = list(), filter_name = "no_filter", replace = TRUE, set_as_current = TRUE, na.rm = FALSE, is_no_filter = TRUE)
      }
    },
    #' @description 
    #' Sets the column selections for the DataSheet object.
    #' @param new_column_selections A list containing the new column selections.
    set_column_selections = function(new_column_selections) {
      stopifnot(is.list(new_column_selections))
      self$append_to_changes(list(Set_property, "column selections"))  
      private$column_selections <- new_column_selections
      if (!".everything" %in% names(private$column_selections)) {
        self$add_column_selection(column_selection = list(), name = ".everything", replace = TRUE, set_as_current = TRUE, is_everything = TRUE)
      }
    },
    #' @description 
    #' Sets the objects for the DataSheet object.
    #' @param new_objects A list containing the new objects.
    set_objects = function(new_objects) {
      if (!is.list(new_objects)) stop("new_objects must be of type: list")
      self$append_to_changes(list(Set_property, "objects"))  
      private$objects <- new_objects
    },
    
    #' @description 
    #' Sets the calculations for the DataSheet object.
    #' @param new_calculations A list containing the new calculations.
    set_calculations = function(new_calculations) {
      if (!is.list(new_calculations)) stop("new_calculations must be of type: list")
      self$append_to_changes(list(Set_property, "calculations"))  
      private$calculations <- new_calculations
    },
    
    #' @description 
    #' Sets the keys for the DataSheet object.
    #' @param new_keys A list containing the new keys.
    set_keys = function(new_keys) {
      if (!is.list(new_keys)) stop("new_keys must be of type: list")
      self$append_to_changes(list(Set_property, "keys"))  
      private$keys <- new_keys
    },
    
    #' @description 
    #' Sets the comments for the DataSheet object.
    #' @param new_comments A list containing the new comments.
    set_comments = function(new_comments) {
      if (!is.list(new_comments)) stop("new_comments must be of type: list")
      self$append_to_changes(list(Set_property, "comments"))  
      private$comments <- new_comments
    },
    
    #' @description 
    #' Set the data_changed flag.
    #' @param new_val Logical, new value for the data_changed flag.
    set_data_changed = function(new_val) {
      self$data_changed <- new_val
    },
    
    #' @description 
    #' Set the variables_metadata_changed flag.
    #' @param new_val Logical, new value for the variables_metadata_changed flag.
    set_variables_metadata_changed = function(new_val) {
      self$variables_metadata_changed <- new_val
    },
    
    
    #' @description 
    #' Set the metadata_changed flag.
    #' @param new_val Logical, new value for the metadata_changed flag.
    set_metadata_changed = function(new_val) {
      self$metadata_changed <- new_val
    },
    
    #' @description 
    #' Set whether undo functionality is enabled or disabled.
    #' @param disable_undo Logical, whether to disable the undo functionality.
    set_enable_disable_undo = function(disable_undo) {
      private$disable_undo <- disable_undo
      if (disable_undo) {
        private$undo_history <- list()
        gc()
      }
    },
    
    #' @description 
    #' Save the current state to the undo history.
    save_state_to_undo_history = function() {
      self$set_undo_history(private$data, attributes(private$data))
    },
    
    #' @description 
    #' Check if undo functionality is currently disabled.
    #' @return Logical, TRUE if undo functionality is disabled, otherwise FALSE.
    is_undo = function() {
      return(private$disable_undo)
    },
    
    #' @description 
    #' Check if there are any actions available to undo.
    #' @return Logical, TRUE if undo history is available, otherwise FALSE.
    has_undo_history = function() {
      return(length(private$undo_history) > 0)
    },
    
    #' @description 
    #' Undo the last action by restoring the previous state.
    #' Removes the last saved state from the undo history.
    undo_last_action = function() {
      
      # Check if there's any action to undo
      if (length(private$undo_history) > 0) {
        # Get the last state from the undo history
        previous_state <- private$undo_history[[length(private$undo_history)]]
        
        # Restore the data and its attributes
        restored_data <- previous_state$data  # Extract the dataframe
        restored_attributes <- previous_state$attributes  # Extract the attributes
        
        # Set the dataframe in the DataSheet
        self$set_data(as.data.frame(restored_data))
        
        # Restore attributes
        restored_attributes <- previous_state$attributes  # Extract the attributes
        for (property in names(restored_attributes)) {
          self$append_to_metadata(property, restored_attributes[[property]])
        }  
        # Remove the latest state from the undo history
        private$undo_history <- private$undo_history[-length(private$undo_history)]
        
        # Trigger garbage collection to free memory
        gc()
      } else {
        message("No more actions to undo.")
      }
    },
    
    #' @description 
    #' Redo the last undone action by restoring the next state.
    #' Moves the restored state back to the undo history.
    redo_last_action = function() {
      if (length(private$redo_undo_history) > 0) {
        # Get the last undone state from redo undo_history
        next_state <- private$redo_undo_history[[length(private$redo_undo_history)]]
        
        # Restore the next state
        self$set_data(as.data.frame(next_state))
        
        # Move the state back to the undo_history
        private$undo_history <- append(private$undo_history, list(next_state))
        
        # Remove the state from redo undo_history
        private$redo_undo_history <- private$redo_undo_history[-length(private$redo_undo_history)]
      } else {
        message("No more actions to redo.")
      }
    },
    
    
    #' @description 
    #' Set the scalars property.
    #' @param new_scalars List, the new scalars to set.
    set_scalars = function(new_scalars) {
      if (!is.list(new_scalars)) stop("scalars must be of type: list")
      self$append_to_changes(list(Set_property, "scalars"))  
      private$scalars <- new_scalars
    },
    
    #' @description 
    #' Set the undo history with memory management.
    #' Ensures undo history size and memory usage are within defined limits.
    #' @param new_data Data frame, the new data to store in undo history.
    #' @param attributes List, attributes associated with the data.
    set_undo_history = function(new_data, attributes = list()) {
      if (!is.data.frame(new_data)) stop("new_data must be of type: data.frame")
      
      if (!private$disable_undo) {
        # Define memory and undo history limits
        MAX_undo_history_SIZE <- 10  # Limit to last 10 undo history states
        MAX_MEMORY_LIMIT_MB <- 1024   # Limit the memory usage for undo history
        
        # Check current memory usage
        current_memory <- instatExtras::monitor_memory()
        
        # If memory exceeds limit, remove the oldest entry
        if (current_memory > MAX_MEMORY_LIMIT_MB) {
          message(paste("Memory limit exceeded:", round(current_memory, 2), "MB. Removing oldest entry."))
          private$undo_history <- private$undo_history[-1]  # Remove the oldest entry
          gc()  # Trigger garbage collection to free memory
        }
        
        # Limit undo history size
        if (length(private$undo_history) >= MAX_undo_history_SIZE) {
          private$undo_history <- private$undo_history[-1]  # Remove the oldest entry
          gc()  # Trigger garbage collection to free memory
        }
        
        # Package the new data and attributes into a list
        new_undo_entry <- list(data = new_data, attributes = attributes)
        
        # Append the new entry to the undo history
        private$undo_history <- append(private$undo_history, list(new_undo_entry))
      }
    },
    
    #' @description 
    #' Retrieve the current scalars.
    #' @return List, the scalars currently stored.
    get_scalars = function() {
      out <- private$scalars[self$get_scalar_names()]
      return(out)
    },
    
    #' @description 
    #' Get the names of the scalars.
    #' @param as_list Logical, whether to return the names as a list. Defaults to FALSE.
    #' @param excluded_items Character vector, items to exclude from the result. Defaults to an empty vector.
    #' @param ... Additional arguments for customization.
    #' @return Character vector or list, the names of the scalars.
    get_scalar_names = function(as_list = FALSE, excluded_items = c(), ...) {
      out <- get_data_book_scalar_names(scalar_list = private$scalars, 
                                        as_list = as_list, 
                                        list_label = self$get_metadata(data_name_label))
      return(out)
    },
    
    #' @description 
    #' Retrieve the value of a specific scalar by name.
    #' @param scalar_name Character, the name of the scalar to retrieve.
    #' @return The value of the specified scalar.
    get_scalar_value = function(scalar_name) {
      if (missing(scalar_name)) stop("scalar_name must be specified.")
      return(private$scalars[[scalar_name]])
    },
    
    #' @description 
    #' Add a scalar to the scalars property.
    #' Replaces an existing scalar if one with the same name already exists.
    #' @param scalar_name Character, the name of the scalar. Defaults to the next available name.
    #' @param scalar_value The value of the scalar.
    add_scalar = function(scalar_name = "", scalar_value) {
      if (missing(scalar_name)) scalar_name <- instatExtras::next_default_item("scalar", names(private$scalars))
      if (scalar_name %in% names(private$scalars)) warning("A scalar called", scalar_name, "already exists. It will be replaced.")
      private$scalars[[scalar_name]] <- scalar_value
      self$append_to_metadata(scalar, private$scalars)
      self$append_to_changes(list(Added_scalar, scalar_name))
      cat(paste("Scalar name: ", scalar_name),
          paste("Value: ", private$scalars[[scalar_name]]),
          sep = "\n")
    },
    
    #' @description 
    #' Get the data frame with various options for filtering, column selection, and attribute handling.
    #' @param convert_to_character Logical, if TRUE converts the data to character format.
    #' @param include_hidden_columns Logical, if TRUE includes hidden columns in the output.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @param filter_name Character, specifies the name of the filter to use.
    #' @param column_selection_name Character, specifies the name of the column selection to use.
    #' @param stack_data Logical, if TRUE stacks the data.
    #' @param remove_attr Logical, if TRUE removes certain attributes from the data.
    #' @param retain_attr Logical, if TRUE retains certain attributes in the data.
    #' @param max_cols Numeric, specifies the maximum number of columns to include in the output.
    #' @param max_rows Numeric, specifies the maximum number of rows to include in the output.
    #' @param drop_unused_filter_levels Logical, if TRUE drops unused levels from factors in the filtered data.
    #' @param start_row Numeric, specifies the starting row for the output.
    #' @param start_col Numeric, specifies the starting column for the output.
    #' @param ... Additional arguments passed to internal functions.
    #' @return A data frame with the specified options applied.
    get_data_frame = function(convert_to_character = FALSE, include_hidden_columns = TRUE, use_current_filter = TRUE, use_column_selection = TRUE, filter_name = "", column_selection_name = "", stack_data = FALSE, remove_attr = FALSE, retain_attr = FALSE, max_cols, max_rows, drop_unused_filter_levels = FALSE, start_row, start_col, ...) {
      if(!stack_data) {
        if(!include_hidden_columns && self$is_variables_metadata(is_hidden_label)) {
          hidden <- self$get_variables_metadata(property = is_hidden_label)
          hidden[is.na(hidden)] <- FALSE
          out <- private$data[!hidden]
        } else {
          out <- private$data
        }
        nam <- names(out)
        if(use_current_filter && self$filter_applied()) {
          if(filter_name != "") {
            out <- out[self$current_filter & self$get_filter_as_logical(filter_name = filter_name), ]
          } else {
            out <- out[self$current_filter, ]
            if(drop_unused_filter_levels) out <- instatExtras::drop_unused_levels(out, self$get_current_filter_column_names())
          }
        } else {
          if(filter_name != "") {
            out <- out[self$get_filter_as_logical(filter_name = filter_name), ]
          }
        }
        if(column_selection_name != "") {
          selected_columns <- self$get_column_selection_column_names(column_selection_name)
          missing_columns <- selected_columns[!selected_columns %in% names(private$data)]
          if(!length(missing_columns) > 0) {
            out <- out[, selected_columns, drop = FALSE]
          }
        }
        if(use_column_selection && self$column_selection_applied()) {
          old_metadata <- attributes(private$data)
          selected_columns <- self$get_column_names()
          missing_columns <- selected_columns[!selected_columns %in% names(private$data)]
          if(!length(missing_columns) > 0) {
            out <- out[, selected_columns, drop = FALSE]
            for(name in names(old_metadata)) {
              if(!(name %in% c("names", "class", "row.names"))) {
                attr(out, name) <- old_metadata[[name]]
              }
            }
            all_columns <- self$get_column_names(use_current_column_selection = FALSE)
            hidden_cols <- all_columns[!(all_columns %in% selected_columns)]
            self$append_to_variables_metadata(hidden_cols, is_hidden_label, TRUE)
            private$.variables_metadata_changed <- TRUE
          }
        }
        if(!is.data.frame(out)) {
          out <- data.frame(out)
          if(length(nam) == length(out)) names(out) <- nam
        }
        if(remove_attr) {
          for(i in seq_along(out)) {
            attributes(out[[i]])[!names(attributes(out[[i]])) %in% c("class", "levels")] <- NULL
          }
        }
        if(retain_attr) {
          for(col_name in names(out)) {
            private_attr_names <- names(attributes(private$data[[col_name]]))
            for(attr_name in private_attr_names) {
              if(!attr_name %in% c("class", "names")) {
                private_attr <- attr(private$data[[col_name]], attr_name)
                if(!is.null(private_attr)) {
                  attr(out[[col_name]], attr_name) <- private_attr
                }
              }
            }
          }
        }
        if(!missing(start_col) && start_col <= ncol(out)) {
          if(!missing(max_cols)) {
            if(max_cols + start_col > ncol(out)) {
              out <- out[start_col:ncol(out)]
            } else {
              out <- out[start_col:(start_col + max_cols - 1)]
            }
          } else {
            out <- out[start_col:ncol(out)]
          }
        } else if(!missing(max_cols) && max_cols < ncol(out)) {
          out <- out[1:max_cols]
        }
        if(!missing(start_row) && start_row <= nrow(out)) {
          if(!missing(max_rows)) {
            if(max_rows + start_row > nrow(out)) {
              if(ncol(out) == 1) {
                rnames <- row.names(out)[start_row:nrow(out)]
                out <- as.data.frame(dplyr::slice(out, start_row:nrow(out)))
                row.names(out) <- rnames
              } else {
                out <- out[start_row:nrow(out), ]
              }
            } else {
              if(ncol(out) == 1) {
                rnames <- row.names(out)[start_row:(start_row + max_rows - 1)]
                out <- as.data.frame(dplyr::slice(out, start_row:(start_row + max_rows - 1)))
                row.names(out) <- rnames
              } else {
                out <- out[start_row:(start_row + max_rows - 1), ]
              }
            }
          } else {
            if(ncol(out) == 1) {
              rnames <- row.names(out)[start_row:nrow(out)]
              out <- as.data.frame(dplyr::slice(out, start_row:nrow(out)))
              row.names(out) <- rnames
            } else {
              out <- out[start_row:nrow(out), ]
            }
          }
        } else if(!missing(max_rows) && max_rows < nrow(out)) {
          if(ncol(out) == 1) {
            rnames <- row.names(out)[1:max_rows]
            out <- as.data.frame(dplyr::slice(out, 1:max_rows))
            row.names(out) <- rnames
          } else {
            out <- out[1:max_rows, ]  
          }
        }
        if(convert_to_character) {
          decimal_places <- self$get_variables_metadata(property = signif_figures_label, column = names(out), error_if_no_property = FALSE, use_column_selection = use_column_selection) 
          scientific_notation <- self$get_variables_metadata(property = scientific_label, column = names(out), error_if_no_property = FALSE)
          return(instatExtras::convert_to_character_matrix(data = out, format_decimal_places = TRUE, decimal_places = decimal_places, is_scientific = scientific_notation))
        } else {
          return(out)
        }
      } else {
        return(reshape2::melt(self$get_data_frame(include_hidden_columns = include_hidden_columns, use_current_filter = use_current_filter, filter_name = filter_name), ...))
      }
    },
    
    #' @description 
    #' Get the metadata for the variables in the data frame.
    #' @param data_type Character, the data type to filter by. Default is "all".
    #' @param convert_to_character Logical, if TRUE converts the metadata to character format.
    #' @param property Character, the property of the metadata to retrieve.
    #' @param column Character, the column to retrieve metadata for.
    #' @param error_if_no_property Logical, if TRUE throws an error if the property is not found.
    #' @param direct_from_attributes Logical, if TRUE retrieves metadata directly from attributes.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @return A data frame or list of metadata for the variables.
    get_variables_metadata = function(data_type = "all", convert_to_character = FALSE, property, column, error_if_no_property = TRUE, direct_from_attributes = FALSE, use_column_selection = TRUE) {
      if(direct_from_attributes) {
        if(missing(property)) return(attributes(private$data[[column]]))
        else return(attr(private$data[[column]], property))
      } else if(!missing(property) && length(property == 1) && property == data_type_label) {
        if(missing(column)) column <- names(private$data)
        out <- sapply(private$data[column], class)
        out <- sapply(out, function(x) paste(unlist(x), collapse = ","))
        return(as.vector(out))
      } else {
        out <- list()
        if(missing(column)) {
          curr_data <- private$data
          cols <- names(curr_data)
          if(self$column_selection_applied()) cols <- self$current_column_selection
        } else {
          cols <- column
          if(self$column_selection_applied()) cols <- self$current_column_selection
          curr_data <- private$data[column]
        }
        for(i in seq_along(cols)) {
          col <- curr_data[[cols[i]]]
          ind <- which(names(attributes(col)) == "levels")
          if(length(ind) > 0) col_attributes <- attributes(col)[-ind]
          else col_attributes <- attributes(col)
          if(is.null(col_attributes)) col_attributes <- list()
          col_attributes[[data_type_label]] <- class(col)
          for(j in seq_along(col_attributes)) {
            att_name <- names(col_attributes)[j]
            if(att_name == labels_label) {
              num_labels <- length(col_attributes[[att_name]])    
              max_labels <- min(max_labels_display, num_labels)    
              col_attributes[[att_name]] <- paste(names(col_attributes[[att_name]])[1:max_labels], "=", col_attributes[[att_name]][1:max_labels], collapse = ", ")    
              if(num_labels > max_labels) col_attributes[[att_name]] <- paste0(col_attributes[[att_name]], "...")    
            } else if(is.list(col_attributes[[att_name]]) || length(col_attributes[[att_name]]) > 1) {
              col_attributes[[att_name]] <- paste(unlist(col_attributes[[att_name]]), collapse = ",")
            }
          }
          col_attributes <- data.frame(col_attributes, stringsAsFactors = FALSE)
          out[[i]] <- col_attributes
        }
        out <- plyr::rbind.fill(out)
        out <- as.data.frame(out)
        if(all(c(name_label, label_label) %in% names(out))) {
          out <- out[c(c(name_label, label_label), sort(setdiff(names(out), c(name_label, label_label))))]
        } else if(name_label %in% names(out)) {
          out <- out[c(name_label, sort(setdiff(names(out), name_label)))]
        }
        row.names(out) <- cols
        if(data_type != "all") {
          if(data_type == "numeric") {
            out <- out[out[[data_type_label]] %in% c("numeric", "integer"), ]
          } else {
            out <- out[out[[data_type_label]] == data_type, ]        
          }
        }
        not_found <- FALSE
        if(!missing(property)) {
          if(!property %in% names(out)) {
            if(error_if_no_property) stop(property, " not found in variables metadata")
            not_found <- TRUE
          }
          if(!missing(column)) {
            if(!all(column %in% names(private$data))) stop(column, " not found in data")
            if(not_found) out <- rep(NA, length(column))
            else out <- out[column, property]
          } else {
            if(not_found) out <- rep(NA, ncol(private$data))
            else out <- out[, property]
          }
        }
        if(is.data.frame(out)) row.names(out) <- NULL
        if(convert_to_character && missing(property)) return(instatExtras::convert_to_character_matrix(out, FALSE))
        else return(out)
      }
    },
    
    #' @description 
    #' Get the data types of the specified columns.
    #' @param columns Character vector, names of the columns to get data types for.
    #' @return A character vector of data types for the specified columns.
    get_column_data_types = function(columns) {
      if(missing(columns)) return(as.vector(sapply(private$data, function(x) paste(class(x), collapse = ","))))
      else return(as.vector(sapply(private$data[columns], function(x) paste(class(x), collapse = ","), USE.NAMES = FALSE)))
    },
    
    #' @description 
    #' Get the labels of the specified columns.
    #' @param columns Character vector, names of the columns to get labels for.
    #' @return A character vector of labels for the specified columns.
    get_column_labels = function(columns) {
      if(missing(columns)) return(as.vector(sapply(private$data, function(x) paste(attr(x, "label"), collapse = ","))))
      else return(as.vector(sapply(private$data[columns], function(x) paste(attr(x, "label"), collapse = ","), USE.NAMES = FALSE)))
    },
    
    #' @description 
    #' Get the label of the data frame.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @return A character string representing the label of the data frame.
    get_data_frame_label = function(use_current_filter = FALSE) {
      return(attr(self$get_data_frame(use_current_filter = use_current_filter), "label"))
    },
    
    #' @description 
    #' Clear the variables metadata.
    clear_variables_metadata = function() {
      for(column in self$get_data_frame(use_current_filter = FALSE)) {
        for(name in names(attributes(column))) {
          if(!name %in% c(data_type_label, data_name_label)) attr(self, name) <- NULL
        }
      }
      self$add_defaults_variables_metadata(self$get_column_names())
    },
    
    #' @description 
    #' Get the metadata for the data frame.
    #' @param label Character, specifies the metadata label to retrieve.
    #' @param include_calculated Logical, if TRUE includes calculated metadata.
    #' @param excluded_not_for_display Logical, if TRUE excludes metadata not for display.
    #' @return A list of metadata for the data frame.
    get_metadata = function(label, include_calculated = TRUE, excluded_not_for_display = TRUE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      n_row <- self$get_data_frame_length(use_current_filter = TRUE)
      if(missing(label)) {
        if(include_calculated) {
          attr(curr_data, row_count_label) <- n_row
          attr(curr_data, column_count_label) <- ncol(curr_data)
        }
        if(excluded_not_for_display) {
          ind <- which(names(attributes(curr_data)) %in% c("names", "row.names"))
          if(length(ind) > 0) out <- attributes(curr_data)[-ind]
        } else {
          out <- attributes(curr_data)
        }
        return(out)
      } else {
        if(label %in% names(attributes(curr_data))) return(attributes(curr_data)[[label]])
        else if(label == row_count_label) return(n_row)
        else if(label == column_count_label) return(ncol(curr_data))
        else return("")
      }
    },
    
    #' @description 
    #' Get the changes made to the data frame.
    #' @return A list of changes made to the data frame.
    get_changes = function() {
      return(private$changes)
    },
    
    #' @description 
    #' Get the calculations applied to the data frame.
    #' @return A list of calculations applied to the data frame.
    get_calculations = function() {
      return(private$calculations)
    },
    
    #' @description 
    #' Get the names of the calculations applied to the data frame.
    #' @param as_list Logical, if TRUE returns the names as a list.
    #' @param excluded_items Character vector, names of calculations to exclude.
    #' @return A character vector or list of calculation names.
    get_calculation_names = function(as_list = FALSE, excluded_items = c()) {
      out = names(private$calculations)
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of calculations")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(!as_list) {
        return(out)
      }
      lst = list()
      lst[[self$get_metadata(data_name_label)]] <- out
      return(lst)
    },
    
    #' @description 
    #' Add new columns to the data frame.
    #' @param col_name Character, name of the new column.
    #' @param col_data Data, the data for the new column.
    #' @param use_col_name_as_prefix Logical, if TRUE uses the column name as a prefix.
    #' @param hidden Logical, if TRUE the new column will be hidden.
    #' @param before Logical, if TRUE adds the new column before the specified adjacent column.
    #' @param adjacent_column Character, name of the adjacent column.
    #' @param num_cols Numeric, number of columns to add.
    #' @param require_correct_length Logical, if TRUE requires the new column to have the correct length.
    #' @param keep_existing_position Logical, if TRUE keeps the existing position of the new column.
    #' @return The updated data frame with the new columns added.
    add_columns_to_data = function(col_name = "", col_data, use_col_name_as_prefix = FALSE, hidden = FALSE, before, adjacent_column = "", num_cols, require_correct_length = TRUE, keep_existing_position = TRUE) {
      # Save the current state to undo_history before making modifications
      self$save_state_to_undo_history()
      
      # Column name must be character
      if(!is.character(col_name)) stop("Column name must be of type: character")
      if(missing(num_cols)) {
        if(missing(col_data)) stop("One of num_cols or col_data must be specified.")
        if(!missing(col_data) && (is.matrix(col_data) || is.data.frame(col_data))) {
          num_cols = ncol(col_data)
        }
        else num_cols = 1
        if(tibble::is_tibble(col_data)) col_data <- data.frame(col_data)
      }
      else {
        if(missing(col_data)) col_data = replicate(num_cols, rep(NA, self$get_data_frame_length()))
        else {
          if(length(col_data) != 1) stop("col_data must be a vector/matrix/data.frame of correct length or a single value to be repeated.")
          col_data = replicate(num_cols, rep(col_data, self$get_data_frame_length()))
        }
      }
      if( col_name != "" && (length(col_name) != 1) && (length(col_name) != num_cols) ) stop("col_name must be a character or character vector with the same length as the number of new columns")
      if(col_name == "") {
        if(!is.null(colnames(col_data)) && length(colnames(col_data)) == num_cols) {
          col_name = colnames(col_data)
        }
        else {
          col_name = "X"
          use_col_name_as_prefix = TRUE
        }
      }
      
      if(length(col_name) != num_cols && (num_cols == 1 || length(col_name) == 1)) {
        use_col_name_as_prefix = TRUE
      } else use_col_name_as_prefix = FALSE
      
      replaced <- FALSE
      previous_length = self$get_column_count()
      if(adjacent_column != "" && !adjacent_column %in% self$get_column_names()) stop(adjacent_column, "not found in the data")
      
      new_col_names <- c()
      for(i in 1:num_cols) {
        if(num_cols == 1) {
          curr_col = col_data
        }
        else curr_col = col_data[,i]
        if(is.matrix(curr_col) || is.data.frame(curr_col)) curr_col = curr_col[,1]
        if(self$get_data_frame_length() %% length(curr_col) != 0) {
          if(require_correct_length) stop("Length of new column must be divisible by the length of the data frame")
          else curr_col <- rep(curr_col, length.out = self$get_data_frame_length())
        }
        print(use_col_name_as_prefix)
        if(use_col_name_as_prefix) curr_col_name = self$get_next_default_column_name(col_name)
        else curr_col_name = col_name[i]
        
        curr_col_name <- make.names(iconv(curr_col_name, to = "ASCII//TRANSLIT", sub = "."))
        new_col_names <- c(new_col_names, curr_col_name)
        if(curr_col_name %in% self$get_column_names()) {
          message(paste("A column named", curr_col_name, "already exists. The column will be replaced in the data"))
          self$append_to_changes(list(Replaced_col, curr_col_name))
          replaced <- TRUE
        }
        else self$append_to_changes(list(Added_col, curr_col_name))
        private$data[[curr_col_name]] <- curr_col
        self$data_changed <- TRUE
      }
      self$add_defaults_variables_metadata(new_col_names)
      
      # If replacing existing columns and not repositioning them, or before and adjacent_column column positioning parameters are missing
      # then do not reposition.
      if((replaced && keep_existing_position) || (missing(before) && adjacent_column == "")) return()
      
      # Get the adjacent position to be used in appending the new column names
      if(before) {
        if(adjacent_column == "") adjacent_position <- 0
        else adjacent_position <- which(self$get_column_names(use_current_column_selection =FALSE) == adjacent_column) - 1
      } else {
        if(adjacent_column == "") adjacent_position <- self$get_column_count()
        else adjacent_position <- which(self$get_column_names(use_current_column_selection =FALSE) == adjacent_column)
      }
      # Replace existing names with empty placeholders. Maintains the indices
      temp_all_col_names <- replace(self$get_column_names(use_current_column_selection = FALSE), self$get_column_names(use_current_column_selection = FALSE) %in% new_col_names, "")
      # Append the newly added column names after the set position
      new_col_names_order <- append(temp_all_col_names, new_col_names, adjacent_position)
      # Remove all empty characters placeholders to get final reordered column names
      new_col_names_order <- new_col_names_order[! new_col_names_order == ""]
      # Only do reordering if the column names order differ
      if(!all(self$get_column_names(use_current_column_selection = FALSE) == new_col_names_order)) self$reorder_columns_in_data(col_order=new_col_names_order)
    },
    
    #' @description 
    #' Get the data for the specified columns.
    #' @param col_names Character vector, names of the columns to retrieve.
    #' @param force_as_data_frame Logical, if TRUE forces the output to be a data frame.
    #' @param use_current_filter Logical, if TRUE uses the current filter applied to the data.
    #' @param use_column_selection Logical, if TRUE uses the current column selection.
    #' @param remove_labels Logical, if TRUE removes labels from the data.
    #' @param drop_unused_filter_levels Logical, if TRUE drops unused levels from factors in the filtered data.
    #' @return A data frame or vector of the specified columns.
    get_columns_from_data = function(col_names, force_as_data_frame = FALSE, use_current_filter = TRUE, use_column_selection = TRUE, remove_labels = FALSE, drop_unused_filter_levels = FALSE) {
      if(missing(col_names)) stop("no col_names to return")
      if(!all(col_names %in% names(private$data))) stop("Not all column names were found in data")
      if(length(col_names) == 1) {
        if(force_as_data_frame) {
          dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[col_names]
          if(remove_labels) {
            for(i in seq_along(dat)) {
              if(!is.numeric(dat[[i]])) attr(dat[[i]], "labels") <- NULL
            }
          }
          return(dat)
        } else {
          dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[[col_names]]
          if(remove_labels && !is.numeric(dat)) attr(dat, "labels") <- NULL
          return(dat)
        }
      } else {
        dat <- self$get_data_frame(use_current_filter = use_current_filter, use_column_selection = use_column_selection, drop_unused_filter_levels = drop_unused_filter_levels)[col_names]
        if(remove_labels) {
          for(i in seq_along(dat)) {
            if(!is.numeric(dat[[i]])) attr(dat[[i]], "labels") <- NULL
          }
        }
        return(dat)
      }
    },
    
    #' @description 
    #' Generate ANOVA tables for the specified columns.
    #' @param x_col_names Character vector, names of the columns to use as independent variables.
    #' @param y_col_name Character, name of the dependent variable column.
    #' @param signif.stars Logical, if TRUE includes significance stars in the output.
    #' @param sign_level Logical, if TRUE includes significance levels in the output.
    #' @param means Logical, if TRUE includes means in the output.
    anova_tables = function(x_col_names, y_col_name, signif.stars = FALSE, sign_level = FALSE, means = FALSE) {
      if(missing(x_col_names) || missing(y_col_name)) stop("Both x_col_names and y_col_names are required")
      if(sign_level || signif.stars) message("This is no longer descriptive")
      if(sign_level) end_col = 5 else end_col = 4
      for(i in seq_along(x_col_names)) {
        mod <- lm(formula = as.formula(paste0("as.numeric(", as.name(y_col_name), ") ~ ", as.name(x_col_names[i]))), data = self$get_data_frame())
        cat("ANOVA table: ", y_col_name, " ~ ", x_col_names[i], "\n", sep = "")
        print(anova(mod)[1:end_col], signif.stars = signif.stars)
        cat("\n")
        if(means) print(model.tables(aov(mod), type = "means"))
      }
    },
    
    #' @description 
    #' Calculate the correlation between specified columns.
    #' 
    #' @param x_col_names Character vector, names of the columns to use as independent variables.
    #' @param y_col_name Character, name of the dependent variable column.
    #' @param use Character, specifies the handling of missing values. Default is "everything".
    #' @param method Character vector, specifies the correlation method to be used. One of "pearson", "kendall", or "spearman". Default is c("pearson", "kendall", "spearman").
    #' 
    #' @return A matrix of correlation coefficients between the specified columns.
    #' 
    cor = function(x_col_names, y_col_name, use = "everything", method = c("pearson", "kendall", "spearman")) {
      x <- self$get_columns_from_data(x_col_names, force_as_data_frame = TRUE)
      y <- self$get_columns_from_data(y_col_name)
      x <- sapply(x, as.numeric)
      y <- as.numeric(y)
      results <- cor(x = x, y = y, use = use, method = method)
      dimnames(results)[[2]] <- y_col_name
      cat("Correlations:\n")
      return(t(results))
    },
    #' @description
    #' Rename a column in the data.
    #'
    #' @param curr_col_name Character, the current name of the column.
    #' @param new_col_name Character, the new name for the column.
    #' @param label Character, the label for the column.
    #' @param type Character, the type of renaming to perform.
    #' @param .fn Function, the function to use for renaming.
    #' @param .cols Character, the columns to rename.
    #' @param new_column_names_df Data frame, the new column names.
    #' @param new_labels_df Data frame, the new labels for the columns.
    #' @param ... Additional arguments passed to the function.
    rename_column_in_data = function(curr_col_name = "", new_col_name = "", label = "", type = "single", .fn, .cols = everything(), new_column_names_df, new_labels_df, ...) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE, use_column_selection = FALSE)
      
      # Save the current state to undo_history before making modifications
      self$save_state_to_undo_history()
      
      # Column name must be character
      if (type == "single") {
        if (new_col_name != curr_col_name) {
          if (new_col_name %in% names(curr_data)) {
            stop("Cannot rename this column. A column named: ", new_col_name, " already exists in the data.")
          }
          if (!is.character(curr_col_name)) {
            stop("Current column name must be of type: character")
          } else if (!(curr_col_name %in% names(curr_data))) {
            stop(paste0("Cannot rename column: ", curr_col_name, ". Column was not found in the data."))
          } else if (!is.character(new_col_name)) {
            stop("New column name must be of type: character")
          } else {
            if (sum(names(curr_data) == curr_col_name) > 1) {
              # Should never happen since column names must be unique
              warning("Multiple columns have name: '", curr_col_name, "'. All such columns will be renamed.")
            }
            # remove key
            get_key <- self$get_variables_metadata() %>% dplyr::filter(Name == curr_col_name)
            if (!is.null(get_key$Is_Key)){
              if (!is.na(get_key$Is_Key) && get_key$Is_Key){
                active_keys <- self$get_keys()
                keys_to_delete <- which(grepl(curr_col_name, active_keys))
                keys_to_delete <- purrr::map_chr(.x = keys_to_delete, .f = ~names(active_keys[.x]))
                purrr::map(.x = keys_to_delete, .f = ~self$remove_key(key_name = names(active_keys[.x])))
              }
            }
            # Need to use private$data here because changing names of data field
            names(private$data)[names(curr_data) == curr_col_name] <- new_col_name
            
            column_names <- self$get_column_names()
            
            if (anyNA(column_names)) {
              column_names[is.na(column_names)] <- new_col_name
            } else {
              column_names <- new_col_name
            }
            
            self$update_selection(column_names, private$.current_column_selection$name)
            if(any(c("sfc", "sfc_MULTIPOLYGON") %in% class(private$data[[curr_col_name]]))){
              # Update the geometry column reference
              sf::st_geometry(private$data) <- new_col_name
            } 
            names(private$data)[names(private$data) == curr_col_name] <- new_col_name
            
            self$append_to_variables_metadata(new_col_name, name_label, new_col_name)
            # TODO decide if we need to do these 2 lines
            self$append_to_changes(list(Renamed_col, curr_col_name, new_col_name))
            self$data_changed <- TRUE
            self$variables_metadata_changed <- TRUE
          }
        }
        if (label != "") {
          self$append_to_variables_metadata(col_name = new_col_name, property = "label", new_val = label)
          self$variables_metadata_changed <- TRUE
        }
      } else if (type == "multiple") {
        if (!missing(new_column_names_df)) {
          new_col_names <- new_column_names_df[, 1]
          cols_changed_index <- which(names(private$data) %in% new_column_names_df[, 2])
          curr_col_names <- names(private$data)
          curr_col_names[cols_changed_index] <- new_col_names
          if(any(duplicated(curr_col_names))) stop("Cannot rename columns. Column names must be unique.")
          names(private$data)[cols_changed_index] <- new_col_names
          
          column_names <- self$get_column_names()
          
          if (anyNA(column_names)) {
            column_names[is.na(column_names)] <- new_col_names
          } else {
            column_names <- new_col_names
          }
          
          self$update_selection(column_names, private$.current_column_selection$name)
          
          if(any(c("sfc", "sfc_MULTIPOLYGON") %in% class(private$dataprivate$data)[cols_changed_index])){
            # Update the geometry column reference
            sf::st_geometry(private$data) <- new_col_names
          } 
          names(private$data)[cols_changed_index] <- new_col_names
          
          for (i in seq_along(cols_changed_index)) {
            self$append_to_variables_metadata(new_col_names[i], name_label, new_col_names[i])
          }
        }
        if (!missing(new_labels_df)) {
          new_labels <- new_labels_df[, 1]
          new_labels_index <- new_labels_df[, 2]
          for (i in seq_along(new_labels)) {
            if (isTRUE(new_labels[i] != "")) {
              self$append_to_variables_metadata(col_name = names(private$data)[new_labels_index[i]], property = "label", new_val = new_labels[i])
            }
          }
        }
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      } else if (type == "rename_with") {
        if (missing(.fn)) stop(.fn, "is missing with no default.")
        curr_col_names <- names(curr_data)
        column_names <- self$get_column_names()
        private$data <- curr_data |>
          dplyr::rename_with(
            .fn = .fn,
            .cols = {{ .cols }}, ...
          )
        
        new_col_names <- names(private$data)
        if (!all(new_col_names %in% curr_col_names)) {
          new_col_names <- new_col_names[!(new_col_names %in% curr_col_names)]
          for (i in seq_along(new_col_names)) {
            self$append_to_variables_metadata(new_col_names[i], name_label, new_col_names[i])
          }
          
          column_names <- self$get_column_names()
          if (anyNA(column_names)) {
            column_names[is.na(column_names)] <- new_col_names
          } else {
            column_names <- new_col_names
          }
          
          self$update_selection(column_names, private$.current_column_selection$name)
          
          self$data_changed <- TRUE
          self$variables_metadata_changed <- TRUE
        }
      } else if (type == "rename_labels"){
        # to rename column labels. Here, instead of renaming a column name, we're giving new values in a column.
        curr_metadata <- self$get_variables_metadata()
        curr_col_names <- names(curr_data %>% dplyr::select(.cols))
        
        # create a new data frame containing the changes - but only apply to those that we actually plan to change for efficiency.
        new_metadata <- curr_metadata |>
          dplyr::filter(Name %in% curr_col_names) %>%
          dplyr::mutate(
            dplyr::across(
              label,
              ~ .fn(., ...)
            )
          )
        
        if(self$column_selection_applied()) self$remove_current_column_selection()
        # apply the changes
        new_label_names <- new_metadata[!("Name" %in% curr_col_names)]$label
        for (i in seq_along(new_label_names)) {
          self$append_to_variables_metadata(curr_col_names[i], property = "label", new_val = new_label_names[i])
        }
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      }
    },
    
    #' @description
    #' Remove specified columns from the data.
    #'
    #' @param cols Character vector, the names of the columns to remove.
    #' @param allow_delete_all Logical, if TRUE, allows deleting all columns.
    remove_columns_in_data = function(cols=c(), allow_delete_all = FALSE) {
      # Save the current state to undo_history before making modifications
      self$save_state_to_undo_history()
      
      if(length(cols) == self$get_column_count()) {
        if(allow_delete_all) {
          warning("You are deleting all columns in the data frame.")
        } else {
          stop("Cannot delete all columns through this function. Use delete_dataframe to delete the data.")
        }
      }
      for(col_name in cols) {
        # Column name must be character
        if(!is.character(col_name)) {
          stop("Column name must be of type: character")
        } else if (!(col_name %in% self$get_column_names())) {
          stop(paste0("Column :'", col_name, " was not found in the data."))
        } else {
          get_key <- self$get_variables_metadata() %>% dplyr::filter(Name == col_name)
          if (!is.null(get_key$Is_Key)){
            if (!is.na(get_key$Is_Key) && get_key$Is_Key){
              active_keys <- self$get_keys()
              keys_to_delete <- which(grepl(col_name, active_keys))
              keys_to_delete <- purrr::map_chr(.x = keys_to_delete, .f = ~names(active_keys[.x]))
              purrr::map(.x = keys_to_delete, .f = ~self$remove_key(key_name = names(active_keys[.x])))
            }
          }
          private$data[[col_name]] <- NULL
        }
        self$append_to_changes(list(Removed_col, cols))
        self$data_changed <- TRUE
        self$variables_metadata_changed <- TRUE
      }
    },
    
    #' @description
    #' Replace values in the specified columns and rows.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param rows Character vector, the names of the rows.
    #' @param old_value The old value to be replaced.
    #' @param old_is_missing Logical, if TRUE, treats old_value as missing.
    #' @param start_value Numeric, the starting value for the range to replace.
    #' @param end_value Numeric, the ending value for the range to replace.
    #' @param new_value The new value to replace with.
    #' @param new_is_missing Logical, if TRUE, treats new_value as missing.
    #' @param closed_start_value Logical, if TRUE, includes the start value in the range.
    #' @param closed_end_value Logical, if TRUE, includes the end value in the range.
    #' @param locf Logical, if TRUE, uses the last observation carried forward method.
    #' @param from_last Logical, if TRUE, uses the last observation from the end.
    replace_value_in_data = function(col_names, rows, old_value, old_is_missing = FALSE, start_value = NA, end_value = NA, new_value, new_is_missing = FALSE, closed_start_value = TRUE, closed_end_value = TRUE, locf = FALSE, from_last = FALSE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      self$save_state_to_undo_history()
      
      # Column name must be character
      if(!all(is.character(col_names))) stop("Column name must be of type: character")
      if (!all(col_names %in% names(curr_data))) stop("Cannot find all columns in the data.")
      if(!missing(rows) && !all(rows %in% row.names(curr_data))) stop("Not all rows found in the data.")
      if(!is.na(start_value) && !is.numeric(start_value)) stop("start_value must be numeric")
      if(!is.na(end_value) && !is.numeric(end_value)) stop("start_value must be numeric")
      if(old_is_missing) {
        if(!missing(old_value)) stop("Specify only one of old_value and old_is_missing")
        old_value <- NA
      }
      if(new_is_missing) {
        if(!missing(new_value)) stop("Specify only one of new_value and new_is_missing")
        new_value <- NA
      }
      data_row_names <- row.names(curr_data)
      filter_applied <- self$filter_applied()
      if(filter_applied) curr_filter <- self$current_filter
      for(col_name in col_names) {
        done = FALSE
        str_data_type <- self$get_variables_metadata(property = data_type_label, column = col_name)
        curr_column <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        if(locf){
          my_data <- zoo::na.locf(curr_column, fromLast = from_last, na.rm = FALSE)
        }
        else{
          if("factor" %in% str_data_type) {
            if(!missing(rows)) {
              if(!is.na(new_value) && !new_value %in% levels(self$get_columns_from_data(col_name, use_current_filter = FALSE))) {
                stop("new_value must be an existing level of the factor column.")
              }
              replace_rows <- (data_row_names %in% rows)
            }
            else {
              if(filter_applied) stop("Cannot replace values in a factor column when a filter is applied. Remove the filter to do this replacement.")
              if(is.na(old_value)) {
                if(!is.na(new_value) && !new_value %in% levels(self$get_columns_from_data(col_name, use_current_filter = FALSE))) stop(new_value, " is not a level of this factor. Add this as a level of the factor before using replace.")
                replace_rows <- (is.na(curr_column))
              }
              else {
                self$edit_factor_level(col_name = col_name, old_level = old_value, new_level = new_value)
                done = TRUE
              }
            }
          }
          else if(str_data_type == "integer" || str_data_type == "numeric") {
            if(!is.na(new_value)) {
              if(!is.numeric(new_value)) stop(col_name, " is a numeric/integer column. new_value must be of the same type")
              if(str_data_type == "integer" && !(new_value %% 1 == 0)) stop(col_name, " is an integer column. new_value must be an integer")
            }
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value) || !is.na(start_value) || !is.na(end_value)) warning("old_value, start_value and end_value will be ignored because rows has been specified.")
            }
            else {
              if(!is.na(start_value) || !is.na(end_value)) {
                if(!missing(old_value)) warning("old_value will be ignored because start_value or end_value has been specified.")
                if(closed_start_value) start_value_ineq = match.fun(">=")
                else start_value_ineq = match.fun(">")
                if(closed_end_value) end_value_ineq = match.fun("<=")
                else end_value_ineq = match.fun("<")
                
                if(!is.na(start_value) && is.na(end_value)) {
                  replace_rows <- start_value_ineq(curr_column, start_value)
                }
                else if(is.na(start_value) && !is.na(end_value)) {
                  replace_rows <- end_value_ineq(curr_column, end_value)
                }
                else if(!is.na(start_value) && !is.na(end_value)) {
                  replace_rows <- (start_value_ineq(curr_column,start_value) & end_value_ineq(curr_column, end_value))
                }
              }
              else {
                if(is.na(old_value)) replace_rows <- (is.na(curr_column))
                else replace_rows <- (curr_column == old_value)
              }
            }
          }
          else if(str_data_type == "character") {
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
            new_value <- as.character(new_value)
          }
          else if(str_data_type == "logical") {
            #Removed because new columns are logical and we need to be able to type in new values
            #if(!is.logical(new_value)) stop(col_name, " is a logical column. new_value must be a logical value")
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
          }
          #TODO add other data type cases
          else {
            if(!missing(rows)) {
              replace_rows <- (data_row_names %in% rows)
              if(!missing(old_value)) warning("old_value will be ignored because rows has been specified.")
            }
            else {
              if(is.na(old_value)) replace_rows <- (is.na(curr_column))
              else replace_rows <- (curr_column == old_value)
            }
          }
          
        }
        if(!done) {
          if(locf){
            private$data[[col_name]] <- my_data
          }
          else{
            replace_rows[is.na(replace_rows)] <- FALSE
            if(sum(replace_rows) > 0) {
              if(filter_applied) {
                replace_rows <- replace_rows & curr_filter
              }
              # Need private$data here as replacing values in data
              
              if(sum(replace_rows) > 0) private$data[[col_name]][replace_rows] <- new_value
              else message("No values to replace in ", col_name)
            }
            else message("No values to replace in ", col_name)
          }
          
        }
      }
      #TODO need to think what to add to changes
      self$append_to_changes(list(Replaced_value, col_names))
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Paste data from the clipboard into the specified columns and rows.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param start_row_pos Numeric, the starting row position.
    #' @param first_clip_row_is_header Logical, if TRUE, treats the first row of the clipboard data as a header.
    #' @param clip_board_text Character, the clipboard text data.
    paste_from_clipboard = function(col_names, start_row_pos = 1, first_clip_row_is_header = FALSE, clip_board_text) {
      #get the clipboard text contents as a data frame
      clip_tbl <- clipr::read_clip_tbl(x = clip_board_text, header = first_clip_row_is_header)
      
      #get the selected data frame
      current_tbl <- self$get_data_frame(use_current_filter = FALSE)
      
      #check if copied data rows are more than current data rows
      if( nrow(clip_tbl) > nrow(current_tbl) ){
        stop(paste("rows copied cannot be more than number of rows in the data frame.",
                   "Current data frame rows:", nrow(current_tbl), ". Copied rows:", nrow(clip_tbl)) )
      }
      
      
      #if column names are missing then just add the clip data as new columns and quit function
      if( missing(col_names) ){
        #append missing values if rows are less than the selected data frame. 
        #new column rows should be equal to existing column rows
        if( nrow(clip_tbl) < nrow(current_tbl) ){
          empty_values_df <- data.frame(data = matrix(data = NA, nrow = ( nrow(current_tbl) - nrow(clip_tbl) ), ncol = ncol(clip_tbl) ))
          names(empty_values_df) <- names(clip_tbl)
          clip_tbl <- rbind(clip_tbl, empty_values_df)
        }
        new_col_names <- colnames(clip_tbl)
        for(index in seq_along(new_col_names)){
          self$add_columns_to_data(col_name = new_col_names[index], col_data = clip_tbl[, index])
        }
        return()
      }
      
      #for existing column names
      #check if number of copied columns and selected columns are equal
      if(ncol(clip_tbl) != length(col_names)){
        stop(paste("number of columns are not the same.",
                   "Selected columns:", length(col_names), ". Copied columns:", ncol(clip_tbl)) )
      }
      
      
      #check copied data integrity
      for(index in seq_along(col_names)){
        col_data <- current_tbl[, col_names[index]]
        #get column type of column from the current table using column name
        col_type <- class(col_data)
        #check copied data integrity based on the data type expected
        if (is.factor(col_data)) {
          #get all the factor levels of the selected column in the current data frame
          expected_factor_levels <- levels(col_data)
          #check if all copied data values are contained in the factor levels
          #if any invalid is found. exit function
          for(val in clip_tbl[,index]){
            if(!is.na(val) && !is.element(val,expected_factor_levels)){
              stop("Invalid column values. Level not found in factor")
            }
          }#end inner for loop
        } else if( !(is.numeric(col_data) || is.logical(col_data) || is.character(col_data)) ) {
          #clipr support above column types only. So pasting to a column not recognised by clipr may result to unpredictible results 
          #if not in any of above column types then exit function
          stop( paste("Cannot paste into columns of type:", col_type) )
        }#end if  
      }#end outer for loop
      
      #replace values in the selected columns
      for(index in seq_along(col_names)){
        #set the row positions and the values
        rows_to_replace <- c(start_row_pos : (start_row_pos + nrow(clip_tbl) - 1 ))
        new_values <- clip_tbl[,index]
        
        # Replace the old values with new values
        for (i in seq_along(new_values)) {
          # Replace each value one by one
          self$replace_value_in_data(col_names = col_names[index], rows = rows_to_replace[i], new_value = new_values[i])
        }
        
        #rename header if first row of clip data is header. 
        if(first_clip_row_is_header){
          self$rename_column_in_data(curr_col_name = col_names[index], new_col_name = colnames(clip_tbl)[index]) 
        }
      }#end for loop
    },
    
    #' @description
    #' Append a new value to the metadata of the data.
    #'
    #' @param property Character, the property to append to.
    #' @param new_value The new value to append.
    append_to_metadata = function(property, new_value = "") {
      if(missing(property)) stop("property must be specified.")
      
      if (!is.character(property)) stop("property must be of type: character")
      
      attr(private$data, property) <- new_value
      self$append_to_changes(list(Added_metadata, property, new_value))
      self$metadata_changed <- TRUE
      # Not sure this is correct way to ensure unhidden data frames appear.
      # Possibly better to modify the Grid Link
      if(property == is_hidden_label) self$data_changed <- TRUE
    },
    
    #' @description
    #' Append a new value to the variables metadata.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param property Character, the property to append to.
    #' @param new_val The new value to append.
    append_to_variables_metadata = function(col_names, property, new_val = "") {
      if (missing(property)) stop("property must be specified.")
      if (!is.character(property)) stop("property must be a character")
      if (!missing(col_names)) {
        # if(!all(col_names %in% self$get_column_names())) stop("Not all of ", paste(col_names, collapse = ","), " found in data.")
        if (!all(col_names %in% names(private$data))) stop("Not all of ", paste(col_names, collapse = ","), " found in data.")
        for (curr_col in col_names) {
          #see comments in  PR #7247 to understand why ' property == labels_label && new_val == "" ' check was added
          #see comments in issue #7337 to understand why the !is.null(new_val) check was added. 
          if (((property == labels_label && any(new_val == "")) || (property == colour_label && new_val == -1)) && !is.null(new_val)) {
            #reset the column labels or colour property 
            attr(private$data[[curr_col]], property) <- NULL
          } else {
            attr(private$data[[curr_col]], property) <- new_val
          }
          self$append_to_changes(list(Added_variables_metadata, curr_col, property))
        }
      } else {
        for (col_name in self$get_column_names()) {
          #see comments in  PR #7247 to understand why ' property == labels_label && new_val == "" ' check was added
          #see comments in issue #7337 to understand why the !is.null(new_val) check was added. 
          if (((property == labels_label && any(new_val == "")) || (property == colour_label && new_val == -1)) && !is.null(new_val)) {
            #reset the column labels or colour property 
            attr(private$data[[col_name]], property) <- NULL
          } else {
            attr(private$data[[col_name]], property) <- new_val
          }
        }
        self$append_to_changes(list(Added_variables_metadata, property, new_val))
      }
      self$variables_metadata_changed <- TRUE
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Append a value to the changes list.
    #'
    #' @param value The value to append.
    append_to_changes = function(value) {
      #functionality disabled temporarily
      #see PR #8465 and issue #7161 comments
      
      #if(missing(value)) {
      #  stop("value arguements must be specified.")
      #}else {
      #see comments in issue #7161 that explain more about why list() was used
      #primary reason was because of performance when it comes to wide data sets
      #private$changes[[length(private$changes)+1]] <- value 
      #private$changes<-list(private$changes, value)
      #}
    },
    
    #' @description
    #' Check if a string is in the metadata.
    #'
    #' @param str Character, the string to check.
    #'
    #' @return Logical, TRUE if the string is in the metadata, FALSE otherwise.
    is_metadata = function(str) {
      return(str %in% names(attributes(private$data)))
    },
    
    #' @description
    #' Check if a string is in the variables metadata.
    #'
    #' @param str Character, the string to check.
    #' @param col Character, the column to check in.
    #' @param return_vector Logical, if TRUE, returns the result as a vector.
    #'
    #' @return Logical, TRUE if the string is in the variables metadata, FALSE otherwise.
    is_variables_metadata = function(str, col, return_vector = FALSE) {
      if(str == data_type_label) return(TRUE)
      if(missing(col)) {
        dat <- self$get_data_frame(use_current_filter = FALSE)
        return(any(sapply(dat, function(x) str %in% names(attributes(x))), na.rm = TRUE))
      }
      else {
        out <- sapply(col, function(x) str %in% names(attributes(self$get_columns_from_data(x, use_current_filter = FALSE))))
        if(return_vector) return(out)
        else return(all(out))
      }
    },
    
    #' @description
    #' Adds default values to the metadata.
    add_defaults_meta = function() {
      if(!self$is_metadata(is_calculated_label)) self$append_to_metadata(is_calculated_label, FALSE)
      if(!self$is_metadata(is_hidden_label)) self$append_to_metadata(is_hidden_label, FALSE)
      if(!self$is_metadata(label_label)) self$append_to_metadata(label_label, "")
    },
    
    #' @description
    #' Adds default values to the variables metadata for the specified columns.
    #'
    #' @param column_names Character vector, the names of the columns.
    add_defaults_variables_metadata = function(column_names) {
      for(column in column_names) {
        self$append_to_variables_metadata(column, name_label, column)
        if(!self$is_variables_metadata(is_hidden_label, column)) {
          self$append_to_variables_metadata(column, property = is_hidden_label, new_val = FALSE)
        }
        if(!self$is_variables_metadata(label_label, column)) {
          self$append_to_variables_metadata(column, label_label, "")
        }
        if(!self$is_variables_metadata(scientific_label, column)) {
          self$append_to_variables_metadata(column, scientific_label, FALSE)
        }
        if(!self$is_variables_metadata(signif_figures_label, column) || is.na(self$get_variables_metadata(property = signif_figures_label, column = column))) {
          self$append_to_variables_metadata(column, signif_figures_label, instatExtras::get_default_significant_figures(self$get_columns_from_data(column, use_current_filter = FALSE, use_column_selection = FALSE)))
        }
        if(self$is_variables_metadata(labels_label, column)) {
          curr_labels <- self$get_variables_metadata(property = labels_label, column = column, direct_from_attributes = TRUE)
          if(!is.numeric(curr_labels)) {
            numeric_labs <- as.numeric(curr_labels)
            if(any(is.na(numeric_labs))) {
              warning("labels attribute of non numeric values is not currently supported. labels will be removed from column: ", column, " to prevent compatibility issues. removed labels: ", curr_labels)
              self$append_to_variables_metadata(column, labels_label, NULL)
            }
            else {
              adjusted_labels <- numeric_labs
              names(adjusted_labels) <- names(curr_labels)
              self$append_to_variables_metadata(column, labels_label, adjusted_labels)
            }
          }
        }
      }
    },
    
    #' @description
    #' Removes the specified rows from the data.
    #'
    #' @param row_names Character vector, the names of the rows to remove.
    remove_rows_in_data = function(row_names) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      self$save_state_to_undo_history()
      
      if(!all(row_names %in% rownames(curr_data))) stop("Some of the row_names not found in data")
      rows_to_remove <- which(rownames(curr_data) %in% row_names)
      #Prefer not to use dplyr::slice as it produces a tibble
      #tibbles remove row names e.g. for filtering
      #but cannot use standard curr_data[-rows_to_remove, ] 
      #since it removes column attributes
      
      self$set_data(dplyr::slice(curr_data, -rows_to_remove, .preserve = TRUE))
      self$append_to_changes(list(Removed_row, row_names))
      #Added this line to fix the bug of having the variable names in the metadata changinng to NA
      # This affects factor columns only  - we need to find out why and how to solve it best
      self$add_defaults_variables_metadata(self$get_column_names())
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Gets the next default column name based on the given prefix.
    #'
    #' @param prefix Character, the prefix for the new column name.
    #'
    #' @return Character, the next default column name.
    get_next_default_column_name = function(prefix) {
      return(instatExtras::next_default_item(prefix = prefix, existing_names = self$get_column_names(use_current_column_selection = FALSE)))
    },
    
    #' @description
    #' Reorders the columns in the data based on the given order.
    #'
    #' @param col_order Character vector, the new order of the columns.
    reorder_columns_in_data = function(col_order) {
      # Save the current state to undo_history before making modifications
      self$save_state_to_undo_history()
      
      if (ncol(self$get_data_frame(use_current_filter = FALSE, use_column_selection = FALSE)) != length(col_order)) stop("Columns to order should be same as columns in the data.")
      
      if(is.numeric(col_order)) {
        if(!(identical(sort(col_order), sort(as.numeric(1:ncol(data)))))) {
          stop("Invalid column order")
        }
      }
      else if(is.character(col_order)) {
        if(!(dplyr::setequal(col_order,names(private$data)))) stop("Invalid column order")
      }
      else stop("column order must be a numeric or character vector")
      old_metadata <- attributes(private$data)
      self$set_data(private$data[ ,col_order])
      for(name in names(old_metadata)) {
        if(!name %in% c("names", "class", "row.names")) {
          self$append_to_metadata(name, old_metadata[[name]])
        }
      }
      self$append_to_changes(list(Col_order, col_order))
    },
    
    #' @description
    #' Inserts new rows into the data at the specified position.
    #'
    #' @param start_row Character, the starting row for the new rows.
    #' @param row_data Data frame, the data for the new rows.
    #' @param number_rows Numeric, the number of new rows to insert.
    #' @param before Logical, if TRUE, inserts the new rows before the specified row.
    insert_row_in_data = function(start_row, row_data = c(), number_rows = 1, before = FALSE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      self$save_state_to_undo_history()
      curr_row_names <- rownames(curr_data)
      if (!start_row %in% curr_row_names) {
        stop(paste(start_row, " not found in rows"))
      }
      row_position = which(curr_row_names == start_row)
      row_data <- curr_data[0, ]
      for(i in 1:number_rows) {
        row_data[i, ] <- NA
      }
      #row_data <- data.frame(matrix(NA, nrow = number_rows, ncol = ncol(curr_data)))
      #colnames(row_data) <- colnames(curr_data)
      if(length(curr_row_names[!is.na(as.numeric(curr_row_names))]) > 0) {
        rownames(row_data) <- max(as.numeric(curr_row_names), na.rm = TRUE) + 1:number_rows
      }
      else rownames(row_data) <- nrow(curr_data) + 1:(number_rows - 1)
      old_attr <- attributes(private$data)
      # Need to use rbind.fill (not bind_rows) because it preserves column attributes
      if(before && row_position == 1) {
        # This transfers attributes to new data so that they are kept after rbind.fill
        # Only needed when row_data is first argument to rbind.fill
        for(i in seq_along(row_data)) {
          attributes(row_data[[i]]) <- attributes(curr_data[[i]])
        }
        self$set_data(plyr::rbind.fill(row_data, curr_data))
      }
      else if(!before && row_position == nrow(curr_data)) {
        self$set_data(plyr::rbind.fill(curr_data, row_data))
      }
      else {
        if(before) {
          self$set_data(plyr::rbind.fill(dplyr::slice(curr_data,(1:(row_position - 1))), row_data, dplyr::slice(curr_data,row_position:nrow(curr_data))))
        }
        else {
          self$set_data(plyr::rbind.fill(dplyr::slice(curr_data, (1:row_position)), row_data, dplyr::slice(curr_data,(row_position + 1):nrow(curr_data))))
        }
      }
      for(attr_name in names(old_attr)) {
        if(!attr_name %in% c("names", "class", "row.names")) {
          self$append_to_metadata(attr_name, old_attr[[attr_name]])
        }
      }
      self$append_to_changes(list(Inserted_row, number_rows))
      #Added this line to fix the bug of having the variable names in the metadata changinng to NA
      # This affects factor columns only  - we need to find out why and how to solve it best
      self$add_defaults_variables_metadata(self$get_column_names())
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Gets the length of the data frame.
    #'
    #' @param use_current_filter Logical, if TRUE, uses the current filter.
    #'
    #' @return Numeric, the length of the data frame.
    get_data_frame_length = function(use_current_filter = FALSE) {
      return(nrow(self$get_data_frame(use_current_filter = use_current_filter)))
    },
    
    #' @description
    #' Gets the data frame for a factor column with optional inclusion of levels and NA level.
    #'
    #' @param col_name Character, the name of the factor column.
    #' @param include_levels Logical, if TRUE, includes the levels of the factor.
    #' @param include_NA_level Logical, if TRUE, includes the NA level.
    #'
    #' @return Data frame, the data frame for the factor column.
    get_factor_data_frame = function(col_name = "", include_levels = TRUE, include_NA_level = FALSE) {
      if(!(col_name %in% self$get_column_names())) stop(col_name, " is not a column name,")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = TRUE)
      if(!(is.factor(col_data))) stop(col_name, " is not a factor column")
      
      counts <- data.frame(table(col_data))
      counts <- plyr::rename(counts, replace = c("col_data" = "Label"))
      counts[["Label"]] <- as.character(counts[["Label"]])
      counts[["Ord."]] <- 1:nrow(counts)
      if(include_levels) {
        if(self$is_variables_metadata(str = labels_label, col = col_name)) {
          curr_levels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
          curr_levels <- data.frame(Label = names(curr_levels), Level = as.vector(curr_levels), stringsAsFactors = FALSE)
          counts <- dplyr::left_join(counts, curr_levels, by = "Label")
        }
        else {
          curr_levels <- counts[["Ord."]]
          counts[["Level"]] <- curr_levels
        }
        counts <- counts[c("Ord.", "Label", "Level", "Freq")]
      }
      else counts <- counts[c("Ord.", "Label", "Freq")]
      if(include_NA_level) {
        missing_count <- sum(is.na(col_data))
        if(include_levels) counts[nrow(counts) + 1, ] <- c("-", "NA", "-", missing_count)
        else counts[nrow(counts) + 1, ] <- c("-", "(NA)", missing_count)
      }
      return(counts)
    },
    
    #' @description
    #' Gets the factor levels for the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #'
    #' @return Character vector, the factor levels for the column.
    get_column_factor_levels = function(col_name = "") {
      if(!(col_name %in% self$get_column_names())) {
        stop(col_name, " is not a column in", get_metadata(data_name_label))
      }
      
      if(!(is.factor(self$get_columns_from_data(col_name, use_current_filter = FALSE)))){
        stop(col_name, " is not a factor column")
      }
      
      return(levels(self$get_columns_from_data(col_name, use_current_filter = FALSE)))
    },
    
    #' @description
    #' Sorts the data frame based on the specified columns.
    #'
    #' @param col_names Character vector, the names of the columns to sort by.
    #' @param decreasing Logical, if TRUE, sorts in decreasing order.
    #' @param na.last Logical, if TRUE, places NA values last.
    #' @param by_row_names Logical, if TRUE, sorts by row names.
    #' @param row_names_as_numeric Logical, if TRUE, treats row names as numeric values.
    sort_dataframe = function(col_names = c(), decreasing = FALSE, na.last = TRUE, by_row_names = FALSE, row_names_as_numeric = TRUE) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      
      # Check for missing or empty column names
      if (missing(col_names) || length(col_names) == 0) {
        if (by_row_names) {
          row_names_sort <- if (row_names_as_numeric) as.numeric(row.names(curr_data)) else row.names(curr_data)
          if (decreasing) self$set_data(arrange(curr_data, dplyr::desc(row_names_sort)))
          else self$set_data(arrange(curr_data, row_names_sort))
        } else {
          message("No sorting to be done.")
        }
      } else {
        if (by_row_names) warning("Cannot sort by columns and row names. Sorting will be done by given columns only.")
        
        if (decreasing) self$set_data(dplyr::arrange(curr_data, dplyr::across(dplyr::all_of(col_names), dplyr::desc)))
        else self$set_data(dplyr::arrange(curr_data, dplyr::across(dplyr::all_of(col_names))))
      }
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Converts the specified columns to the given type.
    #'
    #' @param col_names Character vector, the names of the columns.
    #' @param to_type Character, the type to convert to.
    #' @param factor_values Character, the factor values to use for conversion.
    #' @param set_digits Numeric, the number of digits to use for conversion.
    #' @param set_decimals Logical, if TRUE, sets the number of decimals.
    #' @param keep_attr Logical, if TRUE, keeps the attributes of the columns.
    #' @param ignore_labels Logical, if TRUE, ignores labels during conversion.
    #' @param keep.labels Logical, if TRUE, keeps labels during conversion.
    convert_column_to_type = function(col_names = c(), to_type, factor_values = NULL, set_digits, set_decimals = FALSE, keep_attr = TRUE, ignore_labels = FALSE, keep.labels = TRUE) {
      if(!all(col_names %in% self$get_column_names())) stop("Some column names not found in the data")
      
      if(length(to_type) !=1 ) {
        stop("to_type must be a character of length one")
      }
      
      if(!(to_type %in% c("integer", "factor", "numeric", "character", "ordered_factor", "logical"))) {
        stop(to_type, " is not a valid type to convert to")
      }
      
      if(!is.null(factor_values) && !(factor_values %in% c("force_ordinals", "force_values"))) {
        stop(factor_values, " must be either 'force_ordinals' or 'force_values'")
      }
      
      for(col_name in col_names) {
        curr_col <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        if(keep_attr) {
          tmp_attr <- instatExtras::get_column_attributes(curr_col)
        }
        if(!is.null(factor_values) && is.factor(curr_col) && to_type %in% c("integer", "numeric")) {
          if(factor_values == "force_ordinals") new_col <- as.numeric(curr_col)
          else if(factor_values == "force_values") new_col <- as.numeric(levels(curr_col))[curr_col]
        }
        else if(to_type %in% c("factor", "ordered_factor")) {
          ordered <- (to_type == "ordered_factor")
          # TODO This looks like it may not work if curr_col is not numeric.
          # If this is not currently used anywhere possibly remove or modify.
          if(set_decimals) curr_col <- round(curr_col, digits = set_digits)
          if(ignore_labels) {
            new_col <- instatExtras::make_factor(curr_col, ordered = ordered)
          }
          else {
            if(self$is_variables_metadata(labels_label, col_name)) {
              new_col <- sjlabelled::as_label(curr_col, add.non.labelled = TRUE)
              # Adds "ordered" to the class in the same way as factor().
              # factor(ordered = TURE) is not used as this drops all attributes of x.
              if(ordered) class(new_col) <- c("ordered", class(new_col))
              else class(new_col) <- class(new_col)[class(new_col) != "ordered"]
            }
            else {
              new_col <- instatExtras::make_factor(curr_col, ordered = ordered)
              if(is.numeric(curr_col) && !self$is_variables_metadata(labels_label, col_name)) {
                labs <- sort(unique(curr_col))
                names(labs) <- labs
                # temporary fix to issue of add_columns not retaining attributes of new columns
                tmp_attr[[labels_label]] <- labs
              }
            }
          }
        }
        else if(to_type == "integer") {
          new_col <- as.integer(curr_col)
        }
        else if(to_type == "numeric") {
          if(ignore_labels) {
            if (is.factor(curr_col)) new_col <- as.numeric(levels(curr_col))[curr_col]
            else new_col <- as.numeric(curr_col)
          }
          else {
            if(self$is_variables_metadata(labels_label, col_name) && !is.numeric(curr_col)) {
              #TODO WARNING: need to test this on columns of different types to check for strange behaviour
              curr_labels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
              if(!all(curr_col %in% names(curr_labels))) {
                additional_names <- sort(unique(na.omit(curr_col[!curr_col %in% names(curr_labels)])))
                additonal <- seq(max(curr_labels, na.rm = TRUE) + 1, length.out = length(additional_names))
                names(additonal) <- additional_names
                curr_labels <- c(curr_labels, additonal)
                # temporary fix to issue of add_columns not retaining attributes of new columns
                tmp_attr[[labels_label]] <- curr_labels
              }
              new_col <- as.numeric(curr_labels[as.character(curr_col)])
            }
            # This ensures that integer columns get type changed to numeric (not done by sjlabelled::as_numeric)
            else if(is.integer(curr_col)) new_col <- as.numeric(curr_col)
            else new_col <- sjlabelled::as_numeric(curr_col, keep.labels = keep.labels)
          }
        }
        else if(to_type == "character") {
          new_col <- sjmisc::to_character(curr_col) 
        }
        else if(to_type == "logical") {
          if(instatExtras::is.logical.like(curr_col)) new_col <- as.logical(curr_col)
          else stop("Column is not numeric or contains values other than 0 and 1. Converting to logical would result in losing information.")
        }
        
        self$add_columns_to_data(col_name = col_name, col_data = new_col)
        
        if(keep_attr) {
          if(to_type %in% c("numeric", "integer") && signif_figures_label %in% names(tmp_attr) && is.na(tmp_attr[[signif_figures_label]])) {
            tmp_attr[[signif_figures_label]] <- NULL
          }
          self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
        }
      }
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Copies the specified columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to copy.
    copy_columns = function(col_names = "") {
      for(col_name in col_names){
        if(!(col_name %in% self$get_column_names())) {
          stop(col_name, " is not a column in ", get_metadata(data_name_label))
        }
      }
      dat1 <- self$get_columns_from_data(col_names, use_current_filter = FALSE)
      
      for(name in col_names){
        names(dat1)[names(dat1) == name] <- self$get_next_default_column_name(prefix = paste(name, "copy", sep = "_" ) )
      }
      
      self$add_columns_to_data(col_name = names(dat1), col_data = dat1)
      self$append_to_changes(list(Copy_cols, col_names))
    },
    
    #' @description
    #' Drops unused factor levels in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    drop_unused_factor_levels = function(col_name) {
      if(!col_name %in% self$get_column_names()) stop(paste(col_name,"not found in data."))
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      level_counts <- table(col_data)
      if(any(level_counts == 0)) {
        if(self$is_variables_metadata(labels_label, col_name)) {
          curr_labels <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
          curr_labels <- curr_labels[names(level_counts[level_counts > 0])]
          self$append_to_variables_metadata(property = labels_label, col_names = col_name, new_val = curr_labels)
          col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
        }
        tmp_attr <- instatExtras::get_column_attributes(col_data)
        self$add_columns_to_data(col_name, droplevels(col_data))
        self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
      }
    },
    
    #' @description
    #' Sets the factor levels for the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_labels Character vector, the new labels for the factor levels.
    #' @param new_levels Character vector, the new levels for the factor.
    #' @param set_new_labels Logical, if TRUE, sets the new labels.
    set_factor_levels = function(col_name, new_labels, new_levels, set_new_labels = TRUE) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      old_labels <- levels(col_data)
      if(length(new_labels) < length(old_labels)) stop("There must be at least as many new levels as current levels.")
      if(!missing(new_levels) && anyDuplicated(new_levels)) stop("new levels must be unique")
      # Must be private$data because setting an attribute
      levels(private$data[[col_name]]) <- new_labels
      
      if(!missing(new_levels)) {
        labels_list <- new_levels
        names(labels_list) <- new_labels
        self$append_to_variables_metadata(col_name, labels_label, labels_list)
      }
      else if(set_new_labels && self$is_variables_metadata(labels_label, col_name)) {
        labels_list <- self$get_variables_metadata(property = labels_label, column = col_name, direct_from_attributes = TRUE)
        names(labels_list) <- as.character(new_labels[1:length(old_labels)])
        if(length(new_labels) > length(old_lables)) {
          extra_labels <- seq(from = max(labels_list) + 1, length.out = (length(new_labels) - length(old_labels)))
          names(extra_labels) <- new_labels[!new_labels %in% names(labels_list)]
          labels_list <- c(labels_list, extra_labels)
        }
        self$append_to_variables_metadata(col_name, labels_label, labels_list)
      }
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Edits the factor level in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param old_level Character, the old factor level.
    #' @param new_level Character, the new factor level.
    edit_factor_level = function(col_name, old_level, new_level) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      if(!is.factor(self$get_columns_from_data(col_name, use_current_filter = FALSE))) stop(col_name, " is not a factor.")
      self$add_columns_to_data(col_name, plyr::mapvalues(x = self$get_columns_from_data(col_name, use_current_filter = FALSE), from = old_level, to = new_level))
      self$data_changed <- TRUE
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Sets the reference level for a factor column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_ref_level Character, the new reference level.
    set_factor_reference_level = function(col_name, new_ref_level) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(col_data)) stop(col_name, " is not a factor.")
      if(!new_ref_level %in% levels(col_data)) stop(new_ref_level, " is not a level of ", col_name)
      tmp_attr <- instatExtras::get_column_attributes(col_data)
      self$add_columns_to_data(col_name, relevel(col_data, new_ref_level))
      self$append_column_attributes(col_name = col_name, new_attr = tmp_attr)
    },
    
    #' @description
    #' Reorders the factor levels in the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #' @param new_level_names Character vector, the new order of the factor levels.
    reorder_factor_levels = function(col_name, new_level_names) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in data.")
      curr_column <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      if(!is.factor(curr_column)) stop(col_name, " is not a factor.")
      curr_levels <- levels(curr_column)
      if(length(new_level_names) != length(curr_levels)) stop("Incorrect number of new levels given.")
      if(!all(new_level_names %in% curr_levels)) stop("new_level_names must be a reordering of the current levels:", paste(levels(curr_column), collapse = ", "))
      new_column <- factor(curr_column, levels = new_level_names, ordered = is.ordered(curr_column))
      #TODO are these the only attributes we don't want to manually set?
      curr_attr <- attributes(curr_column)[!names(attributes(curr_column)) %in% c("levels", "class")]
      for(i in seq_along(curr_attr)) {
        attr(new_column, names(curr_attr)[i]) <- curr_attr[[i]]
      }
      self$add_columns_to_data(col_name = col_name, col_data = new_column)
      self$variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Gets the number of columns in the data.
    #'
    #' @param use_column_selection Logical, if TRUE, uses the current column selection.
    #'
    #' @return Numeric, the number of columns in the data.
    get_column_count = function(use_column_selection = FALSE) {
      return(ncol(self$get_data_frame(use_column_selection = use_column_selection)))
    },
    
    #' @description
    #' Gets the names of the columns in the data.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #' @param max_no Numeric, the maximum number of columns to return.
    #' @param use_current_column_selection Logical, if TRUE, uses the current column selection.
    #'
    #' @return Character vector or list, the names of the columns in the data.
    get_column_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c(), max_no, use_current_column_selection = TRUE) {
      if(length(include) == 0 && length(exclude) == 0 && (!use_current_column_selection || !self$column_selection_applied())) out <- names(private$data)
      else {
        if(data_type_label %in% names(include) && "numeric" %in% include[[data_type_label]]) {
          include[[data_type_label]] = c(include[[data_type_label]], "integer")
        }
        if(data_type_label %in% names(exclude) && "numeric" %in% exclude[[data_type_label]]) {
          exclude[[data_type_label]] = c(exclude[[data_type_label]], "integer")
        }
        
        if (use_current_column_selection) col_names <- self$current_column_selection
        else col_names <- names(private$data)
        out <- c()
        i <- 1
        for(col in col_names) {
          if(length(include) > 0 || length(exclude) > 0) {
            curr_var_metadata <- self$get_variables_metadata(column = col, direct_from_attributes = TRUE)
            if(!data_type_label %in% names(curr_var_metadata)) curr_var_metadata[[data_type_label]] <- class(private$data[[col]])
            #TODO this is a temp compatibility solution for how the class of ordered factor used to be shown when getting metadata
            if(length(curr_var_metadata[[data_type_label]]) == 2 && all(curr_var_metadata[[data_type_label]] %in% c("ordered", "factor"))) curr_var_metadata[[data_type_label]] <- "ordered,factor"
            if(all(c(names(include), names(exclude)) %in% names(curr_var_metadata)) && all(sapply(names(include), function(prop) any(curr_var_metadata[[prop]] %in% include[[prop]])))
               && all(sapply(names(exclude), function(prop) !any(curr_var_metadata[[prop]] %in% exclude[[prop]])))) {
              out <- c(out, col)
            }
          }
          else out <- c(out, col)
          i = i + 1
        }
        if(!missing(max_no) && max_no < length(out)) out <- out[1:max_no]
      }
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the data")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Gets the data type of the specified column.
    #'
    #' @param col_name Character, the name of the column.
    #'
    #' @return Character, the data type of the column.
    get_data_type = function(col_name = "") {
      if(!(col_name %in% self$get_column_names())) {
        stop(paste(col_name, "is not a column in", self$get_metadata(data_name_label)))
      }
      type <- ""
      curr_col <- self$get_columns_from_data(col_name, use_current_filter = TRUE)
      if(is.character(curr_col)) {
        type = "character"
      }
      else if(is.logical(curr_col)) {
        type = "logical"
      }
      # Question: Why is the using private$data[[col_name]] instead of curr_col?
      else if(lubridate::is.Date(private$data[[col_name]])){
        # #TODO
        #we can add options for other forms of dates serch as POSIXct, POSIXlt, Date, chron, yearmon, yearqtr, zoo, zooreg, timeDate, xts, its, ti, jul, timeSeries, and fts objects.
        type = "Date"
      }
      else if(is.numeric(curr_col)) {
        #TODO vectors with integer values but stored as numeric will return numeric.
        #     Is that desirable?
        if(instatExtras::is.binary(curr_col)) {
          type = "two level numeric"
        }
        else if(all(curr_col == as.integer(curr_col), na.rm = TRUE)) {
          if(all(curr_col > 0, na.rm = TRUE)) {
            type = "positive integer"
          }
          else type = "integer"
        }
        else type = "numeric"
      }
      else if(is.factor(curr_col)) {
        if(nlevels(curr_col) == 2 || nlevels(factor(curr_col)) == 2) type = "two level factor"
        else if(length(levels(curr_col)) > 2) type = "multilevel factor"
        else type = "factor"
      }
      return(type)
    },
    
    #' @description
    #' Set the hidden columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to hide.
    set_hidden_columns = function(col_names = c()) {
      if(length(col_names) == 0) self$unhide_all_columns()
      else {
        if(!all(col_names %in% self$get_column_names())) stop("Not all col_names found in data")
        
        self$append_to_variables_metadata(col_names, is_hidden_label, TRUE)
        hidden_cols = self$get_column_names()[!self$get_column_names() %in% col_names]
        self$append_to_variables_metadata(hidden_cols, is_hidden_label, FALSE)
      }
    },
    
    #' @description
    #' Unhide all columns in the data.
    unhide_all_columns = function() {
      self$append_to_variables_metadata(self$get_column_names(), is_hidden_label, FALSE)
    },
    
    #' @description
    #' Set the row names of the data frame.
    #'
    #' @param row_names Character vector, the new row names.
    set_row_names = function(row_names) {
      if(missing(row_names)) row_names = 1:nrow(self$get_data_frame(use_current_filter = FALSE))
      if(length(row_names) != nrow(self$get_data_frame(use_current_filter = FALSE))) stop("row_names must be a vector of same length as the data")
      if(anyDuplicated(row_names) != 0) stop("row_names must be unique")
      rownames(private$data) <- row_names
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Set the column names of the data frame.
    #'
    #' @param col_names Character vector, the new column names.
    set_col_names = function(col_names) {
      if(missing(col_names)) col_names = 1:ncol(self$get_data_frame(use_current_filter = FALSE))
      if(length(col_names) != ncol(self$get_data_frame(use_current_filter = FALSE))) stop("col_names must be a vector of same length as the data")
      if(anyDuplicated(col_names) != 0) stop("col_names must be unique")
      names(private$data) <- make.names(iconv(col_names, to = "ASCII//TRANSLIT", sub = "."))
      self$data_changed <- TRUE
    },
    
    #' @description
    #' Get the row names of the data frame.
    #'
    #' @return Character vector, the row names of the data frame.
    get_row_names = function() {
      return(rownames(private$data))
    },
    
    #' @description
    #' Get the dimensions of the data frame.
    #'
    #' @return Numeric vector, the dimensions of the data frame.
    get_dim_dataframe = function() {
      return(dim(self$get_data_frame(use_current_filter = FALSE)))
    },
    
    #' @description
    #' Set the protected columns in the data.
    #'
    #' @param col_names Character vector, the names of the columns to protect.
    set_protected_columns = function(col_names) {
      if(!all(col_names %in% self$get_column_names())) stop("Not all col_names found in data")
      
      self$append_to_variables_metadata(col_names, is_protected_label, TRUE)
      other_cols = self$get_column_names()[!self$get_column_names() %in% col_names]
      self$append_to_variables_metadata(other_cols, is_protected_label, FALSE)
    },
    
    #' @description
    #' Add a filter to the data.
    #'
    #' @param filter List, the filter conditions.
    #' @param filter_name Character, the name of the filter.
    #' @param replace Logical, if TRUE, replaces an existing filter with the same name.
    #' @param set_as_current Logical, if TRUE, sets the filter as the current filter.
    #' @param na.rm Logical, if TRUE, removes NA values.
    #' @param is_no_filter Logical, if TRUE, specifies that no filter is applied.
    #' @param and_or Character, specifies the logical operator for combining conditions.
    #' @param inner_not Logical, if TRUE, applies negation to the inner condition.
    #' @param outer_not Logical, if TRUE, applies negation to the outer condition.
    add_filter = function(filter, filter_name = "", replace = TRUE, set_as_current = FALSE, na.rm = TRUE, is_no_filter = FALSE, and_or = "&", inner_not = FALSE, outer_not = FALSE) {
      if(missing(filter)) stop("filter is required")
      if(filter_name == "") filter_name = instatExtras::next_default_item("Filter", names(private$filters))
      
      for(condition in filter) {
        if(length(condition) < 2 || length(condition) > 3 || !all(names(condition) %in% c("column", "operation", "value"))) {
          stop("filter must be a list of conditions containing: column, operation and (sometimes) value")
        }
        if(!condition[["column"]] %in% self$get_column_names()) stop(condition[["column"]], " not found in data.")
      }
      if(filter_name %in% names(private$filters) && !replace) {
        warning("A filter named ", filter_name, " already exists. It will not be replaced.")
      }
      else {
        if(filter_name %in% names(private$filters)) message("A filter named ", filter_name, " already exists. It will be replaced by the new filter.")
        filter_calc = instatCalculations::calculation$new(type = "filter", filter_conditions = filter, name = filter_name, parameters = list(na.rm = na.rm, is_no_filter = is_no_filter, and_or = and_or, inner_not = inner_not, outer_not = outer_not))
        private$filters[[filter_name]] <- filter_calc
        self$append_to_changes(list(Added_filter, filter_name))
        if(set_as_current) {
          self$current_filter <- filter_calc
          self$data_changed <- TRUE
        }
      }
    },
    
    #' @description
    #' Add filters based on levels of a column.
    #'
    #' @param filter_levels Character vector, the levels to create filters for.
    #' @param column Character, the name of the column.
    add_filter_as_levels = function(filter_levels, column) {
      for (i in seq_along(filter_levels)) {
        filter_cond <- list(C0 = list(column = column, operation = "==", value = filter_levels[i]))
        self$add_filter(filter = filter_cond, filter_name = filter_levels[i])
      }
    },
    
    #' @description
    #' Get the current filter.
    #'
    #' @return List, the current filter.
    get_current_filter = function() {
      return(private$.current_filter)
    },
    
    #' @description
    #' Set the current filter by name.
    #'
    #' @param filter_name Character, the name of the filter to set as current.
    set_current_filter = function(filter_name = "") {
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      self$current_filter <- private$filters[[filter_name]]
    },
    
    #' @description
    #' Get the names of all filters.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the names of the filters.
    get_filter_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c()) {
      out = names(private$filters)
      if(length(excluded_items) > 0) {
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of filters")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Get a specific filter by name.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return List, the specified filter.
    get_filter = function(filter_name) {
      if(missing(filter_name)) return(private$filters)
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      return(private$filters[[filter_name]])
    },
    
    #' @description
    #' Get the filter as a logical vector.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Logical vector, the filter applied as a logical vector.
    get_filter_as_logical = function(filter_name) {
      curr_filter <- self$get_filter(filter_name)
      and_or <- curr_filter$parameters[["and_or"]]
      # This should no longer be needed as default will be set in check_filter()
      if (is.null(and_or)) and_or <- "&"
      outer_not <- curr_filter$parameters[["outer_not"]]
      i <- 1
      if (!isTRUE(outer_not)) {
        if (length(curr_filter$filter_conditions) == 0) {
          out <- rep(TRUE, nrow(self$get_data_frame(use_current_filter = FALSE)))
        } else {
          result <- matrix(nrow = nrow(self$get_data_frame(use_current_filter = FALSE)), ncol = length(curr_filter$filter_conditions))
          for (condition in curr_filter$filter_conditions) {
            # Prevents crash if column no longer exists
            # TODO still shows filter is applied
            if (!condition[["column"]] %in% self$get_column_names()) {
              return(TRUE)
            }
            if (condition[["operation"]] == "is.na" || condition[["operation"]] == "! is.na") {
              col_is_na <- is.na(self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE))
              if (condition[["operation"]] == "is.na") {
                result[, i] <- col_is_na
              } else {
                result[, i] <- !col_is_na
              }
            } else if (condition[["operation"]] == "is.empty" || condition[["operation"]] == "! is.empty"){
              col_is_empty <- self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE) == ""
              if (condition[["operation"]] == "is.empty") {
                result[, i] <- col_is_empty
              } else {
                result[, i] <- !col_is_empty
              }
            }
            else {
              func <- match.fun(condition[["operation"]])
              if (any(is.na(condition[["value"]])) && condition[["operation"]] != "%in%") {
                stop("Cannot create a filter on missing values with operation: ", condition[["operation"]])
              } else {
                logical_vec <- func(self$get_columns_from_data(condition[["column"]], use_current_filter = FALSE), condition[["value"]])
              }
              if (! isTRUE(curr_filter$parameters[["inner_not"]])) {
                result[, i] <- logical_vec
              } else {
                result[, i] <- !logical_vec
              }
            }
            i <- i + 1
          }
          if (and_or == "&") {
            out <- apply(result, 1, all)
          } else if (and_or == "|") {
            out <- apply(result, 1, any)
          } else {
            stop(and_or, " should be & or |.")
          }
          out[is.na(out)] <- !curr_filter$parameters[["na.rm"]]
        }
      } else {
        dat <- self$get_data_frame(use_current_filter = FALSE)
        str_out <- "("
        for (condition in curr_filter$filter_conditions) {
          str_out <- paste0(str_out, paste0("dat", "$", condition[["column"]], condition[["operation"]], ifelse(is.numeric(condition[["value"]]), condition[["value"]], paste0("'", condition[["value"]], "'"))))
          if (i != length(curr_filter$filter_conditions)) str_out <- paste0(str_out, curr_filter$parameters[["and_or"]])
          i <- i + 1
        }
        str_out <- paste0("!", str_out, ")")
        out <- eval(parse(text = str_out))
      }
      return(out)
    },
    
    #' @description
    #' Get the column names used in a specific filter.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Character vector, the column names used in the filter.
    get_filter_column_names = function(filter_name) {
      curr_filter <- self$get_filter(filter_name)
      column_names <- c()
      for(i in seq_along(curr_filter$filter_conditions)) {
        column_names <- c(column_names, curr_filter$filter_conditions[[i]][["column"]])
      }
      return(column_names)
    },
    
    #' @description
    #' Get the column names used in the current filter.
    #'
    #' @return Character vector, the column names used in the current filter.
    get_current_filter_column_names = function() {
      return(self$get_filter_column_names(private$.current_filter$name))
    },
    
    #' @description
    #' Check if a filter is applied.
    #'
    #' @return Logical, TRUE if a filter is applied, FALSE otherwise.
    filter_applied = function() {
      return(!private$.current_filter$parameters[["is_no_filter"]])
    },
    
    #' @description
    #' Remove the current filter.
    remove_current_filter = function() {
      self$set_current_filter("no_filter")
    },
    
    #' @description
    #' Get the filter as a string.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Character, the filter as a string.
    filter_string = function(filter_name) {
      if (!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      curr_filter <- self$get_filter(filter_name)
      out <- "("
      i <- 1
      for (condition in curr_filter$filter_conditions) {
        if (i != 1) out <- paste(out, curr_filter$parameters[["and_or"]])
        out <- ifelse(!curr_filter$parameters[["inner_not"]], paste0(out, " (", condition[["column"]], " ", condition[["operation"]]), paste0(out, " !(", condition[["column"]], " ", condition[["operation"]]))
        if (condition[["operation"]] == "%in%") {
          out <- paste0(out, " c(", paste(paste0("'", condition[["value"]], "'"), collapse = ","), ")")
        } else {
          out <- paste(out, condition[["value"]])
        }
        out <- paste0(out, ")")
        i <- i + 1
      }
      out <- paste(out, ")")
      if (isTRUE(curr_filter$parameters[["outer_not"]])) {
        out <- gsub("[!()]", "", out)
        out <- paste0("!(", out, ")")
      }
      return(out)
    },
    
    #' @description
    #' Get the filter as an instat calculation.
    #'
    #' @param filter_name Character, the name of the filter.
    #'
    #' @return Instat calculation, the filter as an instat calculation.
    get_filter_as_instat_calculation = function(filter_name) {
      if(!filter_name %in% names(private$filters)) stop(filter_name, " not found.")
      curr_filter <- self$get_filter(filter_name)
      filter_string <- self$filter_string(filter_name)
      calc_from <- list()
      for(condition in curr_filter$filter_conditions) {
        calc_from[[length(calc_from) + 1]] <- condition[["column"]]
      }
      names(calc_from) <- rep(self$get_metadata(data_name_label), length(calc_from))
      calc <- instatCalculations::instat_calculation$new(type="filter", function_exp = filter_string, calculated_from = calc_from)
      return(calc)
    },
    
    #' @description
    #' Add a column selection to the data.
    #'
    #' @param column_selection List, the column selection conditions.
    #' @param name Character, the name of the column selection.
    #' @param replace Logical, if TRUE, replaces an existing column selection with the same name.
    #' @param set_as_current Logical, if TRUE, sets the column selection as the current selection.
    #' @param is_everything Logical, if TRUE, selects all columns.
    #' @param and_or Character, specifies the logical operator for combining conditions.
    add_column_selection = function(column_selection, name = "", replace = TRUE, set_as_current = FALSE, is_everything = FALSE, and_or = "|") {
      if(missing(column_selection)) stop("column_selection is required")
      if(name == "") name <- instatExtras::next_default_item("sel", names(private$column_selections))
      if(name %in% names(private$column_selections) && !replace) {
        warning("The column selection was not added. A column selection named ", name, " already exists. Specify replace = TRUE to overwrite it.")
        return()
      }
      for(condition in column_selection) {
        if(!length(condition) %in% c(2, 3) || !all(names(condition) %in% c("operation", "parameters", "negation"))) {
          stop("column_selection must be a list of conditions containing: operation and parameters (list)")
        }
        if (!condition[["operation"]] %in% column_selection_operations) stop("Unkown operation. Operation must be one of ", paste(column_selection_operations, collapse = ", "))
        if (!is.list(condition[["parameters"]])) stop("parameters must be a list.")
        if (is.null(condition[["negation"]])) condition[["negation"]] <- FALSE
        if (!is.logical(condition[["negation"]])) stop("negative must be either TRUE or FALSE.")
      }
      if(name %in% names(private$column_selection)) message("A column selection named ", name, " already exists. It will be replaced by the new column selection.")
      column_selection_obj <- list(name = name,
                                   conditions = column_selection,
                                   is_everything = is_everything,
                                   and_or = and_or
      )
      private$column_selections[[name]] <- column_selection_obj
      self$append_to_changes(list(Added_column_selection, name))
      if(set_as_current) {
        self$current_column_selection <- column_selection_obj
        self$data_changed <- TRUE
      }
    },
    
    #' @description
    #' Get the current column selection.
    #'
    #' @return List, the current column selection.
    get_current_column_selection = function() {
      return(private$.current_column_selection)
    },
    
    #' @description
    #' Set the current column selection by name.
    #'
    #' @param name Character, the name of the column selection to set as current.
    set_current_column_selection = function(name = "") {
      if (!name %in% names(private$column_selections)) stop(name, " not found as a column selection.")
      if (length(self$get_column_selection_column_names(name)) == 0) {
        cat(name, " has no columns selected.")
      } else {
        self$current_column_selection <- private$column_selections[[name]]
      }
    },
    
    #' @description
    #' Get the names of all column selections.
    #'
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #' @param include List, the properties to include.
    #' @param exclude List, the properties to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the names of the column selections.
    get_column_selection_names = function(as_list = FALSE, include = list(), exclude = list(), excluded_items = c()) {
      out <- names(private$column_selections)
      if(length(excluded_items) > 0) {
        ex_ind <- which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of column selections.")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Get a specific column selection by name.
    #'
    #' @param name Character, the name of the column selection.
    #'
    #' @return List, the specified column selection.
    get_column_selection = function(name) {
      if(missing(name)) return(private$column_selections)
      if(!name %in% names(private$column_selections)) stop(name, " not found as a column selection.")
      return(private$column_selections[[name]])
    },
    
    #' @description
    #' Get the column names selected by a specific column selection.
    #'
    #' @param name Character, the name of the column selection.
    #'
    #' @return Character vector, the column names selected by the column selection.
    get_column_selection_column_names = function(name) {
      curr_column_selection <- self$get_column_selection(name)
      all_column_names <- names(private$data)
      if (length(curr_column_selection[["conditions"]]) == 0) return(all_column_names)
      and_or <- curr_column_selection[["and_or"]]
      i <- 1
      res <- vector("list", length(curr_column_selection[["conditions"]]))
      for (condition in curr_column_selection[["conditions"]]) {
        op <- condition[["operation"]]
        args <- condition[["parameters"]]
        neg <- condition[["negation"]]
        if (is.null(neg)) neg <- FALSE
        fn <- switch(op,
                     "base::match" = base::match,
                     "tidyselect::starts_with" = tidyselect::starts_with,
                     "tidyselect::ends_with" = tidyselect::ends_with,
                     "tidyselect::contains" = tidyselect::contains,
                     "tidyselect::matches" = tidyselect::matches,
                     "tidyselect::num_range" = tidyselect::num_range,
                     "tidyselect::last_col" =  tidyselect::last_col,
                     "tidyselect::where" = NULL,
                     NULL
        )
        if (op == "base::match") {
          args$table <- all_column_names
          res[[i]] <- do.call(fn, args)
        }else if (op == "tidyselect::where"){
          selected_columns <- private$data |> 
            dplyr::select(where(args$fn)) |> 
            colnames()
          res[[i]] <- which(all_column_names %in% selected_columns)
        }else{
          args$vars <- all_column_names
          res[[i]] <- do.call(fn, args)
        }
        if (neg) res[[i]] <- setdiff(1:length(all_column_names), res[[i]])
        i <- i + 1
      }
      if (and_or == "&") {
        out <- Reduce(intersect, res)
      } else if (and_or == "|") {
        out <- Reduce(union, res)
      } else {
        stop("and_or must be & or |")
      }
      return(all_column_names[out])
    },
    
    #' @description
    #' Get the column names selected by the current column selection.
    #'
    #' @param column_selection_name Character, the name of the column selection.
    #'
    #' @return Character vector, the column names selected by the current column selection.
    get_column_selected_column_names = function(column_selection_name = "") {
      if(column_selection_name != "") {
        selected_columns <- self$get_column_selection_column_names(column_selection_name)
        return(selected_columns)
      }
    },
    
    #' @description
    #' Check if a column selection is applied.
    #'
    #' @return Logical, TRUE if a column selection is applied, FALSE otherwise.
    column_selection_applied = function() {
      curr_sel <- private$.current_column_selection
      if (is.null(curr_sel) || length(curr_sel) == 0) {
        return(FALSE)
      } else return(!curr_sel[["is_everything"]])
    },
    
    #' @description
    #' Remove the current column selection.
    remove_current_column_selection = function() {
      self$set_current_column_selection(".everything")
      self$append_to_variables_metadata(self$get_column_names(), is_hidden_label, FALSE)
      private$.variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Get the fields of the variables metadata.
    #'
    #' @param as_list Logical, if TRUE, returns the fields as a list.
    #' @param include Character vector, the fields to include.
    #' @param exclude Character vector, the fields to exclude.
    #' @param excluded_items Character vector, the items to exclude.
    #'
    #' @return Character vector or list, the fields of the variables metadata.
    get_variables_metadata_fields = function(as_list = FALSE, include = c(), exclude = c(), excluded_items = c()) {
      out = names(self$get_variables_metadata())
      if(length(excluded_items) > 0){
        ex_ind = which(out %in% excluded_items)
        if(length(ex_ind) != length(excluded_items)) warning("Some of the excluded_items were not found in the list of objects")
        if(length(ex_ind) > 0) out = out[-ex_ind]
      }
      if(as_list) {
        lst = list()
        lst[[self$get_metadata(data_name_label)]] <- out
        return(lst)
      }
      else return(out)
    },
    
    #' @description
    #' Add an object to the data.
    #'
    #' @param object_name Character, the name of the object.
    #' @param object_type_label Character, the type label of the object.
    #' @param object_format Character, the format of the object.
    #' @param object Any, the object to add.
    add_object = function(object_name, object_type_label, object_format, object) {
      if(missing(object_name)){
        object_name <- instatExtras::next_default_item("object", names(private$objects))
      } 
      
      if(object_name %in% names(private$objects)){
        message("An object called ", object_name, " already exists. It will be replaced.")
      }
      
      #add the object with its metadata to the list of objects and add an "Added_object" change 
      private$objects[[object_name]] <- list(object_type_label = object_type_label, object_format = object_format, object = object)
      self$append_to_changes(list(Added_object, object_name))
    },
    
    #' @description
    #' Get the names of objects.
    #'
    #' @param object_type_label Character, the type label of the objects to get names for.
    #' @param as_list Logical, if TRUE, returns the names as a list.
    #'
    #' @return Character vector or list, the names of the objects.
    get_object_names = function(object_type_label = NULL, as_list = FALSE) {
      out <- get_data_book_output_object_names(output_object_list = private$objects, 
                                               object_type_label = object_type_label,  
                                               as_list = as_list, 
                                               list_label= self$get_metadata(data_name_label) )
      return(out)
      
    },
    
    #' @description
    #' Get objects by type label.
    #'
    #' @param object_type_label Character, the type label of the objects to get.
    #'
    #' @return List, the objects with the specified type label.
    get_objects = function(object_type_label = NULL) {
      print(object_type_label)
      out <- private$objects[self$get_object_names(object_type_label = object_type_label)]
      return(out)
    },
    
    #' @description
    #' Get a specific object by name.
    #'
    #' @param object_name Character, the name of the object.
    #'
    #' @return Any, the specified object.
    get_object = function(object_name) {
      #make sure supplied object name is a character, prevents return of unexpected object
      if(is.character(object_name) ){
        return(private$objects[[object_name]])
      }else{
        return(NULL)
      }
    },
    
    #' @description
    #' Rename an object.
    #'
    #' @param object_name Character, the current name of the object.
    #' @param new_name Character, the new name for the object.
    #' @param object_type Character, the type of the object.
    rename_object = function(object_name, new_name, object_type = "object") {
      if(!object_type %in% c("object", "filter", "calculation", "graph", "table", "model", "structure", "summary", "column_selection", "scalar")) stop(object_type, " must be either object (graph, table or model), filter, column selection, calculation or scalar.")
      
      #Temp fix:: added graph, table and model so as to distinguish this when implementing it in the dialog. Otherwise they remain as objects
      if (object_type %in% c("object", "graph", "table","model","structure","summary")){
        
        if(!object_name %in% names(private$objects)) stop(object_name, " not found in objects list")
        if(new_name %in% names(private$objects)) stop(new_name, " is already an object name. Cannot rename ", object_name, " to ", new_name)
        names(private$objects)[names(private$objects) == object_name] <- new_name
      } 
      else if (object_type == "filter"){
        if(!object_name %in% names(private$filters)) stop(object_name, " not found in filters list")
        if(new_name %in% names(private$filters)) stop(new_name, " is already a filter name. Cannot rename ", object_name, " to ", new_name)
        if("no_filter" == object_name) stop("Renaming no_filter is not allowed.")
        names(private$filters)[names(private$filters) == object_name] <- new_name
        if(private$.current_filter$name == object_name){private$.current_filter$name <- new_name}
      } 
      else if (object_type == "calculation") {
        if(!object_name %in% names(private$calculations)) stop(object_name, " not found in calculations list")
        if(new_name %in% names(private$calculations)) stop(new_name, " is already a calculation name. Cannot rename ", object_name, " to ", new_name)
        names(private$calculations)[names(private$calculations) == object_name] <- new_name
      }
      else if (object_type == "column_selection"){
        if(!object_name %in% names(private$column_selections)) stop(object_name, " not found in column selections list")
        if(new_name %in% names(private$column_selections)) stop(new_name, " is already a column selection name. Cannot rename ", object_name, " to ", new_name)
        if(".everything" == object_name) stop("Renaming .everything is not allowed.")
        names(private$column_selections)[names(private$column_selections) == object_name] <- new_name
        if(private$.current_column_selection$name == object_name){private$.current_column_selection$name <- new_name}
      } else if (object_type == "scalar") {
        if(!object_name %in% names(private$scalars)) stop(object_name, " not found in calculations list")
        if(new_name %in% names(private$scalars)) stop(new_name, " is already a calculation name. Cannot rename ", object_name, " to ", new_name)
        names(private$scalars)[names(private$scalars) == object_name] <- new_name
        self$append_to_metadata(scalar, private$scalars)
      }
    },
    
    #' @description
    #' Delete objects.
    #'
    #' @param data_name Character, the name of the data.
    #' @param object_names Character vector, the names of the objects to delete.
    #' @param object_type Character, the type of the objects to delete.
    delete_objects = function(data_name, object_names, object_type = "object") {
      if(!object_type %in% c("object", "graph", "table","model","structure","summary", "filter", "calculation", "column_selection", "scalar")) stop(object_type, " must be either object (graph, table or model), filter, column selection,  calculation or scala.")
      
      
      if(any(object_type %in% c("object", "graph", "table","model","structure","summary"))){
        
        if(!all(object_names %in% names(private$objects))) stop("Not all object_names found in overall objects list.")
        private$objects[names(private$objects) %in% object_names] <- NULL
      }else if(object_type == "filter"){
        if(!all(object_names %in% names(private$filters))) stop(object_names, " not found in filters list.")
        if("no_filter" %in% object_names) stop("no_filter cannot be deleted.")
        if(any(private$.current_filter$name %in% object_names))stop(private$.current_filter$name, " is currently in use and cannot be deleted.")
        private$filters[names(private$filters) %in% object_names] <- NULL
      }else if(object_type == "calculation"){
        if(!object_names %in% names(private$calculations)) stop(object_names, " not found in calculations list.")
        private$calculations[names(private$calculations) %in% object_names] <- NULL
      }else if(object_type == "scalar"){
        if(!object_names %in% names(private$scalars)) stop(object_names, " not found in scalars list.")
        private$scalars[names(private$scalars) %in% object_names] <- NULL
        self$append_to_metadata(scalar, private$scalars)
      }else if(object_type == "column_selection"){
        if(!all(object_names %in% names(private$column_selections))) stop(object_names, " not found in column selections list.")
        if(".everything" %in% object_names) stop(".everything cannot be deleted.")
        if(any(private$.current_column_selection$name %in% object_names))stop(private$.current_column_selection$name, " is currently in use and cannot be deleted.")
        private$column_selections[names(private$column_selections) %in% object_names] <- NULL
      }
      if(!is.null(private$.last_graph) && length(private$.last_graph) == 2 && private$.last_graph[1] == data_name && private$.last_graph[2] %in% object_names) {
        private$.last_graph <- NULL
      }
    },
    
    #' @description
    #' Reorder objects.
    #'
    #' @param new_order Character vector, the new order of the objects.
    reorder_objects = function(new_order) {
      if(length(new_order) != length(private$objects) || !setequal(new_order, names(private$objects))) stop("new_order must be a permutation of the current object names.")
      self$set_objects(private$objects[new_order])
    },
    
    #' @description
    #' Clone the data sheet.
    #'
    #' @param include_objects Logical, if TRUE, includes objects in the clone.
    #' @param include_metadata Logical, if TRUE, includes metadata in the clone.
    #' @param include_logs Logical, if TRUE, includes logs in the clone.
    #' @param include_filters Logical, if TRUE, includes filters in the clone.
    #' @param include_column_selections Logical, if TRUE, includes column selections in the clone.
    #' @param include_calculations Logical, if TRUE, includes calculations in the clone.
    #' @param include_comments Logical, if TRUE, includes comments in the clone.
    #' @param ... Additional arguments.
    #'
    #' @return DataSheet, the cloned data sheet.
    data_clone = function(include_objects = TRUE, include_metadata = TRUE, include_logs = TRUE, include_filters = TRUE, include_column_selections = TRUE, include_calculations = TRUE, include_comments = TRUE, ...) {
      if(include_objects) new_objects <- private$objects
      else new_objects <- list()
      if(include_filters) new_filters <- lapply(private$filters, function(x) x$data_clone())
      else new_filters <- list()
      if(include_column_selections) new_column_selections <- private$column_selections
      else new_column_selections <- list()
      if(include_calculations) new_calculations <- lapply(private$calculations, function(x) x$data_clone())
      else new_calculations <- list()
      if(include_comments) new_comments <- lapply(private$comments, function(x) x$data_clone())
      else new_comments <- list()
      
      ret <- DataSheet$new(data = private$data, data_name = self$get_metadata(data_name_label), filters = new_filters, column_selections = new_column_selections, objects = new_objects, calculations = new_calculations, keys = private$keys, comments = new_comments, keep_attributes = include_metadata)
      if(include_logs) ret$set_changes(private$changes)
      else ret$set_changes(list())
      if(include_filters) ret$current_filter <- self$get_current_filter()
      else {
        ret$remove_current_filter()
      }
      if(include_column_selections) ret$current_column_selection <- self$get_current_column_selection()
      else {
        ret$remove_current_column_selection()
      }
      if(!include_metadata) {
        self$clear_metadata()
        self$clear_variables_metadata()
      }
      ret$data_changed <- TRUE
      ret$metadata_changed <- TRUE
      ret$variables_metadata_changed <- TRUE
      return(ret)
    },
    
    #' @description
    #' Freeze columns in the data.
    #'
    #' @param column Character, the name of the column to freeze.
    freeze_columns = function(column) {
      self$unfreeze_columns()
      self$append_to_variables_metadata(column, is_frozen_label, TRUE)
    },
    
    #' @description
    #' Unfreeze all columns in the data.
    unfreeze_columns = function() {
      self$append_to_variables_metadata(self$get_column_names(), is_frozen_label, FALSE)
    },
    
    #' @description
    #' Add a key to the data.
    #'
    #' @param col_names Character vector, the names of the columns to use as the key.
    #' @param key_name Character, the name of the key.
    add_key = function(col_names, key_name) {
      cols <- self$get_columns_from_data(col_names, use_current_filter = FALSE)
      if(anyDuplicated(cols) > 0) {
        stop("key columns must have unique combinations")
      }
      if(self$is_key(col_names)) {
        warning("A key with these columns already exists. No action will be taken.")
      }
      else {
        if(missing(key_name)) key_name <- instatExtras::next_default_item("key", names(private$keys))
        if(key_name %in% names(private$keys)) warning("A key called", key_name, "already exists. It will be replaced.")
        private$keys[[key_name]] <- col_names
        self$append_to_variables_metadata(col_names, is_key_label, TRUE)
        if(length(private$keys) == 1) self$append_to_variables_metadata(setdiff(self$get_column_names(), col_names), is_key_label, FALSE)
        self$append_to_metadata(is_linkable, TRUE)
        self$append_to_metadata(key_label, paste(private$keys[[key_name]], collapse = ","))
        cat(paste("Key name:", key_name),
            paste("Key columns:", paste(private$keys[[key_name]], collapse = ", ")),
            sep = "\n")
      }
    },
    
    #' @description
    #' Check if columns are a key.
    #'
    #' @param col_names Character vector, the names of the columns to check.
    #'
    #' @return Logical, TRUE if the columns are a key, FALSE otherwise.
    is_key = function(col_names) {
      return(any(sapply(private$keys, function(x) setequal(col_names,x))))
    },
    
    #' @description
    #' Check if the data has a key.
    #'
    #' @return Logical, TRUE if the data has a key, FALSE otherwise.
    has_key = function() {
      return(length(private$keys) > 0)
    },
    
    #' @description
    #' Get the keys in the data.
    #'
    #' @param key_name Character, the name of the key to get.
    #'
    #' @return List, the keys in the data.
    get_keys = function(key_name) {
      if(!missing(key_name)) {
        if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
        cat(paste("Key name:", key_name),
            paste("Key columns:", paste(private$keys[[key_name]], collapse = ", ")),
            sep = "\n")
      }
      else return(private$keys)
    },
    
    #' @description
    #' Remove a key from the data.
    #'
    #' @param key_name Character, the name of the key to remove.
    remove_key = function(key_name) {
      if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
      self$append_to_variables_metadata(private$keys[[key_name]], is_key_label, FALSE)
      private$keys[[key_name]] <- NULL
      self$append_to_metadata(key_label, NULL)
      cat("Key removed:", key_name)
    },
    
    #' @description
    #' Get comments in the data.
    #'
    #' @param comment_id Character, the ID of the comment to get.
    #'
    #' @return List, the comments in the data.
    get_comments = function(comment_id) {
      if(!missing(comment_id)) {
        if(!comment_id %in% self$get_comment_ids()) stop("Could not find comment with id: ", comment_id)
        return(private$comments[[comment_id]])
      }
      else return(private$comments)
    },
    
    #' @description
    #' Remove a comment from the data.
    #'
    #' @param key_name Character, the name of the key to remove the comment from.
    remove_comment = function(key_name) {
      if(!key_name %in% names(private$keys)) stop(key_name, " not found.")
      private$keys[[key_name]] <- NULL
    },
    
    #' @description
    #' Set the structure columns in the data.
    #'
    #' @param struc_type_1 Character vector, the names of the columns for structure type 1.
    #' @param struc_type_2 Character vector, the names of the columns for structure type 2.
    #' @param struc_type_3 Character vector, the names of the columns for structure type 3.
    set_structure_columns = function(struc_type_1, struc_type_2, struc_type_3) {
      if(!all(c(struc_type_1,struc_type_2,struc_type_3) %in% self$get_column_names())) stop("Some column names not recognised.")
      if(length(intersect(struc_type_1,struc_type_2)) > 0 || length(intersect(struc_type_1,struc_type_3)) > 0 || length(intersect(struc_type_2,struc_type_3)) > 0) {
        stop("Each column can only be assign one structure type.")
      }
      if(length(struc_type_1) > 0) self$append_to_variables_metadata(struc_type_1, structure_label, structure_type_1_label)
      if(length(struc_type_2) > 0) self$append_to_variables_metadata(struc_type_2, structure_label, structure_type_2_label)
      if(length(struc_type_3) > 0) self$append_to_variables_metadata(struc_type_3, structure_label, structure_type_3_label)
      all <- union(union(struc_type_1, struc_type_2), struc_type_3)
      other <- setdiff(self$get_column_names(), all)
      self$append_to_variables_metadata(other, structure_label, NA)
    },
    
    #' @description
    #' Add dependent columns to the data.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param dependent_cols List, the dependent columns.
    add_dependent_columns = function(columns, dependent_cols) {
      for(col in columns) {
        if(self$is_variables_metadata(dependent_columns_label, col)) {
          curr_dependents <- self$get_variables_metadata(property = dependent_columns_label, column = col, direct_from_attributes = TRUE)
          for(data_frame in names(dependent_cols)) {
            if(data_frame %in% names(curr_dependents)) {
              curr_dependents[[data_frame]] <- union(curr_dependents[[data_frame]], dependent_cols[[data_frame]])
            }
            else {
              curr_dependents[[data_frame]] <- dependent_cols[[data_frame]]
            }
          }
        }
        else curr_dependents <- as.list(dependent_cols)
        self$append_to_variables_metadata(col, dependent_columns_label, curr_dependents)
      }
    },
    
    #' @description
    #' Set the colors of the columns in the data.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param colours Character vector, the colors to set.
    set_column_colours = function(columns, colours) {
      if(missing(columns)) columns <- self$get_column_names()
      if(length(columns) != length(colours)) stop("columns must be the same length as colours")
      
      for(i in 1:length(columns)) {
        self$append_to_variables_metadata(columns[i], colour_label, colours[i])
      }
      other_cols <- self$get_column_names()[!self$get_column_names() %in% columns]
      self$append_to_variables_metadata(other_cols, colour_label, -1)
    },
    
    #' @description
    #' Check if columns have colors.
    #'
    #' @param columns Character vector, the names of the columns.
    #'
    #' @return Logical, TRUE if the columns have colors, FALSE otherwise.
    has_colours = function(columns) {
      return(self$is_variables_metadata(str = colour_label))
    },
    
    #' @description
    #' Set the colors of the columns based on metadata.
    #'
    #' @param data_name Character, the name of the data.
    #' @param columns Character vector, the names of the columns.
    #' @param property Character, the property to base the colors on.
    set_column_colours_by_metadata = function(data_name, columns, property) {
      if(!missing(data_name) && missing(columns)) columns <- names(self$get_data_frame(data_name = data_name))
      if(missing(columns)) property_values <- self$get_variables_metadata(property = property)
      else property_values <- self$get_variables_metadata(property = property, column = columns)
      
      new_colours <- as.numeric(instatExtras::make_factor(property_values))
      new_colours[is.na(new_colours)] <- -1
      if(missing(columns)) self$set_column_colours(colours = new_colours)
      else self$set_column_colours(columns = columns, colours = new_colours)
    },
    
    #' @description
    #' Remove the colors from all columns.
    remove_column_colours = function() {
      if(self$is_variables_metadata(str = colour_label)) {
        self$append_to_variables_metadata(property = colour_label, new_val = -1)
      }
    },
    
    #' @description
    #' Create a graph for one variable.
    #'
    #' @param columns Character vector, the names of the columns.
    #' @param numeric Character, the geom for numeric columns.
    #' @param categorical Character, the geom for categorical columns.
    #' @param output Character, the output type ("facets", "combine", "single").
    #' @param free_scale_axis Logical, if TRUE, uses a free scale for the axis.
    #' @param ncol Numeric, the number of columns for facets.
    #' @param coord_flip Logical, if TRUE, flips the coordinates.
    #' @param ... Additional arguments for the geom functions.
    #'
    #' @return ggplot2 object, the graph.
    graph_one_variable = function(columns, numeric = "geom_boxplot", categorical = "geom_bar", output = "facets", free_scale_axis = FALSE, ncol = NULL, coord_flip = FALSE, ...) {
      if(!all(columns %in% self$get_column_names())) {
        stop("Not all columns found in the data")
      }
      if(!output %in% c("facets", "combine", "single")) {
        stop("output must be one of: facets, combine or single")
      }
      if(!numeric %in% c("box_jitter", "violin_jitter", "violin_box")) {
        numeric_geom <- match.fun(numeric)
      }
      else {
        numeric_geom <- numeric
      }
      if(categorical %in% c("pie_chart")) {
        cat_geom <- categorical
      }
      else {
        cat_geom <- match.fun(categorical)
      }
      curr_data <- self$get_data_frame()
      column_types <- c()
      for(col in columns) {
        # TODO this could be method to avoid needing to get full data frame in this method
        # Everything non numeric is treated as categorical
        if(is.numeric(curr_data[[col]])) {
          column_types <- c(column_types, "numeric")
        }
        else {
          column_types <- c(column_types, "cat")
        }
      }
      if(output == "facets") {
        if(length(unique(column_types)) > 1) {
          warning("Cannot do facets with graphs of different types. Combine graphs will be used instead.")
          output <- "combine"
        }
        else column_types <- unique(column_types)
      }
      if(output == "facets") {
        # column_types will be unique by this point
        column_types <- column_types[1]
        if(column_types == "numeric") {
          curr_geom <- numeric_geom
          curr_geom_name <- numeric
        }
        else if(column_types == "cat") {
          curr_geom <- cat_geom
          curr_geom_name <- categorical
        }
        else {
          stop("Cannot plot columns of type:", column_types[i])
        }    
        curr_data <- self$get_data_frame(stack_data = TRUE, measure.vars = columns)
        if(curr_geom_name == "geom_boxplot" || curr_geom_name == "geom_point" || curr_geom_name == "geom_violin" || curr_geom_name == "geom_jitter" || curr_geom_name == "box_jitter" || curr_geom_name == "violin_jitter" || curr_geom_name == "violin_box") {
          g <- ggplot2::ggplot(data = curr_data, mapping = aes(x = "", y = value)) + xlab("")
        }
        else {
          g <- ggplot2::ggplot(data = curr_data, mapping = aes(x = value)) + ylab("")
        }
        
        if(curr_geom_name == "box_jitter") {
          g <- g + ggplot2::geom_boxplot() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
        }
        else if(curr_geom_name == "violin_jitter") {
          g <- g + ggplot2::geom_violin() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
        }
        else if(curr_geom_name == "violin_box") {
          g <- g + ggplot2::geom_violin() + ggplot2::geom_boxplot() 
        }
        else if(curr_geom_name == "pie_chart") {
          g <- g + ggplot2::geom_bar() + ggplot2::coord_polar(theta = "x")
        }
        else {
          g <- g + curr_geom()
        }
        
        if (coord_flip) {
          g <- g + ggplot2::coord_flip()
        }   
        if(free_scale_axis) {
          g <- g + ggplot2::facet_wrap(facets = ~ variable, scales = "free", ncol = ncol)
        }
        else { 
          g <- g + ggplot2::facet_wrap(facets = ~ variable, scales = "free_x", ncol = ncol)
        }
        
        return(g)    
      }
      else {
        graphs <- list()
        i = 1
        for(column in columns) {
          if(column_types[i] == "numeric") {
            curr_geom <- numeric_geom
            curr_geom_name <- numeric
          }
          else if(column_types[i] == "cat") {
            curr_geom <- cat_geom
            curr_geom_name <- categorical
          }
          else {
            stop("Cannot plot columns of type:", column_types[i])
          }
          if(curr_geom_name == "geom_boxplot" || curr_geom_name == "geom_violin" || curr_geom_name == "geom_point" || curr_geom_name == "geom_jitter" || curr_geom_name == "box_jitter" || curr_geom_name == "violin_jitter" || curr_geom_name == "violin_box") {
            g <- ggplot2::ggplot(data = curr_data, mapping = aes_(x = "", y = as.name(column))) + xlab("")
          }
          else {
            g <- ggplot2::ggplot(data = curr_data, mapping = aes_(x = as.name(column))) + ylab("")
          }
          if (coord_flip) {
            g <- g + ggplot2::coord_flip()
          } 
          if(curr_geom_name == "box_jitter") {
            g <- g + ggplot2::geom_boxplot() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
          }
          else if(curr_geom_name == "violin_jitter") {
            g <- g + ggplot2::geom_violin() + ggplot2::geom_jitter(width = 0.2, height = 0.2)
          }
          else if(curr_geom_name == "violin_box") {
            g <- g + ggplot2::geom_violin() + ggplot2::geom_boxplot()
          }
          else if(curr_geom_name == "pie_chart") {
            g <- g + ggplot2::geom_bar() + ggplot2::coord_polar(theta = "x")
          }
          else {
            g <- g + curr_geom()
          }
          graphs[[i]] <- g
          i = i + 1
        }
        if(output == "combine") {
          return(patchwork::wrap_plots(graphs, ncol = ncol))
        }
        else {
          return(graphs)
        }
      }
    },
    
    #' @description
    #' Create a date from year, month, and day columns.
    #'
    #' @param year Character, the name of the year column.
    #' @param month Character, the name of the month column.
    #' @param day Character, the name of the day column.
    #' @param f_year Numeric vector, the year values.
    #' @param f_month Numeric vector, the month values.
    #' @param f_day Numeric vector, the day values.
    #' @param year_format Character, the format of the year.
    #' @param month_format Character, the format of the month.
    #'
    #' @return Date, the created date.
    make_date_yearmonthday = function(year, month, day, f_year, f_month, f_day, year_format = "%Y", month_format = "%m") {
      if(!missing(year)) year_col <- self$get_columns_from_data(year, use_current_filter = FALSE)
      else if(!missing(f_year)) year_col <- f_year
      else stop("One of year or f_year must be specified.")
      if(!missing(month)) month_col <- self$get_columns_from_data(month, use_current_filter = FALSE)
      else if(!missing(f_month)) month_col <- f_month
      else stop("One of month or f_month must be specified.")
      if(!missing(day)) day_col <- self$get_columns_from_data(day, use_current_filter = FALSE)
      else if(!missing(f_day)) day_col <- f_day
      else stop("One of day or f_day must be specified.")
      
      if(missing(year_format)) {
        year_counts <- stringr::str_count(year_col)
        if(length(unique(year_counts)) > 1) stop("Year column has inconsistent year formats")
        else {
          year_length <- year_counts[1]
          if(year_length == 2) year_format = "%y"
          else if(year_length == 4) year_format = "%Y"
          else stop("Cannot detect year format with ", year_length, " digits.")
        }
      }
      if(missing(month_format)) {
        if(all(month_col %in% 1:12)) month_format = "%m"
        else if(all(month_col %in% month.abb)) month_format = "%b"
        else if(all(month_col %in% month.name)) month_format = "%B"
        else stop("Cannot detect month format")
      }
      return(as.Date(paste(year_col, month_col, day_col), format = paste(year_format, month_format, "%d")))
    },
    
    #' @description
    #' Create a date from year and day-of-year columns.
    #'
    #' @param year Character, the name of the year column.
    #' @param doy Character, the name of the day-of-year column.
    #' @param base Numeric, the base year.
    #' @param doy_typical_length Character, the typical length of the day-of-year ("365" or "366").
    #'
    #' @return Date, the created date.
    make_date_yeardoy = function(year, doy, base, doy_typical_length = "366") {
      if(!missing(year)) year_col <- self$get_columns_from_data(year, use_current_filter = FALSE)
      if(!missing(doy)) doy_col <- self$get_columns_from_data(doy, use_current_filter = FALSE)
      
      year_counts <- stringr::str_count(year_col)
      year_length <- year_counts[1]
      if(year_length == 2){
        if(missing(base)) stop("Base must be specified.")
        year_col <- dplyr::if_else(year_col <= base, year_col + 2000, year_col + 1900)
      }
      if(doy_typical_length == "366") {
        if(is.factor(year_col)) {
          year_col <- as.numeric(levels(year_col))[year_col]
        }
        #Replacing day 60 with 0 for non-leap years.This will result into NA dates
        doy_col[(!lubridate::leap_year(year_col)) & doy_col == 60] <- 0
        doy_col[(!lubridate::leap_year(year_col)) & doy_col > 60] <- doy_col[(!lubridate::leap_year(year_col)) & doy_col > 60] - 1
      }
      return(temp_date <- as.Date(paste(as.character(year_col), "-", doy_col), format = "%Y - %j"))
    },
    
    #' @description
    #' Set the contrasts for a specified factor column.
    #'
    #' @param col_name Character, the name of the factor column.
    #' @param new_contrasts Character or matrix, the type of contrasts to set or a user-defined contrast matrix.
    #' @param defined_contr_matrix Matrix, the user-defined contrast matrix if `new_contrasts` is "user_defined".
    #'
    #' @return None.
    set_contrasts_of_factor = function(col_name, new_contrasts, defined_contr_matrix) {
      if(!col_name %in% self$get_column_names()) stop(col_name, " not found in the data")
      if(!is.factor(self$get_columns_from_data(col_name))) stop(factor, " is not a factor column.")
      factor_col <- self$get_columns_from_data(col_name)
      contr_col <- nlevels(factor_col) - 1
      contr_row <- nlevels(factor_col)
      cat("Factor", col_name, "has", new_contrasts, "contrasts")
      if(new_contrasts == "user_defined") {
        if(any(is.na(defined_contr_matrix)) ||!is.numeric(defined_contr_matrix) ||nrow(defined_contr_matrix) != contr_row || ncol(defined_contr_matrix) != contr_col) stop("The contrast matrix should have ", contr_col, " column(s) and ",  contr_row, " row(s) ")
      }
      if(!(new_contrasts %in% c("contr.treatment", "contr.helmert", "contr.poly", "contr.sum", "user_defined"))) {
        stop(new_contrasts, " is not a valid contrast name")
      }
      else if(!is.character(new_contrasts)) {
        stop("New column name must be of type: character")
      }
      if(new_contrasts == "user_defined") new_contrasts <- defined_contr_matrix
      contrasts(private$data[[col_name]]) <- new_contrasts
    },
    
    #' @description
    #' Split a date column into various components like year, month, day, etc., and create corresponding new columns.
    #'
    #' @param col_name Character, the name of the date column.
    #' @param year_val Logical, whether to create a year column.
    #' @param year_name Logical, whether to create a year name column.
    #' @param leap_year Logical, whether to create a leap year column.
    #' @param month_val Logical, whether to create a month value column.
    #' @param month_abbr Logical, whether to create a month abbreviation column.
    #' @param month_name Logical, whether to create a month name column.
    #' @param week_val Logical, whether to create a week value column.
    #' @param week_abbr Logical, whether to create a week abbreviation column.
    #' @param week_name Logical, whether to create a week name column.
    #' @param weekday_val Logical, whether to create a weekday value column.
    #' @param weekday_abbr Logical, whether to create a weekday abbreviation column.
    #' @param weekday_name Logical, whether to create a weekday name column.
    #' @param day Logical, whether to create a day column.
    #' @param day_in_month Logical, whether to create a day in month column.
    #' @param day_in_year Logical, whether to create a day in year column.
    #' @param day_in_year_366 Logical, whether to create a day in year (366 days) column.
    #' @param pentad_val Logical, whether to create a pentad value column.
    #' @param pentad_abbr Logical, whether to create a pentad abbreviation column.
    #' @param dekad_val Logical, whether to create a dekad value column.
    #' @param dekad_abbr Logical, whether to create a dekad abbreviation column.
    #' @param quarter_val Logical, whether to create a quarter value column.
    #' @param quarter_abbr Logical, whether to create a quarter abbreviation column.
    #' @param with_year Logical, whether to include the year in quarter calculation.
    #' @param s_start_month Numeric, the starting month for shifted year calculation.
    #' @param s_start_day_in_month Numeric, the starting day in month for shifted year calculation.
    #' @param days_in_month Logical, whether to create a days in month column.
    #'
    #' @return None.
    split_date = function(col_name = "", year_val = FALSE, year_name = FALSE, leap_year = FALSE,  month_val = FALSE, month_abbr = FALSE, month_name = FALSE, week_val = FALSE, week_abbr = FALSE, week_name = FALSE,  weekday_val = FALSE, weekday_abbr = FALSE, weekday_name = FALSE,  day = FALSE, day_in_month = FALSE, day_in_year = FALSE, day_in_year_366 = FALSE, pentad_val = FALSE, pentad_abbr = FALSE,  dekad_val = FALSE, dekad_abbr = FALSE, quarter_val = FALSE, quarter_abbr = FALSE, with_year = FALSE, s_start_month = 1, s_start_day_in_month = 1, days_in_month = FALSE) {
      col_data <- self$get_columns_from_data(col_name, use_current_filter = FALSE)
      adjacent_column <- col_name
      if(!lubridate::is.Date(col_data)) stop("This column must be a date or time!")
      s_shift <- s_start_day_in_month > 1 || s_start_month > 1
      is_climatic <- self$is_climatic_data()
      
      if(s_shift) {
        if(s_start_month %% 1 != 0 || s_start_month < 1 || s_start_month > 12) stop("shift_start_month must be an integer between 1 and 12. ", s_start_month, " is invalid.")
        if(s_start_day_in_month %% 1 != 0 || s_start_day_in_month < 1 || s_start_day_in_month > 31) stop("shift_start_day_in_month must be an integer between 1 and 31. ", s_start_day_in_month, " is invalid.")
        s_start_day <- lubridate::yday(as.Date(paste("2000", s_start_month, s_start_day_in_month), format = "%Y %m %d"))
        if(is.na(s_start_day)) stop("Could not identify starting day for shift year with shift_start_month = ", s_start_month, " and shift_start_day = ", s_start_day_in_month)
        if(s_start_day %% 1 != 0 || s_start_day < 2 || s_start_day > 366) stop("shift_start_day must be an integer between 2 and 366")
        doy_col <- as.integer(instatExtras::yday_366(col_data))
        year_col <- lubridate::year(col_data)
        temp_s_doy <- doy_col - s_start_day + 1
        temp_s_year <- year_col
        temp_s_year[temp_s_doy < 1] <- paste(year_col[temp_s_doy < 1] - 1, year_col[temp_s_doy < 1], sep = "-")
        temp_s_year[temp_s_doy > 0] <- paste(year_col[temp_s_doy > 0], year_col[temp_s_doy > 0] + 1, sep = "-")
        temp_s_year <- instatExtras::make_factor(temp_s_year)
        temp_s_year_num <- as.numeric(substr(temp_s_year, 1, 4))
        temp_s_doy[temp_s_doy < 1] <- temp_s_doy[temp_s_doy < 1] + 366
        s_year_labs <- c(min(year_col) -1, sort(unique(year_col)))
        names(s_year_labs) <- paste(s_year_labs, s_year_labs + 1, sep = "-")
      }
      else s_start_day <- 1
      
      if(weekday_name) {
        weekday_name_vector <- lubridate::wday(col_data, label = TRUE, abbr = FALSE)
        col_name <- instatExtras::next_default_item(prefix = "weekday_name", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = weekday_name_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(weekday_abbr) {
        weekday_abbr_vector <- lubridate::wday(col_data, label = TRUE)
        col_name <- instatExtras::next_default_item(prefix = "weekday_abbr", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = weekday_abbr_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(weekday_val) {
        weekday_val_vector <- lubridate::wday(col_data)
        col_name <- instatExtras::next_default_item(prefix = "weekday_val", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = weekday_val_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(week_val) {
        week_Val_vector <- lubridate::week(col_data)
        col_name <- instatExtras::next_default_item(prefix = "week_val", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = week_Val_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(pentad_abbr) {
        month_abbr_vector <-forcats::fct_shift(f = (lubridate::month(col_data, label = TRUE)), n = (s_start_month - 1))
        pentad_val_vector <- ((as.integer(instatExtras::pentad(col_data))) - (s_start_month - 1)*6) %% 6
        pentad_val_vector <- ifelse(pentad_val_vector == 0, 6, pentad_val_vector)
        month.list <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
        month_levels <- if (s_start_month == 1) month.list else c(tail(month.list, -s_start_month + 1), head(month.list, s_start_month - 1))
        pentad_levels <- paste0(rep(month_levels, each = 6), 1:6)
        pentad_abbr_vector <- factor(paste(month_abbr_vector, pentad_val_vector, sep = ""), levels = pentad_levels)
        col_name <- instatExtras::next_default_item(prefix = "pentad_abbr", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = pentad_abbr_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(pentad_val) {
        pentad_val_vector <- ((as.integer(instatExtras::pentad(col_data))) - (s_start_month - 1)*6) %% 72
        pentad_val_vector <- ifelse(pentad_val_vector == 0, 72, pentad_val_vector)
        col_name <- instatExtras::next_default_item(prefix = "pentad", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = pentad_val_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(dekad_abbr) {
        month_abbr_vector <- instatExtras::make_factor(forcats::fct_shift(f = (lubridate::month(col_data, label = TRUE)), n = (s_start_month - 1)), ordered = FALSE)
        dekad_val_vector <- ((as.numeric(instatExtras::dekade(col_data))) - (s_start_month - 1)*3) %% 3
        dekad_val_vector <- ifelse(dekad_val_vector == 0, 3, dekad_val_vector)
        month.list <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
        month_levels <- if (s_start_month == 1) month.list else c(tail(month.list, -s_start_month + 1), head(month.list, s_start_month - 1))
        dekad_levels <- paste0(rep(month_levels, each = 3), 1:3)
        dekad_abbr_vector <- factor(paste(month_abbr_vector, dekad_val_vector, sep = ""), levels = dekad_levels)
        col_name <- instatExtras::next_default_item(prefix = "dekad_abbr", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = dekad_abbr_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(dekad_val) {
        dekad_val_vector <- ((as.numeric(instatExtras::dekade(col_data))) - (s_start_month - 1)*3) %% 36
        dekad_val_vector <- ifelse(dekad_val_vector == 0, 36, dekad_val_vector)
        col_name <- instatExtras::next_default_item(prefix = "dekad", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = dekad_val_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(quarter_abbr){
        if(s_shift) {
          s_quarter_val_vector <- lubridate::quarter(col_data, with_year = with_year, fiscal_start = s_start_month)
          quarter_labels <- instatExtras::get_quarter_label(s_quarter_val_vector, s_start_month)
          col_name <- instatExtras::next_default_item(prefix = "s_quarter", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = quarter_labels, adjacent_column = adjacent_column, before = FALSE)
          self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted quarter starting on day", s_start_day))
        } 
        else {
          quarter_val_vector <- lubridate::quarter(col_data, with_year = with_year)
          quarter_labels <- instatExtras::get_quarter_label(quarter_val_vector, s_start_month)
          col_name <- instatExtras::next_default_item(prefix = "quarter_abbr", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = quarter_labels, adjacent_column = adjacent_column, before = FALSE)
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(quarter_val) {
        if(s_shift) {
          s_quarter_val_vector <- lubridate::quarter(col_data, with_year = with_year, fiscal_start = s_start_month)
          col_name <- instatExtras::next_default_item(prefix = "s_quarter", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = s_quarter_val_vector, adjacent_column = adjacent_column, before = FALSE)
          self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted quarter starting on day", s_start_day))
        } 
        else {
          quarter_val_vector <- lubridate::quarter(col_data, with_year = with_year)
          col_name <- instatExtras::next_default_item(prefix = "quarter", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = quarter_val_vector, adjacent_column = adjacent_column, before = FALSE)
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(day_in_year) {
        day_in_year_vector <- lubridate::yday(col_data) - s_start_day + 1 + (!lubridate::leap_year(col_data) & s_start_day > 59)
        day_in_year_vector <- dplyr::if_else(lubridate::leap_year(col_data), day_in_year_vector %% 366, day_in_year_vector %% 365)
        day_in_year_vector <- dplyr::if_else(day_in_year_vector == 0, dplyr::if_else(lubridate::leap_year(col_data), 366, 365), day_in_year_vector)
        col_name <- instatExtras::next_default_item(prefix = "doy_365", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = day_in_year_vector, adjacent_column = adjacent_column, before = FALSE)
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
        if(s_shift) self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted year starting on day", s_start_day))
      }
      if(day_in_year_366) {
        if(s_shift) {
          col_name <- instatExtras::next_default_item(prefix = "s_doy", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = temp_s_doy, adjacent_column = adjacent_column, before = FALSE)
          self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted day of year starting on day", s_start_day))
        }
        else {
          day_in_year_366_vector <- as.integer(instatExtras::yday_366(col_data))
          col_name <- instatExtras::next_default_item(prefix = "doy", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = day_in_year_366_vector, adjacent_column = adjacent_column, before = FALSE)
        }
        if(is_climatic && is.null(self$get_climatic_column_name(doy_label))) {
          self$append_climatic_types(types = c(doy = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(days_in_month) {
        days_in_month_vector <- as.numeric(lubridate::days_in_month(col_data))
        col_name <- instatExtras::next_default_item(prefix = "days_in_month", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = days_in_month_vector, adjacent_column = adjacent_column, before = FALSE)
      }
      if(day_in_month) {
        day_in_month_vector <- as.numeric(lubridate::mday(col_data))
        col_name <- instatExtras::next_default_item(prefix = "day_in_month", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = day_in_month_vector, adjacent_column = adjacent_column, before = FALSE)
        if(is_climatic && is.null(self$get_climatic_column_name(day_label))) {
          self$append_climatic_types(types = c(day = col_name))
        }
      }
      if(month_val) {
        month_val_vector <- (lubridate::month(col_data) - (s_start_month - 1)) %% 12
        month_val_vector <- ifelse(month_val_vector == 0, 12, month_val_vector)
        col_name <- instatExtras::next_default_item(prefix = "month_val", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = month_val_vector, adjacent_column = adjacent_column, before = FALSE)
        if(s_shift) self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted month starting on day", s_start_day))
        if(is_climatic && is.null(self$get_climatic_column_name(month_label))) {
          self$append_climatic_types(types = c(month = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(month_abbr) {
        month_abbr_vector <- instatExtras::make_factor(forcats::fct_shift(f = lubridate::month(col_data, label = TRUE), n = s_start_month - 1), ordered = FALSE)
        col_name <- instatExtras::next_default_item(prefix = "month_abbr", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = month_abbr_vector, adjacent_column = adjacent_column, before = FALSE)
        if(s_shift) self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted month starting on day", s_start_day))
        if(is_climatic && is.null(self$get_climatic_column_name(month_label))) {
          self$append_climatic_types(types = c(month = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(month_name) { 
        month_name_vector <- forcats::fct_shift(f = lubridate::month(col_data, label = TRUE, abbr = FALSE), n = s_start_month - 1)
        col_name <- instatExtras::next_default_item(prefix = "month_name", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = month_name_vector, adjacent_column = adjacent_column, before = FALSE)
        if(s_shift) self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted month starting on day", s_start_day))
        if(is_climatic && is.null(self$get_climatic_column_name(month_label))) {
          self$append_climatic_types(types = c(month = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(year_name) {
        if(s_shift) {
          col_name <- instatExtras::next_default_item(prefix = "s_year", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = temp_s_year, adjacent_column = adjacent_column, before = FALSE)
          self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted year starting on day", s_start_day))
          new_labels <- sort(unique(temp_s_year_num))
          names(new_labels) <- sort(unique(temp_s_year))
          self$append_to_variables_metadata(col_names = col_name, property = labels_label, new_val = new_labels)
        }
        else {
          year_vector <- lubridate::year(col_data)
          col_name <- instatExtras::next_default_item(prefix = "year", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = instatExtras::make_factor(year_vector), adjacent_column = adjacent_column, before = FALSE)
        }
        if(is_climatic && is.null(self$get_climatic_column_name(year_label))) {
          self$append_climatic_types(types = c(year = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(year_val) {
        if(s_shift) {
          col_name <- instatExtras::next_default_item(prefix = "s_year", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = temp_s_year_num, adjacent_column = adjacent_column, before = FALSE)
          self$append_to_variables_metadata(col_names = col_name, property = label_label, new_val = paste("Shifted year starting on day", s_start_day))
        }
        else {
          year_vector <- lubridate::year(col_data)
          col_name <- instatExtras::next_default_item(prefix = "year", existing_names = self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name = col_name, col_data = year_vector, adjacent_column = adjacent_column, before = FALSE)
        }
        if(is_climatic && is.null(self$get_climatic_column_name(year_label))) {
          self$append_climatic_types(types = c(year = col_name))
        }
        self$append_to_variables_metadata(col_names = col_name, property = doy_start_label, new_val = s_start_day)
      }
      if(leap_year) {
        leap_year_vector <- lubridate::leap_year(col_data)
        col_name <- instatExtras::next_default_item(prefix = "leap_year", existing_names = self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(col_name = col_name, col_data = leap_year_vector, adjacent_column = adjacent_column, before = FALSE)
      }
    },
    
    #' @description
    #' Set the climatic types for columns in the data.
    #'
    #' @param types Named character vector, a named vector where names are climatic types and values are the corresponding column names in the dataset.
    #'
    #' @return None.
    set_climatic_types = function(types) {
      self$append_to_variables_metadata(property = climatic_type_label, new_val = NULL)
      if(!all(names(types) %in% all_climatic_column_types)) stop("Cannot recognise the following climatic types: ", paste(names(types)[!names(types) %in% all_climatic_column_types], collapse = ", "))
      invisible(sapply(names(types), function(name) self$append_to_variables_metadata(types[name], climatic_type_label, name)))
      element_cols <- types[is_climatic_element(names(types))]
      other_cols <- setdiff(self$get_column_names(), element_cols)
      self$append_to_variables_metadata(element_cols, is_element_label, TRUE)
      self$append_to_variables_metadata(other_cols, is_element_label, FALSE)
      
      types <- types[sort(names(types))]
      cat("Climatic dataset:", self$get_metadata(data_name_label), "\n")
      cat("----------------\n")
      cat("Definition", "\n")
      cat("----------------\n")
      for(i in seq_along(types)) {
        cat(names(types)[i], ": ", types[i], "\n", sep = "")
      }
    },
    
    #' @description
    #' Append climatic types to columns in the data.
    #'
    #' @param types Named character vector, a named vector where names are climatic types and values are the corresponding column names in the dataset.
    #'
    #' @return None.
    append_climatic_types = function(types) {
      if(!all(names(types) %in% all_climatic_column_types)) stop("Cannot recognise the following climatic types: ", paste(names(types)[!names(types) %in% all_climatic_column_types], collapse = ", "))
      for(i in seq_along(types)) {
        col <- self$get_climatic_column_name(names(types)[i])
        if(!is.null(col)) self$append_to_variables_metadata(col, climatic_type_label, NULL)
      }
      invisible(sapply(names(types), function(name) self$append_to_variables_metadata(types[name], climatic_type_label, name)))
      cat("Climatic dataset:", self$get_metadata(data_name_label), "\n")
      cat("----------------\n")
      cat("Update", "\n")
      cat("----------------\n")
      for(i in seq_along(types)) {
        cat(names(types)[i], ": ", types[i], "\n", sep = "")
      }
    },
    
    #' @description
    #' Create an inventory plot for a dataset.
    #'
    #' @param date_col Character, the name of the date column.
    #' @param station_col Character, the name of the station column. Default is NULL.
    #' @param year_col Character, the name of the year column. Default is NULL.
    #' @param doy_col Character, the name of the day of year column. Default is NULL.
    #' @param element_cols Character vector, the names of the element columns.
    #' @param add_to_data Logical, whether to add the plot to the data. Default is FALSE.
    #' @param year_doy_plot Logical, whether to plot year vs. day of year. Default is FALSE.
    #' @param coord_flip Logical, whether to flip coordinates. Default is FALSE.
    #' @param facet_by Character, the faceting method. Default is NULL.
    #' @param facet_xsize Numeric, the size of facet x-axis labels. Default is 9.
    #' @param facet_ysize Numeric, the size of facet y-axis labels. Default is 9.
    #' @param facet_xangle Numeric, the angle of facet x-axis labels. Default is 90.
    #' @param facet_yangle Numeric, the angle of facet y-axis labels. Default is 90.
    #' @param graph_title Character, the title of the plot. Default is "Inventory Plot".
    #' @param graph_subtitle Character, the subtitle of the plot. Default is NULL.
    #' @param graph_caption Character, the caption of the plot. Default is NULL.
    #' @param title_size Numeric, the size of the plot title. Default is NULL.
    #' @param subtitle_size Numeric, the size of the plot subtitle. Default is NULL.
    #' @param caption_size Numeric, the size of the plot caption. Default is NULL.
    #' @param labelXAxis Character, the label for the x-axis.
    #' @param labelYAxis Character, the label for the y-axis.
    #' @param xSize Numeric, the size of the x-axis labels. Default is NULL.
    #' @param ySize Numeric, the size of the y-axis labels. Default is NULL.
    #' @param Xangle Numeric, the angle of the x-axis labels. Default is NULL.
    #' @param Yangle Numeric, the angle of the y-axis labels. Default is NULL.
    #' @param scale_xdate Logical, whether to scale the x-axis as dates. Default is NULL.
    #' @param fromXAxis Date, the starting date for the x-axis scale. Default is NULL.
    #' @param toXAxis Date, the ending date for the x-axis scale. Default is NULL.
    #' @param byXaxis Character, the interval for the x-axis scale. Default is NULL.
    #' @param date_ylabels Character, the labels for the y-axis if scaled as dates. Default is NULL.
    #' @param legend_position Character, the position of the legend. Default is NULL.
    #' @param xlabelsize Numeric, the size of the x-axis label. Default is NULL.
    #' @param ylabelsize Numeric, the size of the y-axis label. Default is NULL.
    #' @param scale Character, the scale for faceting. Default is NULL.
    #' @param dir Character, the direction for faceting. Default is "".
    #' @param row_col_number Numeric, the number of rows or columns for faceting. Default is NULL.
    #' @param nrow Numeric, the number of rows for faceting. Default is NULL.
    #' @param ncol Numeric, the number of columns for faceting. Default is NULL.
    #' @param scale_ydate Logical, whether to scale the y-axis as dates. Default is FALSE.
    #' @param date_ybreaks Character, the breaks for the y-axis if scaled as dates. Default is NULL.
    #' @param step Numeric, the step size for date breaks. Default is 1.
    #' @param key_colours Character vector, the colours for the key. Default is c("red", "grey").
    #' @param display_rain_days Logical, whether to display rain days in the plot. Default is FALSE.
    #' @param rain_cats List, the categories for rain days, including breaks, labels, and key colours. Default is list(breaks = c(0, 0.85, Inf), labels = c("Dry", "Rain"), key_colours = c("tan3", "blue")).
    #'
    #' @return ggplot object, the inventory plot.
    make_inventory_plot = function(date_col, station_col = NULL, year_col = NULL, doy_col = NULL, element_cols = NULL, add_to_data = FALSE,
                                    year_doy_plot = FALSE, coord_flip = FALSE, facet_by = NULL, facet_xsize = 9, facet_ysize = 9, facet_xangle = 90,
                                    facet_yangle = 90, graph_title = "Inventory Plot", graph_subtitle = NULL, graph_caption = NULL, title_size = NULL, 
                                    subtitle_size = NULL, caption_size = NULL, labelXAxis, labelYAxis, xSize = NULL, ySize = NULL,
                                    Xangle = NULL, Yangle = NULL, scale_xdate, fromXAxis = NULL, toXAxis = NULL, byXaxis = NULL, date_ylabels, 
                                    legend_position = NULL, xlabelsize = NULL, ylabelsize = NULL, scale = NULL, dir = "", row_col_number,
                                    nrow = NULL, ncol = NULL, scale_ydate = FALSE, date_ybreaks, step = 1, key_colours = c("red", "grey"), 
                                    display_rain_days = FALSE, rain_cats = list(breaks = c(0, 0.85, Inf), labels = c("Dry", "Rain"), 
                                                                                key_colours = c("tan3", "blue"))) {
      if(missing(date_col)) stop("Date columns must be specified.")
      if(missing(element_cols)) stop("Element column(s) must be specified.")
      if(!lubridate::is.Date(self$get_columns_from_data(date_col))) stop(paste(date_col, " must be of type Date."))
      
      if(!all(element_cols %in% self$get_column_names())) {
        stop("Not all elements columns found in the data")
      }
      
      is_climatic <- self$is_climatic_data()
      
      if(year_doy_plot) {
        if(is.null(year_col)) {
          if(is_climatic) {
            if(is.null(self$get_climatic_column_name(year_label))) {
              self$split_date(col_name = date_col, year_val = TRUE)
            }
            year_col <- self$get_climatic_column_name(year_label)
          }
          else {
            self$split_date(col_name = date_col, year_val = TRUE)
            col_names <- self$get_column_names()
            year_col <- col_names[length(col_names)]
          }
        }
        if(is.null(doy_col)) {
          if(is_climatic) {
            if(is.null(self$get_climatic_column_name(doy_label))) {
              self$split_date(col_name = date_col, day_in_year_366 = TRUE)
            }
            doy_col <- self$get_climatic_column_name(doy_label)
          }
          else {
            self$split_date(col_name = date_col, day_in_year_366 = TRUE)
            col_names <- self$get_column_names()
            doy_col <- col_names[length(col_names)]
          }
        }
      }
      
      blank_y_axis <- ggplot2::theme(axis.text.y = ggplot2::element_blank(), axis.ticks.y = ggplot2::element_blank(), axis.line.y = ggplot2::element_blank())
      if(length(element_cols) == 1) {
        curr_data <- self$get_data_frame()
        elements <- curr_data[[element_cols]]
      }
      else {
        if(!is.null(station_col)) {
          curr_data <- self$get_data_frame(stack_data = TRUE, measure.vars = element_cols, id.vars=c(date_col, station_col, year_col, doy_col))
        }
        else {
          curr_data <- self$get_data_frame(stack_data = TRUE, measure.vars = element_cols, id.vars=c(date_col, year_col, doy_col))
        }
        elements <- curr_data[["value"]]
      }
      
      key_name <- instatExtras::next_default_item(prefix = "key", existing_names = names(curr_data), include_index = FALSE)
      curr_data[[key_name]] <- factor(ifelse(is.na(elements), "Missing", "Present"), levels = c("Present", "Missing"))
      
      key <- c(key_colours)
      names(key) <- c("Missing", "Present")
      if(display_rain_days) {
        levels(curr_data[[key_name]]) <- c(levels(curr_data[[key_name]]), rain_cats$labels)
        if(is_climatic) {
          rain_col <- self$get_climatic_column_name(rain_label)
        }
        else {
          warning("Cannot determine rain column automatically. Taking first element specified as the rain column.")
          rain_col <- element_cols[1]
        }
        if(!is.null(rain_col) && rain_col %in% element_cols) {
          if(length(element_cols) > 1) {
            curr_data[[key_name]][curr_data[["variable"]] == rain_col & curr_data[[key_name]] != "Missing"] <- cut(curr_data[["value"]][curr_data[["variable"]] == rain_col & curr_data[[key_name]] != "Missing"], breaks = rain_cats$breaks, labels = rain_cats$labels, right = FALSE)
            key <- c(key_colours, rain_cats$key_colours)
            names(key) <- c("Missing", "Present",rain_cats$labels)
          }
          else {
            curr_data[[key_name]][curr_data[[key_name]] != "Missing"] <- cut(curr_data[[rain_col]][curr_data[[key_name]] != "Missing"], breaks = rain_cats$breaks, labels = rain_cats$labels, right = FALSE)
            key <- c(key_colours[1], rain_cats$key_colours)
            names(key) <- c("Missing", rain_cats$labels)
          }
        }
      }
      if(year_doy_plot) {
        curr_data[["common_date"]] <- as.Date(paste0("2000-", curr_data[[doy_col]]), "%Y-%j")
        g <- ggplot2::ggplot(data = curr_data, mapping = ggplot2::aes_(x = as.name(year_col), y = as.name("common_date"), colour = as.name(key_name))) + ggplot2::geom_point(size=5, shape=15) + ggplot2::scale_colour_manual(values = key) + ggplot2::scale_y_date(date_breaks = "2 month", labels = function(x) format(x, "%e %b"))
        if(!is.null(station_col) && length(element_cols) > 1) {
          if(is.null(facet_by)) {
            message("facet_by not specified. facets will be by stations-elements.")
            facet_by <- "stations-elements"
          }
          else if(facet_by == "stations") {
            warning("facet_by = stations. facet_by must be either stations-elements or elements-stations when there are multiple of both. Using stations-elements.")
            facet_by <- "stations-elements"
          }
          else if(facet_by == "elements") {
            warning("facet_by = elements. facet_by must be either stations-elements or elements-stations when there are multiple of both. Using elements-stations.")
            facet_by <- "elements-stations"
          }
          
          if(facet_by == "stations-elements") {
            if(!missing(row_col_number)){
              g <- g + ggplot2::facet_wrap(facets = as.formula(paste(".~",station_col, "+ variable")), nrow = nrow, ncol = ncol, scales = scale, dir = dir)
            }else {g <- g + ggplot2::facet_grid(facets = as.formula(paste(station_col, "~variable")))}
          }
          else if(facet_by == "elements-stations") {
            if(!missing(row_col_number)){
              g <- g + ggplot2::facet_wrap(facets = as.formula(paste(".~variable +",station_col)), nrow = nrow, ncol = ncol, scales = scale, dir = dir)
            }else {g <- g + ggplot2::facet_grid(facets = as.formula(paste("variable~",station_col)))}
          }
          else stop("invalid facet_by value:", facet_by)
        }
        else if(!is.null(station_col)) {
          g <- g + ggplot2::facet_grid(facets = as.formula(paste(station_col, "~.")))
          if(graph_title == "Inventory Plot") {
            graph_title <- paste0(graph_title, ": ", element_cols)
          }
        }
        else if(length(element_cols) > 1) {
          if(!missing(row_col_number)){
            g <- g + ggplot2::facet_wrap(.~variable, nrow = nrow, ncol = ncol, scales = scale, dir = dir)
          }else {g <- g + ggplot2::facet_grid(facets = variable~.)}
          
        }
        if(!missing(scale_xdate)){ g <- g + ggplot2::scale_x_continuous(breaks=seq(fromXAxis, toXAxis, byXaxis)) } 
        if(scale_ydate && !missing(date_ybreaks) && !missing(date_ylabels)){ g <- g + ggplot2::scale_y_date(breaks = seq(min(curr_data[["common_date"]]), max(curr_data[["common_date"]]), by = paste0(step," ",date_ybreaks)), date_labels = date_ylabels) } 
      }
      else {
        g <- ggplot2::ggplot(data = curr_data, ggplot2::aes_(x = as.name(date_col), y = 1, fill = as.name(key_name))) + ggplot2::geom_raster() + ggplot2::scale_fill_manual(values = key) + ggplot2::scale_x_date(date_minor_breaks = "1 year")
        if(!is.null(station_col) && length(element_cols) > 1) {
          if(is.null(facet_by) || facet_by == "stations") {
            if(is.null(facet_by)) message("facet_by not specified. facets will be by stations.")
            if(!missing(row_col_number)){
              g <- g + ggplot2::facet_wrap(facets = as.formula(paste(station_col, "+ variable~.")), nrow = nrow, ncol = ncol, scales = scale, dir = dir) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
            }
            else{
              g <- g + ggplot2::facet_grid(facets = as.formula(paste(station_col, "+ variable~."))) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
            }
          }
          else if(facet_by == "elements") {
            if(!missing(row_col_number)){
              g <- g + ggplot2::facet_wrap(facets = as.formula(paste("variable +", station_col, "~.")), nrow = nrow, ncol = ncol, scales = scale, dir = dir) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
            }else{
              g <- g + ggplot2::facet_grid(facets = as.formula(paste("variable +", station_col, "~."))) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
            }
          }
          else if(facet_by == "stations-elements") {
            if(!missing(row_col_number)){
              g <- g + ggplot2::facet_wrap(facets = as.formula(paste(".~",station_col, "+ variable")), nrow = nrow, ncol = ncol, scales = scale, dir = dir) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
              
            }
            else{
              g <- g + ggplot2::facet_grid(facets = as.formula(paste(station_col, "~variable"))) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
              
            }
          }
          else if(facet_by == "elements-stations") {
            if(!missing(row_col_number)){
              g <- g +  ggplot2::facet_wrap(facets = as.formula(paste(".~variable +",station_col)), nrow = nrow, ncol = ncol, scales = scale, dir = dir) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
              
            }
            else{
              g <- g + ggplot2::facet_grid(facets = as.formula(paste("variable~", station_col))) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = NULL)
              
            }
          }
          else stop("invalid facet_by value:", facet_by)
        }
        else if(!is.null(station_col)) {
          if(!is.factor(curr_data[[station_col]])) curr_data[[station_col]] <- factor(curr_data[[station_col]])
          g <- ggplot2::ggplot(data = curr_data, ggplot2::aes_(x = as.name(date_col), y = as.name(station_col), fill = as.name(key_name))) + ggplot2::geom_raster() + ggplot2::scale_fill_manual(values = key) + ggplot2::scale_x_date(date_minor_breaks = "1 year") + ggplot2::geom_hline(yintercept = seq(0.5, by = 1, length.out = length(levels(curr_data[[station_col]])) + 1))
          if(graph_title == "Inventory Plot") {
            graph_title <- paste0(graph_title, ": ", element_cols)
          }
        }
        else if(length(element_cols) > 1) {
          g <- ggplot2::ggplot(data = curr_data, ggplot2::aes_(x = as.name(date_col), y = as.name("variable"), fill = as.name(key_name))) + ggplot2::geom_raster() + ggplot2::scale_fill_manual(values = key) + ggplot2::scale_x_date(date_minor_breaks = "1 year") + ggplot2::geom_hline(yintercept = seq(0.5, by = 1, length.out = length(levels(curr_data[["variable"]])) + 1)) + ggplot2::labs(y = "Elements")
        }
        else {
          g <- ggplot2::ggplot(data = curr_data, ggplot2::aes_(x = as.name(date_col), y = 1, fill = as.name(key_name))) + ggplot2::geom_raster() + ggplot2::scale_fill_manual(values = key) + ggplot2::scale_x_date(date_minor_breaks = "1 year") + ggplot2::geom_hline(yintercept = seq(0.5, by = 1, length.out = length(levels(curr_data[["variable"]])) + 1)) + blank_y_axis + ggplot2::scale_y_continuous(breaks = NULL) + ggplot2::labs(y = element_cols)
        }
        if(!missing(scale_xdate)){ g <- g + ggplot2::scale_x_date(breaks = paste0(byXaxis," year"), limits = c(from=as.Date(paste0(fromXAxis,"-01-01")), to = as.Date(paste0(toXAxis,"-12-31"))), date_labels = "%Y") } 
      }
      if(coord_flip) {
        g <- g + ggplot2::coord_flip()
      }
      if(!missing(labelXAxis)){g <- g + ggplot2::xlab(labelXAxis)}else{g <- g + ggplot2::xlab(NULL)}
      if(!missing(labelYAxis)){g <- g + ggplot2::ylab(labelYAxis)}else{g <- g + ggplot2::ylab(NULL)}
      return(g + ggplot2::labs(title = graph_title, subtitle = graph_subtitle, caption = graph_caption) + ggplot2::theme(strip.text.x = element_text(margin = margin(1, 0, 1, 0), size = facet_xsize, angle = facet_xangle), strip.text.y = element_text(margin = margin(1, 0, 1, 0), size = facet_ysize, angle = facet_yangle), legend.position=legend_position, plot.title = ggplot2::element_text(hjust = 0.5, size = title_size), plot.subtitle = ggplot2::element_text(size = subtitle_size), plot.caption = ggplot2::element_text(size = caption_size), axis.text.x = ggplot2::element_text(size=xSize, angle = Xangle, vjust = 0.6), axis.title.x = ggplot2::element_text(size=xlabelsize), axis.title.y = ggplot2::element_text(size=ylabelsize), axis.text.y = ggplot2::element_text(size = ySize, angle = Yangle, hjust = 0.6)))
    },
    
    #' @description
    #' Infill missing dates in the specified column.
    #'
    #' @param date_name Character, the name of the date column.
    #' @param factors Character vector, the names of the factor columns.
    #' @param start_month Numeric, the start month for infilling.
    #' @param start_date Date, the start date for infilling.
    #' @param end_date Date, the end date for infilling.
    #' @param resort Logical, if TRUE, sorts the data frame after infilling.
    #'
    #' @return None
    infill_missing_dates = function(date_name, factors, start_month, start_date, end_date, resort = TRUE) {
      date_col <- self$get_columns_from_data(date_name)
      if(!lubridate::is.Date(date_col)) stop("date_col is not a Date column.")
      if(anyNA(date_col)) stop("Cannot do infilling as date column has missing values")
      if(!missing(start_date) && !lubridate::is.Date(start_date)) stop("start_date is not of type Date")
      if(!missing(end_date) && !lubridate::is.Date(end_date)) stop("end_date is not of type Date")
      if(!missing(start_month) && !is.numeric(start_month)) stop("start_month is not numeric")
      if(!missing(start_month)) end_month <- ((start_month - 2) %% 12) + 1
      
      min_date <- min(date_col)
      max_date <- max(date_col)
      if(!missing(start_date)) {
        if(start_date > min_date) stop("Start date cannot be greater than earliest date")
      }
      if(!missing(end_date)) {
        if(end_date < max_date) stop("End date cannot be less than latest date")
      }
      
      if(missing(factors)) {
        if(anyDuplicated(date_col) > 0) stop("Cannot do infilling as date column has duplicate values.")
        
        if(!missing(start_date) | !missing(end_date)) {
          if(!missing(start_date)) {
            min_date <- start_date
          }
          if(!missing(end_date)) {
            max_date <- end_date
          }
        }
        else if(!missing(start_month)) {
          if(start_month <= lubridate::month(min_date)) min_date <- as.Date(paste(lubridate::year(min_date), start_month, 1, sep = "-"), format = "%Y-%m-%d")
          else min_date <- as.Date(paste(lubridate::year(min_date) - 1, start_month, 1, sep = "-"), format = "%Y-%m-%d")
          if(end_month >= lubridate::month(max_date)) max_date <- as.Date(paste(lubridate::year(max_date), end_month, lubridate::days_in_month(as.Date(paste(lubridate::year(max_date), end_month, 1, sep = "-", format = "%Y-%m-%d"))), sep = "-"), format = "%Y-%m-%d")
          else max_date <- as.Date(paste(lubridate::year(max_date) + 1, end_month, lubridate::days_in_month(as.Date(paste(lubridate::year(max_date) + 1, end_month, 1, sep = "-"))), sep = "-", format = "%Y-%m-%d"), format = "%Y-%m-%d")
        }
        full_dates <- seq(min_date, max_date, by = "day")
        if(length(full_dates) > length(date_col)) {
          cat("Added", (length(full_dates) - length(date_col)), "rows to extend data and fill date gaps", "\n")
          full_dates <- data.frame(full_dates)
          names(full_dates) <- date_name
          by <- date_name
          names(by) <- date_name
          self$merge_data(full_dates, by = by, type = "full")
          if(resort) self$sort_dataframe(col_names = date_name)
        }
        else cat("No missing dates to infill")
      }
      else {
        merge_required <- FALSE
        col_names_exp <- c()
        for(i in seq_along(factors)) {
          col_name <- factors[i]
          col_names_exp[[i]] <- lazyeval::interp(~ var, var = as.name(col_name))
        }
        all_factors <- self$get_columns_from_data(factors, use_current_filter = FALSE)
        first_factor <- self$get_columns_from_data(factors[1], use_current_filter = FALSE)
        if(dplyr::n_distinct(interaction(all_factors, drop = TRUE))!= dplyr::n_distinct(first_factor)) stop("The multiple factor variables are not in sync. Should have same number of levels.")
        grouped_data <- self$get_data_frame(use_current_filter = FALSE) %>% dplyr::group_by_(.dots = col_names_exp)
        # TODO
        date_ranges <- grouped_data %>% dplyr::summarise_(.dots = setNames(list(lazyeval::interp(~ min(var), var = as.name(date_name)), lazyeval::interp(~ max(var), var = as.name(date_name))), c("min_date", "max_date")))
        date_lengths <- grouped_data %>% dplyr::summarise(count = n())
        if(!missing(start_date) | !missing(end_date)) {
          if(!missing(start_date)) {
            date_ranges$min_date <- start_date
          }
          if(!missing(end_date)) {
            date_ranges$max_date <- end_date
          }
        }
        else if(!missing(start_month)) {
          date_ranges$min_date <- dplyr::if_else(lubridate::month(date_ranges$min_date) >= start_month, 
                                                 as.Date(paste(lubridate::year(date_ranges$min_date), start_month, 1, sep = "-"), format = "%Y-%m-%d"),
                                                 as.Date(paste(lubridate::year(date_ranges$min_date) - 1, start_month, 1, sep = "-"), format = "%Y-%m-%d"))
          date_ranges$max_date <- dplyr::if_else(lubridate::month(date_ranges$max_date) <= end_month, 
                                                 as.Date(paste(lubridate::year(date_ranges$max_date), end_month, lubridate::days_in_month(as.Date(paste(lubridate::year(date_ranges$max_date), end_month, 1, sep = "-"), format = "%Y-%m-%d")), sep = "-"), format = "%Y-%m-%d"),
                                                 as.Date(paste(lubridate::year(date_ranges$max_date) + 1, end_month, lubridate::days_in_month(as.Date(paste(lubridate::year(date_ranges$max_date), end_month, 1, sep = "-"), format = "%Y-%m-%d")), sep = "-"), format = "%Y-%m-%d"))
        }
        full_dates_list <- list()
        for(j in 1:nrow(date_ranges)) {
          full_dates <- seq(date_ranges$min_date[j], date_ranges$max_date[j], by = "day")
          if(length(full_dates) > date_lengths[,"count"][j,]) {
            cat(paste(unlist(date_ranges[1:length(factors)][j, ]), collapse = "-"), ": Added", (length(full_dates) - unlist(date_lengths[,"count"][j,])), "rows to extend data and fill date gaps", "\n")
            merge_required <- TRUE
          }
          full_dates <- data.frame(full_dates)
          names(full_dates) <- date_name
          for(k in seq_along(factors)) {
            full_dates[[factors[k]]] <- date_ranges[[k]][j]
          }
          full_dates_list[[j]] <- full_dates
        }
        if(merge_required) {
          all_dates_factors <- plyr::rbind.fill(full_dates_list)
          by <- c(date_name, factors)
          names(by) <- by
          self$merge_data(all_dates_factors, by = by, type = "full")
          if(resort) self$sort_dataframe(col_names = c(factors, date_name))
        }
        else cat("No missing dates to infill")
      }
      #Added this line to fix the bug of having the variable names in the metadata changinng to NA
      # This affects factor columns only  - we need to find out why and how to solve it best
      self$add_defaults_variables_metadata(self$get_column_names())
    },
    
    #' @description
    #' Get the names of the keys in the data.
    #'
    #' @param include_overall Logical, if TRUE, includes the overall keys.
    #' @param include Character vector, the names of the keys to include.
    #' @param exclude Character vector, the names of the keys to exclude.
    #' @param include_empty Logical, if TRUE, includes empty keys.
    #' @param as_list Logical, if TRUE, returns the keys as a list.
    #' @param excluded_items Character vector, the items to exclude from the keys.
    #'
    #' @return A character vector or list with the names of the keys.
    get_key_names = function(include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c()) {
      key_names <- names(private$keys)
      if(as_list) {
        out <- list()
        out[[self$get_metadata(data_name_label)]] <- key_names
      }
      else out <- key_names
      return(out)
    },
    
    #' @description
    #' Define corruption outputs for the dataset.
    #'
    #' @param output_columns Character vector, the names of the output columns.
    #'
    #' @return None
    define_corruption_outputs = function(output_columns = c()) {
      all_cols <- self$get_column_names()
      if(!self$is_metadata(corruption_data_label)) {
        stop("Cannot define corruption outputs when data frame is not defined as corruption data.")
      }
      self$append_to_variables_metadata(output_columns, corruption_output_label, TRUE)
      self$append_to_variables_metadata(output_columns, corruption_index_label, TRUE)
      other_cols <- setdiff(all_cols, output_columns)
      self$append_to_variables_metadata(other_cols, corruption_output_label, FALSE)
    },
    
    #' @description
    #' Define red flags for the dataset.
    #'
    #' @param red_flags Character vector, the names of the red flag columns.
    #'
    #' @return None
    define_red_flags = function(red_flags = c()) {
      if(!self$is_metadata(corruption_data_label)) {
        stop("Cannot define red flags when data frame is not defined as procurement data.")
      }
      self$append_to_variables_metadata(red_flags, corruption_red_flag_label, TRUE)
      self$append_to_variables_metadata(red_flags, corruption_index_label, TRUE)
      other_cols <- self$get_column_names()[!self$get_column_names() %in% red_flags]
      self$append_to_variables_metadata(other_cols, corruption_red_flag_label, FALSE)
    },
    
    #' @description
    #' Define the dataset as procurement country level data.
    #'
    #' @param types Named list, the types of procurement data.
    #' @param auto_generate Logical, if TRUE, automatically generates additional data.
    #'
    #' @return None
    define_as_procurement_country_level_data = function(types = c(), auto_generate = TRUE) {
      invisible(sapply(names(types), function(x) self$append_to_variables_metadata(types[[x]], corruption_type_label, x)))
    },
    
    #' @description
    #' Check if a corruption type is present in the dataset.
    #'
    #' @param type Character, the corruption type to check.
    #'
    #' @return Logical, TRUE if the corruption type is present, FALSE otherwise.
    is_corruption_type_present = function(type) {
      return(self$is_metadata(corruption_data_label) && !is.na(self$get_metadata(corruption_data_label)) && self$is_variables_metadata(corruption_type_label) && (type %in% self$get_variables_metadata(property = corruption_type_label)))
    },
    
    #' @description
    #' Get the column names for CRI components.
    #'
    #' @return A character vector with the names of the CRI component columns.
    get_CRI_component_column_names = function() {
      include <- list(TRUE)
      names(include) <- corruption_index_label
      return(self$get_column_names(include = include))
    },
    
    #' @description
    #' Get the column names for red flag components.
    #'
    #' @return A character vector with the names of the red flag columns.
    get_red_flag_column_names = function() {
      include <- list(TRUE)
      names(include) <- corruption_red_flag_label
      return(self$get_column_names(include = include))
    },
    
    #' @description
    #' Get the column names for CRI.
    #'
    #' @return A character vector with the names of the CRI columns.
    get_CRI_column_names = function() {
      col_names <- self$get_column_names()
      CRI_cols <- col_names[startsWith(col_names, "CRI")]
      return(CRI_cols)
    },
    
    #' @description
    #' Get the column name for a specific corruption type.
    #'
    #' @param type Character, the corruption type to check.
    #'
    #' @return A character string with the column name of the specified corruption type.
    get_corruption_column_name = function(type) {
      if(self$is_corruption_type_present(type)) {
        var_metadata <- self$get_variables_metadata()
        col_name <- var_metadata[!is.na(var_metadata[[corruption_type_label]]) & var_metadata[[corruption_type_label]] == type, name_label]
        if(length(col_name >= 1)) return(col_name)
        else return("")
      }
      return("")
    },
    
    #' @description
    #' Set procurement types for the dataset.
    #'
    #' @param primary_types Named list, the primary types of procurement data.
    #' @param calculated_types Named list, the calculated types of procurement data.
    #' @param auto_generate Logical, if TRUE, automatically generates additional data.
    #'
    #' @return None
    set_procurement_types = function(primary_types = c(), calculated_types = c(), auto_generate = TRUE) {
      if(!all(names(primary_types) %in% all_primary_corruption_column_types)) stop("Cannot recognise the following primary corruption data types: ", paste(names(primary_types)[!names(primary_types) %in% all_primary_corruption_column_types], collapse = ", "))
      if(!all(names(calculated_types) %in% all_calculated_corruption_column_types)) stop("Cannot recognise the following calculated corruption data types: ", paste(names(calculated_types)[!names(calculated_types) %in% all_calculated_corruption_column_types], collapse = ", "))
      if(!all(c(primary_types, calculated_types) %in% self$get_column_names())) stop("The following columns do not exist in the data:", paste(c(primary_types, calculated_types)[!(c(primary_types, calculated_types) %in% self$get_column_names())], collapse = ", "))
      invisible(sapply(names(primary_types), function(x) self$append_to_variables_metadata(primary_types[[x]], corruption_type_label, x)))
      invisible(sapply(names(calculated_types), function(x) self$append_to_variables_metadata(calculated_types[[x]], corruption_type_label, x)))
      if(auto_generate) {
        # Tried to make these independent of order called, but need to test
        self$generate_award_year()
        self$generate_procedure_type()
        self$generate_procuring_authority_id()
        self$generate_winner_id()
        self$generate_foreign_winner()
        self$generate_procurement_type_categories()
        self$generate_procurement_type_2()
        self$generate_procurement_type_3()
        self$generate_signature_period()
        self$generate_signature_period_corrected()
        self$generate_signature_period_5Q()
        self$generate_signature_period_25Q()
        self$generate_rolling_contract_no_winners()
        self$generate_rolling_contract_no_issuer()
        self$generate_rolling_contract_value_sum_issuer()
        self$generate_rolling_contract_value_sum_winner()
        self$generate_rolling_contract_value_share_winner()
        self$generate_single_bidder()
        self$generate_contract_value_share_over_threshold()
        self$generate_all_bids()
        self$generate_all_bids_trimmed()
      }
    },
    
    #' @description
    #' Generate the award year for the dataset.
    #'
    #' @return None
    generate_award_year = function() {
      if(!self$is_corruption_type_present(corruption_award_year_label)) {
        if(!self$is_corruption_type_present(corruption_award_date_label)) message("Cannot auto generate ", corruption_award_year_label, " because ", corruption_award_date_label, " column is not present.")
        else {
          award_date <- self$get_columns_from_data(self$get_corruption_column_name(corruption_award_date_label))
          if(!lubridate::is.Date(award_date)) message(message("Cannot auto generate ", corruption_award_year_label, " because ", corruption_award_date_label, " column is not of type Date."))
          else {
            col_name <- instatExtras::next_default_item(corruption_award_year_label, self$get_column_names(), include_index = FALSE)
            self$add_columns_to_data(col_name, year(award_date))
            self$append_to_variables_metadata(col_name, corruption_type_label, corruption_award_year_label)
            self$append_to_variables_metadata(col_name, "label", "Award year")
          }
        }
      }
    },
    
    #' @description
    #' Generate the procedure type for the dataset.
    #'
    #' @return None
    generate_procedure_type = function() {
      if(!self$is_corruption_type_present(corruption_procedure_type_label)) {
        if(!self$is_corruption_type_present(corruption_method_type_label)) message("Cannot auto generate ", corruption_procedure_type_label, " because ", corruption_method_type_label, " is not defined.")
        else {
          procedure_type <- self$get_columns_from_data(self$get_corruption_column_name(corruption_method_type_label))
          procedure_type[procedure_type == "CQS"] <- "Selection Based On Consultant's Qualification"
          procedure_type[procedure_type == "SHOP"] <- "International Shopping"
          procedure_type <- factor(procedure_type, levels = c("Commercial Practices", "Direct Contracting", "Force Account", "INDB", "Individual", "International Competitive Bidding", "International Shopping", "Least Cost Selection", "Limited International Bidding", "National Competitive Bidding", "National Shopping", "Quality And Cost-Based Selection", "Quality Based Selection", "Selection Based On Consultant's Qualification", "Selection Under a Fixed Budget", "Service Delivery Contracts", "Single Source Selection"))
          
          col_name <- instatExtras::next_default_item(corruption_procedure_type_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, procedure_type)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_procedure_type_label)
          self$append_to_variables_metadata(col_name, "label", "Procedure type")
        }
      }
    },
    
    #' @description
    #' Generate the procuring authority ID for the dataset.
    #'
    #' @return None
    generate_procuring_authority_id = function() {
      if(!self$is_corruption_type_present(corruption_procuring_authority_id_label)) {
        if(!self$is_corruption_type_present(corruption_procuring_authority_label) | !self$is_corruption_type_present(corruption_country_label)) message("Cannot auto generate ", corruption_procuring_authority_id_label, " because ", corruption_procuring_authority_label, "or ", corruption_award_year_label, " is not defined.")
        else {
          id <- as.numeric(factor(paste0(self$get_columns_from_data(self$get_corruption_column_name(corruption_country_label)), self$get_columns_from_data(self$get_corruption_column_name(corruption_procuring_authority_label))), levels = unique(paste0(self$get_columns_from_data(self$get_corruption_column_name(corruption_country_label)), self$get_columns_from_data(self$get_corruption_column_name(corruption_procuring_authority_label))))))
          
          col_name <- instatExtras::next_default_item(corruption_procuring_authority_id_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, id)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_procuring_authority_id_label)
          self$append_to_variables_metadata(col_name, "label", "Procurement Auth. ID")
        }
      }
    },
    
    #' @description
    #' Generate the winner ID for the dataset.
    #'
    #' @return None
    generate_winner_id = function() {
      if(!self$is_corruption_type_present(corruption_winner_id_label)) {
        if(!self$is_corruption_type_present(corruption_winner_name_label)) message("Cannot auto generate ", corruption_winner_id_label, " because ", corruption_winner_name_label, " is not defined.")
        else {
          id <- as.numeric(factor(self$get_columns_from_data(self$get_corruption_column_name(corruption_winner_name_label)), levels = unique(self$get_columns_from_data(self$get_corruption_column_name(corruption_winner_name_label)))))
          
          col_name <- instatExtras::next_default_item(corruption_winner_id_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, id)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_winner_id_label)
          self$append_to_variables_metadata(col_name, "label", "w_name ID")
        }
      }
    },
    
    #' @description
    #' Generate the foreign winner flag for the dataset.
    #'
    #' @return None
    generate_foreign_winner = function() {
      if(!self$is_corruption_type_present(corruption_foreign_winner_label)) {
        if(!self$is_corruption_type_present(corruption_country_label) || !self$is_corruption_type_present(corruption_winner_country_label)) message("Cannot auto generate ", corruption_foreign_winner_label, " because ", corruption_country_label, " or ", corruption_winner_country_label, " are not defined.")
        else {
          f_winner <- (self$get_columns_from_data(self$get_corruption_column_name(corruption_country_label)) != self$get_columns_from_data(self$get_corruption_column_name(corruption_winner_country_label)))
          
          col_name <- instatExtras::next_default_item(corruption_foreign_winner_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, f_winner)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_foreign_winner_label)
          self$append_to_variables_metadata(col_name, "label", "Foreign w_name dummy")
        }
      }
    },
    
    #' @description
    #' Generate procurement type categories for the dataset.
    #'
    #' @return None
    generate_procurement_type_categories = function() {
      if(!self$is_corruption_type_present(corruption_procurement_type_cats_label)) {
        if(!self$is_corruption_type_present(corruption_procedure_type_label)) message("Cannot auto generate ", corruption_procurement_type_cats_label, " because ", corruption_procedure_type_label, " are not defined.")
        else {
          procedure_type <- self$get_columns_from_data(self$get_corruption_column_name(corruption_procedure_type_label))
          procurement_type <- "other, missing"
          procurement_type[procedure_type == "Direct Contracting" | procedure_type == "Individual" | procedure_type == "Single Source Selection"] <- "single source"
          procurement_type[procedure_type == "Force Account" | procedure_type == "Service Delivery Contracts"] <- "own provision"
          procurement_type[procedure_type == "International Competitive Bidding" | procedure_type == "National Competitive Bidding"] <- "open"
          procurement_type[procedure_type == "International Shopping" | procedure_type == "Limited International Bidding" | procedure_type == "National Shopping"] <- "restricted"
          procurement_type[procedure_type == "Quality And Cost-Based Selection" | procedure_type == "Quality Based Selection" | procedure_type == "Selection Under a Fixed Budget"] <- "consultancy,cost"
          procurement_type[procedure_type == "Least Cost Selection" | procedure_type == "Selection Based On Consultant's Qualification"] <- "consultancy,cost"
          procurement_type <- factor(procurement_type, levels = c("open", "restricted", "single source", "consultancy,quality", "consultancy,cost", "own provision", "other, missing"))
          
          col_name <- instatExtras::next_default_item(corruption_procurement_type_cats_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, procurement_type)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_procurement_type_cats_label)
          self$append_to_variables_metadata(col_name, "label", "Main procurement type category")
        }
      }
    },
    
    #' @description
    #' Generate procurement type categories 2 for the dataset.
    #'
    #' @return None
    generate_procurement_type_2 = function() {
      if(!self$is_corruption_type_present(corruption_procurement_type_2_label)) {
        if(!self$is_corruption_type_present(corruption_procurement_type_cats_label)) message("Cannot auto generate ", corruption_procurement_type_2_label, " because ", corruption_procurement_type_cats_label, " are not defined.")
        else {
          procurement_type_cats <- self$get_columns_from_data(self$get_corruption_column_name(corruption_procurement_type_cats_label))
          procurement_type2 <- NA
          procurement_type2[procurement_type_cats == "open"] <- FALSE
          procurement_type2[procurement_type_cats == "restricted" | procurement_type_cats == "single source" | procurement_type_cats == "consultancy,quality" | procurement_type_cats == "consultancy,cost"] <- TRUE
          
          col_name <- instatExtras::next_default_item(corruption_procurement_type_2_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, procurement_type2)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_procurement_type_2_label)
          self$append_to_variables_metadata(col_name, "label", "Proc. type is restricted, single source, consultancy")
        }
      }
    },
    
    #' @description
    #' Generate procurement type categories 3 for the dataset.
    #'
    #' @return None
    generate_procurement_type_3 = function() {
      if(!self$is_corruption_type_present(corruption_procurement_type_3_label)) {
        if(!self$is_corruption_type_present(corruption_procurement_type_cats_label)) message("Cannot auto generate ", corruption_procurement_type_3_label, " because ", corruption_procurement_type_cats_label, " are not defined.")
        else {
          procurement_type_cats <- self$get_columns_from_data(self$get_corruption_column_name(corruption_procurement_type_cats_label))
          procurement_type3 <- NA
          procurement_type3[procurement_type_cats == "open"] <- "open procedure"
          procurement_type3[procurement_type_cats == "restricted" | procurement_type_cats == "single source"] <- "closed procedure risk"
          procurement_type3[procurement_type_cats == "consultancy,quality" | procurement_type_cats == "consultancy,cost"] <- "consultancy spending risk"
          procurement_type3 <- factor(procurement_type3, levels = c("open procedure", "closed procedure risk", "consultancy spending risk"))
          
          col_name <- instatExtras::next_default_item(corruption_procurement_type_3_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, procurement_type3)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_procurement_type_3_label)
          self$append_to_variables_metadata(col_name, "label", "Procedure type (open, closed, consultancy)")
        }
      }
    },
    
    #' @description
    #' Generate the signature period for the dataset.
    #'
    #' @return None
    generate_signature_period = function() {
      if(!self$is_corruption_type_present(corruption_signature_period_label)) {
        if(!self$is_corruption_type_present(corruption_award_date_label) || !self$is_corruption_type_present(corruption_signature_date_label)) message("Cannot auto generate ", corruption_signature_period_label, " because ", corruption_award_date_label, "or", corruption_signature_date_label, " are not defined.")
        award_date <- self$get_columns_from_data(self$get_corruption_column_name(corruption_award_date_label))
        sign_date <- self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_date_label))
        if(!lubridate::is.Date(award_date) || !lubridate::is.Date(sign_date)) message("Cannot auto generate ", corruption_signature_period_label, " because ", corruption_award_date_label, " or ", corruption_signature_date_label, " are not of type Date.")
        else {
          signature_period <- self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_date_label)) - self$get_columns_from_data(self$get_corruption_column_name(corruption_award_date_label))
          col_name <- instatExtras::next_default_item(corruption_signature_period_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, signature_period)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_signature_period_label)
          self$append_to_variables_metadata(col_name, "label", "Signature period")
        }
      }
    },
    
    #' @description
    #' Generate the corrected signature period for the dataset.
    #'
    #' @return None
    generate_signature_period_corrected = function() {
      if(!self$is_corruption_type_present(corruption_signature_period_corrected_label)) {
        self$generate_signature_period()
        if(!self$is_corruption_type_present(corruption_signature_period_label)) message("Cannot auto generate ", corruption_signature_period_corrected_label, " because ", corruption_signature_period_label, " is not defined.")
        else {
          signature_period_corrected <- self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_period_label))
          signature_period_corrected[signature_period_corrected < 0 | signature_period_corrected > 730] <- NA
          
          col_name <- instatExtras::next_default_item(corruption_signature_period_corrected_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, signature_period_corrected)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_signature_period_corrected_label)
          self$append_to_variables_metadata(col_name, "label", "Signature period - corrected")
        }
      }
    },
    
    #' @description
    #' Generate the signature period quintiles (5 quantiles) for the dataset.
    #'
    #' @return None
    generate_signature_period_5Q = function() {
      if(!self$is_corruption_type_present(corruption_signature_period_5Q_label)) {
        self$generate_signature_period()
        if(!self$is_corruption_type_present(corruption_signature_period_label)) message("Cannot auto generate ", corruption_signature_period_5Q_label, " because ", corruption_signature_period_label, " is not defined.")
        else {
          signature_period_5Q <- .bincode(self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_period_label)), quantile(self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_period_label)), seq(0, 1, length.out = 5 + 1), type = 2, na.rm = TRUE), include.lowest = TRUE)
          
          col_name <- instatExtras::next_default_item(corruption_signature_period_5Q_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, signature_period_5Q)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_signature_period_5Q_label)
        }
      }
    },
    
    #' @description
    #' Generate the signature period 25 quantiles for the dataset.
    #'
    #' @return None
    generate_signature_period_25Q = function() {
      if(!self$is_corruption_type_present(corruption_signature_period_25Q_label)) {
        self$generate_signature_period()
        if(!self$is_corruption_type_present(corruption_signature_period_label)) message("Cannot auto generate ", corruption_signature_period_25Q_label, " because ", corruption_signature_period_label, " is not defined.")
        else {
          signature_period_25Q <- .bincode(self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_period_label)), quantile(self$get_columns_from_data(self$get_corruption_column_name(corruption_signature_period_label)), seq(0, 1, length.out = 25 + 1), type = 2, na.rm = TRUE), include.lowest = TRUE)
          
          col_name <- instatExtras::next_default_item(corruption_signature_period_25Q_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, signature_period_25Q)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_signature_period_25Q_label)
        }
      }
    },
    
    #' @description
    #' Generate rolling contract number of winners for the dataset.
    #'
    #' @return None
    generate_rolling_contract_no_winners = function() {
      if(!self$is_corruption_type_present(corruption_roll_num_winner_label)) {
        self$generate_procuring_authority_id()
        self$generate_winner_id()
        if(!self$is_corruption_type_present(corruption_procuring_authority_id_label) | !self$is_corruption_type_present(corruption_winner_id_label) | !self$is_corruption_type_present(corruption_award_date_label)) {
          message("Cannot auto generate ", corruption_roll_num_winner_label, " because ", corruption_procuring_authority_id_label, " or ", corruption_winner_id_label, " or ", corruption_award_date_label, " are not defined.")
        }
        else {
          temp <- self$get_data_frame(use_current_filter = FALSE)
          authority_id_label <- self$get_corruption_column_name(corruption_procuring_authority_id_label)
          winner_id_label <- self$get_corruption_column_name(corruption_winner_id_label)
          award_date_label <- self$get_corruption_column_name(corruption_award_date_label)
          col_name <- instatExtras::next_default_item(corruption_roll_num_winner_label, self$get_column_names(), include_index = FALSE)
          exp <- lazyeval::interp(~ sum(temp[[authority_id1]] == authority_id2 & temp[[winner_id1]] == winner_id2 & temp[[award_date1]] <= award_date2 & temp[[award_date1]] > award_date2 - 365), authority_id1 = authority_id_label, authority_id2 = as.name(authority_id_label), winner_id1 = winner_id_label, winner_id2 = as.name(winner_id_label), award_date1 = award_date_label, award_date2 = as.name(award_date_label))
          temp <- self$get_data_frame(use_current_filter = FALSE)
          # todo
          temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate(!!as.name(col_name) := !!rlang::parse_expr(exp)) # or sym(exp)?
          #temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate_(.dots = setNames(list(exp), col_name))
          self$add_columns_to_data(col_name, temp[[col_name]])
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_roll_num_winner_label)
          self$append_to_variables_metadata(col_name, "label", "12 month rolling contract number of winner for each contract awarded")
        }
      }
    },
    
    #' @description
    #' Generate rolling contract number of issuers for the dataset.
    #'
    #' @return None
    generate_rolling_contract_no_issuer = function() {
      if(!self$is_corruption_type_present(corruption_roll_num_issuer_label)) {
        self$generate_procuring_authority_id()
        if(!self$is_corruption_type_present(corruption_procuring_authority_id_label) | !self$is_corruption_type_present(corruption_award_date_label)) {
          message("Cannot auto generate ", corruption_roll_num_issuer_label, " because ", corruption_procuring_authority_id_label, " or ", corruption_award_date_label, " are not defined.")
        }
        else {
          temp <- self$get_data_frame(use_current_filter = FALSE)
          authority_id_label <- self$get_corruption_column_name(corruption_procuring_authority_id_label)
          award_date_label <- self$get_corruption_column_name(corruption_award_date_label)
          col_name <- instatExtras::next_default_item(corruption_roll_num_issuer_label, self$get_column_names(), include_index = FALSE)
          exp <- lazyeval::interp(~ sum(temp[[authority_id1]] == authority_id2 & temp[[award_date1]] <= award_date2 & temp[[award_date1]] > award_date2 - 365), authority_id1 = authority_id_label, authority_id2 = as.name(authority_id_label), award_date1 = award_date_label, award_date2 = as.name(award_date_label))
          temp <- self$get_data_frame(use_current_filter = FALSE)
          # todo
          temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate(!!as.name(col_name) := !!rlang::parse_expr(exp)) # or sym(exp)?
          #temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate_(.dots = setNames(list(exp), col_name))
          self$add_columns_to_data(col_name, temp[[col_name]])
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_roll_num_issuer_label)
          self$append_to_variables_metadata(col_name, "label", "12 month rolling contract number of issuer for each contract awarded")
        }
      }
    },
    
    #' @description
    #' Generate rolling contract value sum of issuers for the dataset.
    #'
    #' @return None
    generate_rolling_contract_value_sum_issuer = function() {
      if(!self$is_corruption_type_present(corruption_roll_sum_issuer_label)) {
        self$generate_procuring_authority_id()
        # Need better checks than just for original contract value
        if(!self$is_corruption_type_present(corruption_procuring_authority_id_label) | !self$is_corruption_type_present(corruption_award_date_label) | !self$is_corruption_type_present(corruption_original_contract_value_label)) {
          message("Cannot auto generate ", corruption_roll_num_issuer_label, " because ", corruption_procuring_authority_id_label, " or ", corruption_award_date_label, " are not defined.")
        }
        else {
          temp <- self$get_data_frame(use_current_filter = FALSE)
          authority_id_label <- self$get_corruption_column_name(corruption_procuring_authority_id_label)
          award_date_label <- self$get_corruption_column_name(corruption_award_date_label)
          if(self$is_corruption_type_present(corruption_ppp_adjusted_contract_value_label)) {
            contract_value_label <- self$get_corruption_column_name(corruption_ppp_adjusted_contract_value_label)
          }
          else if(self$is_corruption_type_present(corruption_ppp_conversion_rate_label)) {
            self$generate_ppp_adjusted_contract_value()
            contract_value_label <- self$get_corruption_column_name(corruption_ppp_adjusted_contract_value_label)
          }
          else {
            contract_value_label <- self$get_corruption_column_name(corruption_original_contract_value_label)
          }
          col_name <- instatExtras::next_default_item(corruption_roll_sum_issuer_label, self$get_column_names(), include_index = FALSE)
          exp <- lazyeval::interp(~ sum(temp[[contract_value]][temp[[authority_id1]] == authority_id2 & temp[[award_date1]] <= award_date2 & temp[[award_date1]] > award_date2 - 365]), authority_id1 = authority_id_label, authority_id2 = as.name(authority_id_label), award_date1 = award_date_label, award_date2 = as.name(award_date_label), contract_value = contract_value_label)
          temp <- self$get_data_frame(use_current_filter = FALSE)
          temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate(!!as.name(col_name) := !!rlang::parse_expr(exp)) # or sym(exp)?
          #temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate_(.dots = setNames(list(exp), col_name))
          self$add_columns_to_data(col_name, temp[[col_name]])
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_roll_sum_issuer_label)
          self$append_to_variables_metadata(col_name, "label", "12 month rolling sum of contract value of issuer")
        }
      }
    },
    
    #' @description
    #' Generate rolling contract value sum of winners for the dataset.
    #'
    #' @return None
    generate_rolling_contract_value_sum_winner = function() {
      if(!self$is_corruption_type_present(corruption_roll_sum_winner_label)) {
        self$generate_procuring_authority_id()
        self$generate_winner_id()
        # Need better checks than just for original contract value
        if(!self$is_corruption_type_present(corruption_procuring_authority_id_label) | !self$is_corruption_type_present(corruption_winner_id_label) | !self$is_corruption_type_present(corruption_award_date_label) | !self$is_corruption_type_present(corruption_original_contract_value_label)) {
          message("Cannot auto generate ", corruption_roll_num_issuer_label, " because ", corruption_procuring_authority_id_label, " or ", corruption_winner_id_label, " or ", corruption_award_date_label, " are not defined.")
        }
        else {
          temp <- self$get_data_frame(use_current_filter = FALSE)
          authority_id_label <- self$get_corruption_column_name(corruption_procuring_authority_id_label)
          winner_id_label <- self$get_corruption_column_name(corruption_winner_id_label)
          award_date_label <- self$get_corruption_column_name(corruption_award_date_label)
          if(self$is_corruption_type_present(corruption_ppp_adjusted_contract_value_label)) {
            contract_value_label <- self$get_corruption_column_name(corruption_ppp_adjusted_contract_value_label)
          }
          else if(self$is_corruption_type_present(corruption_ppp_conversion_rate_label)) {
            self$generate_ppp_adjusted_contract_value()
            contract_value_label <- self$get_corruption_column_name(corruption_ppp_adjusted_contract_value_label)
          }
          else {
            contract_value_label <- self$get_corruption_column_name(corruption_original_contract_value_label)
          }
          col_name <- instatExtras::next_default_item(corruption_roll_sum_winner_label, self$get_column_names(), include_index = FALSE)
          exp <- lazyeval::interp(~ sum(temp[[contract_value]][temp[[authority_id1]] == authority_id2 & temp[[winner_id1]] == winner_id2 & temp[[award_date1]] <= award_date2 & temp[[award_date1]] > award_date2 - 365]), authority_id1 = authority_id_label, authority_id2 = as.name(authority_id_label), winner_id1 = winner_id_label, winner_id2 = as.name(winner_id_label), award_date1 = award_date_label, award_date2 = as.name(award_date_label), contract_value = contract_value_label)
          temp <- self$get_data_frame(use_current_filter = FALSE)
          temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate(!!as.name(col_name) := !!rlang::parse_expr(exp)) # or sym(exp)?
          #temp <- temp %>% dplyr::rowwise() %>% dplyr::mutate_(.dots = setNames(list(exp), col_name
          self$add_columns_to_data(col_name, temp[[col_name]])
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_roll_sum_winner_label)
          self$append_to_variables_metadata(col_name, "label", "12 month rolling sum of contract value of winner")
        }
      }
    },
    
    #' @description
    #' Generate rolling contract value share of winners for the dataset.
    #'
    #' @return None
    generate_rolling_contract_value_share_winner = function() {
      if(!self$is_corruption_type_present(corruption_roll_share_winner_label)) {
        self$generate_rolling_contract_value_sum_issuer()
        self$generate_rolling_contract_value_sum_winner()
        if(!self$is_corruption_type_present(corruption_roll_sum_winner_label) | !self$is_corruption_type_present(corruption_roll_sum_issuer_label)) {
          message("Cannot auto generate ", corruption_roll_share_winner_label, " because ", corruption_roll_sum_winner_label, " or ", corruption_roll_sum_issuer_label, " are not defined.")
        }
        else {
          share <- self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_sum_winner_label)) / self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_sum_issuer_label))
          col_name <- instatExtras::next_default_item(corruption_roll_share_winner_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, share)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_roll_share_winner_label)
          self$append_to_variables_metadata(col_name, "label", "12 month rolling contract share of winner for each contract awarded")
        }
      }
    },
    
    #' @description
    #' Generate the single bidder flag for the dataset.
    #'
    #' @return None
    generate_single_bidder = function() {
      if(!self$is_corruption_type_present(corruption_single_bidder_label)) {
        self$generate_all_bids_trimmed()
        if(!self$is_corruption_type_present(corruption_all_bids_trimmed_label)) {
          message("Cannot auto generate ", corruption_single_bidder_label, " because ", corruption_all_bids_trimmed_label, " is not defined.")
        }
        else {
          single_bidder <- (self$get_columns_from_data(self$get_corruption_column_name(corruption_all_bids_trimmed_label)) == 1) 
          col_name <- instatExtras::next_default_item(corruption_single_bidder_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, single_bidder)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_single_bidder_label)
          self$append_to_variables_metadata(col_name, "label", "Single bidder dummy")
        }
      }
    },
    
    #' @description
    #' Generate contract value share over threshold for the dataset.
    #'
    #' @return None
    generate_contract_value_share_over_threshold = function() {
      if(!self$is_corruption_type_present(corruption_contract_value_share_over_threshold_label)) {
        self$generate_rolling_contract_value_share_winner()
        self$generate_rolling_contract_no_issuer()
        if(!self$is_corruption_type_present(corruption_roll_share_winner_label) | !self$is_corruption_type_present(corruption_roll_num_issuer_label)) {
          message("Cannot auto generate ", corruption_contract_value_share_over_threshold_label, " because ", corruption_roll_share_winner_label, " or ", corruption_roll_num_issuer_label, " are not defined.")
        }
        else {
          contr_share_over_threshold <- rep(NA, self$get_data_frame_length())
          contr_share_over_threshold[(self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_num_issuer_label)) >= 3) & (self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_share_winner_label)) >= 0.5)] <- TRUE
          contr_share_over_threshold[(self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_num_issuer_label)) >= 3) & (self$get_columns_from_data(self$get_corruption_column_name(corruption_roll_share_winner_label)) < 0.5)] <- FALSE
          
          col_name <- instatExtras::next_default_item(corruption_contract_value_share_over_threshold_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, contr_share_over_threshold)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_contract_value_share_over_threshold_label)
          self$append_to_variables_metadata(col_name, "label", "Winner share at least 50% where issuers awarded at least 3 contracts")
        }
      }
    },
    
    #' @description
    #' Generate the number of all bids for the dataset.
    #'
    #' @return None
    generate_all_bids = function() {
      if(!self$is_corruption_type_present(corruption_all_bids_label)) {
        if(!self$is_corruption_type_present(corruption_no_bids_considered_label)) {
          message("Cannot auto generate ", corruption_all_bids_label, " because ", corruption_no_bids_considered_label, " is not defined.")
        }
        else {
          all_bids <- self$get_columns_from_data(self$get_corruption_column_name(corruption_no_bids_considered_label))
          if(self$is_corruption_type_present(corruption_no_bids_received_label)) {
            all_bids[is.na(all_bids)] <- self$get_columns_from_data(self$get_corruption_column_name(corruption_no_bids_received_label))[is.na(all_bids)]
          }
          
          col_name <- instatExtras::next_default_item(corruption_all_bids_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, all_bids)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_all_bids_label)
          self$append_to_variables_metadata(col_name, "label", "# Bids (all)")
        }
      }
    },
    
    #' @description
    #' Generate the number of all trimmed bids for the dataset.
    #'
    #' @return None
    generate_all_bids_trimmed = function() {
      if(!self$is_corruption_type_present(corruption_all_bids_trimmed_label)) {
        self$generate_all_bids()
        if(!self$is_corruption_type_present(corruption_all_bids_label)) {
          message("Cannot auto generate ", corruption_all_bids_trimmed_label, " because ", corruption_all_bids_label, " is not defined.")
        }
        else {
          all_bids_trimmed <- self$get_columns_from_data(self$get_corruption_column_name(corruption_all_bids_label))
          all_bids_trimmed[all_bids_trimmed > 50] <- 50
          
          col_name <- instatExtras::next_default_item(corruption_all_bids_trimmed_label, self$get_column_names(), include_index = FALSE)
          self$add_columns_to_data(col_name, all_bids_trimmed)
          self$append_to_variables_metadata(col_name, corruption_type_label, corruption_all_bids_trimmed_label)
          self$append_to_variables_metadata(col_name, "label", "# Bids (trimmed at 50)")
        }
      }
    },
    
    #' @description
    #' Standardise country names in the specified columns.
    #'
    #' @param country_columns A vector of column names containing country names to be standardised.
    #' @return None
    standardise_country_names = function(country_columns = c()) {
      for(col_name in country_columns) {
        corrected_col <- standardise_country_names(self$get_columns_from_data(col_name))
        new_col_name <- instatExtras::next_default_item(paste(col_name, "standardised", sep = "_"), self$get_column_names(), include_index = FALSE)
        self$add_columns_to_data(new_col_name, corrected_col)
        type <- self$get_variables_metadata(column = col_name, property = corruption_type_label)
        if(!is.na(type)) {
          if(type == corruption_country_label) {
            self$append_to_variables_metadata(new_col_name, corruption_type_label, corruption_country_label)
            self$append_to_variables_metadata(col_name, corruption_type_label, NA)
            self$append_to_variables_metadata(new_col_name, "label", "Country name - standardised")
          }
          else if(type == corruption_winner_country_label) {
            self$append_to_variables_metadata(new_col_name, corruption_type_label, corruption_winner_country_label)
            self$append_to_variables_metadata(col_name, corruption_type_label, NA)
            self$append_to_variables_metadata(new_col_name, "label", "Winner country name - standardised")
          }
        }
      }
    },
    
    #' @description
    #' Get the column name for a specified climatic type.
    #'
    #' @param col_name The climatic type to look for.
    #' @return The column name corresponding to the climatic type, or NULL if not found.
    get_climatic_column_name = function(col_name) {
      if(!self$get_metadata(is_climatic_label)) {
        warning("Data not defined as climatic.")
        return(NULL)
      }
      if(col_name %in% self$get_variables_metadata()$Climatic_Type){
        new_data = subset(self$get_variables_metadata(), Climatic_Type==col_name, select = Name)
        return(as.character(new_data))
      }
      else{
        message(paste(col_name, "column not found in the data."))
        return(NULL)
      }
    },
    
    #' @description
    #' Check if the data is defined as climatic.
    #'
    #' @return TRUE if the data is defined as climatic, FALSE otherwise.
    is_climatic_data = function() {
      return(self$is_metadata(is_climatic_label) &&  self$get_metadata(is_climatic_label))
    },
    
    #' @description
    #' Append new attributes to a column.
    #'
    #' @param col_name The name of the column.
    #' @param new_attr A named list of new attributes to append.
    #' @return None
    append_column_attributes = function(col_name, new_attr) {
      tmp_names <- names(new_attr)
      for(i in seq_along(new_attr)) {
        self$append_to_variables_metadata(property = tmp_names[i], col_names = col_name, new_val = new_attr[[i]])
      }
    },
    
    #' @description
    #' Display daily graphs for climatic elements.
    #'
    #' @param data_name The name of the data set.
    #' @param date_col The name of the date column.
    #' @param station_col The name of the station column.
    #' @param year_col The name of the year column.
    #' @param doy_col The name of the day of year column.
    #' @param climatic_element The climatic element to plot.
    #' @param rug_colour The color of the rug plot.
    #' @param bar_colour The color of the bar plot.
    #' @param upper_limit The upper limit for the y-axis.
    #' @return A list of ggplot objects or a single ggplot object.
    display_daily_graph = function(data_name, date_col = NULL, station_col = NULL, year_col = NULL, doy_col = NULL, climatic_element = NULL, rug_colour = "red", bar_colour = "blue", upper_limit = 100) {
      if(!self$is_climatic_data()) stop("Data is not defined as climatic.")
      if(missing(date_col)) stop("Date columns must be specified.")
      if(missing(climatic_element)) stop("Element column(s) must be specified.")
      #if(!all(c(date_col, station_col, year_col, doy_col, climatic_element)) %in% self$get_column_names()) {
      # stop("Not all specified columns found in the data")
      # }
      date_data <- self$get_columns_from_data(date_col)
      if(!lubridate::is.Date(date_data)) stop(paste(date_col, " must be of type Date."))
      #Extracting  year and day of the year
      if(is.null(year_col)) {
        if(is.null(self$get_climatic_column_name(year_label))) {
          self$split_date(col_name = date_col, year = TRUE)
        }
        year_col <- self$get_climatic_column_name(year_label)
      }
      if(is.null(doy_col)) {
        if(is.null(self$get_climatic_column_name(doy_label))) {
          self$split_date(col_name = date_col, day_in_year = TRUE)
        }
        doy_col <- self$get_climatic_column_name(doy_label)
      }
      curr_data <- self$get_data_frame()
      if(!is.null(station_col)) {
        station_data <- self$get_columns_from_data(station_col)
      }
      else station_data <- 1
      year_data <- self$get_columns_from_data(year_col)
      
      graph_list <- list()
      ngraph <- 0
      for(station_name in unique(station_data)) {
        print(station_name)
        if(!is.null(station_col)) curr_graph_data <- curr_data[curr_data[[station_col]] == station_name, ]
        else curr_graph_data <- curr_data
        if(nrow(curr_graph_data) != 0) {
          g <- ggplot2::ggplot(data = curr_graph_data, mapping = ggplot2::aes_(x = as.name(doy_col), y = as.name(climatic_element))) + ggplot2::geom_bar(stat  = "identity", fill = bar_colour) + ggplot2::geom_rug(data = curr_graph_data[is.na(curr_graph_data[[climatic_element]]), ], mapping = ggplot2::aes_(x = as.name(doy_col)), sides = "b", color = rug_colour) + ggplot2::theme_minimal() + ggplot2::coord_cartesian(ylim = c(0, upper_limit)) + ggplot2::scale_x_continuous(breaks = c(1, 32, 61, 92, 122, 153, 183, 214, 245, 275, 306, 336, 367), labels = c(month.abb, ""), limits = c(0, 367)) + facet_wrap(facets = as.formula(paste("~", year_col))) + ggplot2::ggtitle(paste(ifelse(station_name == 1, "", station_name), "Daily", climatic_element)) + ggplot2::theme(panel.grid.minor = element_blank(), plot.title = element_text(hjust = 0.5, size = 20), axis.title = element_text(size = 16)) + xlab("Date") + ylab(climatic_element) + ggplot2::theme(axis.text.x=ggplot2::element_text(angle=90))
          if(any(curr_graph_data[[climatic_element]] > upper_limit, na.rm = TRUE)) {
            g <- g + ggplot2::geom_text(data = curr_graph_data[curr_graph_data[[climatic_element]] > upper_limit, ], mapping = ggplot2::aes_(y = upper_limit, label = as.name(climatic_element)), size = 3)
          }
          ngraph <- ngraph + 1
          graph_list[[length(graph_list) + 1]] <- g
        }
      }
      if(ngraph > 1) return(gridExtra::grid.arrange(grobs = graph_list))
      else return(g)
    },
    
    #' @description
    #' Get the names of all metadata variables for specified columns.
    #'
    #' @param columns A vector of column names.
    #' @return A vector of unique metadata variable names.
    get_variables_metadata_names = function(columns) {
      if(missing(columns)) columns <- self$get_column_names()
      cols <- self$get_columns_from_data(columns, force_as_data_frame = TRUE)
      return(unique(as.character(unlist(sapply(cols, function(x) names(attributes(x)))))))
    },
    
    #' @description
    #' Create a variable set with a specified name and columns.
    #'
    #' @param set_name The name of the variable set.
    #' @param columns A vector of column names to include in the set.
    #' @return None
    create_variable_set = function(set_name, columns) {
      adjusted_set_name <- paste0(set_prefix, set_name)
      if(adjusted_set_name %in% self$get_variables_metadata_names()) warning("A set named ", set_name, " already exists and will be replaced.")
      self$append_to_variables_metadata(col_names = setdiff(self$get_column_names(), columns), property = adjusted_set_name, new_val = FALSE)
      self$append_to_variables_metadata(col_names = columns, property = adjusted_set_name, new_val = TRUE)
    },
    
    #' @description
    #' Update an existing variable set with new columns or rename it.
    #'
    #' @param set_name The name of the existing variable set.
    #' @param columns A vector of new column names to include in the set.
    #' @param new_set_name An optional new name for the variable set.
    #' @return None
    update_variable_set = function(set_name, columns, new_set_name) {
      if(!missing(new_set_name) && new_set_name != set_name) {
        self$delete_variable_sets(set_names = set_name)
      }
      suppressWarnings(self$create_variable_set(set_name = new_set_name, columns = columns))
    },
    
    #' @description
    #' Delete specified variable sets.
    #'
    #' @param set_names A vector of variable set names to delete.
    #' @return None
    delete_variable_sets = function(set_names) {
      adjusted_set_names <- paste0(set_prefix, set_names)
      if(!all(adjusted_set_names %in% self$get_variables_metadata_names())) {
        warning("Some of the variable set names were not found. Sets will not be deleted.")
      }
      else {
        sapply(adjusted_set_names, function(x) self$append_to_variables_metadata(col_names = self$get_column_names(), property = x, new_val = NULL))
      }
    },
    
    #' @description
    #' Get the names of all variable sets.
    #'
    #' @param include_overall A logical value indicating whether to include the overall set.
    #' @param include A vector of set names to include.
    #' @param exclude A vector of set names to exclude.
    #' @param include_empty A logical value indicating whether to include empty sets.
    #' @param as_list A logical value indicating whether to return the result as a list.
    #' @param excluded_items A vector of items to exclude.
    #' @return A vector or list of variable set names.
    get_variable_sets_names = function(include_overall = TRUE, include, exclude, include_empty = FALSE, as_list = FALSE, excluded_items = c()) {
      metadata_names <- self$get_variables_metadata_names()
      set_names <- stringr::str_sub(metadata_names[startsWith(metadata_names, set_prefix)], start = nchar(set_prefix) + 1)
      if(as_list) {
        out <- list()
        out[[self$get_metadata(data_name_label)]] <- set_names
      }
      else out <- set_names
      return(out)
    },
    
    #' @description
    #' Get the columns belonging to specified variable sets.
    #'
    #' @param set_names A vector of variable set names.
    #' @param force_as_list A logical value indicating whether to force the result as a list.
    #' @return A list of column names or a single vector of column names.
    get_variable_sets = function(set_names, force_as_list) {
      curr_set_names <- self$get_variable_sets_names()
      if(!missing(set_names) && !all(set_names %in% curr_set_names)) stop("Not all of: ", paste(set_name, collapse = ", "), "exist as variable sets.")
      include_lists <- rep(list(TRUE), length(set_names))
      names(include_lists) <- paste0(set_prefix, set_names)
      out <- lapply(seq_along(include_lists), function(i) self$get_column_names(include = include_lists[i]))
      if(length(set_names) == 1 && !force_as_list) {
        out <- as.character(unlist(out))
      }
      return(out)
    },
    
    #' @description
    #' Patch daily climatic elements in the dataset.
    #'
    #' @param date_col_name The name of the date column.
    #' @param var The name of the variable to patch.
    #' @param vars A vector of variables to use for patching.
    #' @param max_mean_bias The maximum mean bias allowed.
    #' @param max_stdev_bias The maximum standard deviation bias allowed.
    #' @param column_name The name of the column to store the patched values.
    #' @param station_col_name The name of the station column.
    #' @param time_interval The time interval for patching.
    #' @return None
    patch_climate_element = function(date_col_name = "", var = "", vars = c(), max_mean_bias = NA, max_stdev_bias = NA, column_name, station_col_name, time_interval = "month") {
      if (missing(date_col_name)) stop("date is missing with no default")
      if (missing(var)) stop("var is missing with no default")
      if (missing(vars)) stop("vars is missing with no default")
      date_col <- self$get_columns_from_data(date_col_name, use_current_filter = FALSE)
      min_date <- min(date_col)
      max_date <- max(date_col)
      full_date_range <- seq(from = min_date, to = max_date, by = "day")
      if (!lubridate::is.Date(date_col)) stop("This column must be a date or time!")
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      if (!missing(station_col_name)) {
        station_col <- self$get_columns_from_data(station_col_name, use_current_filter = FALSE)
        station_names <- unique(station_col)
        list_out <- list()
        date_lengths <- NULL
        for (i in seq_along(station_names)) {
          temp_data <- curr_data[station_col == station_names[i], ]
          min_date <- min(temp_data[, date_col_name])
          max_date <- max(temp_data[, date_col_name])
          full_date_range <- seq(from = min_date, to = max_date, by = "day")
          date_lengths[i] <- length(full_date_range)
          var_col <- temp_data[, var]
          date_col <- temp_data[, date_col_name]
          Year <- lubridate::year(date_col)
          Month <- lubridate::month(date_col)
          Day <- lubridate::day(date_col)
          weather <- data.frame(Year, Month, Day, var_col)
          colnames(weather)[4] <- var
          patch_weather <- list()
          for (j in seq_along(vars)) {
            col <- temp_data[, vars[j]]
            patch_weather[[j]] <- data.frame(Year, Month, Day, col)
            colnames(patch_weather[[j]])[4] <- var
          }
          out <- chillR::patch_daily_temps(weather = weather, patch_weather = patch_weather, vars = var, max_mean_bias = max_mean_bias, max_stdev_bias = max_stdev_bias, time_interval = time_interval)
          list_out[[i]] <- out[[1]][, var]
        }
        gaps <- sum(date_lengths) - dim(curr_data)[[1]]
      } else {
        gaps <- length(full_date_range) - length(date_col)
        var_col <- self$get_columns_from_data(var, use_current_filter = FALSE)
        Year <- lubridate::year(date_col)
        Month <- lubridate::month(date_col)
        Day <- lubridate::day(date_col)
        weather <- data.frame(Year, Month, Day, var_col)
        colnames(weather)[4] <- var
        patch_weather <- list()
        for (i in seq_along(vars)) {
          col <- self$get_columns_from_data(vars[i], use_current_filter = FALSE)
          patch_weather[[i]] <- data.frame(Year, Month, Day, col)
          colnames(patch_weather[[i]])[4] <- var
        }
      }
      if (!missing(station_col_name)) {
        col <- unlist(list_out)
      }
      else {
        out <- chillR::patch_daily_temps(weather = weather, patch_weather = patch_weather, vars = var, max_mean_bias = max_mean_bias, max_stdev_bias = max_stdev_bias, time_interval = time_interval)
        col <- out[[1]][, var]
      }
      if (length(col) == dim(curr_data)[[1]]) {
        self$add_columns_to_data(col_name = column_name, col_data = col)
        gaps_remaining <- summary_count_miss(col)
        gaps_filled <- (summary_count_miss(curr_data[, var]) - gaps_remaining)
        cat(gaps_filled, " gaps filled", gaps_remaining, " remaining.", "\n")
      } else if (gaps != 0) {
        cat(gaps, " rows for date gaps are missing, fill date gaps before proceeding.", "\n")
      }
    },
    
    #' @description
    #' Visualize missing data for a specified element.
    #'
    #' @param element_col_name The name of the element column with missing data.
    #' @param element_col_name_imputed The name of the element column with imputed data.
    #' @param station_col_name The name of the station column.
    #' @param x_axis_labels_col_name The name of the column for x-axis labels.
    #' @param ncol The number of columns for the plot layout.
    #' @param type The type of plot ("distribution", "gapsize", "interval", or "imputation").
    #' @param xlab The label for the x-axis.
    #' @param ylab The label for the y-axis.
    #' @param legend A logical value indicating whether to include a legend.
    #' @param orientation The orientation of the plot ("horizontal" or "vertical").
    #' @param interval_size The size of the intervals for "interval" type plots.
    #' @param x_with_truth The column with true values for comparison.
    #' @param measure The measure for "interval" type plots ("percent" or "absolute").
    #' @return A ggplot object or a list of ggplot objects.
    visualize_element_na = function(element_col_name, element_col_name_imputed, station_col_name, x_axis_labels_col_name, ncol = 2, type = "distribution", xlab = NULL, ylab = NULL, legend = TRUE, orientation = "horizontal", interval_size = 1461, x_with_truth = NULL, measure = "percent") {
      curr_data <- self$get_data_frame()
      if (!missing(station_col_name)) {
        station_col <- self$get_columns_from_data(station_col_name)
        station_names <- unique(station_col)
      }
      if (!missing(element_col_name)) {
        element_col <- self$get_columns_from_data(element_col_name)
      }
      if (!missing(element_col_name_imputed)) {
        element_imputed_col <- self$get_columns_from_data(element_col_name_imputed)
      }
      if (!(type %in% c("distribution", "gapsize", "interval", "imputation"))) stop(type, " must be either distribution, gapsize or imputation")
      plt_list <- list()
      if (type == "distribution") {
        if (!missing(station_col_name) && dplyr::n_distinct(station_names) > 1) {
          for (i in seq_along(station_names)) {
            temp_data <- curr_data[station_col == station_names[i], ]
            plt_list[[i]] <- imputeTS::ggplot_na_distribution(x = temp_data[, element_col_name], x_axis_labels = temp_data[, x_axis_labels_col_name], title = station_names[i], xlab = xlab, ylab = ylab)
          }
        } else {
          plt <- imputeTS::ggplot_na_distribution(x = element_col, x_axis_labels = curr_data[, x_axis_labels_col_name], xlab = xlab, ylab = ylab)
        }
      } else if (type == "gapsize") {
        if (!missing(station_col_name) && dplyr::n_distinct(station_names) > 1) {
          for (i in seq_along(station_names)) {
            temp_data <- curr_data[station_col == station_names[i], ]
            plt_list[[i]] <- imputeTS::ggplot_na_gapsize(x = temp_data[, element_col_name], include_total = TRUE, title = paste0(station_names[i], ":Occurrence of gap sizes"), xlab = xlab, ylab = ylab, legend = legend, orientation = orientation)
          }
        } else {
          plt <- imputeTS::ggplot_na_gapsize(x = element_col, include_total = TRUE, xlab = xlab, ylab = ylab, legend = legend, orientation = orientation)
        }
      } else if (type == "interval") {
        if (!missing(station_col_name) && dplyr::n_distinct(station_names) > 1) {
          for (i in seq_along(station_names)) {
            temp_data <- curr_data[station_col == station_names[i], ]
            plt_list[[i]] <- imputeTS::ggplot_na_intervals(x = temp_data[, element_col_name], title = paste0(station_names[i], ":Missing Values per Interval"), ylab = ylab, interval_size = interval_size, measure = measure)
          }
        } else {
          plt <- imputeTS::ggplot_na_intervals(x = element_col, ylab = ylab, interval_size = interval_size, measure = measure)
        }
      } else if (type == "imputation") {
        if (!missing(station_col_name) && dplyr::n_distinct(station_names) > 1) {
          for (i in seq_along(station_names)) {
            temp_data <- curr_data[station_col == station_names[i], ]
            plt_list[[i]] <- imputeTS::ggplot_na_imputations(x_with_na = temp_data[, element_col_name], x_with_imputations = temp_data[, element_col_name_imputed], x_axis_labels = temp_data[, x_axis_labels_col_name], title = station_names[i], xlab = xlab, ylab = ylab, legend = legend, x_with_truth = x_with_truth)
          }
        } else {
          plt <- imputeTS::ggplot_na_imputations(x_with_na = element_col, x_with_imputations = element_imputed_col, x_axis_labels = curr_data[, x_axis_labels_col_name], xlab = xlab, ylab = ylab, legend = legend, x_with_truth = x_with_truth)
        }
      }
      if (!missing(station_col_name) && dplyr::n_distinct(station_names) > 1) {
        return(patchwork::wrap_plots(plt_list, ncol = ncol))
      }
      else {
        return(plt)
      }
    },
    
    #' @description
    #' Get data entry data for a specified range and type.
    #'
    #' @param station The name of the station column.
    #' @param date The name of the date column.
    #' @param elements The names of the element columns.
    #' @param view_variables Additional variables to view.
    #' @param station_name The name of the station.
    #' @param type The type of data ("day", "month", or "range").
    #' @param start_date The start date for the range.
    #' @param end_date The end date for the range.
    #' @return A data frame containing the specified data.
    get_data_entry_data = function(station, date, elements, view_variables, station_name, type, start_date, end_date) {
      cols <- c(date, elements)
      if (!missing(view_variables)) cols <- c(cols, view_variables)
      if (!missing(station)) cols <- c(station, cols)
      curr_data <- self$get_columns_from_data(cols)
      col_names <- c(date, elements)
      if (!missing(station)) col_names <- c(station, col_names)
      if (!missing(view_variables)) col_names <- c(col_names, paste(view_variables, "(view)"))
      names(curr_data) <- col_names
      
      if (!missing(station)) curr_data <- curr_data[curr_data[[station]] == station_name, ]
      if (type == "day") {
        curr_data <- curr_data[curr_data[[date]] == start_date, ]
      } else if (type == "month") {
        if (lubridate::day(start_date) != 1) warning("type = 'month' but start_date is not 1st of the month.")
        curr_data <- curr_data[curr_data[[date]] >= start_date & curr_data[[date]] <= (start_date + months(1) - 1), ]
      } else if (type == "range") {
        curr_data <- curr_data[curr_data[[date]] >= start_date & curr_data[[date]] <= end_date, ]
      }
      if (nrow(curr_data) == 0) stop("No data in range.")
      # Convert to character to they display correctly in VB grid.
      curr_data[[date]] <- as.character(curr_data[[date]])
      if (!missing(view_variables) && date %in% view_variables) curr_data[[paste(date, "(view)")]] <- as.character(curr_data[[paste(date, "(view)")]])
      if (!missing(station)) curr_data[[station]] <- as.character(curr_data[[station]])
      curr_data
    },
    
    #' @description
    #' Save data entry data after making changes.
    #'
    #' @param new_data The new data to save.
    #' @param rows_changed The rows that have changed.
    #' @param add_flags A logical value indicating whether to add flag fields.
    #' @param ... Additional arguments.
    #' @return None
    save_data_entry_data = function(new_data, rows_changed, add_flags = FALSE, ...) {
      if (ncol(new_data) > 1) {
        if (nrow(new_data) != length(rows_changed)) stop("new_data must have the same number of rows as length of rows_changed.")
        curr_data <- self$get_data_frame(use_current_filter = FALSE)
        changed_data <- curr_data
        for (i in seq_along(rows_changed)) {
          for (k in seq_along(names(new_data))) {
            changed_data[rows_changed[i], names(new_data)[k]] <- new_data[i, names(new_data)[k]]
          }
        }
        if (add_flags) {
          for (i in names(new_data)[-c(1:2)]) {
            col1 <- curr_data[, i]
            col2 <- changed_data[, i]
            if (paste0(i, "_fl") %in% colnames(changed_data)) {
              flag_col1 <- changed_data[, paste0(i, "_fl")]
              flag_col2 <- factor(x = ifelse(is.na(col1) & !is.na(col2), "add", ifelse(!is.na(col1) & is.na(col2), "edit", ifelse(col1 == col2, "data", "edit"))), levels = c("data", "add", "edit"))
              changed_data[, paste0(i, "_fl")] <- factor(ifelse(flag_col1 %in% c("edit", "add"), as.character(flag_col1), as.character(flag_col2)), levels = c("data", "add", "edit"))
            } else {
              changed_data[, paste0(i, "_fl")] <- factor(x = ifelse(is.na(col1) & !is.na(col2), "add", ifelse(!is.na(col1) & is.na(col2), "edit", ifelse(col1 == col2, "data", "edit"))), levels = c("data", "add", "edit"))
            }
          }
        }
        if(length(nrow(new_data)) > 0) cat("Row(s) updated: ", nrow(new_data), "\n")
        self$set_data(changed_data)
        # Added this line to fix the bug of having the variable names in the metadata changing to NA
        # This affects factor columns only  - we need to find out why and how to solve it best
        self$add_defaults_variables_metadata(self$get_column_names())
        self$data_changed <- TRUE
      }
    },
    
    #' @description
    #' Add flag fields to specified columns.
    #'
    #' @param col_names A vector of column names to add flag fields to.
    #' @return None
    add_flag_fields = function(col_names) {
      curr_data <- self$get_columns_from_data(col_names, force_as_data_frame = TRUE)
      for (i in colnames(curr_data)) {
        col_data <- factor(ifelse(is.na(curr_data[, i]), NA_real_, "data"), levels = c("data", "edit", "add"))
        self$add_columns_to_data(col_data = col_data, col_name = paste0(i, "_fl"))
      }
    },
    
    #' @description
    #' Remove empty rows or columns from the dataset.
    #'
    #' @param which A character vector indicating whether to remove empty "rows", "cols", or both.
    #' @return None
    remove_empty = function(which = c("rows", "cols")) {
      curr_data <- self$get_data_frame()
      old_metadata <- attributes(curr_data)
      new_df <- curr_data |>
        janitor::remove_empty(which = which)
      row_message <- paste(nrow(curr_data) - nrow(new_df), "empty rows deleted")
      cols_message <- paste(ncol(curr_data) - ncol(new_df), "empty variables deleted")
      if (all(which %in% "rows")) cat(row_message, "\n")
      if (all(which %in% "cols")) cat(cols_message)
      if (all(c("rows", "cols") %in% which)) {
        cat(row_message, "\n")
        cat(cols_message)
      }
      
      
      if(self$column_selection_applied()){
        df_without_Selection <- self$get_data_frame(use_column_selection = FALSE)
        df_with_Selection <- self$get_data_frame()
        # Check for missing columns in new_df and remove them from df_with_Selection
        missing_columns <- setdiff(names(df_with_Selection), names(new_df))
        self$remove_current_column_selection()
        if (length(missing_columns) > 0 && ncol(df_with_Selection) != ncol(new_df)) {
          new_df <- df_without_Selection[, !names(df_without_Selection) %in% missing_columns]
        }else{ new_df <- df_without_Selection }
        
      }
      
      for (name in names(old_metadata)) {
        if (!(name %in% c("names", "class", "row.names"))) {
          attr(new_df, name) <- old_metadata[[name]]
        }
      }
      for (col_name in names(new_df)) {
        for (attr_name in names(attributes(private$data[[col_name]]))) {
          if (!attr_name %in% c("class", "levels")) {
            attr(new_df[[col_name]], attr_name) <- attr(private$data[[col_name]], attr_name)
          }
        }
      }
      
      self$set_data(new_df)
      self$data_changed <- TRUE
      private$.variables_metadata_changed <- TRUE
    },
    
    #' @description
    #' Replace values with NA at specified row and column indices.
    #'
    #' @param row_index A vector of row indices.
    #' @param column_index A vector of column indices.
    #' @return None
    replace_values_with_NA = function(row_index, column_index) {
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      self$save_state_to_undo_history()
      if(!all(row_index %in% seq_len(nrow(curr_data)))) stop("All row indexes must be within the dataframe")
      if(!all(column_index %in% seq_len(ncol(curr_data)))) stop("All column indexes must be within the dataframe")
      curr_data[row_index, column_index] <- NA
      self$set_data(curr_data)
    },
    
    #' @description
    #' Set options by context types for the current data sheet.
    #' @param obyc_types A named list of options by context types.
    #' @param key_columns A vector of key columns relevant to the data sheet.
    set_options_by_context_types = function(obyc_types = NULL, key_columns = NULL) {
      if (!all(names(obyc_types) %in% obyc_all_types)) {
        stop("Cannot recognize the following types: ", 
             paste(names(obyc_types)[!names(obyc_types) %in% obyc_all_types], collapse = ", "))
      }
      invisible(sapply(names(obyc_types), function(name) 
        self$append_to_variables_metadata(obyc_types[[name]], obyc_type_label, name)))
      
      other_cols <- dplyr::setdiff(x = self$get_column_names(), y = unlist(obyc_types))
      self$append_to_variables_metadata(other_cols, obyc_type_label, NA)
    },
    
    #' @description
    #' Check if specified columns have labels.
    #'
    #' @param col_names A vector of column names.
    #' @return A logical vector indicating if each column has labels.
    has_labels = function(col_names) {
      if(missing(col_names)) stop("Column name must be specified.")
      return(!is.null(attr(col_names, "labels")))
    },
    
    #' Add a Comment to Data Sheet
    #' @description Adds a new `instat_comment` object to the data sheet if the key is defined and valid.
    #' @param new_comment An `instat_comment` object to be added to the data sheet.
    #' @details This function first checks if a key is defined and valid for the data sheet.
    #' It also verifies that `new_comment` is an `instat_comment` object and that the key columns in `new_comment` are valid keys in the data frame.
    #' If the comment ID already exists, a warning is issued and the existing comment is replaced.
    #' @return None. This function modifies the data sheet by adding or replacing a comment.
    add_comment = function(new_comment) {
      if(!self$has_key()) stop("Define a key before adding comments. Comments can only be added to data frames when rows can be identified by a key.")
      if(!"instat_comment" %in% class(new_comment)) stop("new_comment must be of class 'instat_comment'")
      if(!self$is_key(names(new_comment$key_values))) stop("The columns specified as the names of key_values must be a key in the data frame")
      all_comment_ids <- self$get_comment_ids()
      if(length(all_comment_ids) > 0 && new_comment$id %in% all_comment_ids) warning("A comment with id: ", new_comment$id, " already exists. It will be replaced.")
      if(new_comment$id == "") new_comment$id <- as.character(max(as.numeric(all_comment_ids), 0, na.rm = TRUE) + 1)
      private$comments[[new_comment$id]] <- new_comment
    },
    
    #' Delete a Comment from Data Sheet
    #' @description Deletes a comment from the data sheet based on the comment ID.
    #' @param comment_id A character string representing the ID of the comment to be deleted.
    #' @details If the specified comment ID does not exist in the data sheet, an error is thrown.
    #' @return None. This function modifies the data sheet by removing the specified comment.
    delete_comment = function(comment_id) {
      if(!comment_id %in% self$get_comment_ids()) stop("No comment with id: ", comment_id, " was found.")
      private$comments[[comment_id]] <- NULL
    },
    
    #' Get All Comment IDs
    #' @description Retrieves all comment IDs currently stored in the data sheet.
    #' @return A character vector containing the IDs of all comments in the data sheet.
    get_comment_ids = function() {
      return(names(private$comments))
    },
    
    #' Get Comments as Data Frame
    #' @description Converts all comments in the data sheet to a data frame format for easier inspection and analysis.
    #' @details This function collects various fields from each comment and returns them in a data frame.
    #' The number of replies and attributes for each comment is also included.
    #' Currently, nested comments (replies) and additional attributes are not displayed in detail.
    #' @return A data frame with columns representing comment ID, key values, column, value, type, comment text, label, calculation, timestamp, number of replies, resolved status, active status, and number of attributes.
    get_comments_as_data_frame = function() {
      id <- sapply(private$comments, function(x) x$id)
      # Needs expanding for each key column
      key_columns <- unique(unlist(sapply(private$comments, function(x) names(x$key_values))))
      # key_vals <- list()
      # for(col in key_columns) {
      #   key_vals[[col]] <- sapply(private$comments, function(x) x$key_values[col])
      # }
      column <- sapply(private$comments, function(x) x$column)
      # Not sure what value will be yet
      value <- sapply(private$comments, function(x) x$value)
      type <- sapply(private$comments, function(x) x$type)
      comment <- sapply(private$comments, function(x) x$comment)
      label <- sapply(private$comments, function(x) x$label)
      calculation <- sapply(private$comments, function(x) x$calculation)
      # Returned as character to prevent sapply coercing to numeric
      time_stamp <- sapply(private$comments, function(x) as.character(x$time_stamp))
      # TODO how to display replies in data frame?
      no_replies <- sapply(private$comments, function(x) length(x$no_replies))
      resolved <- sapply(private$comments, function(x) x$resolved)
      active <- sapply(private$comments, function(x) x$active)
      # TODO how to display attributes in data frame?
      no_attributes <- sapply(private$comments, function(x) length(x$attributes))
      return(data.frame(id = id, key_values = key_values, column = column, value = value, type = type, comment = comment, label = label, calculation = calculation, time_stamp = time_stamp, no_replies = no_replies, resolved = resolved, active = active, no_attributes = no_attributes))
    }, 
    
    #' Save a Calculation to the DataSheet
    #' @description This method adds or updates a calculation in the `DataSheet` object. If a calculation 
    #' with the same name already exists, it will be replaced, with a warning issued to the user.
    #' @param calc A list or object representing the calculation to be saved. This object must 
    #'             contain a `name` field. If the `name` field is empty, a default name will be 
    #'             generated using the `instatExtras::next_default_item()` function.
    #' @details
    #' - If the `calc$name` field is empty, a default name is generated using the 
    #'   `instatExtras::next_default_item()` function, based on the prefix "calc" and the existing 
    #'   calculation names in the `private$calculations` environment.
    #' - If a calculation with the same name already exists in `private$calculations`, it 
    #'   will be replaced, and a warning will be issued to inform the user.
    #' - The calculation is saved in the `private$calculations` list, keyed by its `name`.
    #' @return The name of the saved calculation (a character string).
    #'
    #' @note Be cautious when replacing existing calculations, as the new calculation will 
    #'       overwrite the previous one without confirmation.
    save_calculation = function(calc) {
      if(calc$name == "") calc$name <- instatExtras::next_default_item("calc", names(private$calculations))
      if(calc$name %in% names(private$calculations)) warning("There is already a calculation called ", calc$name, ". It will be replaced.")
      private$calculations[[calc$name]] <- calc
      return(calc$name)
    },
    
    #' Merge New Data with Existing Data
    #' @description This method merges a new data frame with the existing data in the `DataSheet` object. 
    #' It supports multiple types of joins (left, right, inner, full) and ensures that the 
    #' data types of the columns used for merging are aligned.
    #'
    #' @param new_data A data frame containing the new data to merge with the existing data.
    #' @param by A character vector specifying the columns to join by. If `NULL`, the function 
    #'           will attempt to join by all columns with matching names.
    #' @param type A string specifying the type of join. Options are:
    #'             - `"left"`: Keeps all rows from the existing data.
    #'             - `"right"`: Keeps all rows from the new data.
    #'             - `"full"`: Keeps all rows from both data frames.
    #'             - `"inner"`: Keeps only rows that match in both data frames.
    #' @param match Reserved for future use. Currently not implemented.
    #' @return None. The merged data is stored internally in the `DataSheet` object.
    #' @details
    #' - The method ensures that the data types of the columns specified in `by` are aligned 
    #'   (e.g., converting factors to numeric if necessary).
    #' - Metadata from the original data is preserved and updated after the merge.
    #' - Column attributes for the `by` columns are restored after the merge.
    merge_data = function(new_data, by = NULL, type = "left", match = "all") {
      #TODO how to use match argument with dplyr join functions
      old_metadata <- attributes(private$data)
      curr_data <- self$get_data_frame(use_current_filter = FALSE)
      by_col_attributes <- list()
      
      if (!is.null(by)) {
        for (i in seq_along(by)) {
          # Collect column attributes
          by_col_attributes[[by[[i]]]] <- instatExtras::get_column_attributes(curr_data[[by[[i]]]])
          
          # Check and align the data types for each "by" column
          if (!inherits(curr_data[[by[[i]]]], class(new_data[[by[[i]]]]))) {
            warning(paste0("Type is different for ", by[[i]], " in the two data frames. Setting as numeric in both data frames."))
            
            # Convert factors to numeric if necessary
            if (inherits(curr_data[[by[[i]]]], "factor")) {
              curr_data[[by[[i]]]] <- as.numeric(as.character(curr_data[[by[[i]]]]))
            } else if (inherits(new_data[[by[[i]]]], "factor")) {
              new_data[[by[[i]]]] <- as.numeric(as.character(new_data[[by[[i]]]]))
            } else {
              stop(paste0("Type is different for ", by[[i]], " in the two data frames and cannot be coerced."))
            }
          }
        }
      }
      
      
      # Perform the appropriate join based on the "type" argument
      if (type == "left") {
        new_data <- dplyr::left_join(curr_data, new_data, by = by)
      } else if (type == "right") {
        new_data <- dplyr::right_join(curr_data, new_data, by = by)
      } else if (type == "full") {
        new_data <- dplyr::full_join(curr_data, new_data, by = by)
      } else if (type == "inner") {
        new_data <- dplyr::inner_join(curr_data, new_data, by = by)
      } else {
        stop("type must be one of left, right, inner, or full")
      }
      
      # Update the data in the object
      self$set_data(new_data)
      self$append_to_changes("Merged_data")
      
      # Restore the old metadata
      for (name in names(old_metadata)) {
        if (!name %in% c("names", "class", "row.names")) {
          self$append_to_metadata(name, old_metadata[[name]])
        }
      }
      
      self$append_to_metadata("is_calculated_label", TRUE)
      self$add_defaults_meta()
      self$add_defaults_variables_metadata(setdiff(names(new_data), names(curr_data)))
      
      # Add back column attributes for the "by" columns
      if (!is.null(by)) {
        for (i in seq_along(by_col_attributes)) {
          self$append_column_attributes(col_name = by[[i]], new_attr = by_col_attributes[[i]])
        }
      }
    },
    
    
    #' Calculate Summaries for Specified Columns
    #' @description This method computes summary statistics for specified columns in the data, 
    #' grouping by optional factors. It supports multiple summary functions (e.g., mean, sum) 
    #' and can handle missing values through the `na.rm` parameter.
    #'
    #' @param calc A calculation object containing parameters for the summary. The object 
    #'             should include:
    #'             - `columns_to_summarise`: Columns to compute the summaries for.
    #'             - `summaries`: Functions to apply (e.g., `"mean"`, `"sum"`).
    #'             - `factors`: Grouping factors for the summaries.
    #'             - `drop`: Whether to drop unused factor levels. Default is `FALSE`.
    #'             - `add_cols`: Additional columns to include in the output.
    #'             - `na.rm`: Logical, whether to remove missing values in the summaries. Default is `FALSE`.
    #'             - `filters`: Filters to apply before performing the summaries.
    #' @param ... Additional arguments to pass to the summary functions.
    #'
    #' @return A data frame containing the computed summaries. The output includes the grouping 
    #'         factors and the computed summary statistics.
    #'
    #' @details
    #' - The method applies the specified summaries to the columns provided in `columns_to_summarise`, 
    #'   grouping by `factors`.
    #' - Filters can be applied to restrict the data before calculating summaries.
    #' - Multiple summaries and columns can be computed in a single call.
    calculate_summary = function(calc, ...) {
      columns_to_summarise = calc[["parameters"]][["columns_to_summarise"]]
      summaries = calc[["parameters"]][["summaries"]]
      factors = calc[["parameters"]][["factors"]]
      drop = calc[["parameters"]][["drop"]]
      add_cols = calc[["parameters"]][["add_cols"]]
      if("na.rm" %in% names(calc[["parameters"]])) na.rm = calc[["parameters"]][["na.rm"]]
      else na.rm = FALSE
      filter_names = calc[["filters"]]
      if(missing(summaries)) stop("summaries must be specified")
      # Removed since curr_data_filter has same columns
      # curr_data_full <- self$get_data_frame(use_current_filter = FALSE)
      # if(!all(columns_to_summarise %in% names(curr_data_full))) stop(paste("Some of the columns from:",paste(columns_to_summarise, collapse = ","),"were not found in the data."))
      # if(!all(summaries %in% all_summaries)) stop(paste("Some of the summaries from:",paste(summaries, collapse = ","),"were not recognised."))
      # if(!all(factors %in% names(curr_data_full))) stop(paste("Some of the factors:","c(",paste(factors, collapse = ","),") were not found in the data."))
      combinations = expand.grid(summaries,columns_to_summarise)
      # Removed to only keep general case
      # if(length(summaries)==1) {
      #   if(length(columns_to_summarise) == 1) out = ddply(curr_data_filter, factors, function(x) match.fun(summaries)(x[[columns_to_summarise]],...), .drop = drop)
      #   else out = ddply(curr_data_filter, factors, function(x) sapply(columns_to_summarise, function(y) match.fun(summaries)(x[[y]],...)), .drop = drop)
      # }
      # else {
      #   if(length(columns_to_summarise) == 1) out = ddply(curr_data_filter, factors, function(x) sapply(summaries, function(y) match.fun(y)(x[[columns_to_summarise]],...)), .drop = drop)
      #   else out = ddply(curr_data_filter, factors, function(x) apply(combinations, 1, FUN = function(y) match.fun(y[[1]])(x[[y[[2]]]],...)), .drop = drop)
      # }
      if(length(filter_names) == 0) {
        filter_names <- "no_filter"
      }
      i = 1
      for(filter_name in filter_names) {
        curr_data_filter <- self$get_data_frame(use_current_filter = TRUE, filter_name = filter_name)
        curr_filter <- self$get_filter(filter_name)
        if(self$filter_applied()) {
          calc_filters <- list(self$get_current_filter(), curr_filter)
        }
        else calc_filters <- list(curr_filter)
        if(!all(columns_to_summarise %in% names(curr_data_filter))) stop(paste("Some of the columns from:",paste(columns_to_summarise, collapse = ","),"were not found in the data."))
        if(!all(summaries %in% all_summaries)) stop(paste("Some of the summaries from:",paste(summaries, collapse = ","),"were not recognised."))
        if(!all(factors %in% names(curr_data_filter))) stop(paste("Some of the factors:","c(",paste(factors, collapse = ","),") were not found in the data."))
        
        out <- plyr::ddply(curr_data_filter, factors, function(x) apply(combinations, 1, FUN = function(y) {
          # temp disabled to allow na.rm to be passed in
          #na.rm <- missing_values_check(x[[y[[2]]]])
          if("na.rm" %in% names(list(...))) stop("na.rm should not be specified. Use xxx to specify missing values handling.")
          match.fun(y[[1]])(x[[y[[2]]]], add_cols = x[add_cols], na.rm = na.rm, ...)
        }
        ), .drop = drop)
        names(out)[-(1:length(factors))] <- get_summary_calculation_names(calc, summaries, columns_to_summarise, calc_filters)
        if(i == 1) {
          calc_columns <- out
        }
        else {
          calc_columns <- full_join(calc_columns, out)
        }
        i = i + 1
      }
      return(calc_columns)
    },
    
    #' @description 
    #' Retrieve the climatic type attribute for a specific column.
    #' @param col_name Character, the name of the column to retrieve the attribute for.
    #' @param attr_name Character, the name of the attribute to retrieve.
    #' @return The value of the specified attribute, or NULL if not available.
    get_column_climatic_type = function(col_name, attr_name) {
      if (!is.null(private$data[[col_name]]) && !is.null(attr(private$data[[col_name]], attr_name))) {
        return(attr(private$data[[col_name]], attr_name))
      }
    },
    
    #' Update Column Selection
    #'
    #' This function updates the conditions of a specified column selection with new values.
    #'
    #' @param new_values A vector of new values to update the column selection with.
    #' @param column_selection_name A character string specifying the name of the column selection to update.
    #' @return No explicit return value. The function updates the column selection object in place.
    update_selection = function(new_values, column_selection_name = NULL) {
      if (missing(new_values)) stop("new_values is required")
      if (missing(column_selection_name)) stop("column_selection_name is required")
      
      column_selection_obj <- private$column_selections[[column_selection_name]]
      
      if (is.null(column_selection_obj)) {
        stop("No column selection found with the name: ", column_selection_name)
      }
      
      updated_conditions <- lapply(column_selection_obj$conditions, function(condition) {
        if ("parameters" %in% names(condition)) {
          condition$parameters$x <- new_values
        }
        return(condition)
      })
      
      column_selection_obj$conditions <- updated_conditions
      private$column_selections[[column_selection_name]] <- column_selection_obj
      
      self$data_changed <- TRUE
      
      message("Column selection '", column_selection_name, "' updated successfully with new values.")
    },
    
    #' @description 
    #' Generate an ANOVA table for specified predictor and response variables.
    #' Optionally includes totals, significance levels, and means.
    #' @param x_col_names Character vector, the names of predictor variables.
    #' @param y_col_name Character, the name of the response variable.
    #' @param total Logical, whether to include a total row in the ANOVA table. Defaults to FALSE.
    #' @param signif.stars Logical, whether to include significance stars. Defaults to FALSE.
    #' @param sign_level Logical, whether to display significance levels. Defaults to FALSE.
    #' @param means Logical, whether to include means or model coefficients. Defaults to FALSE.
    #' @param interaction Logical, whether to include interaction terms for predictors. Defaults to FALSE.
    #' @return A formatted ANOVA table with optional additional sections.
    anova_tables2 = function(x_col_names, y_col_name, total = FALSE, signif.stars = FALSE, sign_level = FALSE, means = FALSE, interaction = FALSE) {
      if (missing(x_col_names) || missing(y_col_name)) stop("Both x_col_names and y_col_name are required")
      if (sign_level || signif.stars) message("This is no longer descriptive")
      
      end_col <- if (sign_level) 5 else 4
      
      # Construct the formula
      if (length(x_col_names) == 1) {
        formula_str <- paste0(as.name(y_col_name), " ~ ", as.name(x_col_names))
      } else if (interaction && length(x_col_names) > 1) {
        formula_str <- paste0(as.name(y_col_name), " ~ ", as.name(paste(x_col_names, collapse = " * ")))
      } else {
        formula_str <- paste0(as.name(y_col_name), " ~ ", as.name(paste(x_col_names, collapse = " + ")))
      }
      
      mod <- lm(formula = as.formula(formula_str), data = self$get_data_frame())
      anova_mod <- anova(mod)[1:end_col]
      
      # Process ANOVA table
      anova_mod <- anova_mod %>%
        dplyr::mutate(
          `Sum Sq` = signif(`Sum Sq`, 3),
          `Mean Sq` = signif(`Mean Sq`, 3),
          `F value` = ifelse(`F value` < 100, round(`F value`, 1), round(`F value`))
        ) %>%
        dplyr::mutate(`F value` = as.character(`F value`)) %>%
        dplyr::mutate(across(`F value`, ~ tidyr::replace_na(., "--"))) %>%
        tibble::as_tibble(rownames = " ")
      
      # Add the total row if requested
      if (total) {
        anova_mod <- anova_mod %>%
          tibble::add_row(` ` = "Total", dplyr::summarise(., across(where(is.numeric), sum))) %>%
          dplyr::mutate(`F value` = ifelse(` ` == "Total", "--", `F value`)) # Replace NA with "--" for Total row
      }
      
      # Handle significance levels
      if (sign_level) {
        anova_mod <- anova_mod %>%
          dplyr::mutate(
            `Pr(>F)` = ifelse(
              is.na(`Pr(>F)`) | !is.numeric(`Pr(>F)`), "--",
              ifelse(`Pr(>F)` < 0.001, "<0.001", formatC(`Pr(>F)`, format = "f", digits = 3))
            )
          )
      }
      
      # Generate the table with a title
      title <- paste0("ANOVA of ", formula_str)
      formatted_table <- anova_mod %>%
        knitr::kable(format = "simple", caption = title)
      
      print(formatted_table)
      
      # Add line break before means section
      cat("\n")
      
      # Optionally print means or model coefficients
      if (means) {
        has_numeric <- any(sapply(x_col_names, function(x) class(mod$model[[x]]) %in% c("numeric", "integer")))
        has_factor <- any(sapply(x_col_names, function(x) class(mod$model[[x]]) == "factor"))
        
        if (has_numeric && has_factor) {
          cat("Model coefficients:\n")
          print(mod$coefficients)
        } else if (class(mod$model[[x_col_names[[1]]]]) %in% c("numeric", "integer")) {
          cat("Model coefficients:\n")
          print(mod$coefficients)
        } else {
          cat(paste0("Means tables of ", y_col_name, ":\n"))
          means_table <- capture.output(model.tables(aov(mod), type = "means"))
          means_table <- means_table[-1]
          cat(paste(means_table, collapse = "\n"))
        }
      }
    },
    
    # TRICOT DATA:
    #' @description
    #' Set the tricot types for columns in the data.
    #'
    #' @param types Named character vector, a named vector where names are tricot types and values are the corresponding column names in the dataset.
    #'
    #' @return None.
    #' 
    set_tricot_types = function(types) {
      self$append_to_variables_metadata(property = tricot_type_label, new_val = NULL)
      if(!all(names(types) %in% all_tricot_column_types))
        stop("Cannot recognise the following tricot types: ",
             paste(names(types)[!names(types) %in% all_tricot_column_types],
                   collapse = ", "))
      invisible(sapply(names(types), function(name)
        self$append_to_variables_metadata(types[name], tricot_type_label, name)))

      other_cols <- dplyr::setdiff(x = self$get_column_names(), y = unlist(types))
      self$append_to_variables_metadata(other_cols, tricot_type_label, NA)
      
      types <- types[sort(names(types))]
      cat("tricot dataset:", self$get_metadata(data_name_label), "\n")
      cat("----------------\n")
      cat("Definition", "\n")
      cat("----------------\n")
      for(i in seq_along(types)) {
        cat(names(types)[i], ": ", types[i], "\n", sep = "")
      }
    },
    
    #' @description
    #' Get the column name for a specified tricot type.
    #'
    #' @param col_name The tricot type to look for.
    #' @return The column name corresponding to the tricot type, or NULL if not found.
    get_tricot_column_name = function(col_name) {
      if(!self$get_metadata(is_tricot_label)) {
        warning("Data not defined as tricot.")
        return(NULL)
      }
      if(col_name %in% self$get_variables_metadata()$Tricot_Type){
        new_data = subset(self$get_variables_metadata(), Tricot_Type==col_name, select = Name)
        return(as.character(new_data))
      }
      else{
        message(paste(col_name, "column not found in the data."))
        return(NULL)
      }
    },
    
    #' @description
    #' Check if the data is defined as tricot.
    #'
    #' @return TRUE if the data is defined as tricot, FALSE otherwise.
    is_tricot_data = function() {
      return(self$is_metadata(is_tricot_label) &&  self$get_metadata(is_tricot_label))
    },
    
    #' @description 
    #' Retrieve the tricot type attribute for a specific column.
    #' @param col_name Character, the name of the column to retrieve the attribute for.
    #' @param attr_name Character, the name of the attribute to retrieve.
    #' @return The value of the specified attribute, or NULL if not available.
    get_column_tricot_type = function(col_name, attr_name) {
      if (!is.null(private$data[[col_name]]) && !is.null(attr(private$data[[col_name]], attr_name))) {
        return(attr(private$data[[col_name]], attr_name))
      }
    },
    
    #' Display Daily Summary Table
    #' @description Display a daily summary table for a specified climatic data element.
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
    #' 
    #' @details
    #' This function retrieves the data frame associated with the specified dataset and renames columns to standardise `Date`, `Year`, and `Station` for ease of processing. It then displays a daily summary table using the specified climatic elements, handling missing codes, trace codes, and zero codes as defined. Monthly statistics are calculated based on the `monstats` argument.
    display_daily_table = function(data_name, climatic_element, date_col = date_col, year_col = year_col, station_col = station_col, Misscode, Tracecode, Zerocode, monstats = c("min", "mean", "median", "max", "IQR", "sum")) {
      curr_data <- self$get_data_frame()
      if(missing(station_col)) curr_data[["Station"]] <- self$get_metadata(data_name_label)
      else names(curr_data)[names(curr_data) == station_col] <- "Station"
      names(curr_data)[names(curr_data) == date_col] <- "Date"
      names(curr_data)[names(curr_data) == year_col] <- "Year"
      return(DisplayDaily(Datain = curr_data, Variables = climatic_element, option = 1, Misscode = Misscode, Tracecode = Tracecode, Zerocode = Zerocode, monstats = monstats))
    }
    
  ),
  
  private = list(
    data = data.frame(),
    filters = list(),
    column_selections = list(),
    objects = list(),
    keys = list(),
    undo_history = list(),
    redo_undo_history = list(),
    comments = list(),
    calculations = list(),
    scalars = list(),
    changes = list(),
    disable_undo = FALSE,
    .current_filter = list(),
    .current_column_selection = list(),
    .data_changed = FALSE,
    .metadata_changed = FALSE, 
    .variables_metadata_changed = FALSE,
    .last_graph = NULL
  ),
  
  active = list(
    #' @field data_changed Logical, indicates if the data has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    data_changed = function(new_value) {
      if (missing(new_value)) return(private$.data_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.data_changed <- new_value
        self$append_to_changes(list(Set_property, "data_changed"))
      }
    },
    
    #' @field metadata_changed Logical, indicates if the metadata has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    metadata_changed = function(new_value) {
      if (missing(new_value)) return(private$.metadata_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "metadata_changed"))
      }
    },
    
    #' @field variables_metadata_changed Logical, indicates if the variables metadata has changed. 
    #' If setting a value, new_value must be TRUE or FALSE.
    variables_metadata_changed = function(new_value) {
      if (missing(new_value)) return(private$.variables_metadata_changed)
      else {
        if (new_value != TRUE && new_value != FALSE) stop("new_val must be TRUE or FALSE")
        private$.variables_metadata_changed <- new_value
        self$append_to_changes(list(Set_property, "variable_data_changed"))
      }
    },
    
    #' @field current_filter A list representing the current filter. 
    #' If setting a value, filter must be a list.
    current_filter = function(filter) {
      if (missing(filter)) {
        return(self$get_filter_as_logical(private$.current_filter$name))
      } else {
        private$.current_filter <- filter
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_filter"))
      }
    },
    
    #' @field current_column_selection A list representing the current column selection. 
    #' If setting a value, column_selection must be a list.
    current_column_selection = function(column_selection) {
      if (missing(column_selection)) {
        if (!is.null(private$.current_column_selection)) {
          return(self$get_column_selection_column_names(private$.current_column_selection$name))
        } else return(names(private$data))
      } else {
        private$.current_column_selection <- column_selection
        self$data_changed <- TRUE
        self$append_to_changes(list(Set_property, "current_column_selection"))
      }
    }
  )
)
