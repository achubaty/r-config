#' Faster masking of a raster using a polygon
#'
#' @param stack      A \code{RasterStack} object.
#' @param polygon    A \code{SpatialPolygons} object.
#'
#' @author Eliot Mcintire
#' @importFrom raster crop extract raster stack
#' @note HAS NOT BEEN FULLY TESTED
#'
fastMask <- function(stack, polygon) {
  croppedStack <- crop(stack, polygon)
  nonNACellIDs <- extract(croppedStack[[1]], polygon, cellnumbers = TRUE)
  nonNACellIDs <- do.call(rbind, nonNACellIDs)
  singleRas <- raster(croppedStack[[1]])
  singleRas[] <- NA
  maskedStack <- stack(lapply(seq_len(nlayers(stack)), function(x) singleRas))
  names(maskedStack) <- names(stack)
  maskedStack[nonNACellIDs[, "cell"]] <- croppedStack[nonNACellIDs[, "cell"]]
  maskedStack
}

#' Faster rasterizing of a polygon
#'
#' @param polygon    A \code{SpatialPolygons} object.
#' @param ras        A \code{RasterLayer} object.
#' @param field      The field to use from \code{polygon}.
#'
#' @author Eliot Mcintire
#' @importFrom plyr mapvalues
#' @importFrom raster extract raster
#' @note HAS NOT BEEN FULLY TESTED
#'
fastRasterize <- function(polygon, ras, field) {
  nonNACellIDs <- extract(ras, polygon, cellnumbers = TRUE)
  polygonIDs <- seq_along(nonNACellIDs)
  nonNACellIDs <- lapply(polygonIDs, function(x) cbind(nonNACellIDs[[x]], "ID" = x))
  nonNACellIDs <- do.call(rbind, nonNACellIDs)
  singleRas <- raster(ras)
  singleRas[] <- NA
  singleRas[nonNACellIDs[, "cell"]] <- nonNACellIDs[, "ID"]
  if (!missing(field)) {
    if (length(field) == 1) {
      singleRas[] <- plyr::mapvalues(singleRas[], from = polygonIDs, to = polygon[[field]])
      numFields <- 1
    } else {
      numFields <- 2
    }
  } else {
    numFields <- 3
  }
  if (numFields == 3) {
    field <- names(polygon)
  } 
  levels(singleRas) <- data.frame(ID = polygonIDs, polygon[field])
  singleRas
}
