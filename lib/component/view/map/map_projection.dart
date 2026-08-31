import 'map_data.dart';

/// Coordinate projection utilities for maps.
class MapProjection {
  MapProjection._();

  // ===== World Map Constants =====

  /// World map SVG width.
  static const double worldWidth = 2000;

  /// World map SVG height.
  static const double worldHeight = 857;

  /// World map viewBox.
  static const String worldViewBox = '0 0 2000 857';

  /// World map aspect ratio.
  static const double worldAspectRatio = 2.33;

  // World projection bounds
  static const double _worldLatMax = 83;
  static const double _worldLatRange = 143; // 83 - (-60)

  // ===== USA Map Constants =====

  /// USA map SVG width.
  static const double usaWidth = 1000;

  /// USA map SVG height.
  static const double usaHeight = 589;

  /// USA map viewBox.
  static const String usaViewBox = '0 0 1000 589';

  /// USA map aspect ratio.
  static const double usaAspectRatio = 1.70;

  /// Get map dimensions for a given map type.
  static ({double width, double height, String viewBox, double aspectRatio})
  dimensions(MapType type) {
    return switch (type) {
      MapType.world => (
        width: worldWidth,
        height: worldHeight,
        viewBox: worldViewBox,
        aspectRatio: worldAspectRatio,
      ),
      MapType.usa => (
        width: usaWidth,
        height: usaHeight,
        viewBox: usaViewBox,
        aspectRatio: usaAspectRatio,
      ),
    };
  }

  /// Convert lat/lng to SVG coordinates.
  static (double x, double y) latLngToSvg(
    MapType type,
    double lat,
    double lng,
  ) {
    return switch (type) {
      MapType.world => _worldLatLngToSvg(lat, lng),
      MapType.usa => _usaLatLngToSvg(lat, lng),
    };
  }

  /// Convert SVG coordinates to lat/lng.
  static (double lat, double lng) svgToLatLng(
    MapType type,
    double x,
    double y,
  ) {
    return switch (type) {
      MapType.world => _worldSvgToLatLng(x, y),
      MapType.usa => _usaSvgToLatLng(x, y),
    };
  }

  static (double x, double y) _worldLatLngToSvg(double lat, double lng) {
    final x = (lng + 180) * (worldWidth / 360);
    final y = (_worldLatMax - lat) * (worldHeight / _worldLatRange);
    return (x.clamp(0, worldWidth), y.clamp(0, worldHeight));
  }

  static (double x, double y) _usaLatLngToSvg(double lat, double lng) {
    final x = ((lng + 125) / 58) * 900 + 50;
    final y = ((50 - lat) / 25) * 450 + 50;
    return (x.clamp(0, usaWidth), y.clamp(0, usaHeight));
  }

  static (double lat, double lng) _worldSvgToLatLng(double x, double y) {
    final lng = (x / worldWidth) * 360 - 180;
    final lat = _worldLatMax - (y / worldHeight) * _worldLatRange;
    return (lat, lng);
  }

  static (double lat, double lng) _usaSvgToLatLng(double x, double y) {
    final lng = ((x - 50) / 900) * 58 - 125;
    final lat = 50 - ((y - 50) / 450) * 25;
    return (lat, lng);
  }

  /// Get coordinates for a location (uses pre-calculated if available).
  static (double x, double y) getCoordinates(
    MapType type,
    String? id,
    double lat,
    double lng,
  ) {
    if (id != null) {
      final coords = type == MapType.world
          ? worldCityCoords[id]
          : usaCityCoords[id];
      if (coords != null) return coords;
    }
    return latLngToSvg(type, lat, lng);
  }

  /// Pre-calculated SVG coordinates for major world cities.
  static const Map<String, (double, double)> worldCityCoords = {
    // North America
    'nyc': (587, 254),
    'lax': (355, 278),
    'chi': (514, 245),
    'sfo': (210, 274),
    'sea': (220, 220),
    'mia': (550, 320),
    'dfw': (435, 295),
    'tor': (545, 235),
    'van': (220, 210),
    // Europe
    'lon': (970, 159),
    'lhr': (970, 159),
    'par': (1011, 200),
    'ber': (1068, 180),
    'mad': (980, 238),
    'rom': (1063, 231),
    'ams': (1023, 175),
    'fra': (1044, 192),
    'sto': (1095, 145),
    'war': (1105, 175),
    'mil': (1050, 210),
    // Asia
    'tyo': (1694, 275),
    'sin': (1566, 478),
    'hkg': (1562, 336),
    'sel': (1615, 261),
    'mum': (1373, 357),
    'dxb': (1294, 332),
    // Oceania
    'syd': (1785, 707),
    'mel': (1744, 559),
    // South America
    'sao': (665, 508),
    'bue': (618, 540),
    'bog': (504, 421),
    'scl': (490, 540),
    // Africa
    'jnb': (1141, 512),
    'cpt': (1095, 540),
  };

