write_atlas_page <- function(map_number){
  template <- glue("# Map {map_number}

```{{r code_chunk_nr_{map_number}, echo=FALSE}}
source('R/map_finnic.R')
map_finnic({map_number})
```
This map has been generated from Lauri Kettunen's Finnish Dialect Atlas data 
which has been distributed [Avaa-portal](https://avaa.tdata.fi/web/kotus/aineistot).
The example has been created by Niko Partanen, and the reproducible code can be
found from this [GitHub repository](https://github.com/langdoc/finnic_atlas). 
This is a proof of concept, and the ideas and pull requests are more than welcome.
")
  current_page <- str_pad(map_number, width = 3, pad = "0")
  write_file(template, glue("{current_page}.Rmd"))
}
