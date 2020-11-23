A<-data
method = "TPS"

function (A, method = c("TPS", "Reg")) 
{
  if (inherits(A, "geomorphShapes")) {
    a <- A
    A <- simplify2array(a$landmarks)
  }
  if (any(is.na(A)) == FALSE) {
    stop("No missing data.")
  }
  method <- match.arg(method)
  if (length(dim(A)) != 3) {
    stop("Data matrix not a 3D array (see 'arrayspecs').")
  }
  if (method == "TPS") {
    A2 <- A
    spec.NA <- which(rowSums(is.na(two.d.array(A))) > 0)
    Y.gpa <- gpagen(A[, , -spec.NA], PrinAxes = FALSE, print.progress = FALSE)
    p <- dim(Y.gpa$coords)[1]
    k <- dim(Y.gpa$coords)[2]
    n <- dim(Y.gpa$coords)[3]
    ref <- mshape(arrayspecs(two.d.array(Y.gpa$coords) * 
                               Y.gpa$Csize, p, k))
    for (i in 1:length(spec.NA)) {
      missing <- which(is.na(A2[, 1, spec.NA[i]]))
      tmp <- tps2d3d(ref, ref[-missing, ], A2[-missing, 
                                              , spec.NA[i]], PB = FALSE)
      A2[, , spec.NA[i]] <- tmp
    }
  }
  if (method == "Reg") {
    spec.NA <- which(rowSums(is.na(two.d.array(A))) > 0)
    land.NA <- which(colSums(is.na(two.d.array(A))) > 0)
    p <- dim(A)[1]
    k <- dim(A)[2]
    A2 <- A
    complete <- A[, , -spec.NA]
    incomplete <- A[, , spec.NA]
    Y.gpa <- gpagen(complete, PrinAxes = FALSE, print.progress = FALSE)
    ref <- mshape(arrayspecs(two.d.array(Y.gpa$coords) * 
                               Y.gpa$Csize, p, k))
    complete <- arrayspecs(two.d.array(Y.gpa$coords) * Y.gpa$Csize, 
                           p, k)
    if (length(dim(incomplete)) > 2) {
      for (i in 1:dim(incomplete)[3]) {
        missing <- which(is.na(incomplete[, 1, i]))
        lndmk <- which(!is.na(incomplete[, 1, i]))
        tmp <- apply.pPsup(center(ref[-missing, ]), list(center(incomplete[-missing, 
                                                                           , i])))[[1]]
        incomplete[lndmk, , i] <- tmp
      }
    }
    if (length(dim(incomplete)) == 2) {
      missing <- which(is.na(incomplete[, 1]))
      lndmk <- which(!is.na(incomplete[, 1]))
      tmp <- apply.pPsup(center(ref[-missing, ]), list(center(incomplete[-missing, 
                                                                         ])))[[1]]
      incomplete[lndmk, ] <- tmp
    }
    A2[, , -spec.NA] <- complete
    A2[, , spec.NA] <- incomplete
    A.2d <- two.d.array(A2)
    for (i in 1:length(spec.NA)) {
      missing.coord <- which(is.na(A.2d[spec.NA[i], ]))
      x <- A.2d[-spec.NA, -missing.coord]
      y <- A.2d[-spec.NA, missing.coord]
      XY.vcv <- cov(cbind(x, y))
      S12 <- XY.vcv[1:dim(x)[2], (dim(x)[2] + 1):(dim(x)[2] + 
                                                    dim(y)[2])]
      pls <- svd(S12)
      U <- pls$u
      V <- pls$v
      XScores <- x %*% U
      YScores <- y %*% V
      beta <- coef(lm(YScores ~ XScores))
      miss.xsc <- c(1, A.2d[spec.NA[i], -missing.coord] %*% 
                      U)
      miss.ysc <- miss.xsc %*% beta
      pred.val <- miss.ysc %*% t(V)
      for (j in 1:length(V)) {
        A.2d[spec.NA[i], missing.coord[j]] <- pred.val[j]
      }
    }
    A2 <- arrayspecs(A.2d, dim(A)[1], dim(A)[2])
  }
  if ("a" %in% ls()) {
    a$landmarks <- lapply(1:length(a$landmarks), function(j) A2[, 
                                                                , j])
    A2 <- a
  }
  return(A2)
}
<bytecode: 0x7fd9c5742278>
  <environment: namespace:geomorph>
  