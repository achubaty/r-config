if (!require("Require", quietly = TRUE)) {
  install.packages("Require")
}

library("Require")
Require("benchmarkme")

res <- benchmark_std(runs = 10)
plot(res)

res_io <- benchmark_std(runs = 10)
plot(res_io)

# parallel ------------------------------------------------------------------------------------

ncores <- parallel::detectCores() / 2

res_p <- benchmark_std(runs = 10, cores = ncores)
plot(res_p)

res_io_p <- benchmark_std(runs = 10, cores = ncores)
plot(res_io_p)

# upload results ------------------------------------------------------------------------------

upload_results(res, args = list(sys_info = FALSE))
upload_results(res_io, args = list(sys_info = FALSE))

upload_results(res_p, args = list(sys_info = FALSE))
upload_results(res_io_p, args = list(sys_info = FALSE))
