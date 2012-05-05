## Dart Music

A simple music visualiser created in Dart and HTML 5. _(Currently audio tag is not working in Dartium, please, compile project to JavaScript.)_

You can Drag & Drop your own mp3 file to play instead of the sample track. (Drag & drop will not work if you open webpage from your harddrive [file:/// protocol], because of Chrome's security restrictions. Try [live demo](martinsikora.com/dart-music) instead.)
By selecting a part of the frequency chart, you can filter different frequencies in real time.
Press spacebar to reset frequency filter.

Canvas is used for rendering animations and Audio API for reading live audio from played track.
Developed and tested in Chrome 18.

## Live Demo

[You can try live demo](martinsikora.com/dart-music) right away. It's automatically **pulled**, **compiled** and **uploaded** to the server every hour, so it reflects current state of this repository.

## Screenshots

![Dart Music screenshot](https://raw.github.com/DartHackPrague/dart-music/master/screenshot.png)
