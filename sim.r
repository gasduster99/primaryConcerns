rm(list=ls())

#
library(MCMCpack)

#
#FUNCTIONS
#

#
combineNs = function(ns){
	#ns: list of ns
	
	#
	eyeL = sapply(ns, length)       
        eye = which(eyeL==max(eyeL))[1]
	#
	wn = list()
        for(n in names(ns[[eye]])){
		Ns = 0
		for(i in 1:length(ns)){
			Ns = Ns + ns[[i]][[n]]
		}
		wn[[n]] = Ns
	}
	
	#
	return(wn)
}

#
combinePs = function(ns, ps){
	#ns: list of ns
	#ps: list of poll vectors
	#
	#value: a weighted average of ps by ns
	
	#which is the longest list of candidates?
	eyeL = sapply(ps, length)	
	eye = which(eyeL==max(eyeL))[1]
	#
	wp = list()
	for(n in names(ps[[eye]])){
		#
		wp[[n]] = c(0,0,0)
		Ns = 0	
		for(i in 1:length(ps)){ 
			#
			if( !n%in%names(ps[[i]]) ){ ps[[i]][[n]] = c(0,0,0) }	
			#
			wp[[n]] = wp[[n]]+ps[[i]][[n]]*ns[[i]][[n]]  #ns[i] 
			Ns = Ns + ns[[i]][[n]]
		}
		#
		wp[[n]] = wp[[n]]/Ns
	}
	
	#
	return( wp )
}

#
#DATA
#

#
fill = 1
#size of poll
ns = list()
#Jan 25 2020 A+
ns[['Iowa']] = list()
ns[['Iowa']][['buttigieg']] = 1689
ns[['Iowa']][['biden']]	    = 1689
ns[['Iowa']][['klobuchar']] = 1689
ns[['Iowa']][['warren']]    = 1689
ns[['Iowa']][['sanders']]   = 1689
ns[['Iowa']][['bloomberg']] = 1689 
#Jan 9 2020 A-
ns[['Nevada']] = list()
ns[['Nevada']][['buttigieg']] = 1505
ns[['Nevada']][['biden']]     = 1505
ns[['Nevada']][['warren']]    = 1505
ns[['Nevada']][['sanders']]   = 1505
#Dec 31 2019 B+
ns[['Virginia']] = list()
ns[['Virginia']][['buttigieg']] = 625
ns[['Virginia']][['biden']]     = 625
ns[['Virginia']][['warren']]    = 625
ns[['Virginia']][['sanders']]   = 625
#Feb 19 2020 A
ns[['NorthCarolina']] = list()
ns[['NorthCarolina']][['buttigieg']] = 2366
ns[['NorthCarolina']][['biden']]     = 2366
ns[['NorthCarolina']][['warren']]    = 2366
ns[['NorthCarolina']][['sanders']]   = 2366
ns[['NorthCarolina']][['bloomberg']] = 2366
ns[['NorthCarolina']][['klobuchar']] = 2366
#Jan 26 2020 A+
ns[['NewHampshire']] = list()
ns[['NewHampshire']][['buttigieg']] = 2223
ns[['NewHampshire']][['biden']]     = 2223
ns[['NewHampshire']][['warren']]    = 2223
ns[['NewHampshire']][['sanders']]   = 2223
#Feb 20 2020 B+
ns[['Pennsylvania']] = list()
ns[['Pennsylvania']][['buttigieg']] = 849
ns[['Pennsylvania']][['biden']]     = 849 
ns[['Pennsylvania']][['warren']]    = 849
ns[['Pennsylvania']][['sanders']]   = 849
ns[['Pennsylvania']][['klobuchar']] = 849
ns[['Pennsylvania']][['bloomberg']] = 849
##Nov 4 2019 A+
#ns[['Pennsylvania1']] = list()
#ns[['Pennsylvania1']][['buttigieg']] = fill
#ns[['Pennsylvania1']][['biden']]     = 661
#ns[['Pennsylvania1']][['warren']]    = 661
#ns[['Pennsylvania1']][['sanders']]   = 661
##Nov 14 2019 A+
#ns[['Pennsylvania2']] = list() 
#ns[['Pennsylvania2']][['buttigieg']] = fill
#ns[['Pennsylvania2']][['biden']]     = 410
#ns[['Pennsylvania2']][['warren']]    = 410
#ns[['Pennsylvania2']][['sanders']]   = 410
#Jan 15 2020 B+
ns[['Michigan1']] = list() 
ns[['Michigan1']][['buttigieg']] = 600
ns[['Michigan1']][['biden']]     = 600
ns[['Michigan1']][['warren']]    = 600
ns[['Michigan1']][['sanders']]   = 600
ns[['Michigan1']][['bloomberg']] = 600
#Feb 20 2020 B+
ns[['Michigan2']] = list() 
ns[['Michigan2']][['buttigieg']] = 845
ns[['Michigan2']][['biden']]     = 845
ns[['Michigan2']][['warren']]    = 845
ns[['Michigan2']][['sanders']]   = 845
ns[['Michigan2']][['bloomberg']] = 845
ns[['Michigan2']][['klobuchar']] = 845
#Jan 15 2020 A/B
ns[['Wisconsin1']] = list()
ns[['Wisconsin1']][['buttigieg']] = 800
ns[['Wisconsin1']][['biden']]     = 800
ns[['Wisconsin1']][['warren']]    = 800
ns[['Wisconsin1']][['sanders']]   = 800
ns[['Wisconsin3']][['bloomberg']] = fill
#Jan 9 2020 A-
ns[['Wisconsin2']] = list()
ns[['Wisconsin2']][['buttigieg']] = 1504
ns[['Wisconsin2']][['biden']]     = 1504
ns[['Wisconsin2']][['warren']]    = 1504
ns[['Wisconsin2']][['sanders']]   = 1504
ns[['Wisconsin3']][['bloomberg']] = fill
#Feb 20 2020 B+
ns[['Wisconsin3']] = list()
ns[['Wisconsin3']][['buttigieg']] = 823
ns[['Wisconsin3']][['biden']]     = 823
ns[['Wisconsin3']][['warren']]    = 823
ns[['Wisconsin3']][['sanders']]   = 823
ns[['Wisconsin3']][['bloomberg']] = 823
ns[['Wisconsin3']][['klobuchar']] = 823
#Dec 31 2019 B+
ns[['Florida1']] = list()
ns[['Florida1']][['buttigieg']] = 625 
ns[['Florida1']][['biden']]     = 625
ns[['Florida1']][['warren']]    = 625
ns[['Florida1']][['sanders']]   = 625
ns[['Florida1']][['bloomberg']] = fill
#Feb 19 2020 A/B
ns[['Florida2']] = list()
ns[['Florida2']][['buttigieg']] = 664 
ns[['Florida2']][['biden']]     = 668
ns[['Florida2']][['warren']]    = 661
ns[['Florida2']][['sanders']]   = 671
ns[['Florida2']][['klobuchar']] = 662
ns[['Florida2']][['bloomberg']] = 672
#Jan 8 2020 B
ns[['Arizona1']] = list()
ns[['Arizona1']][['buttigieg']] = 760
ns[['Arizona1']][['biden']]     = 760
ns[['Arizona1']][['warren']]    = 760 
ns[['Arizona1']][['sanders']]   = 760
ns[['Arizona1']][['bloomberg']] = fill
#Dec 9 2020 B/C
ns[['Arizona2']] = list()
ns[['Arizona2']][['buttigieg']] = 628 
ns[['Arizona2']][['biden']]     = 628
ns[['Arizona2']][['warren']]    = 628
ns[['Arizona2']][['sanders']]   = 628
ns[['Arizona2']][['bloomberg']] = 628
#Nov 4 2019 A+
ns[['Arizona3']] = list()
ns[['Arizona3']][['bloomberg']] = fill
ns[['Arizona3']][['buttigieg']] = fill 
ns[['Arizona3']][['biden']]     = 652
ns[['Arizona3']][['warren']]    = 652
ns[['Arizona3']][['sanders']]   = 652

