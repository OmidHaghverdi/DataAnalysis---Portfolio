# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

# Importing the libraries

import requests
from bs4 import BeautifulSoup
import pandas as pd


# To avoid our IP to get blocked

headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36", 
           "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 
           "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}

# Getting started

baseurl = 'https://www.thewhiskyexchange.com/'

url = 'https://www.thewhiskyexchange.com/c/35/japanese-whisky'

# Navigating through pages of the website

productlinks = []

for x in range (1,4):

    link = requests.get(f'https://www.thewhiskyexchange.com/c/35/japanese-whisky?pg={x}')
    
    data = BeautifulSoup(link.content, "html.parser")
    
    productlist = data.find_all('li', class_ = 'product-grid__item')
        
    for item in productlist:
        for link in item.find_all('a', href = True):
            productlinks.append(baseurl + link['href'])
            
    
# testlink = 'https://www.thewhiskyexchange.com/p/29388/suntory-hibiki-harmony'

whiskylist = []
for link in productlinks:
    r = requests.get(link, headers=headers)        
    soup = BeautifulSoup(r.content, 'lxml')
    name = soup.find('h1', class_='product-main__name').text.strip()
    try:
        rating = soup.find('div', class_='review-overview').text.strip()
    except AttributeError:
        rating = 'No Rating'
    try:    
        reviews = soup.find('span', class_='review-overview__count').text.strip()
    except AttributeError:
        reviews = 'No Review'
    price = soup.find('p', class_='product-action__price').text.strip()
    
    # print(name, rating, reviews, price)
    
    whisky = {
        'Name': name,
        'Rating': rating,
        'Reviews': reviews,
        'Price': price
        }
    
    
    whiskylist.append(whisky)


df = pd.DataFrame(whiskylist)
df.head()


df = pd.DataFrame(whiskylist, columns=['Name', 'Rating', 'Reviews', 'Price'])
    
df.to_csv('FinalDataset.csv', index=False)
















