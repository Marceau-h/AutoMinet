import sys
from time import sleep

from tqdm.auto import tqdm

import pandas as pd

from pathlib import Path

import pyktok as pyk

cwd = Path().cwd()

def main(csv, output):
    df = pd.read_csv(csv).fillna("")
    id = df["id"].tolist()

    folder = Path(output)
    folder.mkdir(exist_ok=True, parents=True)


    for i in tqdm(id):
        pyk.save_tiktok(f'https://www.tiktok.com/@tiktok/video/{i}?is_copy_url=1&is_from_webapp=v1',
                        True,
                        'video_data.csv',
                        'chrome')
        for file in cwd.glob('*.mp4'):
            if file.name.__contains__(str(i)):
                file.rename(folder / f"{i}.mp4")
                break
        sleep(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py csv_file output_folder")
    else:
        csv_file = sys.argv[1]
        output_folder = sys.argv[2]
        main(csv_file, output_folder)
