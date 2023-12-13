import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/home/domain/domain.dart';

const homeMockJson = {
  "user": {
    "safetyNumber": "safetyNumber",
    "username": "username",
    "photo": "photo",
    "numberOfPosts": 2,
    "location": {"latitude": -22.8184393, "longitude": -47.0822301}
  },
  "posts": [
    {
      "post_id": 1,
      "author_photo": "author_photo",
      "author_username": "author_username",
      "post_description": "description",
      "address": "Rua Roxo Moreira, 45",
      "likes": 2,
      "unlikes": 2,
    },
    {
      "post_id": 2,
      "author_photo": "author_photo",
      "author_username": "author_username",
      "post_description": "description",
      "address": "Rua Luverci Pereira, 40",
      "likes": 4,
      "unlikes": 3,
    }
  ],
};

const userJson = {
  "safetyNumber": "safetyNumber",
  "username": "username",
  "numberOfPosts": 2,
  "photo": "photo",
  "location": {"latitude": -22.8184393, "longitude": -47.0822301}
};

const postJson = {
  "post_id": 1,
  "post_description": "description",
  "address": "Rua Roxo Moreira, 45",
  "likes": 2,
  "unlikes": 2,
  "author_photo": "photo",
  "author_username": "name",
  "user_like": 1,
  "isAnonymous": 1,
  "can_vote": 0,
};

const homeMock = HomeEntity(
  user: HomeUserEntity(safetyNumber: "safety_number", username: "username", qtdPosts: 2, coordinates: LatLng(-22.8184393, -47.0822301)),
  posts: [
    HomePostEntity(
      id: 1,
      description: "description",
      local: "Rua Roxo Moreira, 45",
      upVotes: 2,
      downVotes: 2,
    ),
    HomePostEntity(
      id: 2,
      description: "description",
      local: "Rua Luverci Pereira, 40",
      upVotes: 4,
      downVotes: 3,
    )
  ],
);

const latLngMock = LatLng(-22.8184393, -47.0822301);
final positionMock = Position(
  latitude: -22.8184393,
  longitude: -47.0822301,
  timestamp: DateTime.now(),
  accuracy: 0,
  altitude: 0,
  heading: 0,
  speed: 0,
  speedAccuracy: 0,
);
