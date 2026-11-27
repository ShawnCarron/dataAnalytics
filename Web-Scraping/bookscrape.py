import requests
from bs4 import BeautifulSoup as bs

url = f"https://books.toscrape.com/catalogue/a-light-in-the-attic_1000/index.html"


def get_pages(url):
    baseurl = f"https://books.toscrape.com/"
    r = requests.get(url)
    soup = bs(r.text, 'html.parser')
    links = soup.select("li a")
    return [baseurl + link.attrs['href'] for link in links]

def product_data(url):
    r = requests.get(url)
    soup = bs(r.text, 'html.parser')
    product = {
        'title': soup.select_one('div.col-sm-6 h1').text.strip().replace('\n', " "),
        'price': soup.select_one('p.price_color').text.strip().replace('Â£', ""),
        'stock': soup.select_one('p.instock').text.strip(),
        'desc': soup.select_one('p:not([class]):not([id])').text.strip()
     
    }
    return(product)
    
print(product_data("https://books.toscrape.com/catalogue/a-light-in-the-attic_1000/index.html"))