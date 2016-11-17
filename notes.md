Hi I come from Alabama with a laptop on my knee.  I gave my banjo away in the last house move.  I will warn you that as a presenter I require a couple of handicaps:  I'm from Alabama, I graduated in accounting, and I use Windows!  I fully transitioned to R in 2010 motivated by the packages xts, quantmod, and PerformanceAnalytics for finance.  Soon after I discovered the newly released d3.js and quickly started using both d3.js and R to analyze, explore, decide, and communicate in my role as a portfolio manager for institutional bonds and an inflation-focused hedge fund.  I am one of the authors of the R packages rCharts and its more robust successor htmlwidgets.  Last year I embarked on and completed a project to make an htmlwidget each week which I discussed on the site buildingwidgets.com.

Over the past 6 years, I have benefitted immensely from the Power of Combination.  In finance we are taught very early the power of combination in asset allocation based on the 1952 work of Harry Markowitz.  Markowitz illustrated the somewhat paradoxical ability under the right conditions to reduce risk in a portfolio by adding a more risky asset as shown in this efficient frontier plot depicted in Plotly.  We can achieve a more optimal risk/reward combination by blending the more risky stock asset.

Similarly we can achieve a more optimal blend in our non-finance world by exploiting the power of combination.  Samuelson in his textbook Economics first published in 1948 explains how speculation for profit can occur across three boundaries - time, space, and uncertain states of nature.  In the same ways we find our own reward through the power of combination across these same boundaries which I have slightly modified to time, space, and state of mind or pyschological state.  I intentionally use the word boundary since it requires a little extra effort to break out of these silos, but this little bit of extra effort can produce very meaningful rewards.

Let's look at each of these boundaries.

Time


I think most of the audience is aware of the fellow in the middle William Playfair, but you might not be as familiar with some of the other names on this slide before and after Playfair that all created and used very meaningful visualizations.

Look at this map from Nicholas Crucius more than 100 years before Playfair and nearly 300 year ago.  Crucius is credited with inventing the isobath or isobar lines that we see very commonly in weather and geography and many other fields.

Japanese rice trader who created what we know as candlestick charts that are used regularly in finance and continue to confound developers to this day :)  The purpose of these candlestick charts is to embed additional information from each periods prices open, high, low, close in an attempt to reveal patterns in the fickle state of mind as information is revealed and processed.  Here is one small example created from R.  These are extremely popular in finance and now the default chart type in the Markets page of the Wall Street Journal.  Although these were developed for finance, imagine how we might be able to use these for non-finance applications.

I could not find where anyone actually knows who invented this next chart type, but it seems "Hoyle" gets the credit since he first mentioned point-and-figure charts in his 1898 book "The Game in Wall Street".  These charts attempt to compress both time and price movement for both ease of plotting but more powerfully to minimize the un-important movement and reveal only the meaningful patterns and important price points.  This concept is critical and I think all of us either have already learned or can learn that not all data is important and for this reason that not all data necessarily needs to be visualized to convey the important message.  There are some who to this day earn their entire livelihood creating and interpreting these very old but still very useful point-and-figure charts.

I include William Dodge for his informative visualizations but also for their very unlikely source, the US Department of Agriculture in the late 1800s and early 1900s.  Here are a couple of examples from his work.  I urge all of you to check out his entire work.  I like his quote.

talk about camera and old on new


Space

Space in the Samuelson speculative meant geography, but I'll extend the space boundary to be not only geography but also across programming languages and fields/domains.

Geography

