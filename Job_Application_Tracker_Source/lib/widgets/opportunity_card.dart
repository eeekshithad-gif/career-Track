import 'package:flutter/material.dart';
import '../models/opportunity.dart';

class OpportunityCard extends StatelessWidget {
  final Opportunity item;
  final VoidCallback onTap;
  const OpportunityCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(child: Text(item.role, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
            _StatusChip(status: item.status),
          ]),
          const SizedBox(height: 7),
          Text(item.company, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.location_on_outlined, size: 16),
            const SizedBox(width: 4), Text(item.location),
            const SizedBox(width: 14),
            const Icon(Icons.work_outline, size: 16),
            const SizedBox(width: 4), Text(item.type),
          ]),
          if (item.demo)
            const Padding(padding: EdgeInsets.only(top: 8),
              child: Text('FICTIONAL DEMO OPPORTUNITY', style: TextStyle(fontSize: 10, color: Colors.deepOrange))),
        ]),
      ),
    ),
  );
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext context) => Chip(
    visualDensity: VisualDensity.compact,
    label: Text(status, style: const TextStyle(fontSize: 11)),
  );
}
