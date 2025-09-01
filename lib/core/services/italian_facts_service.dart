import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import '../../domain/entities/italian_fact.dart';

class ItalianFactsService {
  static List<ItalianFact>? _facts;

  static Future<List<ItalianFact>> getFacts() async {
    if (_facts != null) {
      return _facts!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/italian_facts.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final ItalianFacts factsData = ItalianFacts.fromJson(jsonData);
      _facts = factsData.facts;
      return _facts!;
    } catch (e) {
      print('❌ Error loading Italian facts: $e');
      return [];
    }
  }

  static Future<ItalianFact?> getTodayFact() async {
    final facts = await getFacts();
    final today = DateTime.now();
    final todayString =
        '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    try {
      return facts.firstWhere((fact) => fact.date == todayString);
    } catch (e) {
      return null; // No fact for today
    }
  }

  static Future<ItalianFact> getRandomFact() async {
    final facts = await getFacts();
    if (facts.isEmpty) {
      throw Exception('No facts available');
    }

    final random = Random();
    return facts[random.nextInt(facts.length)];
  }

  static Future<ItalianFact?> getRandomFactWithUrl() async {
    final facts = await getFacts();
    final factsWithUrl = facts
        .where((fact) => fact.url != null && fact.url!.isNotEmpty)
        .toList();

    if (factsWithUrl.isEmpty) {
      return null;
    }

    final random = Random();
    return factsWithUrl[random.nextInt(factsWithUrl.length)];
  }

  static Future<List<ItalianFact>> getFactsWithUrl() async {
    final facts = await getFacts();
    return facts
        .where((fact) => fact.url != null && fact.url!.isNotEmpty)
        .toList();
  }
}


