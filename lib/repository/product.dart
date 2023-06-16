import 'package:dio/dio.dart';
import 'package:vttr/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<void> addProductComment(
      String token, String comment, int assessment, String productName);
}

class ProductRepositoryImpl implements ProductRepository {
  final client = Dio();

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await client
          .get("https://ronaldo.gtasamp.com.br/api/product/getAllProduct");

      final data = response.data['data']['products'] as List<dynamic>;

      return data
          .map<Product>((e) => Product(
              e['id'] as int,
              e['name'] as String,
              (e['price'] as num).toDouble(),
              e['description'] as String,
              // ignore: prefer_interpolation_to_compose_strings
              "https://ronaldo.gtasamp.com.br/" + e['product_image'],
              DateTime.parse(e['created_at'] as String),
              DateTime.parse(e['updated_at'] as String)))
          .toList();
    } catch (e) {
      print(e);
      throw Exception("Não foi possível buscar os produtos");
    }
  }

  @override
  Future<void> addProductComment(
      String token, String comment, int assessment, String productName) async {
    try {
      final response = await client.post(
        'https://ronaldo.gtasamp.com.br/api/product/comments',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {
          'comment': comment,
          'assessment': assessment,
          'product_name': productName,
        },
      );

      final data = response.data['data'];

      print("OIIIIII");
      print(data);

      print(data['message']);
    } catch (e) {
      print(e);
      throw Exception('Falha ao adicionar o comentario ao produto.');
    }
  }
}
