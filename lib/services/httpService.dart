import 'dart:convert';

import 'package:app/core/constants.dart';
import 'package:app/models/Depense.dart';
import 'package:app/models/Travel.dart';
import 'package:http/http.dart' as http;

class HttpService {
  Future<void> fetchData() async {
    final url = Uri.parse(URL + 'posts');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }

  Future<List<Depense>> getDepenses() async {
    try {
      final response = await http.get(Uri.parse(URL + 'depenses'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map(
              (e) => Depense(
                name: e['name'] ?? 'Unknown',
                paidBy: e['paidBy'] ?? 'Unknown',
                price: e['price']?.toString() ?? '0',
              ),
            )
            .toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Request failed: $e');
      return [];
    }
  }

  Future<List<Travel>> getTravels() async {
    try {
      final response = await http.get(Uri.parse(URL + 'travel'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map(
              (e) => Travel(
                city: e['city'] ?? 'Unknown',
                date: e['date'] ?? 'Unknown',
                price: e['price']?.toString() ?? '0',
                participants: [],
              ),
            )
            .toList();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Request failed: $e');
      return [];
    }
  }

  Future<void> addTravel(Travel travel) async {
    try {
      final response = await http.post(
        Uri.parse('${URL}travel'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(travel.toJson()),
      );

      if (response.statusCode == 200) {
        print('Travel added successfully');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }

  Future<void> addDepense(Depense depense) async {
    try {
      final response = await http.post(
        Uri.parse('${URL}depenses'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(depense.toJson()),
      );

      if (response.statusCode == 200) {
        print('Depense added successfully');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }

  Future<double> getTotalPaidByUser(String username) async {
    List<Depense> depenses = await getDepenses();
    double total = 0.0;
    for (var depense in depenses) {
      if (depense.paidBy.toLowerCase() == username.toLowerCase()) {
        total += double.parse(depense.price);
      }
    }
    return total;
  }

  Future<double> getTotalPaidByOthers(String username) async {
    List<Depense> depenses = await getDepenses();
    double total = 0.0;
    for (var depense in depenses) {
      if (depense.paidBy.toLowerCase() != username.toLowerCase()) {
        total += double.parse(depense.price);
      }
    }
    return total;
  }

  Future<List<Depense>> getDepensesPaidByOthers(String username) async {
    List<Depense> depenses = await getDepenses();
    List<Depense> paidByOthers = [];
    for (var depense in depenses) {
      if (depense.paidBy.toLowerCase() != username.toLowerCase()) {
        paidByOthers.add(depense);
      }
    }
    return paidByOthers;
  }
}
