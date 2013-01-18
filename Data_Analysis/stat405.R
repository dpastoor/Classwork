# Author: Devin Pastoor
# Code for Hadley Wickham's Stat 405: Statistical Computing and Data Analysis
# Associated pdf's and other files in Data Analysis Onenote Notebook

getwd()

#Reminder:
#setwd("C:/Users/Devin Pastoor/Documents/Classwork/Data_Analysis")
rm(list = ls())                # clean out workspace


# Lecture 1 - Introduction -----------------------------------------------------
  
# Scatterplot basics

library("ggplot2")

# find out information about set of data
?mpg
head(mpg)           # initial lines, can alternatively set # of lines (mpg, n=)
str(mpg)            # information about variables and their types
summary(mpg)        # summary statistics for each variable

#basic plotting 

qplot(displ, hwy, data = mpg)     #(x.var, y.var, data = ?)

#add aesthetics (shape/color options) 
qplot(displ, hwy, color = class, data = mpg)

# add facetting (subsets)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~.)      # 4w-, f-, r-wheel drive
qplot(displ, hwy, data = mpg) + facet_grid(. ~ cyl)     # number of cylinders

# and even more depth with colors
qplot(displ, hwy, color = class, data = mpg) +           
  facet_grid(. ~ cyl)

# or shapes (but note the warning - too many shapes can be confusing)
qplot(displ, hwy, shap = class, data = mpg) +           
  facet_grid(. ~ cyl)

# with a large numbers of factors the grid can look awkward
qplot(displ, hwy, data = mpg) + facet_grid(~ class)

# reshape to 'wrap' ribbon to 2d 
qplot(displ, hwy, data = mpg) + facet_wrap(~class)

# can do 2 levels of facetting to compare
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ cyl)  

# does not show complete data by default to prevent overplotting
qplot(cty, hwy, data = mpg)

# to plot all points must add a geom_jitter
qplot(cty, hwy, data = mpg, geom = "jitter")

# sometimes want to rearrange data to better ID trends
qplot(class, hwy, data = mpg)
qplot(reorder(class,hwy), hwy, data = mpg)                          # reorder by mpg mean
qplot(reorder(class,hwy), hwy, data = mpg, geom = "jitter")         # to see all data

# want to know if can reorder by a different summary statistic
?reorder
qplot(reorder(class,hwy, median), hwy, data = mpg, geom = "jitter") #reorder by mpg median

# boxplots are good for summarizing data
qplot(reorder(class,hwy), hwy, data = mpg, geom = "boxplot")

# can add additional layers
qplot(reorder(class,hwy), hwy, data = mpg, geom = c("jitter", "boxplot")) # boxplot on top
qplot(reorder(class,hwy), hwy, data = mpg, geom = c("boxplot", "jitter")) # jitter on top

