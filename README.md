
# <img src="https://ipsmedia.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fd272fe5c-c3f5-4b39-89a7-fd3f3a57f3d9%2FIPS_LOGO-04_1.png?table=block&id=36ec3cda-5f95-461e-a788-97fed1b2d080&spaceId=18c2b86f-5f00-4ff1-baf7-6be563e77c7d&width=250&userId=&cache=v2" alt="photography icon" width="48" height="48" style="vertical-align:middle;margin:50px 0px"> PhotographySchoolTest
This is an assesment test project for [iPhone Photography School](https://iphonephotographyschool.com/). A tiny iOS application where users can pick a lesson from a list and watch it in the details view. 

# Introduction
The project developed by **`swift`** programing language, and is designed with both **`SwiftUI`** framework in the first page and **`UIKit`** for the detail page.

# Using
**Tools**
- 🔨Xcode IDE
- 🔨SPM (swift package manager) 

**Tech**
- 🔨UIKit
- 🔨SwiftUI
- 🔨Combine

**Architecture**
- 🔨Clean
- 🔨MVVM 

**3rd party**
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Realm database](https://github.com/realm/realm-swift)

# Features
Implemented based on **`clean`** architecture, and using **`MVVM`** design pattern for the scense. Using Alamofire for networking and Realm for data storage, all handled basically asynchronously. 
We needed a small database without any relation, so better to use "**Realm**" for better performance.

The project also contains repository for fetching images and videos, both remotely from server, and localy from database or file.
Using `AvPlayer` for displaying video.

# Demo

 <video src="https://user-images.githubusercontent.com/19648240/230814528-82a8fa94-062d-41fb-80d2-3b1b3bcec31c.mov" style="horizontal-align:middle" autoplay loop>

