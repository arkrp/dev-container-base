#!/bin/bash
# This program opens a github flavored markdown for viewing with zathura
pandoc -f gfm -t pdf $1 | zathura -
