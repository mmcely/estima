class Service {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  Service({
    required this.id,
    required this.title,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  Service copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Service(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
