import 'dart:convert';
import 'package:employees_list/models/employee.dart';
import 'package:http/http.dart';

class HttpService {
  final String apiURL = "https://demo8161595.mockable.io";

  List<Employee> parseEmployees(String resultBody) {
    final parsed = json.decode(resultBody).cast<Map<String, dynamic>>();

    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  Future<List<Employee>> getEmployees() async {
    List<Employee> employees;

    Response res = await get(
      "$apiURL/employee",
    );

    if (res.statusCode == 200) {
      employees = parseEmployees(res.body);

      return employees;
    } else if (res.statusCode == 401) {
      print('${res.statusCode} Unauthorized');
    } else {
      throw "Unable to get employees";
    }
    return employees;
  }
}
