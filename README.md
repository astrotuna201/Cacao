# Cacao
[![Swift](https://img.shields.io/badge/swift-3.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platforms](https://img.shields.io/badge/platform-osx%20%7C%20linux-lightgrey.svg)](https://developer.apple.com/swift/)
[![Release](https://img.shields.io/github/release/astrotuna201/cacao.svg)](https://github.com/astrotuna201/Cacao/releases)
[![License](https://img.shields.io/badge/license-MIT-71787A.svg)](https://tldrlegal.com/license/mit-license)
[![Join the chat at https://gitter.im/PureSwift/SwiftFoundation](https://img.shields.io/gitter/room/nwjs/nw.js.svg)](https://gitter.im/PureSwift/Cacao?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=body_badge)

[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Pure Swift Cross-platform UIKit (Cocoa Touch) implementation (Supports Linux)

## Installation

### OS X
`brew install cairo sdl2 freetype fontconfig && carthage bootstrap`
fuse Xcode to build ... or swift build -Xlinker -L/usr/local/lib if SDL2 installed via homebrew to that location
### Ubuntu
`sudo apt-get install libcairo-dev libsdl2-dev`
swift build

## Screenshots

### Run [PaintCode](http://www.paintcodeapp.com) StyleKits in Linux (after removing NSObject base class)

![Image](ReadmeImages/UbuntuStyleKit.png)

### Layout views according to a `UIViewContentMode`

![Image](ReadmeImages/ContentMode.gif)

### Create applications that run in the native Window Manager

![Image](ReadmeImages/UbuntuWindow.jpg)

![Image](ReadmeImages/MacWindow.jpg)

