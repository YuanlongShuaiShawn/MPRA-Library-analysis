ReadUmiFiles<-function(){
  df<-as.data.frame(1:200)
  names(df)="UmiCopies"
  FileList<-list.files(path=getwd(),pattern="*.txt");
  for(i in 1:length(FileList)){
  file<-read.csv(FileList[i],header=FALSE)
  count<-file[,2]
  df[,i+1]<-count
  name<-gsub("(_output.*.txt)","",FileList[i])
  name<-gsub("lsUMI","Fraction",name)
  names(df)[i+1]<-name
  }
  return(df)
}

DensityPlot<-function(df,filename){
  color<-rainbow(24)
  opar<-(no.readonly = TRUE)
  for(i in 2:(length(colnames(df))-1)){
  plot(seq(length(df[,i])),df[,i],
       xlim=c(0,25),ylim=c(0,max(df[,-1])),
       cex=0.1,pch=20,col=color[i-1],
       xlab="UMI Copies",ylab="Count",
       main=filename)
  lines(spline(seq(length(df[,i])),df[,i],100000),
          pch=10,type = "l",col=color[i-1],lwd=0.1)
  par(new=TRUE)
  }
  legend("topright",inset = 0.05,
         colnames(df)[-1],lty=c(1),col=color,cex=0.5)
}

df<-ReadUmiFiles()
#DensityPlot(df,"")