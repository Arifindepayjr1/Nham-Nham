import "package:nham_nham/data/datasources/local/delivery_local.dart";
import "package:nham_nham/models/delivery_person.dart";

class DeliveryRepository {
  final DeliveryLocalDatasources _localDatasources;

  DeliveryRepository({
    required DeliveryLocalDatasources deliveryLocalDatasources,
  }) : _localDatasources = deliveryLocalDatasources;

  Future<List<DeliveryPerson>> getAllDeliveryPerson() async {
    await _localDatasources.loadDeliveryPerson();
    return _localDatasources.deliveryPersonData;
  }
}