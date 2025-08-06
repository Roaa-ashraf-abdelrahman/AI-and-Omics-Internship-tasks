#Create folders in the project directory
dir.create("Raw data")
dir.create("Clean data")
dir.create("Results")
dir.create("Scripts")
dir.create("Plots")

patient_data = read.csv(file.choose())
str(patient_data)
View(patient_data)

#will change gender, diagnosis and smorker to factors
patient_data$gender = as.factor(patient_data$gender)
patient_data$diagnosis = as.factor(patient_data$diagnosis)
patient_data$smoker = as.factor(patient_data$smoker)

#creating new var for smoking status as binary factors
patient_data$smoker_num <- ifelse(patient_data$smoker == "Yes", 1, 0)

str(patient_data)

#saving cleansed data to clean data folder
write.csv(patient_data , file= "Results/patient_info_clean.csv")



