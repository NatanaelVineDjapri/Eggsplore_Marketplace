# 🥚 Eggsplore Marketplace

**Eggsplore** is a Mobile Marketplace App built using The Flutter Framework, this app is inspired by some well-known marketplace app, such as **Tokopedia, Shopee, Lazada, etc.** This project was developed as a part of the **mid-term** exam assignment, we wanted to build a fun and interactive application, that represents a clean use of the front-end and back-end stucture. This app is designed to be further developed in the future.

> 🧩 Designed to be scalable, modular, and easily extendable for future development.

---

## 👨‍💻 Team Members

| No | Name                     | NIM       |
|----|--------------------------|-----------|
| 1  | Claudio Taffarel Santoso | 535240035 | 
| 2  | **Natanael Vine Djapri** | 535240042 | 
| 3  | Ryan Prasetya Arjuna A.  | 535240043 | 
| 4  | Devin Giovano            | 535240057 | 
| 5  | Edbert Halim             | 535240059 | 

---

## 🚀 Features

- 🍳 Browse & explore products dynamically from backend API  
- 🔐 User Authentication (Register, Login, Logout, Forgot Password)  
- 💵 Manage & top-up **EggsplorePay** balance  
- 🛒 Add to Cart & Checkout  
- 💬 Message System between users and admin  
- 💖 Wishlist & Like Products  
- 👤 Manage User Profile  
- 🏪 Upload and sell products  

---

## 🧱 Tech Stack

| Layer | Technology |
|--------|-------------|
| **Frontend** | Flutter (Dart) |
| **Backend** | Laravel 10 (PHP 8+) |
| **Database** | MySQL |
| **State Management** | Riverpod |
| **API Communication** | RESTful API using `http` package |
| **Authentication** | Laravel Sanctum  |
| **Version Control** | Git & GitHub |

---


## ⚙️ Installation & Setup Guide

### 🪄 Prerequisites

Make sure all the following tools are installed on your device:

| Tool | Description |
|------|--------------|
| 🐦 [Flutter SDK](https://docs.flutter.dev/get-started/install) | Main framework for building the frontend |
| 💻 [Dart](https://dart.dev/get-dart) | Programming language used by Flutter|
| 🧰 [Android Studio / VS Code](https://developer.android.com/studio) | IDEs for developing and running the application |
| 🐘 [PHP 8+](https://www.php.net/) | Backend programming language for Laravel |
| 🎼 [Composer](https://getcomposer.org/) | Dependency manager for PHP |
| 🗄️ [MySQL Server](https://dev.mysql.com/downloads/mysql/) | Database server for storing application data |
| 🧭 [Git](https://git-scm.com/) | Version control system |

---

### 🔧 Step 1 — Clone the Repository
```bash
# Clone the full project (Frontend + Backend)
git clone https://github.com/NatanaelVineDjapri/Eggsplore_Marketplace.git

# Enter the main project directory
cd Eggsplore_Marketplace

```

### 🧱 Step 2 — Setup Backend (Laravel)
```bash
# Navigate to the backend folder
cd backend

# Install Laravel dependencies
composer install

# Copy the environment file
cp .env.example .env

# Generate the application key
php artisan key:generate

```

### 🛠️ Edit file .env
```bash
DB_DATABASE=eggsplore_db
DB_USERNAME=root
DB_PASSWORD=

# Run database migrations and seeders
php artisan migrate --seed

# Start the Laravel development server
php artisan serve

```
 ### 📱 Step 3 — Setup Frontend (Flutter)
```bash
# Go back to the main project directory
cd ../Eggsplore-Marketplace/eggsplore

# Install Flutter dependencies
flutter pub get

# Run the Eggsplore app
flutter run

```

 


