from minet.twitter import TwitterAPIScraper

scraper = TwitterAPIScraper()

for tweet in scraper.search_tweets('from:medialab_ScPo'):
    print(tweet)
