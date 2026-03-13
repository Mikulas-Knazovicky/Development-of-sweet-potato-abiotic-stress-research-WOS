library(dplyr)

d1 <- as_tibble(read.delim("Web-of-Science-Impomoea-batatas-Early-access.txt"))
d1

d2 <- as_tibble(read.delim("Web-of-Science-Impomoea-batatas-Highly-cited.txt"))
d2

d3 <- as_tibble(read.delim("Web-of-Science-Sweet-potato-Early-Access.txt"))
d3

d4 <- as_tibble(read.delim("Web-of-Science-Sweet-potato-Enriched-Cited-References.txt"))
d4

d5 <- as_tibble(read.delim("Web-of-Science-Sweet-potato-Highly-cited.txt"))
d5

d6 <- as_tibble(read.delim("Web-of-Science-Sweet-potato-Open-Access-stress-keyword.txt"))
d6

d6 <- as_tibble(read.delim("Web-of-Science-Sweet-potato-Review-articles.txt"))
d6

raw_combined <- rbind(d1, d2, d3, d4, d5, d6)
raw_combined

raw_combined  %>% 
    distinct(Article.Title, .keep_all = TRUE)

all_papers_unique <- raw_combined  %>% 
    distinct(DOI, .keep_all = TRUE)

library(ggplot2)

publication_per_year_plot <- all_papers_unique %>% 
    group_by(Publication.Year) %>% 
    summarise(count = n()) %>% 
    filter(Publication.Year != 2026) %>% 
    ggplot(aes(x = Publication.Year,
                y = count)) +
        geom_line() +
        geom_point() +
        theme_classic()
publication_per_year_plot

ggsave("publication_per_year_plot.jpeg",
        publication_per_year_plot,
        dpi = 300,
        width = 4,
        height = 4)
