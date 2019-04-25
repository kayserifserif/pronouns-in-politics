calc.ingroup.i <- function(corpus.l) {
  ingroup.i <-
    length(corpus.l[grep("\\b(you|your|yours)\\b", corpus.l, ignore.case = TRUE)]) +
    length(corpus.l[grep("\\b(we|us|our|ours)\\b", corpus.l, ignore.case = TRUE)])
  return(as.integer(ingroup.i))
}

calc.outgroup.i <- function(corpus.l) {
  outgroup.i <- 
    length(corpus.l[grep("\\b(I|me|my|mine)\\b", corpus.l, ignore.case = TRUE)]) +
    length(corpus.l[grep("\\b(he|him|his)\\b", corpus.l, ignore.case = TRUE)]) +
    length(corpus.l[grep("\\b(she|her|hers)\\b", corpus.l, ignore.case = TRUE)]) +
    length(corpus.l[grep("\\b(they|their|theirs)\\b", corpus.l, ignore.case = TRUE)])
  return(as.integer(outgroup.i))
}

make.pronouns.freqs.m <- function(corpus.l) {
  pronouns.freqs.m <- matrix(ncol = 4, nrow = length(corpus.l), byrow = TRUE,
                             dimnames = list(c(1:length(corpus.l)), c("Name", "Ingroup", "Outgroup", "Total")))
  for (i in 1:length(corpus.l)) {
    pronouns.freqs.m[i,] = c(
      names(corpus.l[i]),
      as.numeric(calc.ingroup.i(corpus.l[[i]])),
      as.numeric(calc.outgroup.i(corpus.l[[i]])),
      as.numeric(calc.ingroup.i(corpus.l[[i]]) + calc.outgroup.i(corpus.l[[i]]))
    )
  }
  return(pronouns.freqs.m)
}

pronouns.freqs.obama.m <- make.pronouns.freqs.m(corpus.obama.l)

make.pronouns.rel.freqs.m <- function(pronouns.freqs.m) {
  pronouns.rel.freqs.m <- pronouns.freqs.m
  for (i in 2:4) {
    pronouns.rel.freqs.m[,i] <- 100*
      (as.numeric(pronouns.freqs.m[,i])/as.numeric(pronouns.freqs.m[,4]))
  }
  return(pronouns.rel.freqs.m)
}

pronouns.rel.freqs.obama.m <- make.pronouns.rel.freqs.m(pronouns.freqs.obama.m)
pronouns.rel.freqs.obama.m