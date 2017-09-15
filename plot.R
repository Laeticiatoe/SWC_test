df<- read.csv("Metadata.csv")
# which variables?
str(df)
#start plotting
library(ggplot2)
#make first plot
ggplot(data=df, aes(x=Timepoint , y=ph ))+
  geom_point()

# to color the plot
ggplot(data=df, aes(x=Timepoint , y=ph, fill= Reactor.phase ))+
  geom_point(shape=21)
View (df)
# change the reactor-cycle variable to a factor
df$Reactor.cycle<- factor(df$Reactor.cycle)
ggplot(data=df, aes(x=Timepoint , y=ph, fill= Reactor.phase  ))+
  geom_point(shape=21)
ggplot(data=df, aes(x=Timepoint , y=ph, fill= Reactor.phase  ))+
  geom_point(shape=21, size=10)
#store ggplot object
p1<-ggplot(data=df, aes(x=Timepoint , y=ph, fill= Reactor.phase  ))+
  geom_point(shape=21)
#add items to the p1 plot
p1 + geom_line()
p2<- p1 + geom_line()
# facet (each reactor on a different plot)
p3<- p2+facet_grid(~Reactor.cycle)+theme_bw()
p3
#use 2 factors
# how to explore the reactor phase factor
df$Reactor.phase
levels(df$Reactor.phase)
p4<- p2+ facet_grid(Reactor.phase~Reactor.cycle)
p4
#color by reactor phase
#replace fill= Reactor.cycle by fill = Reactor.phase 
# alternantive way
p4+ geom_line()
p4+geom_line(aes(color=Reactor.phase))

#Omit the missing observations
df<-na.omit(df)
p5<-ggplot(data=df, aes(x=Timepoint , y=Diversity...D0, fill=Reactor.phase ))+
  geom_point(shape=21, size=5)
P6 <- p5 + facet_grid(~Reactor.phase)+theme_dark()
P6

#how to calculta summary stats
library(ggplot2)
library(dplyr)
#load dta 
df<- read.csv("Metadata.csv")
mean(df[df$Reactor.phase == "Control", "ph"])
levels(df$Reactor.phase)

#select
physicochem<- dplyr::select(df, ph, temp, Conductivity)
#or when sure you have loaded the dplyr library last, physicochem<- select(df, ph, temp, Conductivity)
#or physicochem  <- df %>% select(ph, temp, Conductivity)
physicochem.control <- df %>% 
  filter(Reactor.phase== "Startup") %>% 
  select(Diversity...D0, Diversity...D1, Diversity...D2)
#  select(contains("Diversity")) is a short way for "above"
physicochem.control
# filter for row and select for colums

#group by (create customized summary data)
meanph <- df %>% group_by(Reactor.phase) %>% 
  summarise(mean.ph= mean(ph), sd.ph=sd(ph), mean.d2= mean(Diversity...D0))
meanph

# Challenge
# Generate a summary for reactor cycle 2 and add
# standard deviation of the d2 and the mean of the log10
# transformed cell density

chalenge <- df %>% 
  filter(Reactor.cycle==2) %>% 
  group_by(Reactor.phase) %>% 
  summarise(sd.d2= sd(Diversity...D2), meanlg= mean(log(Cell.density..cells.mL.)))

