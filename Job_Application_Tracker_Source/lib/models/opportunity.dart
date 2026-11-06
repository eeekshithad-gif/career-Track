class Opportunity {
  final String id;
  final String role;
  final String company;
  final String location;
  final String type;
  final String description;
  final String status;
  final DateTime addedAt;
  final bool demo;

  const Opportunity({
    required this.id, required this.role, required this.company,
    required this.location, required this.type, required this.description,
    required this.status, required this.addedAt, this.demo = false,
  });

  Opportunity copyWith({String? status}) => Opportunity(
    id: id, role: role, company: company, location: location, type: type,
    description: description, status: status ?? this.status,
    addedAt: addedAt, demo: demo,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'role': role, 'company': company, 'location': location,
    'type': type, 'description': description, 'status': status,
    'addedAt': addedAt.toIso8601String(), 'demo': demo,
  };

  factory Opportunity.fromJson(Map<String, dynamic> json) => Opportunity(
    id: json['id'] as String, role: json['role'] as String,
    company: json['company'] as String, location: json['location'] as String,
    type: json['type'] as String, description: json['description'] as String,
    status: json['status'] as String,
    addedAt: DateTime.parse(json['addedAt'] as String),
    demo: json['demo'] as bool? ?? false,
  );
}
