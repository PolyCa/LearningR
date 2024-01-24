# Loading Packages

library(tidyverse)
library(NHANES)

glimpse(NHANES)
str(NHANES)

# Select specific colomuns ------------------------------------------------

select(NHANES, Age, Weight, BMI)

select(NHANES, -HeadCirc)

select(NHANES, starts_with("BP"))

select(NHANES, ends_with("Day"))

select(NHANES, contains("Age"))

# Rename all columns ------------------------------------------------------

rename_with(NHANES, snakecase::to_snake_case)

NHANES_small <- rename_with(NHANES, snakecase::to_snake_case)


# Rename specific column --------------------------------------------------

NHANES_small <- rename(NHANES_small, sex = gender)

NHANES_small

View(NHANES_small)

# Chaining the function with pipe -----------------------------------------

colnames(NHANES_small)

NHANES_small %>%
  colnames()

NHANES_phys <- NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

NHANES_small %>%
  select(bp_sys_ave, education)

NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

NHANES_small %>%
  select(bmi) %>%
  select(contains("age"))

NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)


# FIltering data by row ---------------------------------------------------

filter(NHANES_small, phys_active == "No")

NHANES_small %>%
  filter(phys_active == "No") %>%
  select(phys_active)

NHANES_small %>%
  filter(phys_active != "No")

NHANES_small %>%
  filter(bmi >= 25)

TRUE & TRUE
TRUE & FALSE
FALSE & TRUE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

NHANES_small %>%
    filter(bmi == 25 & phys_active == "No") %>%
    select(bmi, phys_active)

NHANES_small %>%
    filter(bmi == 25 | phys_active == "No") %>%
    select(bmi, phys_active)


# Arrange the rows --------------------------------------------------------


NHANES_small %>%
    arrange(age)

NHANES_small %>%
    arrange(education) %>%
    select(education)
NHANES_small %>%
    arrange(desc(age)) %>%
    select(age)
NHANES_small %>%
    arrange(age,education)

# Transform or add columns ------------------------------------------------

NHANES_small %>%
    mutate(age = age * 12,
           logged_bmi = log(bmi)) %>%
    select(age, logged_bmi)

NHANES_small %>%
    mutate(
        old = if_else(age > 30, "Yes", "No")
    ) %>%
    select(old)


# 7.12 Exercise: Piping, filtering, and mutating --------------------------



# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:

NHANES_modified <- NHANES_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_pressure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age < 6, "Yes", "No")
    )

