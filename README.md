
<h3 align="center">
    <img src="https://raw.githubusercontent.com/NghiaTranUIT/Titan-Postgresql/master/Screenshot/icon_titan.png" width="30%" />
</h3>

<p align="center">
  <a href="http://nghiatran.me">Mad lab</a> &bull;
  <b>Titan</b> &bull;
  <a href="https://github.com/NghiaTranUIT/FeSpinner">FeSpinner</a>
  <br>
  <a href="https://github.com/NghiaTranUIT/Swifty-PostgreSQL">Swifty PostgreSQL</a> &bull;
  <a href="https://github.com/NghiaTranUIT/iOS-Awesome-Starter-Kit/edit/master/README.md">iOS Awesome Starter Kit</a> &bull;
  <a href="https://github.com/NghiaTranUIT/FeSlideFilter">FeSlideFilter</a>
</p>

  
Titan
------------
The SMART PostgreSQL client for macOS/iOS. Clean design. Absolutely 100% free and open-source for everyone.
  
![](https://img.shields.io/badge/Swift-3.0-blue.svg?style=flat)
[![Build Status](https://api.travis-ci.org/NghiaTranUIT/Titan-Postgresql.svg?branch=master)](https://travis-ci.org/NghiaTranUIT/Titan-Postgresql)
![License](https://img.shields.io/npm/l/express.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-osx-green.svg?style=flat)
  
Movation
------------
At this time I'm wirting. I'm working at Pixai project (feels.com) as full-stack developer.  
Go-lang for backend. React-FB and redux for frontend. It's pretty struggle when I tried to find best postgresql client on macOS.
  
*Postico* is the best one I found, but it's missing  multi-tab, multi-connection in free version.  
*pgAdmin III* are the worst , GUI  seem like from 80s, and non-retina support.
  
After tried and deleted various similar apps. Finally, I prefer *PSequel*, clean design, straight-forward GUI, but it's still buggy sometime, and don't support multi-tab.

So 🤔. I make decision to write my own PostgreSQL client - called as **Titan**. It's the best place to apply what I've learnt to real product.
  
Technologies
------------
It's whole new project, I intent to use edge-technologies. I could start with MVC and old-fashionate technologies, but it's too boring.
  
*   Cross-framework: Support iOS and macOS.
*   ReSwift: Unidirectional data flow architecture. State-management easier.
*   RxSwift: Reactive Programming in Swift.
*   MVVM: Isolate logic code with UI code with MVVM architecture.
*   Base foundation and networking abstraction layers.
*   [Swifty-PostgreSQL](https://github.com/NghiaTranUIT/Swifty-PostgreSQL): Swifty-PostgreSQL driver, written by Swift 3.0
*   Swift 3.0
*   Realm.io for elegant storage persistence
*   ...

Titan Refactor 
------------
I created seperate repo for big refactor Titan's structure and logic.   
You can check the progress at [Titan](https://github.com/NghiaTranUIT/titan)
   
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
- [ ] Rename script

Swifty PostgreSQL Driver
------------
Beside Titan, I also develop [PostgreSQL Dirver](https://github.com/NghiaTranUIT/Swifty-PostgreSQL), integrate flawlessly with Titan. Resueable, testable as well.

Screenshot
------------
<h3 align="center">
    <img src="https://raw.githubusercontent.com/NghiaTranUIT/Titan-Postgresql/connection-detail/Screenshot/screen_titan_1.jpg" width="100%" />
</h3>

Reference
------------
1. Redux: http://blog.benjamin-encz.de/post/real-world-flux-ios/
2. Clean Swift: http://clean-swift.com/clean-swift-ios-architecture/
3. Efficient pagination on PostgreSQL: http://leopard.in.ua/2014/10/11/postgresql-paginattion#.WLjjnhhh22w 

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
