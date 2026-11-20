import '../../../constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/rest_client/api_client.dart';
import '../../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient client;
  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    final data = await client.get(ApiConstants.products);
    if (data is! List) throw const ServerException();
    return data
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
