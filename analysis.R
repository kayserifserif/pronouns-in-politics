library(CGPfunctions)
library(ggplot2)
library(plyr)

setwd("~/Documents/pronouns-in-politics")

clusters_my <- read.table("data/clusters/clusters_my.txt", header = TRUE, sep = "\t")
clusters_our <- read.table("data/clusters/clusters_our.txt", header = TRUE, sep = "\t")
clusters_their <- read.table("data/clusters/clusters_their.txt", header = TRUE, sep = "\t")
pronoun_rankings <- read.table("data/wordlist/pronoun_rankings.txt", header = TRUE, sep = "\t")

g_cmy <- newggslopegraph(
  dataframe = clusters_my,
  Times = President,
  Measurement = Freq,
  Grouping = Cluster,
  Title = "Clusters of 'my' for Obama and Trump",
  SubTitle = "Ordered by frequency",
  Caption = NULL
)

g_cour <- newggslopegraph(
  dataframe = clusters_our,
  Times = President,
  Measurement = Freq,
  Grouping = Cluster,
  Title = "Clusters of 'our' for Obama and Trump",
  SubTitle = "Ordered by frequency",
  Caption = NULL,
  YTextSize = 2,
  LineThickness = 0.5
)

g_ctheir <- newggslopegraph(
  dataframe = clusters_their,
  Times = President,
  Measurement = Freq,
  Grouping = Cluster,
  Title = "Clusters of 'their' for Obama and Trump",
  SubTitle = "Ordered by frequency",
  Caption = NULL
)

g_pronouns <- newggslopegraph(
  dataframe = pronoun_rankings,
  Times = President,
  Measurement = Rank,
  Grouping = Pronoun,
  Title = "Pronoun rankings for Obama and Trump",
  SubTitle = "Ordered by rank of usage in five speeches",
  Caption = "In-group pronouns in blue; out-group pronouns in yellow",
  LineColor = c(
    "we" = "#AEC7D5", "us" = "#AEC7D5", "our" = "#AEC7D5",
    "you" = "#AEC7D5", "your" = "#AEC7D5",
    "i" = "#EFD8A7", "me" = "#EFD8A7", "my" = "#EFD8A7", 
    "they" = "#EFD8A7", "them" = "#EFD8A7", "their" = "#EFD8A7", 
    "she" = "#EFD8A7", "her" = "#EFD8A7",
    "he" = "#EFD8A7"
  )
)
g_pronouns <- g_pronouns + scale_y_continuous(trans = "reverse")

ggsave(
  filename = "output/clusters_my1.png",
  plot = g_cmy,
  width = 159,
  height = 106,
  units = "mm",
  dpi = "retina"
)

ggsave(
  filename = "output/clusters_our1.png",
  plot = g_cour,
  width = 159,
  height = 317,
  units = "mm",
  dpi = "retina"
)

ggsave(
  filename = "output/clusters_their1.png",
  plot = g_ctheir,
  width = 159,
  height = 106,
  units = "mm",
  dpi = "retina"
)

ggsave(
  filename = "output/pronoun_rankings1.png",
  plot = g_pronouns,
  width = 159,
  height = 317,
  units = "mm",
  dpi = "retina"
)
