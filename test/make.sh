#!/bin/bash

cd ..
make moodle.sty
cd test/
pdflatex -shell-escape bug_in_cloze.tex
gedit bug_in_cloze-moodle.xml
