Original App Design Project - README 
===

# MANGA-ANIME_SEARCH

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
The user can use this app to get access to lastest manga and anime without any subscription
[Description of your app]

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category**: Anime and Manga
- **Mobile**: Iphones
- **Story**: Analyzes users anime and manga choices, and connects them to world of manga and anime. The user can access to manga and anime of their choice
- **Market**: Comics
- **Habit**: This app could be used as often or unoften as the user wanted depending on how deep they are connected to manga and anime world, and what exactly they're looking for in anime and manga
- **Scope**: All anime and manga lover app

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User will be able to log in
- [x] user can signup to create new account
- [x] User will be able to see the latest animes and manga
- [x] User will be able to have different type of animes genre to pick from.
- [x] User can see Different genre of Manga and Anime

**Optional Nice-to-have Stories**

- [] User is able to watch the anime from the app
- [] User will be able to read manga


### 2. Screen Archetypes

- **Log In Scree**
   - SigUp screen
   - Home Screen with navigation bar
   
- **Home Screen**
   - Anime Screen
   - Manga Screen
   
- **Anime Screen**
   - Home Screen
   - Manga Screen
   
- **Manga Screen**
  - Anime Screen
  - Home Screen
   

### 3. Navigation

**Tab Navigation** (Tab to Screen)

- LogOut
- Sign In
- Sign Up

**Flow Navigation** (Screen to Screen)

- **LogIn Page**
   - Sign Up page
   - or Logged In Page/ Home Page
- **Home Page**
   - Anime
   - Manga
- **Anime**
   - Particular Anime and its episodes page
   - Back to Home Page
   - Manga page
- **Manga**
   - Particular Manga and its chapters page
   - Back to Home Page
   - Anime page

## Wireframes
<img src="https://github.com/CodePathPod8/Manga-Anime_Searcher/blob/main/Screen%20Shot%202022-10-17%20at%209.44.36%20PM.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://github.com/CodePathPod8/Manga-Anime_Searcher/blob/main/Screen%20Shot%202022-10-19%20at%208.53.28%20PM.png">

### [BONUS] Interactive Prototype
![](https://i.imgur.com/VHUIfVX.gif)

## Build Progres: Video Walkthrough

Here's a walkthrough of implemented user stories:

| Oct. 28, 2022 | Nov. 4, 2022 | Nov 12, 2022 | Nov 19, 2022 
| --- | --- | --- | --- |
| ![](https://i.imgur.com/Gu0WNTr.gif) | ![](https://i.imgur.com/tNt2IpK.gif) | ![](https://i.imgur.com/8teSKZT.gif) | ![](https://i.imgur.com/KrLHUQt.gif) | 

| Dec 18, 2022
| --- |
| ![](https://i.imgur.com/ln69PGJ.gif) |

## Schema 
[This section will be completed in Unit 9]
### Models
| Property | Type | Description |
| --- | --- | --- |
| `created At` | String | date of creation of anime and manga |
| `uodated At` | String | date of update of anime and manga |
| `synopsis` | String | summary of anime and manga |
| `title` | Object | containing three string: One english, japanese_english and japanese |
| `favorites count` | number | number of favorites anime and manga |
| `rating rank` | number | rating |
| `poster image` | Object | date of update |
| `cover image` | Object | date of update |



### Networking
- Home Feed Screen
   - (Read/Get) Query all popular anime and manga to be display
   - pick between anime and manga  
- Anime
   
   - top anime back drop, tittle and short overview
   - show latest Animes release
   - show popular animes right now 
- Details about animes/mangas
   - user can click and see preview of animes or mangas 
- Manga
   - top Manga back drop, tittle and short overview
   - show latest Animes release
   - show popular animes right now 

- An API of Kitsu
   - Base URL - [jikanApi](https://docs.api.jikan.moe/)

| HTTP Verb | EndPoint | Description |
| --- | --- | --- |
| `GET` | /Anime | Get current anime Series |
| `GET` | /Episode | get details about an expecific anime episode |
| `GEt` | /Trending Anime | Show most popular animes |
| `GET` | /Manga | Get current Manga Series |
| `GET` | /Chapters | get details about an expecific Manga episode |
| `GEt` | /Trending Manga| Show most popular Manga |

- An API of Parse  
   -base url server - https://parseapi.back4app.com  


| HTTP Verb | EndPoint | Description |
| --- | --- | --- |
| `GET` | /Users | access user data from the data base authenticate to log in |
| `GET` | /Basic Queries | to get data from the Database |
| `GEt` | /Sessions | keep current user loggedin |
   
