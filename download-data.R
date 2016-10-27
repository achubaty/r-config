#' Intelligently download data
#' 
#' Only downloads the specified files if it is not found locally.
#' Optionally unzips the files.
#' 
#' @param urls      A character vector of data file URLs.
#' @param dest      The directory path in which data should be downloaded.
#' @param checksum  Logical indicating whether downloaded files should be checksummed to verify them.
#' @param unzip     Logical indicating whether the file should be unzipped after download.
#' 
#' @author Alex Chubaty and Eliot Mcintire
#' @importFrom digest digest
#' 
dl.data <- function(urls, dest = ".", checksum = TRUE, unzip = FALSE) {
  tmp <- lapply(urls, function(f) {
    dest_file <- file.path(dest, basename(f))
    checksum_file <- file.path(dest, paste0(sub("^([^.]*).*", "\\1", basename(f)), ".checksum"))
    needDownload <- TRUE
    if (file.exists(dest_file)) {
      if (checksum) {
        if (file.exists(checksum_file)) {
          hash <- digest::digest(file = dest_file, algo = "xxhash64")
          hashCheck <- read.table(checksum_file, stringsAsFactors = FALSE)
          if (hash == hashCheck$checksum) {
            needDownload <- FALSE
            message("File, ", basename(dest_file), ", already exists. Skipping download.")
          } else {
            needDownload <- TRUE
          }
        } else {
          message("No hash file exists. Assuming current file, ", basename(f)," is correct")
          hash <- digest::digest(file = dest_file, algo = "xxhash64")
          write.table(data.frame(filename = dest_file, checksum = hash),
                      file = checksum_file)
          needDownload <- FALSE
        }
      } else {
        message(basename(dest_file), " already exists. Skipping download.")
        needDownload <- FALSE
      }
    }
    
    if (needDownload)  {
      download.file(url, dest_file)
      checksum <- digest::digest(file = dest_file, algo = "xxhash64")
      write.table(data.frame(filename = dest_file, checksum = checksum),
                  file = checksum_file)
      
      if (unzip) { unzip(dest_file, exdir = dest, overwrite = TRUE) }
    }
  })
  return(invisible())
}
