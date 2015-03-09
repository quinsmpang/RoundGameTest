sh /Users/neworigin/Documents/quick-3.3/quick/bin/compile_scripts.sh  -i /Users/neworigin/code/quick/RoundGameTest/src -o update.zip
python mkflist.py update.zip 2.2.4
python -m SimpleHTTPServer 8080
