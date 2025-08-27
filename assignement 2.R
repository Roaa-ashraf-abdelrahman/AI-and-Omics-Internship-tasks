dir.create("raw data")
dir.create("script")
dir.create("results")
dir.create("clean data")

input_dir <- "raw data" 
output_dir <- "results"
files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv") 


classify_gene <- function(logFC, padj){
  ifelse(padj < 0.05 & logFC > 1, "Upregulated",
  ifelse(padj < 0.05 & logFC < -1, "Downregulated", "Not_Significant"))
}

result_list <- list()

for (file_names in files_to_process){
  
  cat("\nProcessing:", file_names, "\n")
  input_file_path <- file.path(input_dir, file_names)
  
  data <- read.csv(input_file_path, header =TRUE)
  cat("file imported.")
  
  #for missing values in pdaj
  data$padj[is.na(data$padj)] <- 1
  
  #adding new column status 
  data$status <- classify_gene(data$logFC, data$padj)
  
  result_list[[file_names]]<- data
  output_file_path = file.path(output_dir, paste0("cleaned_results", file_names))
  write.csv(data, output_file_path, row.names = FALSE)
  cat("results saved to:", output_file_path, "\n")
}

results_1 <- result_list[[1]] 
results_2 <- result_list[[2]]

table(results_1$status)
table(results_2$status)


save.image(file = "assignment_2_workspace.RData")
