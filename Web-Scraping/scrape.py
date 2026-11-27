import requests
from bs4 import BeautifulSoup as bs

def get_page(url):
    r = requests.get(url)
    soup = bs(r.text, "lxml")
    links = soup.select("footer.card-footer a")
    return [link.attrs['href'] for link in links]

print(get_page('https://books.toscrape.com/'))
