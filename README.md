# flutter_shop

BUG

```
yaudeMacBook-Pro:flutter_shop yau$ flutter run
Launching lib/main.dart on Sean in debug mode...
Automatically signing iOS for device deployment using specified development team in Xcode project: MTDGTABD6W
Running Xcode build...                                                                                              
Xcode build done.                                            6.3s
Failed to build iOS app
Error output from Xcode build:
↳
    ** BUILD FAILED **


Xcode's output:
↳
    === BUILD TARGET multi_image_picker OF PROJECT Pods WITH CONFIGURATION Debug ===
    /softSdk/flutter/.pub-cache/hosted/pub.flutter-io.cn/multi_image_picker-4.1.2/ios/Classes/MultiImagePickerPlugin.m:2:9: fatal error: 'multi_image_picker/multi_image_picker-Swift.h' file not
    found
    #import <multi_image_picker/multi_image_picker-Swift.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1 error generated.

Could not build the precompiled application for the device.

Error launching application on Sean.
yaudeMacBook-Pro:flutter_shop yau$ 




Runner-Bridging-Header.h
#import "GeneratedPluginRegistrant.h"


swift version 4.2

