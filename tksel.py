import sys
from time import sleep

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options as COptions

import requests

import pandas as pd

from pathlib import Path

from tqdm.auto import tqdm




def main(csv, output):
    df = pd.read_csv(csv).fillna("")
    id = df["id"].tolist()

    folder = Path(output)
    folder.mkdir(exist_ok=True, parents=True)


    headers = {'Accept-Encoding': 'gzip, deflate, sdch',
               'Accept-Language': 'en-US,en;q=0.8',
               'Upgrade-Insecure-Requests': '1',
               'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36',
               'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
               'Cache-Control': 'max-age=0',
               'Connection': 'keep-alive',
               'referer': 'https://www.tiktok.com/'
               }

    headless = True

    options = COptions()

    if headless:
        options.add_argument("--headless=new")

    driver = webdriver.Chrome(options=options)


    for i in tqdm(id):

        url = f"https://www.tiktok.com/@hugodecrypte/video/{i}"

        driver.get(url)

        sleep(1)

        video = driver.find_element(By.XPATH, '/html/body/div[1]/div[2]/div[2]/div/div[2]/div/div[1]/div[1]/div[2]/div/div/div/video').get_attribute("src")

        cookies = driver.get_cookies()
        s = requests.Session()
        for cookie in cookies:
            s.cookies.set(cookie['name'], cookie['value'])
        # headers = driver.get_headers()

        response = s.get(video, stream=True, headers=headers)
        # print(response.status_code)
        response.raise_for_status()

        with open(folder / f"{i}.mp4", mode='wb') as f:
            f.write(response.content)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py csv_file output_folder")
    else:
        csv_file = sys.argv[1]
        output_folder = sys.argv[2]
        main(csv_file, output_folder)