Stuck in Alabama far from the geographic centers of tech and visualizations, I have really enjoyed collaborating around the world and have been amazed at the rewards of this geographically diverse collaboration.  This map produced with the R package tmaps highlights a very limited subset of some of these interactions.  You'll see Montreal representing the connectiong to the incredibly talented Ramnath Vaidyanathan while he was at Mcgill University in Montreal.  I had a blast working with him on rCharts. I was delighted with these two lines out to the West Coast with cancer researchers.  One Anobel at University of Washington conducted research on the use of parallel coordinates htmlwidget for diagnosis and selection of treatment for metastatic renal cell carcinoma.  Another Tim Triche used the biofabric htmlwidget in pediatric acute myeloid leukemia.  The farthest interaction is the line to Shanghai with Ken Run, developer of the pipeR and formattable R packages and author of a fantastic new book on R programming.  I'll show an example later produced from the line to New York City and work from Alex Bresler.  Alex has been an incredible champion of open source and R and has motivated me through quite a few low points in my open source efforts.  I was very happy to finally meet him in person on this trip.  And the last line represents some fun joint geospatial work with Tim Appelhans at the University of Marburg in Germany on the mapview package.  All of these are now easily possible and enhanced by open source and social media.


Domains

The power of combination works extremely well across domains and fields.  I just mentioned the power of combination with my finance-focused work and the medical community, specifically cancer research, and geospatial world.  I have also reaped rewards by peering into the domains of networks,  biostatistics, marketing, and agriculture.  I should also mention the very important (or at least where I'm from) sports, specifically college football.  Roll Tide!  Here is an example using Karl Broman qtlcharts package to show the correlations and return relationships between Pimco mutual funds.  Here is the Likert plot demonstrating the improvement and satisfaction using the parallel coordinates htmlwidget in metastatic renal cell carcinoma.  I am constantly amazed at how much I have learned from other disciplines and how much fun it has been to work with the extremely intelligent and talented folks outside of finance.

Programming Languages

Who wouldn't want these guys on your team?  If you can't tell through my masterful Inkscape manipulation, this photo isn't real, but I feel like each and many more amazing developers are on my team everyday as I tackle difficult tasks.  I choose Hadley for data manipulation and Mike for visualization.  Nearly the entire premise of rCharts and htmlwidgets was to benefit from all of the exciting interactive work done in HTML, CSS, and JavaScript.  With these tools, I can be like the cool kids.  In fact, I have two packages on CRAN, d3r and reactR for seamless use of these "new" tools and their very prolific communities.  I love R, because blending these "new" tools and "old tools" is easy.  I take immense delight every time I use the rolling functions in TTR that use Fortran for tremendous speed improvements.  Although hidden from the average R user, C and C++ make our worlds much better.  In fact, Rcpp is the most depended upon CRAN package.


State of Mind

Throughout my recent experiences and most especially last year, I have learned the very fragile state of open source projects as I have witnessed the death and attended the funerals of some very promising work.  I hope more than anything that the power of combination can transcend the fickle state of mind of open source developers.  It is extremely difficult for one individual or a small group to sustain the momentum, drive, and enthusiasm to continue working on a project.  I would not have been able to keep pushing without the power of combination across all these boundaries of time, space, and uncertain states of nature (mind).  I can only hope that my participation, encouragement, and use has helped pushed some open source work beyond the very short average expected lives.


Examples

I wanted to include some quick examples to highlight the power of combination.  In this first I was able to take advantage of the power of combination across time and space.  Here we incorporate Markowitz work from over 60 years ago with the fPortfolio R package from Europe, the xts and quantmod R packages, the tidyverse (don't say Hadley-verse), and the new animation capabilities in Plotly from Canada.  In the earlier efficient frontier I intentionally overfitted and succumbed to backtest optimization to the period where stocks and bonds worked best together.  In this animated rolling version, we can see that the combination is not always this optimal. 

?? say something about the power of combination and its fluid advantages depending on the environment.

Who has seen an SEC ADV filing that all U.S. money managers?  They are an absolute monstrosity exceedingly difficult to use, but they contain incredibly rich data.  Alex Bresler (New York) has developed a R package fundManageR to let us easily parse and aggregate this opaque data.  In this example I use fundManageR to get a summary of the most recent filings of over 15,000 money managers and combine with the htmlwidget based on the parallel coordinates d3 library from Kai Chang to show how easily we can now explore the data. In this case, discovering money managers either convicted of or charged with a felony.



Let's combine!!  I would love to hear from you to exploit the power of combination.  Please contact me!

Thanks so much to everyone who contributed to this fantastic PlotCon experience and all those open source developers at there that make my life so much easier and better!!
