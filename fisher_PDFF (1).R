library(tidyverse)
library(purrr)
library(ggplot2)
results_liver <- read.csv("~/Downloads/elevated_PDFF_fisher.csv", sep = ';')
hr_plot_colors <- c('FLI' = "#5F00DC", 'Metabolomics' = "#CC79A7")
bands <- unique(results_liver[, c("group", "y_base")])
bands$fill <- rep(c("white", "grey95"), length.out = nrow(bands))
figure <-
  results_liver  %>%
  ggplot(aes(y = y, x = odds_ratio, colour = input, fill = input))  +
  geom_vline(xintercept = 1, linetype = "solid", color = "black") + 
  labs(x = "Odds Ratio (95% CI) per 1 SD for risk score top decile") +
  geom_segment(aes(y = y, yend= y, x = lower_CI, 
                   xend = upper_CI), size = 0.5)  +
  geom_point(aes(fill = ifelse(sig, input, 'FALSE')), shape = 21, size = 2,
             stroke = 1, show.legend = FALSE) + 
  scale_colour_manual(values = hr_plot_colors, labels = 
                        c(
                          'Metabolomics'= 'MRS') )+
  scale_fill_manual(values = c(hr_plot_colors, 
                               'FALSE' = 'white'),
                    guide = 'none')+
  scale_x_log10() +
  scale_y_continuous(
    breaks = unique(results_liver$y_base),
    labels = levels(factor(results_liver$group))
  ) + 
  ggforce::facet_col(facets = ~incident, scales = "free_y", space = "free") +
  theme(
    text = element_text(color = "black"),
    axis.text.y = element_text(size = 12),
    axis.text.x.bottom = element_text(size = 12),
    axis.title.y = element_blank(),
    panel.grid.major.x = element_line(linetype = "dotted",
                                      color = "grey70"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    strip.background = element_blank(),        
    strip.placement = "outside",
    strip.text   = element_text(
      face = 'bold', hjust = 0, size = 12),
    legend.position = c(0.85, 0.85),
    legend.title = element_blank(),
    legend.background = element_rect(fill="white", color="black"),
    legend.key = element_rect(fill = "white", color = NA))  + 
  ggtitle('Top Risk Decile vs Remaining Population')
figure
