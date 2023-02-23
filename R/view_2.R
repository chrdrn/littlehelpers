#' Data Table Alternative Viewer
#'
#' @description This is a custom function to view data frames with many variables, and include variable names, as defined in the labelled package, if they exist.
#'
#' @param df Data frame to view.
#' @param path Path where to save the temporary file, defaults to "dt_tmp.html".
#' @param size Number of randomly selected observations, defaults to 100.
#'
#' @return Nothing, opens browser window
#' @export
#'
#' @examples
#' view_2(data_wide)
#' View = view_2 # replaces RStudio standard viewer

view_2 = function(
    df,
    filename = "dt_tmp.html",
    size = 100
) {
  # dependencies
  require(dplyr)
  require(htmlwidgets)
  require(DT)
  require(labelled)  
  # function
  size = min(nrow(df), size) # updating size
  df_s = df %>% dplyr::sample_n(size) # subsampling data file
  dt = DT::datatable(df_s, 
                     rownames = F, 
                     colnames = paste0(colnames(df), lapply(labelled::var_label(df), function(x) {ifelse(!is.null(x), paste0(" / ", x), "")})),
                     options = list(paging = F)
                    )
  htmlwidgets::saveWidget(dt, filename) # saving file
  browseURL(paste0(getwd(), "/", filename)) # opening file in browser
  # warning if more rows than dislayed are presenent
  if(nrow(df) > nrow(df_s)) {warning(paste0("only displaying ", size, " random rows out of ", nrow(df), " rows"))}
}
