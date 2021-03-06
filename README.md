# Project Dashboard
*Native Apps II - Eindproject iOS*  
**By**: Waut Wyffels (HoGent Aalst)

# About
The purpose of this app it to be able to create and track progress on all your projects.
Add team members and some details to a project (like owner and contact details).
Additionally you can add your tasks to a project and track how much time you've spent on them.

Are you done working on a task or want to reassign it to someone else? No problem, that can all be done from within the app!

# Disclaimer
The app is purely a demo app to show different parts of the iOS UI

# Opening in Xcode
To open the app in Xcode, make sure to open the "Workspace" file!  
If it is not present, recreate it using the "pod install" command

## Debugging
- Run the app on a simulator or real device and make sure they are connected to the internet
- The backend server is located on MS Azure  

- Use the following account to log in:
```
username/email: john.doe@exsertus.be
password: DemoPassword
```

- OR you can register a new account

**Note**: If the login/registration doesn't respond or tableview stays empty, try reopening the app, as Azure is likely restarting the WebApp.

### Localhost
While debugging, the "Swift Compiler - Custom Flag" is set to ``DEBUG``. This causes the app to use "localhost" as the network, which requires the "Project Dashboard backend" to be run on your development machine.

**Important**: Debugging with a real device does not work this way!

To disable this behaviour, either run the app in "Release" mode, remove the flag in Build Settings or remove the following line in ``AppCoordinator.swift``:
``` swift
#if DEBUG
	self.networking = NativeNetworking(baseUrl: "https://localhost:5001/api/", userHelper: userHelper)
```

# Architecture
Build with MVVM-C (MVVM Coordinator) in mind, every part of the app is separated into 'Features'. Each feature has its own unique function and has its own coordinator.  
Additionally, the app is separated into different Framework packages as well, do really distinguish between features. This has the added benefit for teams to work in their favorite language (Swift 4, Swift 5, Obj-C, ...).  

# Libraries
I used CocoaPods for my package manager, with all libs specified in the Podfile.
Every framework has access to all libraries.

**Libs**:
- JWTDecode
- Alamofire
- AlamofireNetworkActivityLogger
- IQKeyboardManagerSwift
- LPSnackbar
- KMPlaceholderTextView
- lottie-ios
