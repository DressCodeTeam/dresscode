class ApiConstants {
  static const String baseUrl = 'https://dresscode-api.onrender.com';
  // static const String baseUrl = 'http://10.0.2.2:3000/';


  static const String garmentEndpoint = '/garments';
  static const String createGarmentEndpoint = '$garmentEndpoint/create';
  static const String findAllGarmentEndpoint = '$garmentEndpoint';

  static const String outfitEndpoint = '/outfits';
  static const String createOutfitEndpoint = '$outfitEndpoint';
  static const String findAllOutfitsEndpoint = '$outfitEndpoint';
  static const String findOutfitByIdEndpoint = '$outfitEndpoint';

  static const String loginEndpoint = '$baseUrl/auth/login';
}
