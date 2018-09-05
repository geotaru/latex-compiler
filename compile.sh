#!/bin/bash
platex $1
dvipdfmx $(echo $1 | sed "s/.tex$/.dvi/g")
