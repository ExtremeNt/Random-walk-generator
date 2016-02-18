shinyServer(function(input,output,session){
  
  rwalkdata<-reactive({
    if (is.na(input$seedn)){set.seed(0)}
    else{set.seed(input$seedn)}
    b<-rbinom(input$nstep, 1,input$steppb1)
    steps<-c(0,input$stepsz1*b+input$stepsz2*(1-b))
    num<-0:input$nstep
    rwalk<-cumsum(steps)
    rwalkmax<-cummax(rwalk)
    rwalkmin<-cummin(rwalk)
    reflect<-rwalk+pmax(-rwalkmin,0)
    

    
    Step<-rep(num,3)
    Walk<-c(rwalk,rwalkmax,reflect)
    Path<- factor( c( rep("Random Walk",input$nstep+1),
                    rep("Walk Maximum", input$nstep+1),
                    rep("Reflected Walk", input$nstep+1)
    ) )
    id<-1:length(Step)
    m<-cbind(Step,Walk,Path,id)

#    m<-cbind(num,rwalk,rwalkmax,reflect)
    m<-as.data.frame(m)
    names(m)<-c("Step","Walk","Path","id")
    m<-filter(m, Path %in% input$Displaywalks )
    m
  })
  
  tooltips<-function(x){
    if(is.null(x)) return(NULL)
          paste0(
      '<b>',x$Paths,'</b><br>',
           '<b>Step:</b>',x$Step, '<br>',
           '<b>Value:</b>', x$Walk)
  }
  
  vis <- reactive({
      walktypes<-c("Random Walk","Reflected Walk","Walk Maximum")
      rwalkdata() %>%
      dplyr :: mutate(Paths=factor(Path
                                 , labels=walktypes[as.numeric(input$Displaywalks)] 
      )) %>%
      ggvis(x=~Step, y=~Walk, stroke=~Paths) %>%
      layer_points() %>%
      set_options(width='auto') %>%
      layer_lines() %>%
      add_tooltip(tooltips, on='hover')
      })
  bind_shiny(vis,'plot')
})
