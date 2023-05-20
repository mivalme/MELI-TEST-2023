# Mobile Test Tech Lead - Meli

_In this repository you will find the Tech Lead test made for Meli_

_By Miguel Angel Valcárcel Mendivelso_

## Screenshots

<img src="https://github.com/mivalme/MELI-TEST-2023/assets/33386326/9dd6a36a-b31a-44ce-9474-ab33aaf0ad7b" width="250"> <img src="https://github.com/mivalme/MELI-TEST-2023/assets/33386326/d9b6fe0a-05f1-4e50-b2de-84be56777bf7" width="250"> <img src="https://github.com/mivalme/MELI-TEST-2023/assets/33386326/698dfec5-0e3f-4344-abcd-3c0d746d7315" width="250"> 

## Let's start 🚀

_These instructions allow you to obtain a copy of the project in operation on your local machine to be able to test._

### Requirements 📋

_IDE Xcode_

### Setup 🔧

_Clone this repository on your local machine, open Xcode and run the project._

## How is the app built? ⚙️

### Deployment Info ⌨️

* iOS Deployment Target:  _iOS 16.4_
* Targeted Device Family:  _iPhone_
* Development Language:  _Swift implementing SwiftUI for interfaces_

### Architecture ⌨️

_The app was developed under the MVVM architecture establishing the following layers:_

* presentation: This is the layer with which the user interacts, this is the one in charge of everything related to the UI, including views and other components such as ViewModels, etc. This layer will include the others, making use of their classes and implementations.

* domain: This layer includes the use cases, models and definition of the calls to the services.

* data: In this layer the data sources of the application are defined

_Unit Testing: All the viewModels were tested_

### Third-party libraries ⌨️

_The method to implement third-party libraries was Swift Package Manager_

__Lottie__

_Lottie is a native iOS, Android, and React library that processes After Effects animations in real time, 
allowing applications to use animations as easily as they use static images. 
So it has become a benchmark for including animations in native applications. 
In addition, the files it processes to run the animation are very light (.json)._

__Alamofire__

_Alamofire is a networking library written in Swift. You use it to make HTTP(S) requests on iOS, macOS and other Apple platforms._

__KingFisher__

_Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images in your next app._


## Author ✒️

* **Miguel Angel Valcarcel Mendivelso (mivalme@gmail.com)** - *Development and implementation*
