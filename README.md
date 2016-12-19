
<h3 align="center">
    <img src="https://raw.githubusercontent.com/NghiaTranUIT/Titan-Postgresql/master/Screenshot/github_titan@2x.png" width="50%" />
</h3>
  
<p align="center">
  <a href="http://nghiatran.me">Mad lab</a> &bull;
  <a href="https://github.com/NghiaTranUIT/FeSpinner">FeSpinner</a> &bull;
  <b>Titan</b> &bull;
  <a href="https://github.com/NghiaTranUIT/iOS-Awesome-Starter-Kit/edit/master/README.md">iOS Awesome Starter Kit</a> &bull;
  <a href="https://github.com/NghiaTranUIT/FeSlideFilter">FeSlideFilter</a> &bull;
  <a href="https://github.com/NghiaTranUIT/Responsive-Interaction-Control">Responsive Interaction Control</a>
</p>

  
Titan
------------
  
The SMART PostgreSQL client for macOS/iOS. Clean design. Absolutely 100% Free and open-source.
  
![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)
[![Build Status](https://api.travis-ci.org/NghiaTranUIT/Titan-Postgresql.svg?branch=master)](https://travis-ci.org/NghiaTranUIT/Titan-Postgresql)[![codecov.io](https://codecov.io/gh/NghiaTranUIT/Titan-Postgresql/branch/master/graphs/badge.svg)](https://codecov.io/gh/NghiaTranUIT/Titan-Postgresql/branch/master)
![License](https://img.shields.io/npm/l/express.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-osx-green.svg?style=flat)
  
Why?
------------
  
At this time I'm wirting. I'm working at Pixai project (feels.com) as full-stack developer.  
Go-lang for backend. React-FB and redux for frontend, ...
  
It's pretty struggle when I tried to find best postgresql client on macOS.
  
*Postico* is the best one I found, but it's missing  multi-tab, multi-connection in free version.  
*pgAdmin III* are the worst , GUI  seem like from 80s, and non-retina support.
  
After tried  and deleted many similar clients.  
Finally, I prefers *PSequel*, clean design, straight-forward GUI, but it's still buggy sometime, and didn't support multi-tab too.

So  🤔
  
I decied to write my own Postgresql client - called as **Titan**.
  
It's best time to apply what I learn to real product.

Technologies
------------
  
It's whole new project, I intent to apply what I'm learning.
  
*   Cross-framework  - supported iOS and macOS too
*   ReSwift (Redux)
*   ~~RxSwift + MVVM~~ -> I decied to get rid of RxSwift, Rx...stuff, and MVVM (binding)
'cause it's too hard to understand, maintain, implemente new features,.. for the fresher or the guy who take responsibility of this projct in future.
*   Clearn Swift architecture: VIP model
*   Networking abstraction layer
*   Postgresql-driver abstraction layer
*   Swift 3.0
*   Realm
*   ...

Roadmap
------------

- [x] Sketch
- [x] Base Foundation (50%)
- [ ] Smart Query
- [ ] Basic Query Recommendation System
- [ ] Export Ruby Migration 
- [ ] Multi-tabs, Multi-databases
- [ ] Cloud
- [ ] Support Object-oriented Programming
- [ ] Write Test 

Sketch
------------
https://github.com/NghiaTranUIT/titan-sketch

How to build libpg.framework
------------
*  Make sure that `xcode-select` points to the correct location by running:
    `sudo /usr/bin/xcode-select --switch /Applications/Xcode.app/Contents/Developer`
*  Clone https://github.com/NghiaTranUIT/libpq.framework  
* Run the script to download and compile OpenSSL:
    `./build-libssl.sh`  
* Open `libpq.xcodeproj` with XCode  
* Select Project  -> Build Setting
* Make sure we select correct configuration  
Base SDK :  Latest macOS 10.12  
Supported Platform  :  macosx  iphonesimulator  iphoneos  
Valid  Architecture :  i386  x86_64  armv7  arm64  armv7s  
* Select framework target  and *Build*
  

Reference
------------
1. http://blog.benjamin-encz.de/post/real-world-flux-ios/
2. http://clean-swift.com/clean-swift-ios-architecture/

Contact
------------
  
Vinh Nghia Tran

http://github.com/NghiaTranUIT  
http://www.nghiatran.me  
vinhnghiatran@gmail.com  
  
Contributor
------------

It would be greatly appreciated  when you make a pull-quest  🤗

License
------------

Titan is available under the MIT license. See the LICENSE file for more info.

Limitation
------------

Althought TITAN publish under MIT license. But I won't ever encourage if someone use it for commercial purpose, or copy it for final test in University 😎
