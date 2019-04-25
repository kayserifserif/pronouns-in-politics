library(CGPfunctions)
library(ggplot2)
library(plyr)

# show.kwic <- function(corpus.l, pattern) {
#   words.l <- list()
#   range = 3
#   positions.v <- grep(pattern, corpus.l, ignore.case = TRUE)
#   if (length(positions.v) > 0) {
#     for (i in 1:length(positions.v)) {
#       start <- positions.v[i] - range
#       if (start < 1) {
#         start <- 1
#       }
#       end <- positions.v[i] + range
#       if (end > length(corpus.l)) {
#         end <- length(corpus.l)
#       }
#       words.l[i] <- cat(corpus.l[start:end], "\n")
#     }
#   }
# }

make.kwic.next.l <- function(corpus.l, keyword) {
  words.l <- list()
  for (text in 1:length(corpus.l)) {
    positions.v <- which(corpus.l[[text]][]==keyword)
    text.words.l <- list()
    for (i in 1:length(positions.v)) {
      text.words.l[[i]] <- corpus.l[[text]][positions.v[i]+1]
    }
    words.l[[text]] <- text.words.l
  }
  return(words.l)
}

kwic.obama.my.l <- make.kwic.next.l(corpus.obama.l, "my")
kwic.trump.my.l <- make.kwic.next.l(corpus.trump.l, "my")
kwic.obama.our.l <- make.kwic.next.l(corpus.obama.l, "our")
kwic.trump.our.l <- make.kwic.next.l(corpus.trump.l, "our")
kwic.obama.your.l <- make.kwic.next.l(corpus.obama.l, "your")
kwic.trump.your.l <- make.kwic.next.l(corpus.trump.l, "your")
kwic.obama.their.l <- make.kwic.next.l(corpus.obama.l, "their")
kwic.trump.their.l <- make.kwic.next.l(corpus.trump.l, "their")

make.kwic.rel.freq.t <- function(kwic.l) {
  kwic.v <- unlist(kwic.l)
  kwic.freqs.t <- sort(table(kwic.v), decreasing=TRUE)
  kwic.rel.freqs.t <- 100*(kwic.freqs.t/sum(kwic.freqs.t))
  return(kwic.rel.freqs.t)
}

kwic.rel.freqs.obama.my.t <- make.kwic.rel.freq.t(kwic.obama.my.l)
kwic.rel.freqs.trump.my.t <- make.kwic.rel.freq.t(kwic.trump.my.l)
kwic.rel.freqs.obama.our.t <- make.kwic.rel.freq.t(kwic.obama.our.l)
kwic.rel.freqs.trump.our.t <- make.kwic.rel.freq.t(kwic.trump.our.l)
kwic.rel.freqs.obama.your.t <- make.kwic.rel.freq.t(kwic.obama.your.l)
kwic.rel.freqs.trump.your.t <- make.kwic.rel.freq.t(kwic.trump.your.l)
kwic.rel.freqs.obama.their.t <- make.kwic.rel.freq.t(kwic.obama.their.l)
kwic.rel.freqs.trump.their.t <- make.kwic.rel.freq.t(kwic.trump.their.l)

make.rel.freqs.d <- function(rel.freqs.obama, rel.freqs.trump) {
  rel.freqs.d <- rbind(
    data.frame(
      president = "Obama",
      rel.freqs = rel.freqs.obama[1:20]
    ),
    data.frame(
      president = "Trump",
      rel.freqs = rel.freqs.trump[1:20]
    )
  )
  return(rel.freqs.d)
}

make.slopegraph.g <- function(df, title) {
  slopegraph <- newggslopegraph(
    dataframe = df,
    Times = president,
    Measurement = rel.freqs.Freq,
    Grouping = rel.freqs.kwic.v,
    Title = title,
    SubTitle = "Ordered by relative frequency",
    Caption = NULL
  )
  return(slopegraph)
}

my.d <- make.rel.freqs.d(kwic.rel.freqs.obama.my.t, kwic.rel.freqs.trump.my.t)
my.g <- make.slopegraph.g(my.d, "'My' in context")
our.d <- make.rel.freqs.d(kwic.rel.freqs.obama.our.t, kwic.rel.freqs.trump.our.t)
our.g <- make.slopegraph.g(our.d, "'Our' in context")
your.d <- make.rel.freqs.d(kwic.rel.freqs.obama.your.t, kwic.rel.freqs.trump.your.t)
your.g <- make.slopegraph.g(your.d, "'Your' in context")
their.d <- make.rel.freqs.d(kwic.rel.freqs.obama.their.t, kwic.rel.freqs.trump.their.t)
their.g <- make.slopegraph.g(their.d, "'Their' in context")