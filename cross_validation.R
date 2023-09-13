library(Metrics)
library(randomForest)

data <- read.csv("C:\\Users\\bean_student\\Documents\\gr_model_data.csv")
set.seed(123)


## setting each building as being in fold 1-5
building_nums <- sample(rep_len(1:5,length(unique(data$building_code))))


# puting numbers to building codes
test_build1 <- unique(data$building_code)[building_nums == 1]
test_build2 <- unique(data$building_code)[building_nums == 2]
test_build3 <- unique(data$building_code)[building_nums == 2]
test_build4 <- unique(data$building_code)[building_nums == 4]
test_build5 <- unique(data$building_code)[building_nums == 5]


## making train and test data based on each fold
train_data1 <- data[!(data$building_code %in% test_build1),]
test_data1 <- data[data$building_code %in% test_build1,]

train_data2 <- data[!(data$building_code %in% test_build2),]
test_data2 <- data[data$building_code %in% test_build2,]

train_data3 <- data[!(data$building_code %in% test_build3),]
test_data3 <- data[data$building_code %in% test_build3,]

train_data4 <- data[!(data$building_code %in% test_build4),]
test_data4 <- data[data$building_code %in% test_build4,]

train_data5 <- data[!(data$building_code %in% test_build5),]
test_data5 <- data[data$building_code %in% test_build5,]




fold1_results <- gr_cv(train_data1, test_data1)
fold2_results <- gr_cv(train_data2, test_data2)
fold3_results <- gr_cv(train_data3, test_data3)
fold4_results <- gr_cv(train_data4, test_data4)
fold5_results <- gr_cv(train_data5, test_data5)

cbind(fold1_results[,1],(as.numeric(fold1_results[,2]) +
                             as.numeric(fold2_results[,2]) +
                             as.numeric(fold3_results[,2]) +
                             as.numeric(fold4_results[,2]) +
                             as.numeric(fold5_results[,2]))/5 )


# Partitioning based on observations

## setting each observation as being in fold 1-5
obs_nums <- sample(rep_len(1:5,nrow(data)))

obs_train_data1 <- data[obs_nums != 1,]
obs_test_data1 <- data[obs_nums == 1,]

obs_train_data2 <- data[obs_nums != 2,]
obs_test_data2 <- data[obs_nums == 2,]

obs_train_data3 <- data[obs_nums != 3,]
obs_test_data3 <- data[obs_nums == 3,]

obs_train_data4 <- data[obs_nums != 4,]
obs_test_data4 <- data[obs_nums == 4,]

obs_train_data5 <- data[obs_nums != 5,]
obs_test_data5 <- data[obs_nums == 5,]


obs_fold1_results <- gr_cv(obs_train_data1, obs_test_data1)
obs_fold2_results <- gr_cv(obs_train_data2, obs_test_data2)
obs_fold3_results <- gr_cv(obs_train_data3, obs_test_data3)
obs_fold4_results <- gr_cv(obs_train_data4, obs_test_data4)
obs_fold5_results <- gr_cv(obs_train_data5, obs_test_data5)

cbind(obs_fold1_results[,1],(as.numeric(obs_fold1_results[,2]) +
                           as.numeric(obs_fold2_results[,2]) +
                           as.numeric(obs_fold3_results[,2]) +
                           as.numeric(obs_fold4_results[,2]) +
                           as.numeric(obs_fold5_results[,2]))/5 )

