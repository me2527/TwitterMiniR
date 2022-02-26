#options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
consumerKey = "NeN3ix57QMIKifXBYeOxAZwm3" 
consumerSecret = "vk9jXtGoNjb1jsqhUWY3vecvBFL0XujErg9oJ2RPjFiQPhtLkY"
accessToken ="YYCLsWrryZ3wiBdl6M8NVFw94xaxO9jbXu4LOXRBlLoCW"
accessTokenSecret="1033296778353758209-9FcBlR8XboS9u6Colfy9k16Bp1SB2L"


#reqURL = "https://api.twitter.com/oauth/request_token" #important at the moment that it is https  Twitter needs a secure connection
#accessURL = "https://api.twitter.com/oauth/access_token"
#authURL = "https://api.twitter.com/oauth/authorize"
#twitCred = OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)
#twitCred$handshake() 
#registerTwitterOAuth(twitCred)


#setup_twitter_oauth(consumerKey,consumerSecret,accessToken,accessTokenSecret)


                                              #data acquistion

#tweets=searchTwitter("trump", n=10000,lang = "en")
#df = do.call("rbind", lapply(tweets, as.data.frame))

#write.csv(df, "Trump10000Tweets.csv", row.names=FALSE)


#TrumpTwiterAcct <- getUser("realDonaldTrump")
#donaldtweetslist = userTimeline(TrumpTwiterAcct, n=3200, includeRts=TRUE, excludeReplies=TRUE)
#tumpprofiletweetsdf = do.call("rbind", lapply(donaldtweetslist, as.data.frame))
#write.csv(tumpprofiletweetsdf, "realDonaldTrump3200Tweets.csv", row.names=FALSE)

URL = "https://raw.githubusercontent.com/chrisestevez/DataAnalyticsProjects/master/FinalProject/Trump10000Tweets.csv"
Rdata1 = getURL(URL)
TrumpSearch = read.csv(text = Rdata1,header = TRUE,stringsAsFactors = F,sep=",")
head(TrumpSearch,5)

TrumpSearchText  = as.vector(TrumpSearch$text)

url= "https://raw.githubusercontent.com/chrisestevez/DataAnalyticsProjects/master/FinalProject/realDonaldTrump3200Tweets.csv"
Rdata2 = getURL(url)
TrumpPersonal = read.csv(text = Rdata2,header = TRUE,stringsAsFactors = F,sep=",")
TrumpPersonalText  = as.vector(TrumpPersonal$text)
head(TrumpPersonal,5)

library('syuzhet')

get_nrc_sentiment("Donal Trump is awesome and amazing I'm happy he is running for president")
get_nrc_sentiment("I hate Donal Trump he is a liar and deceiving person")

head(TrumpSearchText,5)

cleanTweet = gsub("rt|RT", "", TrumpSearchText) # remove Retweet
cleanTweet = gsub("http\\w+", "", cleanTweet)  # remove links http
cleanTweet = gsub("<.*?>", "", cleanTweet) # remove html tags
cleanTweet = gsub("@\\w+", "", cleanTweet) # remove at(@)
cleanTweet = gsub("[[:punct:]]", "", cleanTweet) # remove punctuation
cleanTweet  = gsub("\r?\n|\r", " ", cleanTweet) # remove /n
cleanTweet = gsub("[[:digit:]]", "", cleanTweet) # remove numbers/Digits
cleanTweet = gsub("???|???|???|???|???|???|???|???|???|???", "", cleanTweet) #  asian letters
cleanTweet = gsub("[ |\t]{2,}", "", cleanTweet) # remove tabs
cleanTweet = gsub("^ ", "", cleanTweet)  # remove blank spaces at the beginning
cleanTweet = gsub(" $", "", cleanTweet) # remove blank spaces at the end 

TrumpSearchSentiment = get_nrc_sentiment(cleanTweet)
head(TrumpSearchSentiment,5)

TrumpSearchFinalData = cbind(TrumpSearch,TrumpSearchSentiment)

head( TrumpPersonalText,5)

cleanTweetp = gsub("rt|RT", "", TrumpPersonalText) # remove Retweet
cleanTweetp = gsub("http\\w+", "", cleanTweetp)  # remove links http
cleanTweetp = gsub("<.*?>", "", cleanTweetp) # remove html tags
cleanTweetp = gsub("@\\w+", "", cleanTweetp) # remove at(@)
cleanTweetp = gsub("[[:punct:]]", "", cleanTweetp) # remove punctuation
cleanTweetp  = gsub("\r?\n|\r", " ", cleanTweetp) # remove /n
cleanTweetp = gsub("[[:digit:]]", "", cleanTweetp) # remove numbers/Digits
cleanTweetp = gsub("???|???|???|???|???|???|???|???|???|???", "", cleanTweetp) #  asian letters
cleanTweetp = gsub("[ |\t]{2,}", "", cleanTweetp) # remove tabs
cleanTweetp = gsub("^ ", "", cleanTweetp)  # remove blank spaces at the beginning
cleanTweetp = gsub(" $", "", cleanTweetp) # remove blank spaces at the end 

TrumpPersonalSentiment = get_nrc_sentiment(cleanTweetp)
head(TrumpPersonalSentiment,5)

TrumpPersonalFinalData = cbind(TrumpPersonal,TrumpPersonalSentiment)

print(TrumpPersonalFinalData)



