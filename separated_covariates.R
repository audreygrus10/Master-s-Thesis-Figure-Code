library(tidyverse)
library(survival)
library(ggforestplot)
df_scores_processed <- read.csv("separated_covariates.csv", sep = ';')
plot_colors <- c(
  "Metabolomics LP" = "#CC79A7",
  "FLI LP"  = "#5F00DC",
  "CT1"    = "black",
  'PDFF' = '#56B4E9'
)
Figure_4 <- ggforestplot::forestplot(
  df_scores_processed,
  estimate = estimate,
  se = std.error,
  name = endpoint,
  ci = 0.95,
  pvalue = p.value,
  colour = color_group,
  psignif = 0.05,
  logodds = TRUE,
  xlab = "Hazard ratio (95% CI) per 1 SD for single covariates"
  
) +
theme( legend.background = element_rect(fill = "white"),
       legend.title = element_blank(),
       legend.position = c(0.85, 0.90),
       legend.key.height = unit(0.25, "cm"),
       plot.title = element_text(hjust = 0.5),
       axis.title = element_text(size  = 10),
       strip.text = element_text(size  = 10, margin = margin(0.1, 0, 1, 0))
) + 
  guides(
    colour = guide_legend(reverse = TRUE),
    shape = guide_legend(reverse = TRUE)
  ) + 
  scale_color_manual(values = plot_colors) + 
  scale_y_discrete(
    labels = c(
      "INCIDENT_FATTYLIVER" = "Fatty Liver Event",
      "INCIDENT_MAJORLIVER" = "Major Liver Event"
    )
  ) +
  ggtitle('Cox Proportional Hazard Models for\n Separated Covariates of Interest')


