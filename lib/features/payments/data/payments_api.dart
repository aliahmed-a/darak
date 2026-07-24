import '../../../core/models/payment_target_type.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/paged_result.dart';
import 'models/payment.dart';
import 'models/payment_method.dart';

class PaymentsApi {
  const PaymentsApi(this._client);

  final ApiClient _client;

  Future<PagedResult<Payment>> search({int pageNumber = 1, int pageSize = 20}) => runApiCall(() async {
        final response = await _client.dio.get('/resident/payments', queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        });
        return PagedResult.fromJson(response.data as Map<String, dynamic>, (json) => Payment.fromJson(json));
      });

  Future<Payment> getById(String id) => runApiCall(() async {
        final response = await _client.dio.get('/resident/payments/$id');
        return Payment.fromJson(response.data as Map<String, dynamic>);
      });

  Future<Payment> start({
    required PaymentTargetType targetType,
    required String targetId,
    required PaymentMethod paymentMethod,
    required double amount,
  }) =>
      runApiCall(() async {
        final response = await _client.dio.post('/resident/payments/start', data: {
          'targetType': targetType.index,
          'targetId': targetId,
          'paymentMethod': paymentMethod.index,
          'amount': amount,
        });
        return Payment.fromJson(response.data as Map<String, dynamic>);
      });

  Future<Payment> confirmMock({
    required String paymentId,
    required PaymentMethod method,
    required bool success,
  }) =>
      runApiCall(() async {
        final provider = method == PaymentMethod.zainCashMock ? 'zaincash' : 'mastercard';
        final outcome = success ? 'success' : 'failure';
        final response = await _client.dio.post(
          '/resident/payments/$paymentId/mock-$provider/$outcome',
          data: <String, dynamic>{},
        );
        return Payment.fromJson(response.data as Map<String, dynamic>);
      });
}
