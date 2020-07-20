rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## 1.Read outcome data
  outcome_overall <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  column=c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  
  ## 2.Check that state and outcome are valid
  if (is.na(column[outcome])){
    stop("invalid outcome")
  }
  unique_state_vec<-unique(outcome_overall$State)
  if (!(state %in% unique_state_vec)){
    stop("invalid state")
  }
  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  ## 3.convert class of "outcome for 30-day death" to numeric from char
  outcome_overall[, column[outcome]] <- as.numeric(outcome_overall[, column[outcome]])
  
  ## 4.Split according to state and extract relavant state as dataframe
  target_state_filter<-sapply(outcome_overall[, "State"] == state,function(x) !is.na(x)&x)
  outcome_overall<-outcome_overall[target_state_filter,]
  
  
  
  outcome_overall<-outcome_overall[,c(2,column[outcome])]
  #print(head(outcome_overall))
  outcome_overall<-outcome_overall[!is.na(outcome_overall[2]),]
  outcome_overall<-outcome_overall[order(outcome_overall[2],outcome_overall[1]),]
  #print(head(outcome_overall,1))
  #print(tail(outcome_overall,1))
  
  if (is.numeric(num)){
    if (num>nrow(outcome_overall)){
      print(NA)
    }else{
      print(outcome_overall[num,1])
    }
  }
  else{
    if(num=='best'){
      print(head(outcome_overall,1)[1,1])
    }else if(num=='worst'){
      print(tail(outcome_overall,1)[1,1])
    }
  }
}