best <- function(state, outcome) {
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
  
  ## Return hospital name in the state with lowest 30-day death
  
  ## 3.convert class of "outcome for 30-day death" to numeric from char
  outcome_overall[, column[outcome]] <- as.numeric(outcome_overall[, column[outcome]])
  
  ## 4.Split according to state and extract relavant state as dataframe
  target_state_filter<-sapply(outcome_overall[, "State"] == state,function(x) !is.na(x)&x)
  target_state<-outcome_overall[target_state_filter,]
  
  ## 4.1
  #states<-split(outcome_overall,outcome_overall$State)
  #target_state<-as.data.frame(states[state])
  
  ## 5.Extract Hospital.Name column
  best_int<-(target_state["Hospital.Name"])
  
  ## 5.1-> more tedius because variable names are changed
  #best_int<-(target_state[paste(state,".Hospital.Name",sep = "")])

  ## 6.Min 30-day death filter
  min_val<-sapply(target_state[, column[outcome]] == min(target_state[, column[outcome]],na.rm = TRUE),function(x) !is.na(x)&x)
  
  

  
  best_list<-best_int[min_val,]
  sort(best_list)[1]
  print(sort(best_list)[1])

}

