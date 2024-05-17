#' Download data folder from OSF
#'
#' This function downloads a complete data folder from OSF. It allows you to specify multiple folders and nodes.
#'
#' @param download_folder A character vector specifying the folder(s) to download data into.
#' @param osf_node_component A character vector specifying the corresponding node(s) for each component.
#' @param osf_node_project An osf_project object representing the OSF project.
#' @param data_directory The directory where data will be downloaded. Default is "local_data/osf_pull".
#'
#' @return No explicit return value. Data will be downloaded to the specified directory.
#' @importFrom osfr here osf_download osf_ls_nodes osf_ls_files
#' @export
#' @examples
#' \dontrun{
#' download_folder <- c("base")
#' osf_node_component <- c("Base data")
#' osf_node_project <- osfr::osf_retrieve_node("Your OSF project")
#' download_osf_data(download_folder, osf_node_component, osf_node_project)
#' }
download_osf_component <- function(
    download_folders,
    osf_node_components,
    osf_node_project,
    data_directory = "local_data/osf_pull") {

  for (i in seq_along(download_folders)) {
    download_folder <- download_folders[i]
    osf_node_component <- osf_node_components[i]

    # Check if directory exists
    download_dir_folder <- here::here(data_directory, download_folder)
    if (!dir.exists(download_dir_folder)) {
      dir.create(download_dir_folder, recursive = TRUE)
    }

    # Download data
    osfr::osf_download(
      osf_node_project |>
        osfr::osf_ls_nodes(osf_node_component) |>
        osfr::osf_ls_files(n_max = 20),
      path = download_dir_folder,
      recurse = TRUE,
      conflicts = "overwrite",
      verbose = TRUE
    )
  }
}
