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