#
#

#pooling probabilities (candiate, trump, other)
p = list()
#Jan 25 2020 A+
p[['Iowa']] = list()
p[['Iowa']][['buttigieg']] = c(0.44,0.45,0.11)
p[['Iowa']][['biden']]	   = c(0.44,0.46,0.1)
p[['Iowa']][['klobuchar']] = c(0.41,0.46,0.13)
p[['Iowa']][['warren']]	   = c(0.42,0.47,0.11)
p[['Iowa']][['sanders']]   = c(0.42,0.48,0.1)
p[['Iowa']][['bloomberg']] = c(0.39,0.47,0.14)
#Jan 9 2020 A-
p[['Nevada']] = list()
p[['Nevada']][['buttigieg']] = c(0.41,0.40,0.19)
p[['Nevada']][['biden']]     = c(0.47,0.39,0.14)
p[['Nevada']][['warren']]    = c(0.43,0.42,0.15)
p[['Nevada']][['sanders']]   = c(0.46,0.41,0.13)
#Dec 31 2019 B+
p[['Virginia']] = list()
p[['Virginia']][['buttigieg']] = c(0.45,0.47,0.08)
p[['Virginia']][['biden']]     = c(0.49,0.45,0.06)
p[['Virginia']][['warren']]    = c(0.44,0.48,0.08)
p[['Virginia']][['sanders']]   = c(0.45,0.51,0.04)
#Feb 19 2020 A
p[['NorthCarolina']] = list()
p[['NorthCarolina']][['buttigieg']] = c(0.45,0.46,0.09)
p[['NorthCarolina']][['biden']]	    = c(0.49,0.45,0.06)
p[['NorthCarolina']][['klobuchar']] = c(0.42,0.46,0.12)
p[['NorthCarolina']][['warren']]    = c(0.44,0.48,0.08)
p[['NorthCarolina']][['sanders']]   = c(0.50,0.45,0.05)
p[['NorthCarolina']][['bloomberg']] = c(0.49,0.43,0.08)
#Jan 26 2020 A+
p[['NewHampshire']] = list()
p[['NewHampshire']][['buttigieg']] = c(0.51,0.41,0.08)
p[['NewHampshire']][['biden']]     = c(0.51,0.43,0.06)
p[['NewHampshire']][['warren']]    = c(0.48,0.44,0.08)
p[['NewHampshire']][['sanders']]   = c(0.51,0.43,0.06)
#Feb 20 2020 B+
p[['Pennsylvania']] = list()
p[['Pennsylvania']][['buttigieg']] = c(0.47,0.43,0.1)
p[['Pennsylvania']][['biden']]     = c(0.50,0.42,0.08)
p[['Pennsylvania']][['warren']]    = c(0.47,0.44,0.09)
p[['Pennsylvania']][['sanders']]   = c(0.48,0.44,0.08)
p[['Pennsylvania']][['bloomberg']] = c(0.48,0.42,0.1)
p[['Pennsylvania']][['klobuchar']] = c(0.49,0.42,0.09)
#Jan 15 2020 B+
p[['Michigan1']] = list()
p[['Michigan1']][['buttigieg']] = c(0.47,0.43,0.1)
p[['Michigan1']][['biden']]     = c(0.50,0.44,0.06)
p[['Michigan1']][['warren']]    = c(0.48,0.45,0.07)
p[['Michigan1']][['sanders']]   = c(0.5,0.45,0.05)
p[['Michigan1']][['bloomberg']] = c(0.49,0.42,0.09)
#Feb 20 2020 B+
p[['Michigan2']] = list()
p[['Michigan2']][['buttigieg']] = c(0.45,0.44,0.11)
p[['Michigan2']][['biden']]     = c(0.47,0.43,0.1)
p[['Michigan2']][['warren']]    = c(0.45,0.43,0.12)
p[['Michigan2']][['sanders']]   = c(0.48,0.43,0.09)
p[['Michigan2']][['bloomberg']] = c(0.47,0.42,0.11)
p[['Michigan2']][['klobuchar']] = c(0.45,0.44,0.11)
#Jan 15 2020 A/B
p[['Wisconsin1']] = list()
p[['Wisconsin1']][['buttigieg']] = c(0.44,0.46,0.1)
p[['Wisconsin1']][['biden']]     = c(0.49,0.45,0.06)
p[['Wisconsin1']][['warren']]    = c(0.45,0.48,0.07)
p[['Wisconsin1']][['sanders']]   = c(0.47,0.46,0.07)
#Jan 9 2020 A-
p[['Wisconsin2']] = list()
p[['Wisconsin2']][['buttigieg']] = c(0.42,0.41,0.17)
p[['Wisconsin2']][['biden']]     = c(0.46,0.41,0.13)
p[['Wisconsin2']][['warren']]    = c(0.44,0.42,0.14)
p[['Wisconsin2']][['sanders']]   = c(0.46,0.42,0.12)
#Feb 20 2020 B+
p[['Wisconsin3']] = list()
p[['Wisconsin3']][['buttigieg']] = c(0.41,0.49,0.10)
p[['Wisconsin3']][['biden']]     = c(0.42,0.49,0.09)
p[['Wisconsin3']][['warren']]    = c(0.41,0.51,0.08)
p[['Wisconsin3']][['sanders']]   = c(0.43,0.50,0.07)
p[['Wisconsin3']][['bloomberg']] = c(0.41,0.49,0.10)
p[['Wisconsin3']][['klobuchar']] = c(0.39,0.50,0.11)
#Dec 31 2019 B+
p[['Florida1']] = list()
p[['Florida1']][['buttigieg']] = c(0.45,0.49,0.06)
p[['Florida1']][['biden']]     = c(0.47,0.45,0.08)
p[['Florida1']][['warren']]    = c(0.42,0.51,0.07)
p[['Florida1']][['sanders']]   = c(0.44,0.49,0.07)
#Feb 19 2020 A/B
p[['Florida2']] = list()
p[['Florida2']][['buttigieg']] = c(0.45,0.49,0.06)
p[['Florida2']][['biden']]     = c(0.49,0.48,0.03)
p[['Florida2']][['warren']]    = c(0.47,0.47,0.06)
p[['Florida2']][['sanders']]   = c(0.48,0.48,0.04)
p[['Florida2']][['bloomberg']] = c(0.50,0.44,0.06)
p[['Florida2']][['klobuchar']] = c(0.44,0.48,0.08)
#Jan 8 2020 B
p[['Arizona1']] = list()
p[['Arizona1']][['buttigieg']] = c(0.44,0.47,0.09)
p[['Arizona1']][['biden']]     = c(0.46,0.46,0.08)
p[['Arizona1']][['warren']]    = c(0.45,0.47,0.08)
p[['Arizona1']][['sanders']]   = c(0.46,0.47,0.07)
#Dec 9 2019 B/C
p[['Arizona2']] = list()
p[['Arizona2']][['biden']]     = c(0.44,0.46,0.1)
p[['Arizona2']][['warren']]    = c(0.41,0.47,0.12)
p[['Arizona2']][['sanders']]   = c(0.34,0.47,0.19)
p[['Arizona2']][['buttigieg']] = c(0.43,0.45,0.12)
p[['Arizona2']][['bloomberg']] = c(0.40,0.47,0.13)
#Nov 4 2019 A+
p[['Arizona3']] = list()
p[['Arizona3']][['biden']]     = c(0.49,0.46,0.05)
p[['Arizona3']][['warren']]    = c(0.46,0.47,0.07)
p[['Arizona3']][['sanders']]   = c(0.45,0.49,0.06)

