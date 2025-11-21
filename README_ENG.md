# Social Network Feed

iOS application for displaying a news feed using MVVM architecture and UIKit.

## 📱 App Screenshots

<div align="center">
  <img src="https://github.com/user-attachments/assets/f1919262-3d52-419f-ac89-d3edab2be7b2" width="30%" alt="Main Feed Screen"/>
  <img src="https://github.com/user-attachments/assets/137b5337-9f7c-4930-b542-60291f6ba11b" width="30%" alt="Loading State"/>  
  <img src="https://github.com/user-attachments/assets/887462ab-4ac1-4c4b-9ffb-8c89fdee58a6" width="30%" alt="Pull to Refresh"/>
</div>

## 🏗 Architecture

The application is built using **MVVM (Model-View-ViewModel)** architecture:

### Architecture Components:

- **Models** (`News`, `NewsModel`) - data structures and business logic
- **Views** (`ViewController`, `NewsCell`) - user interface
- **ViewModels** (`NewsViewModel`) - data transformers for View
- **Services** (`NetworkManager`, `CoreDataManager`, `LogoProvider`) - service layer

### Data Flow:
```
View ↔ ViewModel → Services/Model
```

## 🛠 Technologies and Libraries

### Main Stack:
- **UIKit** - UI framework
- **MVVM** - architectural pattern
- **URLSession** - network requests
- **Core Data** - local data storage
- **UICollectionView** - news feed display

### Additional Technologies:
- **Auto Layout** - programmatic layout
- **GCD (Grand Central Dispatch)** - multithreading
- **Custom UICollectionViewCell** - custom cells

## 📁 Project Structure

```
Social Network Feed/
├── Application/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Info.plist
├── Resources/
│   └── Assets.xcassets
├── Models/
│   ├── NewsModel.swift
│   └── News.swift
├── Views/
│   ├── ViewController.swift
│   └── NewsCell.swift
├── ViewModels/
│   └── NewsViewModel.swift
└── Services/
    ├── NetworkManager.swift
    ├── LogoProvider.swift
    └── CoreData
        ├── CoreDataManager.swift
        └── Social_Network_Feed.xcdatamodeld
```

## 🚀 Build Instructions

### Requirements:
- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+

### Steps to Run:

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd "Social Network Feed"
   ```

2. **Open the project**
   - Open `Social Network Feed.xcodeproj` in Xcode

3. **Build and Run**
   - Select a simulator or connected device
   - Press `Cmd + R` or click the "Run" button

### Build Features:
- No additional dependencies required
- All network requests go to JSONPlaceholder API
- Core Data for offline functionality

## 🔧 Functionality

- ✅ News loading from API
- ✅ Local caching with Core Data
- ✅ Pull-to-refresh for updates
- ✅ Offline mode with cached data display
- ✅ Custom UI elements
- ✅ Error handling
- ✅ Loading indicator

This project was created for educational purposes.
