
devtools::load_all()
data_book <- DataBook$new()

x <- readRDS("~/cochran_bib.RDS")
data_book$import_RDS(x)

data_book$get_data_names()

data_book$get_data_frame("cochran_variety")


check_variety_data_level("cochran_variety", "gen")
check_variety_data_level("cochran_variety", c("gen", "gen_colour"))
check_variety_data_level("cochran_variety", "gen_colour")

check_variety_data_level("cochran.bib", "gen")
check_variety_data_level("cochran.bib", "gen_colour")
check_variety_data_level("cochran.bib", c("gen", "gen_recoded"))
check_variety_data_level("cochran.bib", c("gen", "gen_colour"))



#####################

library(databook)

devtools::load_all()

data_book <- DataBook$new()

# Setting display options (e.g Number of significant digits)
options(digits=4, show.signif.stars=FALSE, dplyr.summarise.inform=FALSE, R.commands.displayed.in.the.output.window=TRUE, Comments.from.dialogs.displayed.in.the.output.window=TRUE)

# 1. Import the data ===============================================================
utils::data(package="agridat", X=cochran.bib)
data_book$import_data(data_tables=list(cochran.bib=cochran.bib))


# Dialog: Define as Tricot ============================================================
data_book$define_as_tricot(data_name="cochran.bib", key_col_names=c("loc", "gen"), types=c(traits="yield", variety="gen", id="loc"), auto_selection=TRUE)

cochran.bib <- data_book$get_data_frame(data_name="cochran.bib")
traits <- data_book$get_column_selection(name="traits_selection", data_name="cochran.bib")
traits <- unname(traits$conditions$C0$parameters$x)
rankings_list <- instatExtras::create_rankings_list(data=cochran.bib, traits=traits, variety="gen", id="loc", FALSE)
data_book$add_object(data_name="cochran.bib", object_name="rankings_list", object_type_label="structure", object_format="text", object=rankings_list)

grouped_rankings_list <- instatExtras::create_rankings_list(data=cochran.bib, traits=traits, variety="gen", id="loc", TRUE)
data_book$add_object(data_name="cochran.bib", object_name="grouped_rankings_list", object_type_label="structure", object_format="text", object=grouped_rankings_list)

rm(list=c("grouped_rankings_list", "rankings_list", "cochran.bib", "traits"))

# Set up: Create covariates that are at variety level but in the plot level data ===================================
cochran.bib <- data_book$get_data_frame(data_name="cochran.bib", use_current_filter=FALSE)
attach(what=cochran.bib)
calc1 <- cochran.bib %>% dplyr::group_by(gen) %>% mutate(x = round(mean(yield), 0)-20) %>% dplyr::pull(x)
data_book$add_columns_to_data(data_name="cochran.bib", col_name="calc1", col_data=calc1, before=FALSE)

detach(name=cochran.bib, unload=TRUE)
data_book$append_to_variables_metadata(data_name="cochran.bib", col_names="calc1", property="labels", new_val="")
rm(list=c("calc1", "cochran.bib"))
