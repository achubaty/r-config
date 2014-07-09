library(raster)

splitRaster = function(x, nx, ny, ...) {
    ext = extent(x)
    masked = vector("list", length=nx*ny)
    tiles = vector("list", length=nx*ny)
    
    n=1
    for (i in seq_len(nx)-1) {
        for (j in seq_len(ny)-1) {
            x0 = ext@xmin + i*(ext@xmax / nx)
            x1 = ext@xmin + (i+1)*(ext@xmax / nx)
            y0 = ext@ymin + j*(ext@ymax / ny)
            y1 = ext@ymin + (j+1)*(ext@ymax / ny)
            
            x.coords = c(x0, x1, x1, x0, x0)
            y.coords = c(y0, y0, y1, y1, y0)
            
            square = Polygon(cbind(x.coords, y.coords))
            square = Polygons(list(square), "square")
            square = SpatialPolygons(list(square))
            
            tiles[[n]] = rasterize(square, x)
            n = n+1
        }
    }
    
    # for each tile, do the masking:
    for (n in seq_len(nx*ny)) {
      #cropped = crop(x, tile)
      #newExtent = extent(crop(x, tiles[[n]]))
            
      masked[[n]] = mask(x, tiles[[n]])
      
      # writeRaster (but will have to make sure its loaded in memory when read later)
    }
    return(masked)
}

######################
# an example with dimensions:
# nrow = 77
# ncol = 101
# nlayers = 3
#
x <- brick(system.file("external/rlogo.grd", package="raster"))
x1 <- x[[1]] # use first layer only

nx = 3 # number of tiles along x
ny = 4 # number of tiles along y

y = splitRaster(x1, nx, ny)

quartz()
layout(mat=matrix(seq_len(nx*ny), ncol=nx, nrow=ny))
lapply(y, plot)
