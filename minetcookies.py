import subprocess
import sys

import yaml
from pathlib import Path

from tqdm.auto import tqdm
import pandas as pd




default_yaml = """
---
buzzsumo:
  token: "MY_BZ_TOKEN"
crowdtangle:
  token: "MY_CT_TOKEN"
  rate_limit: 10
facebook:
  cookie: "MY_FACEBOOK_COOKIE"
instagram:
  cookie: "MY_INSTAGRAM_COOKIE"
mediacloud:
  token: "MY_MC_TOKEN"
tiktok:
  cookie: "MY_TIKTOK_COOKIE"
twitter:
  cookie: "MY_TWITTER_COOKIE"
  api_key: "MY_API_KEY"
  api_secret_key: "MY_API_SECRET_KEY"
  access_token: "MY_ACCESS_TOKEN"
  access_token_secret: "MY_ACCESS_TOKEN_SECRET"
youtube:
  key: "MY_YT_API_KEY"
  """

home = Path.home()
configfile = home / ".minetrc"

if not configfile.exists():
    configfile.write_text(default_yaml)

config = yaml.safe_load(configfile.read_text())

def minettest():
    try:
        subprocess.run(["minet", "--version"], capture_output=True)
    except FileNotFoundError:
        args = "curl -sSL https://raw.githubusercontent.com/medialab/minet/master/scripts/install.sh | bash".split(" ")
        subprocess.run(args, capture_output=True)

def get(media:str, key:str):
    return config[media][key]

def set(media:str, key:str, value:str):
    config[media][key] = value

def save():
    configfile.write_text(yaml.dump(config))

def recover_cookies(media:str):
    cookie = subprocess.run(["minet", "cookies", "chrome", "--url", f"https://www.{media}.com"], capture_output=True)
    cookie = cookie.stdout.decode("utf-8").strip()

    set(media, "cookie", cookie)
    save()

    print(f"Cookie for {media} saved")

# def call_minet(query:list):
#     query = ["minet"] + query
#     query = " ".join(query)
#     print(query)
#     minet = subprocess.run(query, capture_output=True)
#
#
#     if minet.returncode != 0:
#         print(minet.stderr.decode("utf-8"))
#         raise Exception("Error")
#
#     return minet.stdout.decode("utf-8").strip()

def main(query: list):
    args = query.copy()
    query = " ".join(args)

    minettest()

    query = query.split(" ")
    media = query[0]

    if media in ["instagram", "tiktok", "twitter", "facebook"]:
        key = "cookie"
    else:
        raise NotImplementedError

    actualcookie = get(media, key)
    if actualcookie.startswith("MY_") or actualcookie == "":
        recover_cookies(media)

    # outp = call_minet(query)
    #
    # with output.open(mode="w", encoding="utf-8") as f:
    #     f.write(outp)

    outp = Path(args[2])

    print(outp.as_posix())





if __name__ == "__main__":
    args = sys.argv[1:]
    main(args)

