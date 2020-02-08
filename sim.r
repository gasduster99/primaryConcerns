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
ns[['NorthCarolina']] = 1504	

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
#Nov 14 2019 A-
p[['NorthCarolina']] = list()
p[['NorthCarolina']][['buttigieg']] = c(0.39,0.43,0.18)
p[['NorthCarolina']][['biden']]     = c(0.45,0.43,0.12)
p[['NorthCarolina']][['warren']]    = c(0.43,0.44,0.13)
p[['NorthCarolina']][['sanders']]   = c(0.45,0.44,0.11)

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

#define to who and were I have full data to run simulation 
peeps = c("buttigieg", "biden", "warren", "sanders")
states = c(
	"Iowa", 
	"Florida", 
	"Michigan", 
	"Nevada", 
	"NewHampshire", 
	"Virginia", 
	"Wisconsin", 
	"NorthCarolina"
)

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
		post = rdirichlet(M, ns[[state]]*p[[state]][[peep]]+1)
		who = apply(post, 1, function(x){
			#
			pred = rmultinom(1, size[[state]], x)
			#
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
#OUTPUT
#

#compute probability of winning
probWins = colSums((cast[['dCast']]-cast[['tCast']])>0)/M
#prep probability vector for plotting
l = list('a'=names(probWins), 'b'=rep(':', length(probWins)), 'c'=sprintf('%s  ', round(probWins, 3)))
l = do.call(c, l)[order(sequence(sapply(l, length)))]

#
jpeg('swingVotes.jpg', width=800)
box = do.call(cbind, cast)[,order(sequence(sapply(cast, ncol)))]
boxplot(box,
        col     = c('red', 'blue', 'grey'),
        outline = F,
	ylim    = c(0, totalVotes),
        #names   = names,
        at      = seq(1, length(peeps)*4)[-seq(4, length(peeps)*4, 4)],
        ylab    = "Swing Electoral College Votes",
        main    = sprintf("Pr(Democrat eVotes>Trump | swing states) = %s", paste(l, collapse=c("")))
)
legend('topright', legend=c('Trump', 'Democrat', 'Other'), fill=c('red', 'blue', 'grey'))
dev.off()

#
dBump = 199
tBump = 179
bCast = cast
#
bCast[['dCast']] = bCast[['dCast']]+dBump
bCast[['tCast']] = bCast[['tCast']]+tBump

#
inn  = dBump+tBump+totalVotes
miss = 538-inn
effThresh = ceiling( (538-miss)/2 )

#compute probability of winning
bProbWins = colSums(bCast[['dCast']]>effThresh)/M
#prep probability vector for plotting
bl = list('a'=names(bProbWins), 'b'=rep(':', length(bProbWins)), 'c'=sprintf('%s  ', round(bProbWins, 3)))
bl = do.call(c, bl)[order(sequence(sapply(bl, length)))]

#
jpeg('collegeVotes.jpg', width=800)
bbox = do.call(cbind, bCast)[,order(sequence(sapply(bCast, ncol)))]
boxplot(bbox,
        col     = c('red', 'blue', 'grey'),
        outline = F,
	ylim    = c(0, max(bbox)),
        #names   = names,
        at      = seq(1, length(peeps)*4)[-seq(4, length(peeps)*4, 4)],
        ylab    = "Electoral College Votes",
        main    = sprintf("*** Electoral College Votes From AZ, MN, OH, PA, NE#2, and ME#2 Left Out ***\nPr(eVotes>%s) = %s", effThresh, paste(bl, collapse=c("")))
)
abline(h=270, lwd=3)
abline(h=effThresh, lwd=2, lty=2)
legend('right', legend=c('Trump', 'Democrat', 'Other', '270 eVotes', sprintf('%s eVotes', effThresh)), 
	fill=c('red', 'blue', 'grey', NA, NA), 
	lwd=c(NA, NA, NA, 3, 2), 
	lty=c(NA, NA, NA, 1, 2),
	border=c(rep('black', 3), NA, NA), 
	x.intersp=-c(1, 1, 1, -0.5, -0.5)
)
dev.off()




