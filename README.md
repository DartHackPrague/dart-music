## Dart Music

A simple music visualisation created in Dart and HTML 5. (Currently audio tag is not working in Dartium, please compile all scripts to JavaScript.)

You can Drag and Drop your own mp3 file to play it instead of sample track. (Drag & drop will not work if you launch webpage directly from harddrive [file:/// protocol], because of Chrome's security restrictions. Try (live demo)[martinsikora.com/dart-music] instead.)
By selecting a part of the frequency chart, you can filter different frequencies in real time.
Press spacebar to reset frequency filter.

Canvas is used to render animations and Audio API for reading live audio from played track.
Developed and tested in Chrome 18.

## Live Demo

(You can try live demo)[martinsikora.com/dart-music] right away. It's automatically **pulled**, **compiled** and **uploaded** to the server every hour, so it reflects current state of this repository.

## Screenshots

![Dart Music screenshot](https://raw.github.com/DartHackPrague/dart-music/master/screenshot.png)
