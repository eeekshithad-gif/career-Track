import 'package:flutter/foundation.dart';
import '../models/opportunity.dart';
import '../services/storage_service.dart';

class JobProvider extends ChangeNotifier {
  final StorageService _storage = StorageService();
  List<Opportunity> _items = [];
  bool isLoading = false;
  String? error;

  List<Opportunity> get items => List.unmodifiable(_items);

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      _items = await _storage.load();
    } catch (_) {
      error = 'Unable to load saved opportunities. Please retry.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  List<Opportunity> search(String query, String status) {
    final q = query.trim().toLowerCase();
    return _items.where((item) {
      final matchStatus = status == 'All' || item.status == status;
      final matchQuery = q.isEmpty || item.role.toLowerCase().contains(q) ||
          item.company.toLowerCase().contains(q);
      return matchStatus && matchQuery;
    }).toList();
  }

  Future<void> add({
    required String role, required String company, required String location,
    required String type, required String description,
  }) async {
    _items = [Opportunity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: role.trim(), company: company.trim(), location: location.trim(),
      type: type, description: description.trim(), status: 'Interested',
      addedAt: DateTime.now(),
    ), ..._items];
    await _persist();
    notifyListeners();
  }

  Future<void> updateStatus(String id, String status) async {
    _items = _items.map((e) => e.id == id ? e.copyWith(status: status) : e).toList();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() => _storage.save(_items);
}
