library(raster)

# an example with dimensions: 77, 101, 3  (nrow, ncol, nlayers)
x <- raster(system.file("external/rlogo.grd", package="raster"))

N = 4 # split raster into 4 tiles

y = splitRaster(x, "square", N)
layout(mat=matrix(seq_len(N), ncol=sqrt(N), nrow=sqrt(N)))
lapply(y, plot)

######################
splitRaster = function(x, shape="square", ntiles, ...) {
    ext = extent(x)
    masked = vector("list", length=ntiles)
    tiles = vector("list", length=ntiles)
    
    if (shape=="triangle") {
        # figure out dimensions using voodoo
        voodoo(x)
        
        triangle = Polygon(cbind(c(10, 80, 50, 10), c(10, 20, 65, 10))) # voodoo needed to get coords
        triangle = Polygons(list(triangle), "triangle")
        triangle = SpatialPolygons(list(triangle))
        
        tiles[[n]] = rasterize(triangle, x)
        
    } else if (shape=="square") {
        nx = ny = sqrt(ntiles)
        
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
        
    } else if (shape=="hexagon") {
        # figure out dimensions using voodoo
        voodoo(x)
    }
        
    # for each tile, do the masking:
    for (n in seq_len(ntiles)) {
        #cropped = crop(x, tile)
        masked[[n]] = mask(x, tiles[[n]])
        
        # writeRaster (but will have to make sure its loaded in memory when read later)
    }
    return(masked)
}

voodoo = function(x) { return(x) }
