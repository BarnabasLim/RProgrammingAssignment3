rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## 1.Read outcome data
  outcome_overall <- read.csv("rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  column=c("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  
  ## 2.Check that state and outcome are valid
  if (is.na(column[outcome])){
    stop("invalid outcome")
  }
  unique_state_vec<-sort(unique(outcome_overall$State))
  print(unique_state_vec)
  #if (!(state %in% unique_state_vec)){
  #  stop("invalid state")
  #}
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  ## 3.convert class of "outcome for 30-day death" to numeric from char
  outcome_overall[, column[outcome]] <- as.numeric(outcome_overall[, column[outcome]])
  outcome_overall<-outcome_overall[,c(7,column[outcome],2)]
  
  ## 3.1 remove na
  outcome_overall<-outcome_overall[!is.na(outcome_overall[2]),]
  ## 3.2 
  outcome_overall<-outcome_overall[order(outcome_overall[1],outcome_overall[2],outcome_overall[3]),]
  #print(tail(outcome_overall))
  
  
  
  states<-split(outcome_overall,outcome_overall$State)
 
  rankall_states<-data.frame(hospital=character(),state=character())
  for (State in unique_state_vec){
    #print(State)
    ## 5.1-> more tedious because variable names are changed
    target_state<-as.data.frame(states[State])
    best_int<-(target_state[paste(State,".Hospital.Name",sep = "")])
    #print(head(best_int,3))
    
    if (is.numeric(num)){
      if (num>nrow(outcome_overall)){
        target_hos<-data.frame(hospital=NA,state=State)
      }else{
        target_hos<-data.frame(hospital=best_int[num,1],state=State)
        #print(outcome_overall[num,1])
      }
    }
    else{
      if(num=='best'){
        target_hos<-data.frame(hospital=head(best_int,1)[1,1],state=State)
        #print(head(outcome_overall,1)[1,1])
      }else if(num=='worst'){
        target_hos<-data.frame(hospital=tail(best_int,1)[1,1],state=State)
        #print(tail(outcome_overall,1)[1,1])
      }
    }
    #print(rankall_states)
    rankall_states<-rbind(rankall_states,target_hos )
  }
  print(rankall_states)
}