#deal with bloomberg
i = 1
nBoot = list()
for(n in names(p)){
	nBoot[[i]] = ns[[n]]
	i = i+1
}
pBoot = combinePs(nBoot, p)

#
##Nov 4 2019 A+
#p[['Pennsylvania1']] = list()
#p[['Pennsylvania1']][['buttigieg']] = pBoot[['buttigieg']]
#p[['Pennsylvania1']][['biden']]     = c(0.46,0.45,0.09)
#p[['Pennsylvania1']][['warren']]    = c(0.44,0.45,0.11)
#p[['Pennsylvania1']][['sanders']]   = c(0.44,0.45,0.11)
##Nov 14 2019 A+
#p[['Pennsylvania2']] = list() 
#p[['Pennsylvania2']][['biden']]     = c(0.52,0.43,0.05)
#p[['Pennsylvania2']][['warren']]    = c(0.50,0.45,0.05)
#p[['Pennsylvania2']][['sanders']]   = c(0.50,0.45,0.05)
##
#p[['Pennsylvania']] = combinePs( list(ns[['Pennsylvania1']], ns[['Pennsylvania2']]), list(p[['Pennsylvania1']], p[['Pennsylvania2']]) )
#ns[['Pennsylvania']] = combineNs( list(ns[['Pennsylvania1']], ns[['Pennsylvania2']]) )

