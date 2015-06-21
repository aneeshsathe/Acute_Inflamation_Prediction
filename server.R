
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
# library(caret)
# library(randomForest)
# load('data/Bpred_formula.RData')
# load('data/Npred_formula.RData')
rm(list=ls())
library(caret)
# https://archive.ics.uci.edu/ml/datasets/Acute+Inflammations

pro_in_dat=read.table("diagnosis.data", fileEncoding="UTF-16", dec=",")

colnames(pro_in_dat)=c('temp','naus','LumPain','UrinePushing','MictPain','burning','BladInflm','Nephritis')


blad_in=pro_in_dat[,1:7]
neph_in=pro_in_dat[,c(1:6,8)]
#Create Data Partition

BinTrain <- createDataPartition(y=blad_in$BladInflm,p=0.8, list=FALSE)
Btraining <- blad_in[BinTrain,]
Btesting <- blad_in[-BinTrain,]

NinTrain <- createDataPartition(y=neph_in$Nephritis,p=0.8, list=FALSE)
Ntraining <- neph_in[NinTrain,]
Ntesting <- neph_in[-NinTrain,]


# nearZeroVar(Btesting[,1:6],saveMetrics=TRUE)

library(randomForest)
BmodFit=randomForest(BladInflm~.,data=Btraining)
NmodFit=randomForest(Nephritis~.,data=Ntraining)
q=predict(BmodFit,Btraining[2,1:6])

print(Btraining[2,1:6])
print(q)


shinyServer(function(input, output) {
  output$BPred=renderText({
          
      
          ui_in_dat=data.frame(temp=input$temp,
                               naus=factor(input$naus,levels = c("no","yes")),
                               LumPain=factor(input$LumPain,levels = c("no","yes")),
                               UrinePushing=factor(input$UrinePushing,levels = c("no","yes")),
                               MictPain=factor(input$MictPain,levels = c("no","yes")),
                               burning=factor(input$burning,levels = c("no","yes")))
#           
          
#           ui_in_dat2=Btraining[2,1:6]
#           print(ui_in_dat)
#           print(ui_in_dat2)
#           print(ui_in_dat2==ui_in_dat)
#          
#           # print(class(ui_in_dat$temp))
#           print(sapply(ui_in_dat2,levels))
#           print(sapply(ui_in_dat,levels))
          Bout_pred=predict(BmodFit,ui_in_dat)
          Nout_pred=predict(NmodFit,ui_in_dat)
          # print(Bout_pred)
          # print(Bout_pred)
          print(
          paste0(" Inflammation of urinary bladder: ",Bout_pred, '<br/>',
         "Nephritis of renal pelvis origin:  ",Nout_pred)
          )
  
          })

})
# paste0(" Inflammation of urinary bladder: ",as.character(Bout_pred), '<br/>',
#        "\n Nephritis of renal pelvis origin  ",as.character(Nout_pred))