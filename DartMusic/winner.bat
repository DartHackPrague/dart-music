@echo off

:LOOP
ping 1.1.1.1 -n 1 -w 220000 > nul
  echo This world is full of awesome opportunities %time% >> winner.txt
  echo I like hacking >> winner.txt
  echo and I am increasing number of lines in our code base right now >> winner.txt
  echo by this super awesome effin batch file >> winner.txt
  echo LLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLLLLLLLL >> winner.txt
  echo  gooooood night ladies >> winner.txt
  echo LLLLLLLLLLLLLOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLLLLLLLL >> winner.txt
  call git st
  call git na 1
  call git commit -m "yes"
  call git pull
  call git push
GOTO LOOP