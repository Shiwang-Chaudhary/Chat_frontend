# Chat App with Live Location Sharing

A real-time chat application built using Flutter + Node.js that supports
live location tracking of friends.

## Features

- Real-time messaging using Socket.IO
- Live location updates for online users
- JWT Authentication (Login/Register)
- Group chat functionality
- Search user and group using searchfield
- File sharing (Documents, Video, Audio and Images)
- File opening within the app(PDF, Video, Audio and Images)


## Tech Stack

### Frontend
- Flutter
- GetX 
#### Packages
- socket_io_client → Real-time chat
- geolocator + google_maps_flutter → Live location tracking
- dio + file_picker → File upload/download
- video_player + just_audio → Media playback
- logger → Debugging


## Setup Instructions
git clone https://github.com/Shiwang-Chaudhary/Chat_frontend.git

cd Chat_frontend

Update API base URL inside:
lib/services/api_endpoints.dart
ChatScreenController.dart
GrpMessageController.dart
LocationScreenController.dart

flutter pub get

## Backend Repository

This app requires the backend server to be running.

Backend Repo: [Chat Backend](https://github.com/Shiwang-Chaudhary/Chat_backend)


