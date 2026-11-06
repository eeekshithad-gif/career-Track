import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();
    final matches = provider.items.where((e) => e.id == id);
    if (matches.isEmpty) return Scaffold(appBar: AppBar(), body: const Center(child: Text('Opportunity not found.')));
    final item = matches.first;
    const statuses = ['Interested', 'Applied', 'Interview', 'Offered', 'Rejected'];
    return Scaffold(
      appBar: AppBar(title: const Text('Opportunity details')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Text(item.role, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(item.company, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Wrap(spacing: 8, children: [Chip(label: Text(item.location)), Chip(label: Text(item.type))]),
        const Divider(height: 32),
        Text('Description', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SelectableText(item.description),
        const SizedBox(height: 24),
        Text('Application status', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: item.status, decoration: const InputDecoration(labelText: 'Update status'),
          items: statuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (v) { if (v != null) provider.updateStatus(id, v); }),
        if (item.demo) const Padding(padding: EdgeInsets.only(top: 18),
          child: Text('This is fictional sample data. It is not a real job vacancy.', style: TextStyle(color: Colors.deepOrange))),
      ]),
    );
  }
}
