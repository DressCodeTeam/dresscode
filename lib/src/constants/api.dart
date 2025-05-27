class ApiConstants {
  static const String baseUrl = 'https://dresscode-api.onrender.com';
  // static const String baseUrl = 'http://10.0.2.2:3000/';
  static const String localUrl = 'http://192.168.1.151/';


  static const String garmentEndpoint = '/garments';

  static const String outfitEndpoint = '/outfits';
  static const String createOutfitEndpoint = outfitEndpoint;
  static const String findAllOutfitsEndpoint = outfitEndpoint;
  static const String findOutfitByIdEndpoint = outfitEndpoint;

  static const String categoriesEndpoint = '/categories';

  static const String loginEndpoint = '$baseUrl/auth/login';
}
