rm(list=ls())

#
library(MCMCpack)

#
#DATA
#

#size of poll
ns = list()
ns[['Iowa']] = 1689
ns[['Florida']] = 625
ns[['Michigan']] = 600
ns[['Nevada']] = 1505
ns[['NewHampshire']] = 2223
ns[['Virginia']] = 625
ns[['Wisconsin']] = 800

#poling probabilities (candiate, trump, other)
p = list()
#Jan 25 2020 A+
p[['Iowa']] = list()
p[['Iowa']][['buttigieg']] = c(0.44,0.45,0.11)
p[['Iowa']][['biden']]	   = c(0.44,0.46,0.1)
p[['Iowa']][['klobuchar']] = c(0.41,0.46,0.13)
p[['Iowa']][['warren']]	   = c(0.42,0.47,0.11)
p[['Iowa']][['sanders']]   = c(0.42,0.48,0.1)
p[['Iowa']][['bloomerberg']] = c(0.39,0.47,0.14)
#Dec 31 2019 B+
p[['Florida']] = list()
p[['Florida']][['buttigieg']] = c(0.45,0.49,0.06)
p[['Florida']][['biden']]     = c(0.47,0.45,0.08)
p[['Florida']][['warren']]    = c(0.42,0.51,0.07)
p[['Florida']][['sanders']] = c(0.44,0.49,0.07)
#Jan 15 2020 B+
p[['Michigan']] = list()
p[['Michigan']][['buttigieg']] = c(0.47,0.43,0.1)
p[['Michigan']][['biden']]     = c(0.50,0.44,0.06)
p[['Michigan']][['warren']]    = c(0.48,0.45,0.07)
p[['Michigan']][['sanders']]   = c(0.5,0.45,0.05)
p[['Michigan']][['bloomerberg']] = c(0.49,0.42,0.09)
#Jan 9 2020 A-
p[['Nevada']] = list()
p[['Nevada']][['buttigieg']] = c(0.41,0.40,0.19)
p[['Nevada']][['biden']]     = c(0.47,0.39,0.14)
p[['Nevada']][['warren']]    = c(0.43,0.42,0.15)
p[['Nevada']][['sanders']]   = c(0.46,0.41,0.13)
#Jan 26 2020 A+
p[['NewHampshire']] = list()
p[['NewHampshire']][['buttigieg']] = c(0.51,0.41,0.08)
p[['NewHampshire']][['biden']]     = c(0.51,0.43,0.06)
p[['NewHampshire']][['warren']]    = c(0.48,0.44,0.08)
p[['NewHampshire']][['sanders']]   = c(0.51,0.43,0.06)
#Dec 31 2019 B+
p[['Virginia']] = list()
p[['Virginia']][['buttigieg']] = c(0.45,0.47,0.08)
p[['Virginia']][['biden']]     = c(0.49,0.45,0.06)
p[['Virginia']][['warren']]    = c(0.44,0.48,0.08)
p[['Virginia']][['sanders']]   = c(0.45,0.51,0.04)
#Jan 15 2020 A/B
p[['Wisconsin']] = list()
p[['Wisconsin']][['buttigieg']] = c(0.44,0.46,0.1)
p[['Wisconsin']][['biden']]     = c(0.49,0.45,0.06)
p[['Wisconsin']][['warren']]    = c(0.45,0.48,0.07)
p[['Wisconsin']][['sanders']]   = c(0.47,0.46,0.07)


#number of electoral college votes in each state
votes = list()
votes[['Iowa']] = 6
votes[['Florida']] = 29
votes[['Michigan']] = 16
votes[['Minnesota']] = 10
votes[['Ohio']] = 18
votes[['Nevada']] = 6
votes[['NewHampshire']] = 4
votes[['NorthCarolina']] = 15
votes[['Pennsylvania']] = 20
votes[['Virginia']] = 13
votes[['Wisconsin']] = 10

#number of likely voters in east state as of 2016 http://www.electproject.org/2016g
size = list()
size[['Iowa']] = 1581371
size[['Florida']] = 9580489 
size[['Michigan']] = 4874619	 
size[['Minnesota']] = 2968281	
size[['Ohio']] = 5607641	
size[['Nevada']] = 1125429
size[['NewHampshire']] = 755850	
size[['NorthCarolina']] = 4769640
size[['Pennsylvania']] = 6165478
size[['Virginia']] = 3984631
size[['Wisconsin']] = 2976150

#
peeps = c("buttigieg", "biden", "warren", "sanders") #names(p[['Nevada']])
states = c("Iowa", "Florida", "Michigan", "Nevada", "NewHampshire", "Virginia", "Wisconsin") #names(votes)[c(1:3,6)] #NOTE: just here to make the code work

#
#SAMPLE
#

#
M = 10^6

#
totalVotes = 0
cast = list()
cast[['tCast']] = matrix(0, nrow=M, ncol=length(peeps))
cast[['dCast']] = matrix(0, nrow=M, ncol=length(peeps))
cast[['oCast']] = matrix(0, nrow=M, ncol=length(peeps))
colnames(cast[['dCast']]) = peeps
for(state in states){
	for(peep in peeps){
		#nome = c(peep, 'trump', 'other')
		post = rdirichlet(M, ns[[state]]*p[[state]][[peep]]+1)
		who = apply(post, 1, function(x){
			pred = rmultinom(1, size[[state]], x)
			#print(pred)
			#print(which(pred==max(pred)))
			if(pred[1]==pred[2]){ return( sample(which(pred==max(pred)),1) ) 
			}else{ return(which(pred==max(pred))) }
		})
		#democrate numbers
		cast[['dCast']][who==1,peep] = cast[['dCast']][who==1,peep]+votes[[state]]
		#trump numbers
		cast[['tCast']][who==2,peeps==peep] = cast[['tCast']][who==2,peeps==peep]+votes[[state]]
		#other numbers
		cast[['oCast']][who==3,peeps==peep] = cast[['oCast']][who==3,peeps==peep]+votes[[state]]
	}
	totalVotes = totalVotes + votes[[state]]
}
#
box = do.call(cbind, cast)[,order(sequence(sapply(cast, ncol)))]

#
#OUTPUT
#

#
pdf('collegeVotes.pdf', width=12)
boxplot(box,
        col     = c('red', 'blue', 'grey'),
        outline = F,
	ylim    = c(0, totalVotes),
        #names   = names,
        #at      = ats,
        ylab    = "Votes",
        main    = "Electoral College Votes"
)
legend('topright', legend=c('Trump', 'Democrat', 'Other'), fill=c('red', 'blue', 'grey'))
dev.off()

#
probWins = colSums((cast[['dCast']]-cast[['tCast']])>0)/M

