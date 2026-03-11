library(tidyverse)
library(survival)
library(ggforestplot)
df_scores_processed <- read.csv("glm_model.csv", sep = ';')
hr_plot_colors <- c("#5F00DC", "#CC79A7", 'black')
figure1 <- ggforestplot::forestplot(
  df_scores_processed,
  estimate = estimate,
  se = std.error,
  name = endpoint,
  ci = 0.95,
  colour = input,
  pvalue = p.value,
  psignif = 0.05,
  logodds = TRUE,
  xlab = "Odds ratio (95% CI) per 1 SD for age and sex adjusted linear predictor"
  
) +
  theme(legend.background = element_rect(fill = "white"),
        legend.title = element_blank(),
        legend.position = c(0.81, 0.90),
        legend.key.height = unit(0.45, "cm"),
        axis.title = element_text(size  = 10),
        strip.text = element_text(size  = 10, margin = margin(0.1, 0, 1, 0)),
        plot.title = element_text(hjust = 0.5)
  ) + 
  guides(
    colour = guide_legend(reverse = TRUE),
    shape = guide_legend(reverse = TRUE)
  ) +
  scale_color_manual(values = hr_plot_colors) + 
  ggtitle('GLM Model Predictions\n for Abnormal MRI Imaging Results')


