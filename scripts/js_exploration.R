# data exploration

#### load data & libraries ####
library(tidyverse)

df <- haven::read_sas("data/frax_risk.sas7bdat")


#### replace NAs ####
dn9<-c("ALQ101","DBQ197","DBQ229","DIQ010","DIQ220","MCQ190","MCQ160C","OSQ010A","OSQ010B","OSQ010C","OSQ040AA","OSQ040BA","OSQ040CA","OSQ070","OSQ130","OSQ170","OSQ200","OSQ140U","SMQ020")
na_values <- c(666, 777, 999, 6666, 7777, 9999, 77777, 99999)
df <- df %>%
  mutate(across(everything(), ~ if_else(.x %in% na_values, NA_real_, .x))) %>%
  mutate(across(all_of(dn9), ~ if_else(.x %in% c(7, 9), NA_real_, .x)))
rm(na_values, dn9)

#### rename columns ####
df <- df %>%
  rename(demog_sex = RIAGENDR,
         demog_age = RIDAGEYR,
         demog_eth = RIDRETH1,
         demog_bmi = BMXBMI,
         demog_weight_cur = WHD020,
         demog_weight_10yr = WHD110,
         demog_height = WHD010,
         sample_weight = WTMEC2YR,
         sample_psu_var = SDMVPSU,
         sample_strata_var = SDMVSTRA,
         frac_hip = OSQ010A,
         frac_wrist = OSQ010B,
         frac_spine = OSQ010C,
         frac_n_hip = OSQ020A,
         frac_n_wrist = OSQ020B,
         frac_n_spine = OSQ020C,
         frac_over50_hip = OSQ040AA,
         frac_over50_wrist = OSQ040BA,
         frac_over50_spine = OSQ040CA,
         osteoporosis_ever = OSQ070,
         steroid_pc_ever = OSQ130,
         steroid_pc_length = OSQ140Q,
         steroid_pc_length1 = OSQ140U,
         hipFrac_mother = OSQ170,
         hipFrac_father = OSQ200,
         cigarette_past = SMQ020,
         cigarette_current = SMQ040,
         bmd_femur = DXXOFBMD,
         bmd_femoral = DXXNKBMD,
         bmd_troch = DXXTRBMD,
         bmd_intertroch = DXXINBMD,
         bmd_ward = DXXWDBMD,
         bmd_spine = DXXOSBMD,
         bmd_l1 = DXXL1BMD,
         bmd_l2 = DXXL2BMD,
         bmd_l3 = DXXL3BMD,
         bmd_l4 = DXXL4BMD,
         alc_12drink_yr = ALQ101,
         alc_avg_day = ALQ130,
         alc_5ormore = ALQ140Q,
         diabetes = DIQ010,
         diabetes_age_dx = DID040,
         diabetes_when_dx = DIQ220,
         diet_milk_past30days = DBQ197,
         diet_milk_5timesperweek = DBQ229,
         medical_arthritis = MCQ160A,
         medical_arthritis_age = MCQ180A,
         medical_arthritis_type = MCQ190,
         medical_chd = MCQ160C,
         medical_chd_age = MCQ180C,
         medical_liver_ever = MCQ160L,
         medical_liver_current = MCQ170L,
         medical_liver_age = MCQ180L
  )

#### simple predictor ####
# Create a new column that is one for any type of fracture, zero otherwise
df <- df %>%
  mutate(frac = if_else(if_any(frac_hip:frac_spine, ~ .x == 1), 1, 0))



