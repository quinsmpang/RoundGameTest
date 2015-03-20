sh /Users/UHEVER/Documents/quick-3.3/quick/bin/compile_scripts.sh  -i /Users/UHEVER/code/quick/RoundGameTest/src -o update.zip
python mkflist.py update.zip 2.0.3
python -m SimpleHTTPServer 8080
