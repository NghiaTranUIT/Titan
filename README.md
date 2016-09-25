
# Titan
Postgresql client for macOS/iOS. Clean design. Absolutely 100% Free and open-source.

## Why postgresql ?
At this time I'm wirting. I'm working at Pixai project (feels.com) as full-stack position.  
Go for backend. React-FB and redux for frontend, ...
It's pretty suck when I tried to find best postgresql client on macOS.  
*Postico* is the best one I found, but it's missing  multi-tab, multi-connection in free version.  
*pgAdmin III* are the worst , GUI  seem like from 20s, and only non-retina support. 
After tried  and deleted many similar client.  
Finally, I prefers *PSequel*, clean design, straight-forward GUI, but it's still buggy sometime, and didn't support multi-tab too.

So  🤔  

I decied to write my own Postgresql client - called as Titan.  
It's best time to apply what I learn to real product.

## Technogy

*   Cross-framework  - supported iOS and macOS too
*   ReSwift (Redux)
*   RxSwift + MVVM 
*   Networking abstraction layer
*   Postgresql-driver abstraction layer
*   Swift 3.0 
*   Core Data

## How to build libpg.framework
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

## Contact

Vinh Nghia Tran

http://github.com/NghiaTranUIT  
http://www.nghiatran.me  
vinhnghiatran@gmail.com  

## Contributor
It would be greatly appreciated  when you make a pull-quest  🤗

## License

Titan is available under the MIT license. See the LICENSE file for more info.
