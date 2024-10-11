import 'package:mommy_be/models/makanan.dart';
import 'package:mommy_be/shared/dio.dart';

class MakananService {
  Future<List<Makanan>> getMakanan(String token) async {
    final response = await Request.get('/makanan', headers: {
      'Authorization': 'Bearer $token',
    });

    List<Makanan> makanan = [];

    for (var item in response['data']['makanan']) {
      makanan.add(Makanan.fromJson(item));
    }

    return makanan;
  }
}
