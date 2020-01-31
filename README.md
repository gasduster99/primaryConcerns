# The Premise

FiveThirtyEight recently added a tool for viewing summaries of many of the polls that they use in models to better understand the upcoming 2020 election.
It occurs to me that any vote worth making in the primary must produce a viable candidate among the swing states in the general election.
In pursuit of that end I wrote the code here to consider how the hypothetical runoff style polls, for assessing the general election, would position each democratic candidate when you further consider the somewhat unintuitve behavior of the electoral college.  

The general election polls (for example [Pennsylvania](https://projects.fivethirtyeight.com/polls/president-general/pennsylvania/)) take the form of trinomial outcomes for the number of polled registered voters for a democratic candidate matched-up against Trump, as well as some other (third party or write-in) candiate in each state (![equation](https://latex.codecogs.com/gif.latex?j)).

![equation](https://latex.codecogs.com/gif.latex?\bm{y}&space;=&space;[Democrat,&space;Trump,&space;Other])

![equation](https://latex.codecogs.com/gif.latex?\bm{y}&space;\sim&space;Multinomial(n,&space;\bm{p}))

![equation](https://latex.codecogs.com/gif.latex?n) is the known total number of poll respondents.
Assuming a Dirichlet prior on ![equation](https://latex.codecogs.com/gif.latex?\bm{p}) 
gives conjugacy and produces the following posterior,

![equation](https://latex.codecogs.com/gif.latex?\bm{p}|\bm{y}&space;\sim&space;Dir(\bm{y}+\bm{\alpha}).)

One may specify a particular prior through the choice of ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}) 
components relative to each other; prior strength is then selected by the 
absolute scale of the components of ![equation](https://latex.codecogs.com/gif.latex?\bm{p_j}). 
At this time I am selecting the laplace prior over the ![equation](https://latex.codecogs.com/gif.latex?\bm{\alpha}).

# Simulation




