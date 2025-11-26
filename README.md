# MovieLovr
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Sven491/Eindopdracht)

MovieLovr is a Flutter-based mobile application designed for film enthusiasts. It allows users to discover, search for, and manage a personal watchlist of movies, leveraging the TMDB API for comprehensive movie data and Supabase for user authentication and data storage.

## Features

*   *User Authentication*: Secure sign-up, login, and sign-out functionality powered by Supabase.
*   *Framed Pages*: Smooth transitions ensured by page-in-frame design and bottombar. 
*   *Discover Movies*: Browse a curated list of movies on the main page.
*   *Movie Search*: Find specific movies by title using the search functionality.
*   *Detailed Information*: View detailed information for each movie, including the overview, release date, cast, and genres.
*   *Personal Watchlist*: Add or remove movies from a personalized watchlist to keep track of films you want to see.
*   *Account Management*: Users can view their account details, empty their watchlist, or delete their account data from the client side.

## Tech Stack

*   *Framework*: Flutter
*   *Backend as a Service (BaaS)*: [Supabase](https://supabase.io/) for user authentication and database management (watchlist).
*   *Data Source*: [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api) for all movie-related data, including details, cast, and search results.

## Application Architecture

The project is structured to separate concerns, making it organized and maintainable:

-   lib/pages: Contains all the primary screens of the application, such as homepage.dart, detailpage.dart, listpage.dart, and account.dart.
-   lib/services: Handles all external API communications. remote_service.dart is responsible for fetching data from the TMDB API and interacting with the Supabase backend.
-   lib/model: Defines the Dart data models (GET.dart, GET_actor.dart) used for parsing JSON responses from the TMDB API.
-   lib/auth: Manages the user authentication logic and flow, including the AuthGate which directs users based on their authentication state.
-   lib/components: Contains reusable UI widgets, such as the bottom_navbar.dart for consistent navigation.

## Setup and Installation

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed.
*   An editor like VS Code or Android Studio.

### Installation

1.  *Clone the repository:*
    sh
    git clone https://github.com/sven491/eindopdracht.git
    

2.  *Navigate to the project directory:*
    sh
    cd eindopdracht/movieapp
    

3.  *Install dependencies:*
    sh
    flutter pub get
    

4.  *Configure API Keys:*
    This project uses hardcoded API keys for demonstration purposes. For a production environment, you should use environment variables.
    *   *Supabase*: Update the url and anonKey in lib/main.dart.
    *   *TMDB*: Update the Authorization bearer token in lib/services/remote_service.dart.

5.  *Run the application:*
    ```sh
    flutter run