#Aggregate Polls
#
p[['Michigan']] = combinePs( list(ns[['Michigan1']], ns[['Michigan2']]), list(p[['Michigan1']], p[['Michigan2']]) )
ns[['Michigan']] = combineNs( list(ns[['Michigan1']], ns[['Michigan2']]) ) 
#
p[['Wisconsin']] = combinePs( list(ns[['Wisconsin1']], ns[['Wisconsin2']], ns[['Wisconsin3']]), list(p[['Wisconsin1']], p[['Wisconsin2']], p[['Wisconsin3']]) )
ns[['Wisconsin']] = combineNs( list(ns[['Wisconsin1']], ns[['Wisconsin2']], ns[['Wisconsin3']]) ) 
#
p[['Florida']] = combinePs( list(ns[['Florida1']], ns[['Florida2']]), list(p[['Florida1']], p[['Florida2']]) )
ns[['Florida']] = combineNs( list(ns[['Florida1']], ns[['Florida2']]) ) 
#
p[['Arizona']] = combinePs( list(ns[['Arizona1']], ns[['Arizona2']], ns[['Arizona3']]), list(p[['Arizona1']], p[['Arizona2']], p[['Arizona3']]) )
ns[['Arizona']] = combineNs( list(ns[['Arizona1']], ns[['Arizona2']], ns[['Arizona3']]) )

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
votes[['Arizona']] = 11

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
size[['Arizona']] = 2661497	

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
	"NorthCarolina",
	"Pennsylvania",
	"Arizona"
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
		post = rdirichlet(M, ns[[state]][[peep]]*p[[state]][[peep]]+1)
		who = apply(post, 1, function(x){
			#
			pred = rmultinom(1, size[[state]], x)
			#
			if(pred[1]==pred[2] | pred[1]==pred[3] | pred[2]==pred[3]){ return( sample(which(pred==max(pred)),1) ) 
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
bProbWins = colSums(bCast[['dCast']]>=effThresh)/M
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
        main    = sprintf("*** Electoral College Votes From MN, OH, NE#2, and ME#2 Left Out ***\nPr(eVotes\u2265%s) = %s", effThresh, paste(bl, collapse=c("")))
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




