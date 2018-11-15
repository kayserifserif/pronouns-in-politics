library(CGPfunctions)
library(ggplot2)
library(plyr)

setwd("~/Documents/pronouns-in-politics")

clusters_my <- read.table("data/clusters/clusters_my.txt", header = TRUE, sep = "\t")
clusters_our <- read.table("data/clusters/clusters_our.txt", header = TRUE, sep = "\t")
clusters_their <- read.table("data/clusters/clusters_their.txt", header = TRUE, sep = "\t")

g_cmy <- newggslopegraph(
  dataframe = clusters_my,
  Times = President,
  Measurement = Rank,
  Grouping = Cluster,
  Title = "Clusters of 'my' for Obama and Trump",
  SubTitle = "Ordered by rank",
  Caption = NULL
)
g_cmy <- g_cmy + scale_y_continuous(trans = "reverse")

g_cour <- newggslopegraph(
  dataframe = clusters_our,
  Times = President,
  Measurement = Rank,
  Grouping = Cluster,
  Title = "Clusters of 'our' for Obama and Trump",
  SubTitle = "Ordered by rank",
  Caption = NULL
)
g_cour <- g_cour + scale_y_continuous(trans = "reverse")

g_ctheir <- newggslopegraph(
  dataframe = clusters_their,
  Times = President,
  Measurement = Rank,
  Grouping = Cluster,
  Title = "Clusters of 'their' for Obama and Trump",
  SubTitle = "Ordered by rank",
  Caption = NULL
)
g_ctheir <- g_ctheir + scale_y_continuous(trans = "reverse")

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