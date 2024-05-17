#' OSF Setup for DBD
#'
#' @description This is a custom function to create a data import pipeline for the Digital behavioral data seminar. It creates the local folders for saving the data downloaded from an osf repository. ´For the package to work correctly, the following parameters must be defined in the R Environemnt: OSF_PAT (Personal Access Token for OSF) and OSF_PATH (URL of the OSF project)
#'
#' @param semester OsF folder name of the semester (character string; e.g. "2022_ws").
#' @param session OSF folder name of the session (character string; e.g. "04-api_access-twitter").
#'
#' @return List with string parameteres
#' @importFrom fs dir_create
#' @importFrom here here
#' @importFrom osfr osf_retrieve_node osf_ls_files
#' @export
osf_setup_dbd <- function(semester = "OSF folder name of the semster",
                          session = "OSF folder name of the session") {

  # Create local_data_path`
  local_data_path <- paste0("content/", session, "/data.local")

  # Create data directory on disk
  fs::dir_create(
    here::here(local_data_path)
    )

  # Create `osf_data_path`
  ## Get OSF information
  node <- osfr::osf_retrieve_node(
    Sys.getenv("OSF_PATH")
    )

  ## Get OSF path
  osf_data_path <- osfr::osf_ls_files(
    node,
    path = paste0(semester, "/", session))

  # Create list for output
  output <- list(
    local_data_path = local_data_path,
    osf_data_path = osf_data_path
  )

  # Return output
  return(output)
}
