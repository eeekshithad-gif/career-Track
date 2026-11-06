import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';
import '../widgets/opportunity_card.dart';
import 'add_opportunity_screen.dart';
import 'detail_screen.dart';
import 'tracker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  String _status = 'All';
  final _statuses = const ['All', 'Interested', 'Applied', 'Interview', 'Offered', 'Rejected'];

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobProvider>();
    final items = provider.search(_search.text, _status);
    return Scaffold(
      appBar: AppBar(title: const Text('CareerTrack'), actions: [
        IconButton(tooltip: 'Application tracker', icon: const Icon(Icons.track_changes),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TrackerScreen()))),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddOpportunityScreen())),
        icon: const Icon(Icons.add), label: const Text('Add opportunity')),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Text('Keep your career moving.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(controller: _search, onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search role or company')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _status, decoration: const InputDecoration(labelText: 'Filter by status'),
            items: _statuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) => setState(() => _status = v ?? 'All')),
          const SizedBox(height: 16),
          if (provider.isLoading && provider.items.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))
          else if (provider.error != null && provider.items.isEmpty)
            Center(child: Column(children: [Text(provider.error!), TextButton(onPressed: provider.load, child: const Text('Retry'))]))
          else if (items.isEmpty)
            const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No opportunities found. Add one to get started.')))
          else
            ...items.map((item) => OpportunityCard(item: item,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(id: item.id))))),
        ]),
      ),
    );
  }
}
