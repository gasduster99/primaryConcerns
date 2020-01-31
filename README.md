# primaryConcerns

FiveThirtyEight recently added a tool for viewing summaries of many of the polls that they use in models to better understand the upcoming 2020 election.
It occurs to me that any vote worth making in the primary must produce a viable candidate among the swing states in the general election.
In pursuit of that end I wrote the code here to consider how the hypothetical runoff style polls, for assessing the general election, would position each democratic candidate when you further consider the somewhat unintuitve behavior of the electoral college.  

The general election polls (for example [Pennsylvania](https://projects.fivethirtyeight.com/polls/president-general/pennsylvania/)) take the form of trinomial outcomes for the number of polled registered voters for a democratic candidate matched-up against Trump, as well as some other (third party or write-in) candiate in each state.

![equation](https://latex.codecogs.com/gif.latex?\bm{y_j}&space;=&space;[Democrat,&space;Trump,&space;Other])

![equation](https://latex.codecogs.com/gif.latex?\bm{y_j}&space;\sim&space;Multinomial(n_j,&space;\bm{p_j}))


Assuming a Dirichlet prior on ![equation](https://latex.codecogs.com/gif.latex?\bm{p_j}).

![equation](https://latex.codecogs.com/gif.latex?\bm{p_j}&space;\sim&space;Dir(\bm{\alpha}))

One may specify a particular prior through the choice of $\bm{\alpha}$ components relative to each other; prior strength is then selected by the absolute scale of the components of $\bm{\alpha}$. At this time I am selecting the laplace prior of $\bm{\alpha}=\bm{1}$.

