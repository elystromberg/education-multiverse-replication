
library(ggplot2)
library(ggjoy)
library(haven)
library(forcats)
library(dplyr)
library(countrycode)

setwd("YOUR WORKING DIRECTORY HERE")
print("R script starting...")
#data <- read_dta("data\\tmp.dta")

reg <- read_dta('data\\models_reg.dta') %>% 
  mutate(parameter="reg")
corr <- read_dta('data\\models_corr.dta') %>% 
  mutate(parameter="corr")
odds <- read_dta('data\\models_odds.dta') %>% 
  #  select(-m11, -m12) %>% 
  mutate(parameter="odds")
pos <- read_dta('data\\models_pos.dta') %>% 
  mutate(parameter="pos")
unidiff <- read_dta('data\\models_unidiff.dta') %>% 
  mutate(parameter="unidiff") %>% 
  mutate(m1=std)
data <- reg %>%
  bind_rows(corr, odds, pos, unidiff)

parameterlist <- c("reg", "corr", "odds", "pos", "unidiff", "all")
genderlist <- c("", "women", "men")

# Convert country codes to full country names
data$cntry_name <- countrycode(data$cntry, "iso2c", "country.name")

# Manually handle "UK" code
data$cntry_name[data$cntry == "UK"] <- "United Kingdom"
data <- data %>% 
  mutate(cntry = cntry_name) %>% 
  select(-cntry_name)



# Loop over parameter values
for (param in parameterlist) {
  if(param != "all"){
    for (gender in genderlist) {
      # Subset the data based on the current parameter value
      if(gender==""){
        subset_data <- filter(data, parameter == param)
      } else if (gender=="women"){
        subset_data <- filter(data, parameter == param) %>% 
          filter(m8==2)
      }else if (gender=="men"){
        subset_data <- filter(data, parameter == param) %>% 
          filter(m8==1)
      }
      
      
      # Calculate median and mean for each country
      subset_data <- subset_data %>%
        group_by(cntry) %>%
        mutate(median_rank = median(rank),
               mean_rank = mean(rank))
      
      # Create a custom ranking variable
      #  subset_data$custom_rank <- with(subset_data, ifelse(median_rank == mean_rank, mean_rank, median_rank))
      
      # Reorder levels of "cntry" based on the custom ranking
      #  subset_data$country <- fct_rev(fct_reorder(subset_data$cntry, subset_data$custom_rank))
      subset_data <- subset_data %>%
        mutate(country=cntry)
      
      custom_sort <-function(group, median, mean) {
        return(-(median + 0.1 * mean))
      }
      
      subset_data$country <- reorder(subset_data$country, custom_sort(subset_data$country, subset_data$median_rank, subset_data$mean_rank))
      # Remove the intermediate ranking variables if needed
      subset_data <- subset_data %>%
        select(-median_rank, -mean_rank)
      
      ### Boxplot
      
      box <- ggplot(subset_data, aes(x=country, y=rank)) + 
        scale_y_continuous(breaks=seq(1, 15, 2)) + 
        geom_boxplot() + theme_joy()  + ylab("Rank") + xlab("") + coord_flip()
      
      filename <- paste0("out\\box", param, gender, ".pdf")
      pdf(filename, height = 5, width = 5)
      print(box)
      dev.off()
      
      # Generate ridgeplot
      ridge <- ggplot(subset_data, aes(x = m1, y = country)) + 
        geom_joy() + theme_joy() + ylab("") + xlab("Coefficient") 
      
      
      filename <- paste0("out\\ridge", param, gender, ".pdf")
      pdf(filename, height = 5, width = 5)
      # Print the plot (optional)
      print(ridge)
      dev.off()
    } 
    
  } else if (param=="all") {
    subset_data <- data
    # Calculate median and mean for each country
    subset_data <- subset_data %>%
      group_by(cntry) %>%
      mutate(median_rank = median(rank),
             mean_rank = mean(rank))
    
    # Reorder levels of "cntry" based on the custom ranking
    #  subset_data$country <- fct_rev(fct_reorder(subset_data$cntry, subset_data$custom_rank))
    subset_data <- subset_data %>%
      mutate(country=cntry)
    
    custom_sort <-function(group, median, mean) {
      return(-(median + 0.1 * mean))
    }
    
    subset_data$country <- reorder(subset_data$country, custom_sort(subset_data$country, subset_data$median_rank, subset_data$mean_rank))
    # Remove the intermediate ranking variables if needed
#    subset_data <- subset_data %>%
#      select(-median_rank, -mean_rank)
    
    ### Boxplot
    
    box <- ggplot(subset_data, aes(x=country, y=rank)) + 
      scale_y_continuous(breaks=seq(1, 15, 2)) + 
      geom_boxplot() + theme_joy()  + ylab("Rank") + xlab("") + coord_flip()
    
    filename <- paste0("out\\box_all", ".pdf")
    pdf(filename, height = 5, width = 5)
    print(box)
    dev.off()
    
  }
}

dev.off()


# Kdensity for Denmark

# Assuming you have a dataframe 'df' with columns 'm1' and 'cntry'
# Filter the data for Denmark
df_dk <- reg %>% filter(cntry == "DK")


# Create the density plot
box <- ggplot(df_dk, aes(x = m1)) +
  geom_density(color = "black", n = 5024) + 
  geom_vline(xintercept = 0.37, linetype = "longdash", color = "blue") +
  geom_vline(xintercept = 0.42, linetype = "dashed", color = "blue") +
  geom_vline(xintercept = 0.49, linetype = "dashed", color = "darkgreen") +
  geom_vline(xintercept = 0.20, linetype = "longdash", color = "red") +
  geom_vline(xintercept = 0.23, linetype = "dashed", color = "red") +
  annotate("text", x = 0.38, y = 5, label = ".37", hjust = 0) +
  annotate("text", x = 0.38, y = 4.75, label = "A&T 2018 Fathers", hjust = 0) +
  annotate("text", x = 0.43, y = 4, label = ".42", hjust = 0) +
  annotate("text", x = 0.43, y = 3.75, label = "A&T 2018 Parents", hjust = 0) +
  annotate("text", x = 0.50, y = 3, label = ".49", hjust = 0) +
  annotate("text", x = 0.50, y = 2.75, label = "Hertz et al 2008", hjust = 0) +
  annotate("text", x = 0.205, y = 1.7, label = ".20", hjust = 0) +
  annotate("text", x = 0.205, y = 1.45, label = "L&D 2020 Mothers", hjust = 0) +
  annotate("text", x = 0.24, y = 0.9, label = ".23", hjust = 0) +
  annotate("text", x = 0.24, y = 0.65, label = "L&D 2020 Fathers", hjust = 0) +
  labs(x = "Coefficient size", y = "Density", title = "", subtitle = "", caption = "") +
  scale_x_continuous(limits = c(0.1, 0.7), breaks = seq(0.1, 0.7, by = 0.1)) +
  theme_minimal() +
  theme(
    axis.line.x = element_line(color = "black"),  # Adds x-axis line
    axis.line.y = element_line(color = "black"),  # Adds y-axis line
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank()
  )

filename <- paste0("out\\kdens", ".pdf")
pdf(filename, height = 5, width = 7)
print(box)
dev.off()


