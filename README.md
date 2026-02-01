# Pinterest Clone Mobile App

A pixel-perfect, fully functional Pinterest clone built with Flutter. This project replicates the core user experience of the official Pinterest app, demonstrating advanced UI implementation, complex micro-interactions, and a scalable Clean Architecture.

## 📱 Screenshots

| Home Feed (Masonry) | Long Press Menu | Search Experience | Pin Details |
|:-------------------:|:---------------:|:-----------------:|:-----------:|
| <img width="427" height="944" alt="image" src="https://github.com/user-attachments/assets/03826d28-1960-4ab0-963f-025e1c055c11" /> | <img width="426" height="948" alt="image" src="https://github.com/user-attachments/assets/0175993a-af08-4131-82da-0d7257f7f6f7" /> | <img width="424" height="947" alt="image" src="https://github.com/user-attachments/assets/48fd06a6-73e8-4a71-8345-62b542bd3d1c" /> | <img width="420" height="950" alt="Screenshot 2026-02-01 101954" src="https://github.com/user-attachments/assets/64f9afff-c30d-4523-8925-75005723492f" /> |

> *Note: The app features a responsive masonry grid layout that adapts seamlessly to screen sizes.*

## ✨ Key Features

* **Masonry Grid Layout:** Implemented using `flutter_staggered_grid_view` to replicate Pinterest's iconic dual-column feed.
* **Pixel-Perfect UI:** High-fidelity replication of fonts, border radii, shadows, and spacing.
* **Advanced Micro-interactions:**
    * **Long-Press Menu:** A custom radial gesture menu for quick actions (Save, Share, More).
    * **Interactive Animations:** Smooth page transitions and scalable button effects.
* **Authentication:** Secure sign-up and login flow fully integrated with **Clerk Auth**.
* **Media Integration:** Dynamic high-quality image and video fetching using the **Pexels API**.
* **Optimized Performance:** * Efficient image caching with `cached_network_image`.
    * Skeleton loading states using `shimmer` for a polished user experience.

## 🛠️ Tech Stack

This project is built using **Clean Architecture** to ensure scalability, testability, and separation of concerns.

* **Framework:** Flutter (Dart)
* **State Management:** [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
* **Navigation:** [go_router](https://pub.dev/packages/go_router)
* **Networking:** [dio](https://pub.dev/packages/dio)
* **Authentication:** [clerk_flutter](https://pub.dev/packages/clerk_flutter)
* **UI Components:**
    * `flutter_staggered_grid_view` (Masonry)
    * `shimmer` (Loading effects)
    * `cached_network_image` (Image optimization)

## 📂 Architecture Overview

The codebase follows a strict strict separation of layers:

1.  **Presentation Layer:** UI Widgets, Riverpod Notifiers, and State.
2.  **Domain Layer:** Entities, Repository Interfaces, and Use Cases (Pure Dart).
3.  **Data Layer:** API Implementations (Pexels), Models, and Repository Implementations.

## 🚀 Getting Started

### Prerequisites
* Flutter SDK (Latest Stable)
* Dart SDK

### Installation

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/Nikhil-kesarwani111/pintrest_clone_nikhil.git](https://github.com/Nikhil-kesarwani111/pintrest_clone_nikhil.git)
    cd pintrest_clone_nikhil
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Environment Setup**
    Create a `.env` file in the root directory and add your API keys:
    ```env
    CLERK_PUBLISHABLE_KEY=your_clerk_key_here
    PEXELS_API_KEY=your_pexels_key_here
    ```

4.  **Run the App**
    ```bash
    flutter run
    ```

## 🧪 Evaluation Criteria Check

* **UI Accuracy:** Matching Pinterest's visual style, typography, and spacing.
* **Code Architecture:** Implementation of Clean Architecture with Riverpod providers.
* **Code Quality:** Modular, readable code with proper naming conventions.
* **Performance:** Jank-free scrolling and efficient asset management.

## 👤 Author

**Nikhil**
* GitHub: [Nikhil-kesarwani111](https://github.com/Nikhil-kesarwani111)
