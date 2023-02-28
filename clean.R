
#install.packages('data.table') # if needed

# setup environment
if (!require(data.table)) install.packages('data.table') # this is still a bit dodgy - shouldn't install things for people
# note that clearing the environment, setting paths no longer happens - that's all managed outside the script

# fetch the arguments from the command line, other than the script name
.args <- commandArgs(trailingOnly = TRUE)

# which are source data and target output figure
d <- fread(.args[1])
tarfile <- tail(.args, 1)
# we use `tail()` here, because we have adopted a pattern where the last argument is the target file
# now, if we add additional arguments, we don't have to change picking out the target file

# convert date field, compute the crude CFR
d$date = as.Date(d$date)
d$crude_cfr = d$new_deaths_smoothed_per_million/d$new_cases_smoothed_per_million

# and now we just save the data in the R native format - plotting should happen in a different script
saveRDS(d, tarfile)
