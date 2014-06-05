
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
