
![Plister works with plists like a piece of cake](https://github.com/mohamadrezakoohkan/Plister/blob/master/Plister/Plister.png)

# Plister
Working with property lists like a piece of cake.  
Plister creates,read,update and delete `.plist` files super fast in just **one row** :bowtie:  
Also values can encrypt by **AES** encryption :sunglasses: and plister will decrypt values when you need them! :alien:  
Speed of Plister is because it uses his own Cache system.

## What it can do ?

Plister creates a property list by your command,save your given key,value pair, encrypt it as you wish and retrieves the value for given key.   
There is a list of available methods from Plister here in [Documentations](https://mohamadrezakoohkan.github.io/Plister/)

## Requirements
- iOS 8.1+ 
- watchOS 3.0+
- macOS 10.12 (Sierra)+
- tvOS 10.0+

- Xcode 10.2+
- Swift 4.2+
>  Also fully compatible with **Swift** version **5.x**

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Dequer into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Plister'
```

If you had problem with finding pod try to include source of project.

```ruby
pod 'Plister', :git => 'https://github.com/mohamadrezakoohkan/Plister.git'
```

Then run `pod inistall` to add **Plister** pod to your project. then you should work inside new created `.xcworkspace`

---
### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Plister`

- ##### Using XCode Swift Packages

    In the **Xcode** menu bar choose this path:
    > **`File`** > **`Swift Packages`** > **`Add Package Dependency`**

    In opened window type this repository address:

        https://github.com/mohamadrezakoohkan/Plister.git
 
     At the end choose your **Package Option** and simply add to your project.

- ##### Manually

    add the plister package description to your `Package.swift` as a **dependency** file:

    ```swift
    import PackageDescription

    let package = Package(
        name: "YOUR_PROJECT_NAME",
        dependencies: [
            .package(url: "https://github.com/mohamadrezakoohkan/Plister.git", from: "1.0.0"),
        ],
    targets: [
            .target(
                name: "YOUR_TARGET_NAME",
                dependencies: ["Plister"],
                path: "YOUR_TARGET_PATH")
        ]
    )
     ```
    Then run `swift package generate-xcodeproj` in **Terminal** to generate Xcode project or `swift build` to build the project.

    If you are on **Linux** run `swift run` in **Terminal** to build and run the project.

---

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can use source code manually. get latest relase from [Releases](https://github.com/mohamadrezakoohkan/Plister/releases).



## Usage

Example of how to implement Dequer in your project.

```swift
import Plister

let plist = Plist(withNameAtDocumentDirectory: "Github")

plist.set("Mohamadreza Koohkan", for: "Developer")

plist.get("Developer")
// output will be Mohamadreza Koohkan

```

### Example project

Clone the project and use example project  for more.


## Contact

Follow and contact me on [Instagram](https://www.instagram.com/mohamadreza.codes/),  [Github](https://github.com/mohamadrezakoohkan), [LinkedIn](https://www.linkedin.com/in/mohammad-reza-koohkan-558306160/) and [stack overflow](https://stackoverflow.com/users/9706268/mohamad-reza-koohkan?tab=profile). If you find an issue [open a ticket](https://github.com/mohamadrezakoohkan/Plister/issues/new). You can send me email at mohamad_koohkan@icloud.com .

## License
Plister is released under the [MIT license](https://github.com/mohamadrezakoohkan/Plister/blob/master/LICENSE.md).
