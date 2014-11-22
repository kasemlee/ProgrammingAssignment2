## Matrix inversion is usually a costly computation and their may be some 
## benefit to caching the inverse of a matrix rather than compute it repeatedly
## The following two functions demonstrate how the scoping rulesand how they 
## can be manipulated to preserve state inside of an R object. They also show 
## the uses of the special assignment operator "<<-"

## For this assignment, assume that the matrix supplied is always invertible.

## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
    # initialize the inverse matrix to NULL during the first call to makeCacheMatrix
    # this is needed because ig getinverse() is called immediately after
    # the makeCacheMatrix function is constructed, without a call to setinverse
    # we know we must first get the inverse of the matrix in cacheSolve.  
    m <- NULL
    
    ## function to set a new value for the underlying matrix
    ## this invalidates the cached matrix, m
    set <- function(y) {
        ## we use the <<- operator to set the value of x and m because we want 
        ## to modify x and m defined in the enclosing environment (created 
        ## when makeCacheMatrix was first called), not in the environment local 
        ## to set(), in which x and m are undefined.
        x <<- y
        ## we must reset m to NULL since we are modifying the underlying
        ## matrix and the cached value is no longer the valid
        m <<- NULL
    }
    get <- function() x
    setinverse <- function(inverse) m <<- inverse
    getinverse <- function()        m
    list(set = set, get = get,
         setinverse = setinverse,
         getinverse = getinverse)
}


## This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated (and 
## the matrix has not changed), then cacheSolve should retrieve the inverse 
## from the cache.
cacheSolve <- function(x) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    ## call get() to get the underlying matrix
    data <- x$get()
    ## Computing the inverse of a square matrix can be done with the solve 
    ## function in R. For example, if X is a square invertible matrix, then 
    ## solve(X) returns its inverse.
    m <- solve(data)
    x$setinverse(m)
    m
}
