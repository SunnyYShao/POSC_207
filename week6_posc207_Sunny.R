#############################
# Sunny Shao       #
# Basic Classes and methods #
# Week 6               #
#############################
library(tidyverse)
rm(list=ls())

setClass("cmps_2016", representation(data = "data.frame", 
                                    groups="character"))

####################################
# generate summarize table Data #
####################################
cmps <- readxl::read_xlsx("~/Dropbox/pd_research/new working directory/CMPS.xlsx")
cross<-table(cmps$pd, cmps$Generation)
prop.table(cross,2)*100

generation <- c(1:4)
pd <- c(47,53,56,60)
dat <- data.frame(generation, pd); dat
dat$pd <- as.integer(dat$pd)
######################################
# Create Function that outputs class #
######################################

dat_prep <- function(dat) {
  dat <- dat[,1:2]
  tab_out <- dat
  groups <- c("Generational Status", "Percent Perceived Discrimination")
  tab_out <- new("cmps_2016", data = tab_out, groups=groups)
  return(tab_out)
}

############################################
# Creating Plot Method for Class: cmps_2016 #
############################################

plot.cmps_2016 <- function(x, ...) {
  # Extract columns 1 and 2 from dat_prep function output
  xvar <- x@data[,1]
  yvar <- x@data[,2]
  # Initite plot() within the function
  # Note: ggplot2() will also work here
  plot(xvar, yvar,
       xlab=x@groups[1],
       ylab=x@groups[2],
       bty="n",
       main = "Percent Perceived Discrimination by Generation",
       ...)
}

###########################
# Initiate First Function #
###########################

p_dat <- dat_prep(dat); p_dat

# Check Type of Clas (is S4 class/method?)

isS4(p_dat)

# Look at attributes
names(attributes(p_dat))

# How to Access Object Attributes
p_dat@data
p_dat@groups
p_dat@class

#####################
# Plot p_dat object #
#####################

plot(p_dat)

##################################
# Make Adjustments               #
##################################

plot(p_dat, pch=12, col="blue")

# Try out plotting another data
cross<-table(cmps$edu, cmps$Generation)
prop.table(cross,2)*100

generation <- c(1:4)
edu <- c(23, 18, 16, 12)
my_dat2 <- data.frame(generation, edu); my_dat2
my_dat2$edu <- as.integer(my_dat2$edu)


my_dat2 <- dat_prep(my_dat2)
# Plot out the data #
plot(my_dat2, pch=4, col="brown")
text(2.5,22, "% BA or higher by generation") # you can add text to
legend("topright", 
       title ="BA or Higher",
       pch=4, 
       col="brown", 
       legend="Generational Status",
       bty="n",
       cex=.7)

##################
# Summary Method #
##################

summary.cmps_2016 <- function(x, ...) {
  
  xvar <- x@data[,1]
  yvar <- x@data[,2]
  
  # Print out a bunch of stuff #
  cat("data.frame() dimensions\n")
  print( dim(x@data) )
  cat("XVar Length:\n")
  print(length(xvar))
  cat("YVar Length:\n")
  print(length(yvar))
  
}

# Now just use summary function/method to *summarize* data #
summary(my_dat2)
