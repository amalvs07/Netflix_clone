import '../../core/strings.dart';
import '../../infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$KBaseUrl/trending/all/day?api_key=$apiKey";

  static const search = "$KBaseUrl/search/movie?api_key=$apiKey&language=en-US";

  static const HotAndNewDiscoverMovies = "$KBaseUrl/discover/movie?api_key=$apiKey";

  static const HotAndNewDiscoverTv = "$KBaseUrl/discover/tv?api_key=$apiKey";

    static const HomeScreenPopular= "$KBaseUrl/movie/popular?api_key=$apiKey";

    static const HomeScreenUpcomming= "$KBaseUrl/movie/upcoming?api_key=$apiKey";
}
