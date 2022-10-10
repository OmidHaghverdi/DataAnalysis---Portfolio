# -*- coding: utf-8 -*-
"""
Created on Tue Oct  4 13:29:40 2022

@author: omidh
"""


# Importing the libraries

from bs4 import BeautifulSoup
import requests
import urllib.parse
import pandas as pd


# Getting started

url = 'https://www.amazon.com/s?k=ultrawide+monitor&crid=3V3E1HXDA508B&sprefix=ultrawide+monitor%2Caps%2C252&ref=nb_sb_noss_1'


headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36", 
           "Accept-Encoding":"gzip, deflate", "Accept":"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 
           "DNT":"1","Connection":"close", "Upgrade-Insecure-Requests":"1"}


webpages = []

for i in range(1,19):
    webpages.append(f'https://www.amazon.com/s?k=ultrawide+monitor&page={i}')
    
ss = []

for w in webpages:
    ss.append(BeautifulSoup(requests.get(w, headers=headers).content, 'html.parser'))
    
htmlss = []
for soops in ss:
    htmlss.append(soops.find_all('div', {'data-component-type': 's-search-result'}))
    

secondpart = []
product = []

for bago in htmlss:
    for nago in bago:
        secondpart.append(nago.h2.a['href'])
        
        urls = []
        for links in secondpart:
            urls.append(urllib.parse.urljoin(url, links))
                
        product.append(nago.h2.a.text.strip())
        
rating = []
for zz in htmlss:
    for jj in zz:
        try:
            rating.append(jj.find('span', class_='a-icon-alt').text)
        except AttributeError:
            rating.append('no rating')
            

review_count = []
for bb in htmlss:
    for kk in bb:
        try:
            review_count.append(kk.find('span', class_='a-size-base').text)
        except AttributeError:
            review_count.append('no review')   
            
            
price = []


for gg in htmlss:
    for tt in bb:
        try:
            price.append(tt.find('span', class_='a-price-whole').text.strip())
        except AttributeError:
            price.append('no price')
            

result = {
    'Product': product,
    'URL': urls,
    'Rating': rating,
    'Reviews': review_count,
    'Price': price,
}

df = pd.DataFrame(result, columns=['Product', 'URL', 'Rating', 'Reviews', 'Price'])
    
df.to_csv('FinalDataset.csv', index=False)












