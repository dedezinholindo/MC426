import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mc426_front/home/domain/domain.dart';

const homeMockJson = {
  "user": {
    "safetyNumber": "safetyNumber",
    "username": "username",
    "qtdPosts": 2,
    "coordinates": {"latitude": -22.8184393, "longitude": -47.0822301}
  },
  "posts": [
    {
      "id": 1,
      "description": "description",
      "time": "2 horas",
      "local": "Rua Roxo Moreira, 45",
      "upVotes": 2,
      "downVotes": 2,
    },
    {
      "id": 2,
      "description": "description",
      "time": "10 dias",
      "local": "Rua Luverci Pereira, 40",
      "upVotes": 4,
      "downVotes": 3,
    }
  ],
};

const userJson = {
  "safetyNumber": "safetyNumber",
  "username": "username",
  "qtdPosts": 2,
  "photo": "photo",
  "coordinates": {"latitude": -22.8184393, "longitude": -47.0822301}
};

const postJson = {
  "id": 1,
  "description": "description",
  "time": "2 horas",
  "local": "Rua Roxo Moreira, 45",
  "upVotes": 2,
  "downVotes": 2,
  "photo": "photo",
  "name": "name",
  "userUpVoted": true,
  "userDownVoted": true,
  "isAnonymous": true,
};

const homeMock = HomeEntity(
  user: HomeUserEntity(
      safetyNumber: "safety_number",
      username: "username",
      qtdPosts: 2,
      coordinates: Coordinates(latitude: -22.8184393, longitude: -47.0822301)),
  posts: [
    HomePostEntity(
      id: 1,
      description: "description",
      time: "2 horas",
      local: "Rua Roxo Moreira, 45",
      upVotes: 2,
      downVotes: 2,
    ),
    HomePostEntity(
      id: 2,
      description: "description",
      time: "10 dias",
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