  /// Pre-calculated SVG coordinates for major US cities.
  static const Map<String, (double, double)> usaCityCoords = {
    'nyc': (893, 185),
    'lax': (123, 340),
    'chi': (648, 195),
    'hou': (510, 420),
    'phx': (215, 355),
    'phi': (870, 210),
    'san': (505, 410),
    'sdi': (135, 365),
    'dal': (485, 380),
    'sfo': (90, 265),
    'aus': (475, 405),
    'sea': (115, 95),
    'den': (340, 260),
    'bos': (920, 155),
    'det': (720, 185),
    'mia': (840, 495),
    'atl': (730, 340),
    'msp': (545, 140),
    'was': (845, 235),
    'ord': (648, 195),
    'dfw': (485, 375),
    'las': (175, 300),
    'por': (100, 115),
    'slc': (250, 240),
  };

  /// Common location lat/lng coordinates.
  static const Map<String, (double, double)> commonLocations = {
    // North America
    'nyc': (40.7128, -74.0060),
    'lax': (34.0522, -118.2437),
    'dfw': (32.7767, -96.7970),
    'chi': (41.8781, -87.6298),
    'sea': (47.6062, -122.3321),
    'mia': (25.7617, -80.1918),
    'tor': (43.6532, -79.3832),
    'van': (49.2827, -123.1207),
    // Europe
    'lhr': (51.5074, -0.1278),
    'fra': (50.1109, 8.6821),
    'ams': (52.3676, 4.9041),
    'par': (48.8566, 2.3522),
    'mad': (40.4168, -3.7038),
    'mil': (45.4642, 9.1900),
    'sto': (59.3293, 18.0686),
    'war': (52.2297, 21.0122),
    // Asia-Pacific
    'sin': (1.3521, 103.8198),
    'syd': (-33.8688, 151.2093),
    'tyo': (35.6762, 139.6503),
    'hkg': (22.3193, 114.1694),
    'sel': (37.5665, 126.9780),
    'mum': (19.0760, 72.8777),
    'mel': (-37.8136, 144.9631),
    // Middle East & Africa
    'dxb': (25.2048, 55.2708),
    'jnb': (-26.2041, 28.0473),
    'cpt': (-33.9249, 18.4241),
    // South America
    'sao': (-23.5505, -46.6333),
    'bue': (-34.6037, -58.3816),
    'bog': (4.7110, -74.0721),
    'scl': (-33.4489, -70.6693),
  };

  /// US state names lookup.
  static const Map<String, String> usaStateNames = {
    'AK': 'Alaska',
    'AL': 'Alabama',
    'AR': 'Arkansas',
    'AZ': 'Arizona',
    'CA': 'California',
    'CO': 'Colorado',
    'CT': 'Connecticut',
    'DC': 'District of Columbia',
    'DE': 'Delaware',
    'FL': 'Florida',
    'GA': 'Georgia',
    'HI': 'Hawaii',
    'IA': 'Iowa',
    'ID': 'Idaho',
    'IL': 'Illinois',
    'IN': 'Indiana',
    'KS': 'Kansas',
    'KY': 'Kentucky',
    'LA': 'Louisiana',
    'MA': 'Massachusetts',
    'MD': 'Maryland',
    'ME': 'Maine',
    'MI': 'Michigan',
    'MN': 'Minnesota',
    'MO': 'Missouri',
    'MS': 'Mississippi',
    'MT': 'Montana',
    'NC': 'North Carolina',
    'ND': 'North Dakota',
    'NE': 'Nebraska',
    'NH': 'New Hampshire',
    'NJ': 'New Jersey',
    'NM': 'New Mexico',
    'NV': 'Nevada',
    'NY': 'New York',
    'OH': 'Ohio',
    'OK': 'Oklahoma',
    'OR': 'Oregon',
    'PA': 'Pennsylvania',
    'RI': 'Rhode Island',
    'SC': 'South Carolina',
    'SD': 'South Dakota',
    'TN': 'Tennessee',
    'TX': 'Texas',
    'UT': 'Utah',
    'VA': 'Virginia',
    'VT': 'Vermont',
    'WA': 'Washington',
    'WI': 'Wisconsin',
    'WV': 'West Virginia',
    'WY': 'Wyoming',
  };
}
