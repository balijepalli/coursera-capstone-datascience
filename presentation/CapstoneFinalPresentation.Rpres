<style>

  .reveal h1, .reveal h2, .reveal h3 {
    margin-top: 20px;
    margin-bottom: 20px;
    padding-top: 10px;
    padding-bottom: 20px;
    padding-left: 10px;
    background-color: #E8E8E8;
  }

  .midcenter {
      position: fixed;
      top: 50%;
      left: 50%;
  }

  .footer {
      color: black;
      background: #E8E8E8;
      position: fixed;
      top: 83%;
      text-align:center;
      width:100%;
  }

</style>
Capstone Project : Predicting Next Word 
========================================================
author: Preetam Balijepalli
date: October 2016
autosize: true
transition: rotate
transition-speed: slow

<hr style="border: 0; border-bottom: 2px dashed #ddd; background: #999;">
<h2 style="color:maroon">Data Science Specialization   <img src="./images/mainlogo.png"/></h2>


1. Introduction
========================================================
- This is the presentation of the Coursera Data Science Specialisation Capstone project provided by the John Hopkins University, For more information about the Project: https://www.coursera.org/learn/data-science-project/
- This project is to create a shiny app that predict the next word based on given English phrases / sentence.
- The prediction algorythm was a combination of N-gram Model & Stupid Backoff Scoring Scheme. This presentation will give you a glance at the prediction algorythm.

<div class="footer">Predicting Next Word</div>

2. How the app works
========================================================
incremental:true


Just type a phrase or a sentence in the topleft panel, then select the number of words eg: 3 . The app shows what the user has entered, followed by cleansed form. As the main result, until the top five (more probable)

n-grams predictions are displayed in a list control. The user can review or swap your input data, and the app will turn back to present more hints to predict. Another tabs offer a more extensive documentation and references.

<h4>Main steps to achieve next word(s) predictions:</h4>

<ol style="font-size:20pt; line-height:20px;">
<li>Loading 4 data frames contained <b>n-grams</b> combinations with 4-words, 3-words, 2-words, and 1-word previously generated.</li>
<br/>
<li>Reading user input phrase or a sentence</li>
<br/>
<li>App searches for the phrase </li>
<br/>
<li>Cleansing of user input (lowering, profanities removing, tokenization of input words: the last four) is done by the app behind the scenes</li>
<br/>
<li>Call to prediction model function, basically, the <b><em>Stupid backoff</em> algorithm</b> (a more simplified approach to Katz Backoff):</li>

3. How the search works
========================================================
incremental:true

<div class="footer">Predicting Next Word</div>

<br/>
  <ul style="width:140%">
  <li>search in the <em>fourgram</em> data frame, if found, shows top 5 most probable matches. Otherwise;
  <li>&nbsp;&nbsp;&nbsp;search in the <em>trigram</em> data frame, by the same way above. Otherwise;
  <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;search in <em>bigram</em> data frame, by the same way above.
  <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else, at last, if none matching, displays the most frequent words in the <em>unigram</em> data frame.
  </ul>
</ol>


4. More Information
========================================================
<div class="footer">Predicting Next Word</div>

* N-gram Model is a contiguous sequence of n items from a given sequence of text or speech and can be used to predict the most likely next word in a sentence,For more information of N-gram Model: <a href="https://en.wikipedia.org/wiki/N-gram">link</a>

* Natural Language Processing (NLP) is a highly technical and analytic application of many forms of machine learning. Due to the fact the natural language usually does not follow any mathematical (or sometimes even logical) structure, For more information of Natural Language Processing(NLP): <a href="https://en.wikipedia.org/wiki/Natural_language_processing">link</a>


5. Prototype Resources
========================================================
<div class="footer">Predicting Next Word Capstone</div>
<div class="midcenter" style="margin-left:250px; margin-top:-200px">
<img src="./images/wordcloud.png"></img>
</div>

- Link to <a href="https://github.com/balijepalli/coursera-capstone-datascience" target="_top">GitHub</a> source code
- Here is the link to the shiny app,to try out: https://balijepalli.shinyapps.io/Capstone/


6. Appendix - References
========================================================
<div class="footer">Predicting Next Word</div>
Here are the technical references used to format these slides.

- http://slidify.org/samples/intro/#1
- https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations
- https://rpubs.com/ajlyons/rpres_css
- https://support.rstudio.com/hc/en-us/articles/200714023-Displaying-and-Distributing-Presentations
