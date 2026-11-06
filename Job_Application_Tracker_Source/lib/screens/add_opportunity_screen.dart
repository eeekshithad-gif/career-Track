import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/job_provider.dart';

class AddOpportunityScreen extends StatefulWidget {
  const AddOpportunityScreen({super.key});
  @override
  State<AddOpportunityScreen> createState() => _AddOpportunityScreenState();
}

class _AddOpportunityScreenState extends State<AddOpportunityScreen> {
  final _key = GlobalKey<FormState>();
  final _role = TextEditingController(), _company = TextEditingController();
  final _location = TextEditingController(), _description = TextEditingController();
  String _type = 'Internship';
  bool _saving = false;

  @override
  void dispose() {
    _role.dispose(); _company.dispose(); _location.dispose(); _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_key.currentState!.validate() || _saving) return;
    setState(() => _saving = true);
    try {
      await context.read<JobProvider>().add(
        role: _role.text, company: _company.text, location: _location.text,
        type: _type, description: _description.text);
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add opportunity')),
    body: Form(key: _key, child: ListView(padding: const EdgeInsets.all(20), children: [
      TextFormField(controller: _role, decoration: const InputDecoration(labelText: 'Job role'),
        validator: (v) => v == null || v.trim().length < 3 ? 'Enter a valid role' : null),
      const SizedBox(height: 12),
      TextFormField(controller: _company, decoration: const InputDecoration(labelText: 'Company'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter company name' : null),
      const SizedBox(height: 12),
      TextFormField(controller: _location, decoration: const InputDecoration(labelText: 'Location / Remote'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter a location' : null),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: _type, decoration: const InputDecoration(labelText: 'Opportunity type'),
        items: const ['Internship', 'Full-time', 'Part-time', 'Remote'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
        onChanged: (v) => setState(() => _type = v ?? 'Internship')),
      const SizedBox(height: 12),
      TextFormField(controller: _description, minLines: 4, maxLines: 7,
        decoration: const InputDecoration(labelText: 'Notes / description', alignLabelWithHint: true),
        validator: (v) => v == null || v.trim().length < 10 ? 'Enter at least 10 characters' : null),
      const SizedBox(height: 20),
      FilledButton.icon(onPressed: _saving ? null : _save,
        icon: const Icon(Icons.save), label: Text(_saving ? 'Saving...' : 'Save opportunity')),
    ])),
  );
}
