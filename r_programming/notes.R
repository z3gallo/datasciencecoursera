# Coercion
# as.*
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

x <- c("a", "b", "c")
as.numeric(x)

# Matrices
m <- matrix(nrow = 2, ncol = 3)
m
dim(b)
attributes(m)
m <- matrix(1:6, nrow = 2, ncol = 3) 
m

# Coerce a vector into a matrix
m <- 1:10 
dim(m) <- c(2, 5)
m

# Column and row binding
x <- 1:3
y <- 10:12
cbind(x, y)
rbind(x, y)

# Lists (similar to vectors but can contain multiple types)

# Factors (categorical vectors)
x <- factor(c("yes", "yes", "no", "yes", "no")) 
x
table(x)

# Specify the levels in non-alphabedical order
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
x

# Data frames
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
x
nrow(x)
ncol(x)

# Named vectors & matrices
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "norf") 
x
names(x)

x <- list(a = 1, b = 2, c = 3)m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 
m

# Subsetting
x <- c("a", "b", "c", "c", "d", "a")
x[1]
x[1:4]

# Use conditionals
x[x > "a"]

# Apply a logical vector to select items to subset
u <- x > "a"
u
x[u]

# Matrix subsets
x <- matrix(1:6, 2, 3)
x[1, 2]
x[2, 1]

# Full rows/cols
x[1, ]
x[, 2]

# Return a matrix rather than a single element (using drop=FALSE)
x <- matrix(1:6, 2, 3)
x[1, 2]
x[1, 2, drop = FALSE]

# Computing list subsets

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
name <- "foo"
x[[name]]  ## computed index for ‘foo’
x$name     ## element ‘name’ doesn’t exist!
x$foo

# Remove missing or NA values
x <- c(1, 2, NA, 4, NA, 5)
x[ ! is.na(x) ] # is.na() returns logical vector

# Find rows/cases with no missing values
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x, y)
good
x[good]
y[good]

# Remove missing values from a data frame (airquality)

airquality[1:6, ]
##   Ozone Solar.R Wind Temp Month Day
## 1    41     190  7.4   67     5   1
## 2    36     118  8.0   72     5   2
## 3    12     149 12.6   74     5   3
## 4    18     313 11.5   62     5   4
## 5    NA     NA  14.3   56     5   5
## 6    28     NA  14.9   66     5   6
good <- complete.cases(airquality)
airquality[good, ][1:6, ]

# Reading data (read.table, read.csv)
#
## read.table, read.csv, for reading tabular data
## readLines, for reading lines of a text file
## source, for reading in R code files (inverse of dump)
## dget, for reading in R code files (inverse of dput)
## load, for reading in saved workspaces
## unserialize, for reading single R objects in binary form

data <- read.table("foo.txt")

y <- data.frame(a = 1, b = "a")
dput(y)
## structure(list(a = 1,
##                b = structure(1L, .Label = "a",
##                              class = "factor")),
##           .Names = c("a", "b"), row.names = c(NA, -1L),
##           class = "data.frame")
dput(y, file = "y.R")
new.y <- dget("y.R")

# Connections
con <- file("foo.txt", "r")
data <- read.csv(con)
close(con)

# Read lines of a text file
con <- gzfile("words.gz") 
x <- readLines(con, 10) 

# Conditionals
for (i in seq_along(x)) print(x[i]);

count=10
while (count < 10) {
    print(count)
    count = count + 1
}

repeat {
    break
}

myFunc = function(x, y = 1.5, z = NULL) {
    return x
}

# Variable args. (...) matches any number of arguments and can come first in the arg list. Args
# after ... must be named.

myPlot = function(x, y, ...) {
    plot(x, y, ...)
}


add2 <- function(x, y) {
    x + y
}

# Return items >n

above <- function(x, n=10) {
    use = x > n
    x[use]
}

column.mean <- function(y) {
    nc <- ncol(y)
    means <- numeric(nc)
    for (i in 1:nc) {
        means[i] <- mean(y[,i])
    }
    means
}
