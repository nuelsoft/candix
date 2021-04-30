import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/core/services/_api.dart';

class ProcurementService extends API {
  Future<NetworkResponse> getRequests() async {
    return parse(
      await get(uri("procurements"), headers: J.authorization),
    );
  }

  Future<NetworkResponse> getStats() async {
    return parse(
      await get(uri("stats/procurements"), headers: J.authorization),
    );
  }

  Future<NetworkResponse> push(ProcurementRequest request) async {
    return parse(
        request.id != null
            ? await put(uri("procurements/${request.id}"), request.json,
                headers: J.authorization)
            : await post(uri("procurements"), request.json,
                headers: J.authorization),
        message: "Request ${request.id != null ? "Updated" : "Submitted"}");
  }

  Future<NetworkResponse> remove(int id) async {
    return parse(
        await delete(uri("procurements/$id"), headers: J.authorization),
        message: "Request Deleted");
  }
}
