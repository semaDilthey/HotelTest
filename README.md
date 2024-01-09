# HotelTest
Test task for ordering hotel room. Fetching information from 3 different APIs and distributing it across controllers.
MVVM architecture was used in its creation. It consists of 4 screens with 1 flow and the first two screens do not pose technical challenges, as the primary emphasis was placed on the (3) booking screen.

## Prototype:  [FIGMA](https://www.figma.com/file/33MKMNqJedmRgipHlpsqaf/iOS?type=design&node-id=0-1&mode=design&t=XdR9M4eOh3rwlZAA-0)

## Technologies Used

- SWIFT
- UIKit
- MVVM + Coordinator
- URLSession
- GCD
- AutoLayout, SnapKit

 ## Presentation
  ### 1. Main screen: 
  At the top, there is a custom reusable Collection View with a Page Control for navigation. Additionally, below, there is a custom layout for displaying hotel features.
  All of this is embedded within a Scroll View.

![1  slides presentation](https://github.com/semaDilthey/Employees-Info/assets/128741166/d21933df-cefd-46ee-bdce-bb8092d90948), ![4  Searching](https://github.com/semaDilthey/Employees-Info/assets/128741166/a08017d7-dbaf-4c7f-ad4d-0325a01b4fdd) ,![3  sorting by name or birthday](https://github.com/semaDilthey/Employees-Info/assets/128741166/781cea46-600c-4269-87b8-0dd1ce303fe1)

 ### 2. Rooms Screen:
 This is a simple table view with 2 cells, as the API contains only 2 objects. It utilizes the same custom Collection View and custom layout for features. 
 The "Learn more" button for each room is non-clickable. When either of the 2 rooms is selected, further details always load based on the ID == 1.
 
![2  details screen and UIApplication functionality](https://github.com/semaDilthey/Employees-Info/assets/128741166/913bcf91-49fb-4e0b-8308-f551a50fe8f8)

### 3. Booking Screen:
The most complex screen in terms of both layout and business logic. It encompasses several views, one of which contains fields for entering email and phone number.
Both are validated and must be filled in correctly. Additionally, expandable cells with 6 data input fields are implemented. By default, at least one tourist must be filled in to proceed to the payment screen. If any of the fields are left empty, they are highlighted in red, preventing further progression. 
The "Add Tourist" button allows adding up to 4 individuals.

![5  When there is no internet connection](https://github.com/semaDilthey/Employees-Info/assets/128741166/fdd670db-b745-46ae-97f8-776fccd56cb5)

### 4. Payment Successful Screen:
In the event of a successful transaction, the "Payment Successful" screen appears, displaying a randomly generated booking number each time. It can also be initialized (although there is no API for it). Clicking the "Super" button returns to the initial screen, and the Coordinator restarts the flow from the beginning.

![6  Demonstration](https://github.com/semaDilthey/Employees-Info/assets/128741166/575c5f82-c9ea-4cee-b31a-84950ccad774)


## App Structure

The app follows a modular structure, divided into different components:

```bash

 | | |____Resources
 | | | |____Assets.xcassets
 | | | | |____LaunchScreen.storyboard
 | | | | |____Main.storyboard
 | | |____Sources
 | | | |____ViewModels
 | | | | |____BookingViewModel.swift
 | | | | |____PaidViewModel.swift
 | | | | |____MainViewModel.swift
 | | | | |____BaseViewModel
 | | | | | |____BaseViewModel.swift
 | | | | |____RoomViewModel.swift
 | | | |____Coordinator
 | | | | |____AppCoordinator.swift
 | | | | |____Coordinator.swift
 | | | |____App
 | | | | |____AppDelegate.swift
 | | | | |____SceneDelegate.swift
 | | | |____Other
 | | | | |____extensions
 | | | | |____CustomComponents
 | | | | | |____TagViewCollectionView
 | | | | | |____PagingCollectionView
 | | | | | |____RatingLabel
 | | | | | |____BlueButton
 | | | |____Models
 | | | | |____Hotel.swift
 | | | | |____Booking.swift
 | | | | |____Room.swift
 | | | |____NetworkLayer
 | | | | |____NetworkManager.swift
 | | | | |____API
 | | | | | |____API.swift
 | | | | |____Service
 | | | | | |____FetchingService.swift
 | | | | | |____Parser.swift
 | | | | | |____NetworkError.swift
 | | | |____Controllers
 | | | | |____Booking
 | | | | | |____Components
 | | | | | |____BookingViewController.swift
 | | | | |____Paid
 | | | | | |____PaidViewController.swift
 | | | | |____Rooms
 | | | | | |____RoomsCell.swift
 | | | | | |____RoomCellModel.swift
 | | | | | |____RoomsViewController.swift
 | | | | |____Main
 | | | | | |____MainViewController.swift
 | | | | | |____Components
 | | | |____Helper
 | | | | |____Constants.swift
 | | | | |____Validator.swift
 | | | | |____Formatter.swift
 | | | |____Factory
 | | | | |____ControllerFactory.swift
 | | |____fonts


```




   
   
