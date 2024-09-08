# devtools::install_github("seungwoo-stat/L1centrality")
library(L1centrality)
library(igraph)

series_names <- c("Avengers", "Iron Man", "Spider-Man", "Thor", "Captain America",
                  "Guardians of the Galaxy", "Doctor Strange", "Black Panther", "Ant-Man")
series_nodes <- lapply(series_names, \(l) which(grepl(l, V(MCUmovie)$name)))
res_group <- matrix(ncol = 3, nrow = length(series_nodes))
colnames(res_group) <- c("minimum","maximum","average")
rownames(res_group) <- series_names

for(n in seq_along(colnames(res_group))){
  for(i in seq_along(series_nodes)){
    res_group[i,n] <- L1centGROUP(MCUmovie, nodes = series_nodes[[i]], eta = V(MCUmovie)$worldwidegross,
                                  method = colnames(res_group)[n])
  }
}
res_group[order(res_group[,"minimum"], decreasing = TRUE),] |> round(3)


## The group measure is *not* monotone: counterexample
L1centGROUP(MCUmovie, nodes = c(5, 25), method = "minimum")
L1centGROUP(MCUmovie, nodes = c(5, 25), method = "maximum")
L1centGROUP(MCUmovie, nodes = c(5, 25), method = "average")
L1cent(MCUmovie)[c(5, 25)]





