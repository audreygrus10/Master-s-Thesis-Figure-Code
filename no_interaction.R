library(tidyverse)
library(survival)
library(ggforestplot)
df_scores_processed <- read.csv("no_interaction.csv", sep = ';')
hr_plot_colors <- c("#5F00DC", "#CC79A7", 'black')
Figure_3 <- ggforestplot::forestplot(
  df_scores_processed,
  estimate = estimate,
  se = std.error,
  name = endpoint,
  ci = 0.95,
  pvalue = p.value,
  colour = term,
  psignif = 0.05,
  logodds = TRUE,
  xlab = 'Hazard ratio (95% CI) per 1 SD for covariates of interest'
  
) +
  theme( legend.background = element_rect(fill = "white"),
         legend.title = element_blank(),
         legend.position = c(0.83, 0.9),
         legend.key.height = unit(0.5, "cm"),
         axis.title = element_text(size  = 10),
         strip.text = element_text(size  = 10, margin = margin(0.1, 0, 1, 0)),
         plot.title = element_text(hjust = 0.5)
  ) + 
  guides(
    colour = guide_legend(reverse = TRUE),
    shape = guide_legend(reverse = TRUE)
  ) + ggforce::facet_col(facets = ~input, scales = "free_y", space = "free") +
  scale_y_discrete(
    labels = c(
      "INCIDENT_FATTYLIVER" = "Fatty Liver Event",
      "INCIDENT_MAJORLIVER" = "Major Liver Event"
    )
  ) +
  scale_color_manual(values = hr_plot_colors,
                     labels = 
                       c(
                         'CT1' = 'cT1',
                         'lp_age_sex_adjusted' = 'Linear Predictor')) + 
  ggtitle('Cox Proportional Hazard Models\n Without Interaction Term')

