#!/bin/python

# Title: glDocsCommandFetcher
# Purpose: Utility to fetch / cache glCommands from docs.gl
# Author: Carl Findahl
# Date: 21.07.2018

import requests
import pathlib
import bs4


def main():
        glCommands = []

        # If command list is cached load from file
        if pathlib.Path.exists(pathlib.Path("/tmp/glList.txt")):
                with open("/tmp/glList.txt", 'r') as f:
                        glCommands = [line for line in f]

        # Otherwise get fresh list from web
        else:
                glPage = requests.get("http://docs.gl")
                soup = bs4.BeautifulSoup(glPage.text, "html5lib")

                # Find GL Commands
                for span in soup.find_all("span", attrs={"class", "commandcolumn"}):
                        glCommands.append(f"{span.string}\n")

                # Write cached file
                with open("/tmp/glList.txt", 'w') as f:
                        for cmd in glCommands:
                                f.write(f"{cmd}")

        for cmd in glCommands:
                print(cmd, end='')


if __name__ == '__main__':
        main()
