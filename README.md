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
At this time I am selecting the laplace prior over ![equation](https://latex.codecogs.com/gif.latex?\bm{p}) by 
selecting all ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}=1).

# Simulation

Above outlines the posterior density for the probability vector for each candidate getting a vote in the primary 
election in a particular state. 
As we all know, the person with the highest proportion of votes does not neccessarily win the election, each state 
has some number of electoral college votes which are generally speaking winner-take-all for the candidate who wins 
the highest number of votes in the state.

![image](https://upload.wikimedia.org/wikipedia/commons/4/49/ElectoralCollege2020.svg)

The above model based perspective gives a straight forward prediction for the 
number of votes each state will produce for each hypothetical general election matchup.
The posterior predictive distribution for the number of votes each candidate will get is given by doing the 
following Monte Carlo integral,

![equation](https://latex.codecogs.com/gif.latex?p(y^*|y)=\int&space;Multinomial(y^*|n,\bm{p})Dir(\bm{p}|\bm{y}&plus;\bm{\alpha})d\bm{p}.)

For predicting the number of votes in the general election the multinomial 
size n is given by the number of votes cast in the given state in 2016 
as sourced from [http://www.electproject.org/2016g](http://www.electproject.org/2016g). 
This produces a slight scaling of variability between states, but (based on preliminary 
sensativity analysis) misspecifying n here does not dramatically change the results.

Sampling a million y* voting outcomes and assigning the appropriate number of electoral college votes 
to the winner in each case produces a distribution of electoral college votes in each state for each democratic 
candidate against Trump. Summing these distributions over the relavent states gives a prediction for the number 
of electoral college votes each candidate will get from those states. In this simulation I have limited the
prediction to Iowa, Florida, Michigan, Nevada, New Hampshire, Virginia, and Wisconsin. Although I would like to 
add Minnesota, Ohio, Nevada, North Carolina, and Pennsylvania, pending decent polls from those states. I have 
tried to limit poll inclusion to polls present on FivethirtyEight appearing within the last two-three months and 
that achieve at least a B+ rating pollster rating from FivethirtyEight. If you can think of any other states that 
deserve to be considered, I welcome you to provide me a convincing argument as to why, If I am convinced and I can 
find the data I will include it.

Candidate electoral boxplots

![image](https://github.com/gasduster99/primaryConcerns/blob/master/collegeVotes.pdf)

Describe probability measure

Display probability

