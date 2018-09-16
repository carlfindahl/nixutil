#!/bin/python

# Title: vkDocsCommandFetcher
# Purpose: Utility to fetch / cache vulkan commands from
#          https://www.khronos.org/registry/vulkan/specs/1.1-extensions/man/html/
# Author: Carl Findahl
# Date: 12.09.2018

import requests
import pathlib
import bs4

URL = "https://www.khronos.org/registry/vulkan/specs/1.1-extensions/man/html/"
cacheFile = "/home/carl/.cache/vkList.txt"


def main():
    vkCommands = []

    # If command list is cached load from file
    if pathlib.Path.exists(pathlib.Path(cacheFile)):
        with open(cacheFile, 'r') as f:
            vkCommands = [line for line in f]

    # Otherwise get fresh list from web
    else:
        print("Loading web-page..")
        vkPage = requests.get(URL)
        print(f"Response: {vkPage.status_code}")
        soup = bs4.BeautifulSoup(vkPage.text, "html5lib")
        print("Parsed output!")

        # Find Vulkan Commands
        for element in soup.find("table").find_all("a"):
            if(element.get('href').endswith(".html")):
                vkCommands.append(f"{element.get('href')[:-5]}\n")

        # Write cached file
        with open(cacheFile, 'w') as f:
            for cmd in vkCommands:
                f.write(f"{cmd}")

    for cmd in vkCommands:
        print(cmd, end='')


if __name__ == '__main__':
    main()
