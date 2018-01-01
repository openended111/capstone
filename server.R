#--------------------------------------------------
# R Server Code for the Capstone Project Shiny App
#--------------------------------------------------


suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))

options(shiny.sanitize.errors = F)
mesg <- as.character(NULL);

#-------------------------------------------------
# This function "Clean up" the user input string 
# before it is used to predict the next term
#-------------------------------------------------
CleanInputString <- function(inStr)
{
    # Test sentence
    #inStr <- "This is. the; -  .   use's 12"
    
    # First remove the non-alphabatical characters
    inStr <- iconv(inStr, "latin1", "ASCII", sub=" ");
    inStr <- gsub("[^[:alpha:][:space:][:punct:]]", "", inStr);
    
    # Then convert to a Corpus
    inStrCrps <- VCorpus(VectorSource(inStr))
    
    # Convert the input sentence to lower case
    # Remove punctuations, numbers, white spaces
    # non alphabets characters
    inStrCrps <- tm_map(inStrCrps, content_transformer(tolower))
    inStrCrps <- tm_map(inStrCrps, removePunctuation)
    inStrCrps <- tm_map(inStrCrps, removeNumbers)
    inStrCrps <- tm_map(inStrCrps, stripWhitespace)
    inStr <- as.character(inStrCrps[[1]])
    inStr <- gsub("(^[[:space:]]+|[[:space:]]+$)", "", inStr)
    
    # Return the cleaned 
    # If the resulting string is empty return empty and string.
    if (nchar(inStr) > 0) {
        return(inStr); 
    } else {
        return("");
    }
}

#---------------------------------------
# Description of the Back Off Algorithm
#---------------------------------------
# To predict the next term of the user specified sentence
# 1. first we use a FourGram; the first three words of which are the last three words of the user provided sentence
#    for which we are trying to predict the next word. The FourGram is already sorted from highest to lowest frequency
# 2. If no FourGram is found, we back off to ThreeGram (first two words of ThreeGram last two words of the sentence)
# 3. If no FourGram is found, we back off to TwoGram (first word of TwoGram last word of the sentence)
# 4. If no TwoGram is found, we back off to OneGram (the most common word with highest frequency)
#
#source("input_string.R")
#source("predict_next_term.R")

msg <- ""
shinyServer(function(input, output) {
    output$prediction <- renderPrint({
        str2 <- CleanInputString(input$inputString);
        strDF <- PredNextTerm(str2);
        input$action;
        msg <<- as.character(strDF[1,2]);
        cat("", as.character(strDF[1,1]))
        cat("\n\t");
        cat("\n\t");
        cat("Note: ", as.character(strDF[1,2]));
    })
    
    output$text1 <- renderText({
        paste("Input Sentence: ", input$inputString)});
    
    output$text2 <- renderText({
        input$action;
        #paste("Note: ", msg);
    })
}
)