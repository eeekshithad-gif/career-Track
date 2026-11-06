import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/opportunity.dart';

class StorageService {
  static const _key = 'careertrack_opportunities_v1';

  Future<List<Opportunity>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return _samples();
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.map((e) => Opportunity.fromJson(Map<String, dynamic>.from(e as Map))).toList();
    } catch (_) {
      return _samples();
    }
  }

  Future<void> save(List<Opportunity> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  List<Opportunity> _samples() {
    final now = DateTime.now();
    return [
      Opportunity(id: 'j1', role: 'Flutter Developer Intern', company: 'DemoSoft',
        location: 'Hybrid', type: 'Internship', description: 'Sample internship record. Review the employer website and verify eligibility, stipend and application deadline before applying.',
        status: 'Interested', addedAt: now, demo: true),
      Opportunity(id: 'j2', role: 'Data Analyst Trainee', company: 'Sample Analytics',
        location: 'Remote', type: 'Full-time', description: 'Fictional example role for demonstrating the tracker. No real vacancy is being advertised.',
        status: 'Applied', addedAt: now.subtract(const Duration(days: 2)), demo: true),
      Opportunity(id: 'j3', role: 'Python Intern', company: 'Learning Labs',
        location: 'On-site', type: 'Internship', description: 'Demo opportunity to show how a student can record an interview stage and follow-up details.',
        status: 'Interview', addedAt: now.subtract(const Duration(days: 4)), demo: true),
    ];
  }
}
