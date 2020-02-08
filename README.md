# Premise

FiveThirtyEight recently added a tool for viewing summaries of many of the 
polls that they use in modeling the upcoming 2020 election. It occurs to me 
that any vote worth making in the primary should be cast in order to produce a 
viable candidate in the general election (in particular among the swing states). 
In pursuit of that end, I wrote the code here to consider how the hypothetical 
runoff style polls, for assessing the general election, would position 
each democratic candidate when you further consider the somewhat 
unintuitive behavior of the electoral college.  

# Model

The general election polls on FiveThirtyEight (for example 
[Pennsylvania](https://projects.fivethirtyeight.com/polls/president-general/pennsylvania/)) 
take the form of trinomial outcomes for the number of polled registered voters 
for each democratic candidate matched-up against Trump, as well as some other 
(third party or write-in) candidate in each state.

![equation](https://latex.codecogs.com/gif.latex?\bm{y}&space;=&space;[Democrat,&space;Trump,&space;Other])

![equation](https://latex.codecogs.com/gif.latex?\bm{y}|n,\bm{p}&space;\sim&space;Multinomial(n,&space;\bm{p}))

![equation](https://latex.codecogs.com/gif.latex?n) is the known total number 
of poll respondents.  Assuming a Dirichlet prior on 
![equation](https://latex.codecogs.com/gif.latex?\bm{p}) gives conjugacy and 
produces the following posterior density on the vector of probabilities for 
each candidate getting a vote,

![equation](https://latex.codecogs.com/gif.latex?\bm{p}|\bm{y}&space;\sim&space;Dir(\bm{y}+\bm{\alpha}).)

One may specify prior information through the choice of the components of 
![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}) 
relative to each other; prior uncertainty is then selected by the 
absolute scale of the components of ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}). 
At this time I am selecting a flat prior over ![equation](https://latex.codecogs.com/gif.latex?\bm{p}) by 
selecting all ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}=1).

# Simulation

The above model suggests a mechanism for directly sampling voting outcomes for the 
purpose of simulating general election outcomes. As we all know, the person 
with the highest proportion of votes does not necessarily win the 
election, each state has some number of electoral college votes which are, 
generally speaking, winner-take-all for the candidate who wins the highest 
number of votes in that state.  

![image](https://upload.wikimedia.org/wikipedia/commons/4/49/ElectoralCollege2020.svg)

This model based perspective gives a straight forward prediction for the 
number of votes each state will produce for each hypothetical general election matchup.
The posterior predictive distribution for the number of votes each candidate will get 
is given by doing the following Monte Carlo integral,

![equation](https://latex.codecogs.com/gif.latex?p(y^*|y)=\int&space;Multinomial(y^*|n^*,\bm{p})Dir(\bm{p}|\bm{y}&plus;\bm{\alpha})d\bm{p}.)

For predicting the number of votes in the general election the multinomial 
size, n*, is given by the number of votes cast in a given state in 2016 
as sourced from [http://www.electproject.org/2016g](http://www.electproject.org/2016g). 
This scales the variability between states, but (based on preliminary 
sensitivity analysis) realistically misspecifying n* here does not dramatically 
change the results.

Sampling one million y* voting outcomes and assigning the appropriate number 
of electoral college votes to the winner in each case produces a distribution 
of electoral college votes in each state, for each democratic candidate 
against Trump. Summing these distributions over the relevant states gives a 
prediction for the number of electoral college votes each candidate will get 
from those states.  

In this simulation I have limited the prediction to Iowa, Florida, Michigan, 
Nevada, New Hampshire, Virginia, Wisconsin, and North Carolina. Although I 
would like to add Arizona, Minnesota, Ohio, and Pennsylvania, pending decent polls 
from those states. I have tried to limit poll inclusion to polls present 
on FiveThirtyEight appearing within the last two-three months and that achieve 
at least a B+ pollster rating from FiveThirtyEight. If you can think of any 
other states that deserve to be considered, I welcome you to provide me a 
convincing argument as to why. If I am convinced and I can find the data I 
will include it.  

# A Measure of Success

To boil the simulation down to a simple measure of success, I compute 
the probability that each candidate will get more electoral college votes than 
Trump in the swing states. I subtract Trump's aggregate distribution of 
electoral college votes from that of the democrat. The probability of getting 
more electoral college votes than Trump in these states is now the number 
of positive differences divided by the total number of simulation runs (in 
this case one million).

![image](https://raw.github.com/gasduster99/primaryConcerns/master/swingVotes.jpg)

# A Lazy Election Forecast *(kinda)*

Assuming that non-swing states vote as expected (and the same for each democrat) 
I produce a lazy general election forecast for each democratic candidate 
against Trump. I tabulated my expected outcome among non-swing states with [270towin](https://www.270towin.com/maps/8xlYX).  

![image](https://www.270towin.com/maps/63XyE.png)

As seen above, my expectation gives democrats 199 and Trump 179 electoral 
college votes right out of the gate. This produces a 20 vote electoral college 
head start for the democrats. Shifting the previously computed distributions 
by these expectations produces the following forecast of the general election. 
Each distribution is compared against the 270 electoral college vote line (the 
minimum number of electoral college votes required to win the election) to 
judge the election outcome.  

![image](https://raw.github.com/gasduster99/primaryConcerns/master/collegeVotes.jpg)

Again I would like to add Arizona, Minnesota, Ohio, and Pennsylvania, pending decent 
polls in these states. Since I do not have such polls, I opted to leave them out
of the forecast entirely. Further I have left out the 2nd Districts of Nebraska and 
Maine. In total, this analysis leaves 61 electoral college votes unaccounted for. I 
figure it is less misleading to obviously exclude them from the analysis than to make 
a poorly informed guess about their outcome. Thus this lowers the effictive threshold 
for the minimum number of electoral college votes need to win to 239. 




