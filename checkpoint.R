## see: ?.Random.seed
##
## RNG SAVE CODE MODIFIED FROM:
## http://www.cookbook-r.com/Numbers/Saving_the_state_of_the_random_number_generator/
## https://stackoverflow.com/questions/13997444/

checkpoint.load = function(file="checkpoint.RData") {
    # check for previous checkpoint file
    if (file.exists(file)) {
        load(file)
        if (exists(".Random.seed")) {
            do.call("RNGkind", as.list(rng.kind))
            assign(".Random.seed", rng.state, .GlobalEnv)
        }
        return(invisible(TRUE))
    } else {
        return(invisible(FALSE))
    }
}

checkpoint.save = function(file="checkpoint.RData") {
    if (exists(".Random.seed"))  {
        assign("rng.state", get(".Random.seed", .GlobalEnv), .GlobalEnv)
        assign("rng.kind", RNGkind(), .GlobalEnv)
    }
    save.image(file) # saves entire workspace
    invisible(TRUE) # return "success" invisibly
}

### TEST CODE:
set.seed(0)
r <- runif(10000)
checkpoint.save()
r <- runif(10000)
checkpoint.load()
identical(r, runif(10000))
