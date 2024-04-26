#' Download data folder from OSF
#'
#' This function downloads a complete data folder from OSF. It allows you to specify multiple folders and nodes.
#'
#' @param osf_folders A character vector specifying the folder(s) to download data from.
#' @param osf_folders_nodes A character vector specifying the corresponding node(s) for each folder.
#' @param osf_project_node An osf_project object representing the OSF project.
#' @param data_directory The directory where data will be downloaded. Default is "local_data/osf_pull".
#'
#' @return No explicit return value. Data will be downloaded to the specified directory.
#' @importFrom osfr here osf_download osf_ls_nodes osf_ls_files
#' @export
 #' @examples
#' \dontrun{
#' osf_folders <- c("base")
#' osf_folders_nodes <- c("Base data")
#' osf_project_node <- osfr::osf_retrieve_node("Your OSF project")
#' download_osf_data(osf_folders, osf_folders_nodes, osf_project_node)
#' }
download_osf_folder <- function(
    osf_folders,
    osf_folders_nodes,
    osf_project_node,
    data_directory = "local_data/osf_pull") {

  for (i in seq_along(osf_folders)) {
    osf_folder <- osf_folders[i]
    osf_folder_node <- osf_folders_nodes[i]

    # Check if directory exists
    download_dir_folder <- here::here(data_directory, osf_folder)
    if (!dir.exists(download_dir_folder)) {
      dir.create(download_dir_folder, recursive = TRUE)
    }

    # Download data
    osfr::osf_download(
      osf_project_node |>
        osfr::osf_ls_nodes(osf_folder_node) |>
        osfr::osf_ls_files(n_max = 20),
      path = download_dir_folder,
      recurse = TRUE,
      conflicts = "overwrite",
      verbose = TRUE
    )
  }
}
