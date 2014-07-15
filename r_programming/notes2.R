##
## Coercion
##

# as.*
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

x <- c("a", "b", "c")
as.numeric(x)

##
## Matrices
##

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

##
## Lists (similar to vectors but can contain multiple types)
##

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

##
## Remove missing or NA values
##

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

##
## Reading data (read.table, read.csv)
##

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

##
## Looping
##

# lapply: Loop over a list and evaluate a function on each element. Returns a list
# sapply: Same as lapply but try to simplify the result (combine into list/matrix/etc)
# apply: Apply a function over the margins of an array
# tapply: Apply a function over subsets of a vector
# mapply: Multivariate version of lapply

lapply(list, function, function_args)

# Anonymous functions
#
# Extract the first column of a matrix
lapply(x, function(elt) elt[,1])

# apply(x, margin, func, ...)
# margin is the dimension to keep. margin = 1 -> collapse columns, margin = 2 -> collapse rows
# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)

# take the mean of each row
x <- matrix(rnorm(200), 20, 10)
apply(x, 1, mean)

# take the mean of each column
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))

a = rnorm(10)
b = runif(10)
c = rnorm(10, 1)
x = c(a,b,c)
f = gl(3, 10)
mean(a)
mean(b)
mean(c)
tapply(x, f, mean)

# Splitting a data frame by month
library(datasets)
s <- split(airquality, airquality$Month)

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
# $‘5‘
#    Ozone  Solar.R     Wind
#       NA       NA 11.62258
# $‘6‘
#     Ozone   Solar.R      Wind
#        NA 190.16667  10.26667
# $‘7‘
#      Ozone    Solar.R       Wind
#         NA 216.483871   8.941935

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
#                5         6          7        8        9
# Ozone         NA        NA         NA       NA       NA
# Solar.R       NA 190.16667 216.483871       NA 167.4333
# Wind    11.62258  10.26667   8.941935 8.793548  10.1800

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm=TRUE))
#                   5            6             7            8           9 
# Ozone      23.61538     29.44444     59.115385    59.961538   31.44828 
# Solar.R   181.29630    190.16667    216.483871   171.857143  167.43333 
# Wind       11.62258     10.26667      8.941935     8.793548   10.18000

# Vectorize functions
#
# mapply(rep, 1:4, 4:1) is equivalent to
# list(rep(1, 4), rep(2, 3), rep(3, 2), rep(4, 1))

# Saving state via closures.
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(v = x) m <<- mean(v)
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

#


# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.
#
# Example Usage:
# mcm = makeCacheMatrix(matrix(rnorm(1:9), 3, 3))

makeCacheMatrix <- function(m = matrix()) {
    # Initialize internal state to the matrix and NULL inverse
    
    source.matrix <- m
    matrix.inverse <- NULL

    # NOTE: set() function provided in example is not required by HW specification
    reset <- function(m = matrix()) {
        source.matrix <<- m
        matrix.inverse <<- NULL
    }
    
    # Get the current matrix
    get <- function() { source.matrix }

    # Return the inverse
    get.inverse <- function() { matrix.inverse }

    # Set the inverse
    set.inverse <- function(inv) { matrix.inverse <<- inv }

    # Return a list of references to the internal functions
    list(get = get, reset=reset, set.inverse = set.inverse, get.inverse = get.inverse)
    
}  # makeCacheMatrix()

# cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix
# above. If the inverse has already been calculated (and the matrix has not changed), then the
# cachesolve should retrieve the inverse from the cache.
#
# Example Usage:
# cacheSolve(mcm)
# mcm$reset(matrix(rnorm(1:9), 3, 3))

cacheSolve <- function(cache.matrix, ...) {

    # Get the inverse of the cached matrix. If the inverse has already been calculated, return it
    # now. Otherwise calculate the inverse, save it, and return it.
    
    inv <- cache.matrix$get.inverse()
    if ( ! is.null(inv) ) {
        message("using cached inverse")
        return(inv)
    }

    # Get the matrix
    my.matrix <- cache.matrix$get()

    # Calculate the inverse and store in the local variable
    inv <- solve(my.matrix)

    # Save the result into the cached object for use later
    cache.matrix$set.inverse(inv)

    # Return the inverse
    return(inv)
    
}  # cacheSolve()


##
## Debugging
##

# traceback: prints out the function call stack after an error occurs; does nothing if there’s no
# error
#
# debug: flags a function for “debug” mode which allows you to step through execution of a function
# one line at a time
#
# browser: suspends the execution of a function wherever it is called and puts the function in debug
# mode
#
# trace: allows you to insert debugging code into a function a specific places
#
# recover: allows you to modify the error behavior so that you can browse the function call stack

##
## Simulate data
##

# Random number generation

# d* for density (dnorm)
# r* for random number generation (rnorm)
# p* for cumulative distribution (pnorm)
# q* for quantile function (aka inverse cumulative) (qnorm)

rnorm(n, mean = 0, sd = 1)
summary(rnorm(10, 20, 2))
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  15.94   17.68   20.04   19.46   20.76   22.52 

# Generate random samples for a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
#  Min. 1st Qu.  Median
# -6.4080 -1.5400  0.6789  0.6893  2.9300  6.5050
plot(x, y)

# Sampling

# random sample
sample(1:10, 4)
sample(letters, 3)

# with replacement
sample(1:10, 4, replace=TRUE)

##
## Profiling
##

system.time(readLines("http://www.jhsph.edu"))
##   user  system elapsed 
##  0.004   0.002   0.431

x <- hilbert(1000)
system.time(svd(x))
## Note elapsed time may be shorter than user + system if parallelism is present
##   user  system elapsed
##  1.605   0.094   0.742

## Does not profile inside C/Fortran code!
Rprof()
summaryRprof()


make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) {
    params <- fixed
    function(p) {
        params[!fixed] <- p
        mu <- params[1]
        sigma <- params[2]
        a <- -0.5*length(data)*log(2*pi*sigma^2)
        b <- -0.5*sum((data-mu)^2) / (sigma^2)
        -(a + b)
    }
}

## > set.seed(1); normals <- rnorm(100, 1, 2)
## > nLL <- make.NegLogLik(normals)
## > nLL
## function(p) {
##     params[!fixed] <- p
##     mu <- params[1]
##     sigma <- params[2]
##     a <- -0.5*length(data)*log(2*pi*sigma^2)
##     b <- -0.5*sum((data-mu)^2) / (sigma^2)
##     -(a + b)
## }
## <environment: 0x165b1a4>
## > ls(environment(nLL))
## [1] "data" "fixed" "params"
