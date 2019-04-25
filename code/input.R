input.obama.dir <- "../speeches/obama"
input.trump.dir <- "../speeches/trump"
files.obama.v <- dir(input.obama.dir)
files.trump.v <- dir(input.trump.dir)

make.file.word.v.l <- function(files.v, input.dir) {
  # set up an empty container
  text.word.vector.l <- list()
  # loop over the files
  for (i in 1:length(files.v)) {
    # read the file in
    text.v <- scan(paste(input.dir, files.v[i], sep="/"),
                   what="character", sep="\n")
    # convert to single string
    text.v <- paste(text.v, collapse=" ")
    text.lower.v <- tolower(text.v)
    text.words.v <- strsplit(text.lower.v, "\\W")
    text.words.v <- unlist(text.words.v)
    # remove blanks
    text.words.v <- text.words.v[which(text.words.v!="")]
    # use index id from files.v vector as "name" in list
    text.word.vector.l[[files.v[i]]] <- text.words.v
  }
  return(text.word.vector.l)
}

corpus.obama.l <- make.file.word.v.l(files.obama.v, input.obama.dir)
corpus.trump.l <- make.file.word.v.l(files.trump.v, input.trump.dir)