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

## App Structure

<details>
  <summary><b>The app follows a modular structure, divided into different components:</b></summary>

```bash

 | | |____***Resources***
 | | | |____Assets.xcassets
 | | | | |____LaunchScreen.storyboard
 | | |____***Sources***
 | | | |____**ViewModels**
 | | | | |____BookingViewModel.swift
 | | | | |____PaidViewModel.swift
 | | | | |____MainViewModel.swift
 | | | | |____BaseViewModel
 | | | | | |____BaseViewModel.swift
 | | | | |____RoomViewModel.swift
 | | | |____**Coordinator**
 | | | | |____AppCoordinator.swift
 | | | | |____Coordinator.swift
 | | | |____**App**
 | | | | |____AppDelegate.swift
 | | | | |____SceneDelegate.swift
 | | | |____**Other**
 | | | | |____extensions
 | | | | |____CustomComponents
 | | | | | |____TagViewCollectionView
 | | | | | |____PagingCollectionView
 | | | | | |____RatingLabel
 | | | | | |____BlueButton
 | | | |____**Models**
 | | | | |____Hotel.swift
 | | | | |____Booking.swift
 | | | | |____Room.swift
 | | | |____**NetworkLayer**
 | | | | |____NetworkManager.swift
 | | | | |____API
 | | | | | |____API.swift
 | | | | |____Service
 | | | | | |____FetchingService.swift
 | | | | | |____Parser.swift
 | | | | | |____NetworkError.swift
 | | | |____**Controllers**
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
 | | | |____**Helper**
 | | | | |____Constants.swift
 | | | | |____Validator.swift
 | | | | |____Formatter.swift
 | | | |____**Factory**
 | | | | |____ControllerFactory.swift
 | | |____fonts


```
</details>


 ## Presentation
  ### 1. Main screen && Rooms screen : 
  * Main:
  At the top, there is a custom reusable Collection View with a Page Control for navigation. Additionally, below, there is a custom layout for displaying hotel features.
  All of this is embedded within a Scroll View.
  * Rooms:
 This is a simple table view with 2 cells, as the API contains only 2 objects. It utilizes the same custom Collection View and custom layout for features. 
 The "Learn more" button for each room is non-clickable. When either of the 2 rooms is selected, further details always load based on the ID == 1.

![Демонстрация отеля_1-2экран](https://github.com/semaDilthey/HotelTest/assets/128741166/7a30de79-0124-4287-8215-ba891051b5b9)
 

### 3. Booking Screen:
The most complex screen in terms of both layout and business logic. It encompasses several views, one of which contains fields for entering email and phone number.
Both are validated and must be filled in correctly. Additionally, expandable cells with 6 data input fields are implemented. By default, at least one tourist must be filled in to proceed to the payment screen. If any of the fields are left empty, they are highlighted in red, preventing further progression. 
The "Add Tourist" button allows adding up to 4 individuals.

### Layout presentation $~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ Validation
![Демонстрация отеля_Ячейки_3 экран](https://github.com/semaDilthey/HotelTest/assets/128741166/256159f9-58a3-430e-b594-5ff5bf78400f),    $~~~~~~~~~~~~~~~~$     ![Демонстрация отеля_3-4экран_Валидация](https://github.com/semaDilthey/HotelTest/assets/128741166/387de716-3e79-4f23-aba8-05718ee0f7f0)

### 4. Payment Successful Screen:
In the event of a successful transaction, the "Payment Successful" screen appears, displaying a randomly generated booking number each time. It can also be initialized (although there is no API for it). Clicking the "Super" button returns to the initial screen, and the Coordinator restarts the flow from the beginning.

### 5. Demo:

![Демонстрация](https://github.com/semaDilthey/HotelTest/assets/128741166/5b3c470f-82d6-4784-a02b-cc0fe9769726)

