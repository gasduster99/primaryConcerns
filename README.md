# The Premise

FiveThirtyEight recently added a tool for viewing summaries of many of the polls that they use in models to better understand the upcoming 2020 election.
It occurs to me that any vote worth making in the primary should be cast in order to produce a viable candidate among the swing states in the general election.
In pursuit of that end I wrote the code here to consider how the hypothetical runoff style polls, for assessing the general election, would position each democratic candidate when you further consider the somewhat unintuitve behavior of the electoral college.  

The general election polls (for example [Pennsylvania](https://projects.fivethirtyeight.com/polls/president-general/pennsylvania/)) take the form of trinomial outcomes for the number of polled registered voters for a democratic candidate matched-up against Trump, as well as some other (third party or write-in) candiate in each state.

<!--https://www.codecogs.com/latex/eqneditor.php-->
![equation](https://latex.codecogs.com/gif.latex?\bm{y}&space;=&space;[Democrat,&space;Trump,&space;Other])

![equation](https://latex.codecogs.com/gif.latex?\bm{y}&space;\sim&space;Multinomial(n,&space;\bm{p}))

![equation](https://latex.codecogs.com/gif.latex?n) is the known total number of poll respondents.
Assuming a Dirichlet prior on ![equation](https://latex.codecogs.com/gif.latex?\bm{p}) 
gives conjugacy and produces the following posterior,

![equation](https://latex.codecogs.com/gif.latex?\bm{p}|\bm{y}&space;\sim&space;Dir(\bm{y}+\bm{\alpha}).)

One may specify a particular prior through the choice of ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}) 
components relative to each other; prior strength is then selected by the 
absolute scale of the components of ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}). 
At this time I am selecting the laplace prior over the ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}).

# Simulation

Above outlines the posterior density for the probability vector for each candidate getting a vote in the primary 
election in a particular state. 
As we all know, the person with the highest proportion of votes does not neccessarily win the election, each state 
has some number of electoral college votes which are generally speaking winner-take-all for the candidate who wins 
the highest number of votes in the state.

The above model based perspective gives a straight forward prediction for the 
number of votes each state will produce for each hypothetical general election matchup.
The posterior predictive distribution for the number of votes each candidate will get is 

![equation](https://latex.codecogs.com/gif.latex?p(\bm{y}^*|\bm{y})&space;=&space;\int Multinomial(y^*|n,&space;\bm{p})Dir(\bm{p}|\bm{y}+\bm{\alpha})d\bm{p})



