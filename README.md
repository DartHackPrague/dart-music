dart-music
==========
A simple music visualisation created in Dart and HTML 5. (Currently <audio> is not working in Dartium, so you have to compile all scripts to JavaScript.)

You can Drag and Drop your own mp3 file to play it instead of sample track. (Drag and drop will not work if you launch webpage directly from harddrive [file:/// protocol], because of Chrome security restrictions.)
By selecting a part of frequency chart, you can filter different frequencies in real time (only selected frequencies will be played).
Hit spacebar for reseting frequency filter.

Canvas tag is used for animations and HTML5 audio API for reading live audio from played track.
Developed and tested in Chrome 18.0.1025.165.
