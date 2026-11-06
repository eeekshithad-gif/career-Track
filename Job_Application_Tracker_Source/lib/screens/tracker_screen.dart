import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import 'detail_screen.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();
    final statuses = ['Interested', 'Applied', 'Interview', 'Offered', 'Rejected'];
    return Scaffold(
      appBar: AppBar(title: const Text('Application tracker')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        for (final status in statuses) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('$status (${provider.items.where((e) => e.status == status).length})',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
          ...provider.items.where((e) => e.status == status).map((item) => Card(
            child: ListTile(title: Text(item.role), subtitle: Text(item.company),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(id: item.id))))),
          ),
        ],
      ]),
    );
  }
}
