shinyUI(
  fluidPage(
    
    titlePanel('Random walk generator'),
    
    fluidRow(
      
      column(2, wellPanel(
               numericInput('stepsz1','Step size 1', value=1),
               numericInput('stepsz2','step size 2', value=-1),
               numericInput('steppb1','step 1 probability',min=0, max=1,value=0.5),
               numericInput('nstep','Number of steps',min=1, step=1, value=100),
               numericInput('seedn','Seed', min=0, step=1, value=0),
               checkboxGroupInput('Displaywalks','Display',
                                  c('Random walk'=1,'Maximum process'=2,'Reflected process'=3)
                                  ,selected = 1)
               
             )),
     column(10, 
            wellPanel(ggvisOutput('plot') )
            )
           
    )
    
    )
)
