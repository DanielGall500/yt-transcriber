from __future__ import unicode_literals
from pathlib import Path
from os import path
import pandas as pd
import youtube_dl
import argparse
import sys
import os

#Get URL information
URLS_FILE = "urls.txt"
url_df = pd.read_csv(URLS_FILE)
urls = url_df['url']

#Create filenames for each URL
lang = url_df['lang']
descriptions = url_df['desc']
start_times = url_df['start_time']
filenames = [f"{lang}.{desc}.{start}.%(ext)s" for lang, desc, start in zip(lang, descriptions, start_times)]

for url, filename in zip(urls, filenames):
    save_path = os.path.join(os.getcwd(), 'delib-audio', 'full-audio', filename)

    download_settings = {
        'format': 'bestaudio/best',
        'outtmpl': save_path,
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192'
        }],
    }
    with youtube_dl.YoutubeDL(download_settings) as ydl:
        ydl.download([url])
