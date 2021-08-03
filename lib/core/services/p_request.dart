import 'package:candix/core/controllers/j.dart';
import 'package:candix/core/models/note.dart';
import 'package:candix/core/models/p_request.dart';
import 'package:candix/core/services/_api.dart';

class ProcurementService extends API {
  Future<NetworkResponse> getRequests() async {
    return parse(
      await get(uri("procurements"), headers: J.authorization),
    );
  }

  Future<NetworkResponse> single(int id) async {
    return parse(await get(
      uri("procurements/$id"),
      headers: J.authorization,
    ));
  }

  Future<NetworkResponse> getStats() async {
    return parse(
      await get(uri("stats/procurements"), headers: J.authorization),
    );
  }

  Future<NetworkResponse> push(ProcurementRequest request,
      {bool updateJustStatus = false}) async {
    return parse(
        updateJustStatus
            ? await post(uri("procurements/${request.id}"), request.statusData,
                headers: J.authorization)
            : request.id != null
                ? await put(uri("procurements/${request.id}"), request.json,
                    headers: J.authorization)
                : await post(uri("procurements"), request.json,
                    headers: J.authorization),
        message: "Request ${request.id != null ? "Updated" : "Submitted"}");
  }

  Future<NetworkResponse> attachNote(Note note) async {
    return parse(await post(uri("notes"), note.json, headers: J.authorization),
        message: "Note attached");
  }

  Future<NetworkResponse> retrieveNote(int id) async {
    return parse(await get(uri("notes/$id"), headers: J.authorization));
  }

  Future<NetworkResponse> projects() async {
    return parse(await get(uri("projects"), headers: J.authorization));
  }

  Future<NetworkResponse> assignProject(
      {required int project, required int procurement}) async {
    return parse(
      await post(uri("projects/$project"), {"procurement_id": procurement},
          headers: J.authorization),
    );
  }

  Future<NetworkResponse> remove(int id) async {
    return parse(
        await delete(uri("procurements/$id"), headers: J.authorization),
        message: "Request Deleted");
  }
}
