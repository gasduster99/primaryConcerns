# primaryConcerns

FiveThirtyEight recently added a tool for viewing summaries of many of the polls they use to understand the upcoming 2020 election.
As I consider the upcoming primary vote I find myself vetting each decision by refering to the general election polls in swing states. It occurs to me that any vote worth making in the primary must produce a viable candidate among the swing states in the general election.
This idea prompted me to consider how the hypothetical runoff style polls, for assessing the general election, would position each democratic candidate when you further consider the somewhat unintuitve behavior of the electoral college.  

The general election polls (for example [Pennsylvania](https://projects.fivethirtyeight.com/polls/president-general/pennsylvania/)) takes the form of trinomial outcomes for each candidate against Trump and some other (third party or write-in) candiate in each state.

$$\bm{y_j} = [Democat, Trump, Other]$$
$$\bm{y_j} \sim Multinomial(n_j, \bm{p_j})$$

Assuming a Dirichlet prior on $\bm{p_j}$.

$$\bm{p_j} \sim Dir(\bm{\alpha})$$

One may specify a particular prior through the choice of $\bm{\alpha}$ components relative to each other; prior strength is then selected by the absolute scale of the components of $\bm{\alpha}$. At this time I am selecting the laplace prior of $\bm{\alpha}=\bm{1}$.

