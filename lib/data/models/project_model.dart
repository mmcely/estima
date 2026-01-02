import 'dart:ui';

import 'user_model.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final User projectManager;
  final List<Module> modules;
  final ProjectStatus status;
  final DateTime startDate;
  final DateTime? endDate;
  final double estimatedCost;
  final double actualCost;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.projectManager,
    required this.modules,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.estimatedCost,
    required this.actualCost,
  });
}

class Module {
  final String id;
  final String name;
  final String description;
  final List<Task> tasks;
  final double estimatedHours;

  Module({
    required this.id,
    required this.name,
    required this.description,
    required this.tasks,
    required this.estimatedHours,
  });
}

class Task {
  final String id;
  final String title;
  final String description;
  final User? assignedTo;
  final TaskStatus status;
  final double progress;
  final DateTime startDate;
  final DateTime deadline;
  final List<TaskElement> elements;
  final double estimatedHours;
  final double actualHours;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.deadline,
    required this.elements,
    required this.estimatedHours,
    required this.actualHours,
  });
}

class TaskElement {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String reference;
  final String unity;

  TaskElement({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.reference,
    required this.unity,
  });
}

// Classe Ressource (synonyme de TaskElement pour votre application)
class Ressource {
  final String id;
  final String name;
  final String reference;
  final String unity;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String category;
  final String section;
  final String element;
  final String? taskId;
  final String? projectId;

  Ressource({
    required this.id,
    required this.name,
    required this.reference,
    required this.unity,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.category,
    required this.section,
    required this.element,
    this.taskId,
    this.projectId,
  });

  // Convertir de TaskElement à Ressource
  factory Ressource.fromTaskElement(
    TaskElement element, {
    String? taskId,
    String? projectId,
  }) {
    return Ressource(
      id: element.id,
      name: element.name,
      reference: element.reference,
      unity: element.unity,
      quantity: element.quantity,
      unitPrice: element.unitPrice,
      totalPrice: element.totalPrice,
      category: element.category,
      section: element.subCategory,
      element: element.name,
      taskId: taskId,
      projectId: projectId,
    );
  }
}

class GanttTask {
  final int id;
  final String text;
  final DateTime startDate;
  final DateTime endDate;
  final int? parentId;
  final Color color;
  final bool isProject;

  GanttTask({
    required this.id,
    required this.text,
    required this.startDate,
    required this.endDate,
    this.parentId,
    required this.color,
    this.isProject = false,
  });
}

enum ProjectStatus { draft, planning, inProgress, onHold, completed, cancelled }

enum TaskStatus { notStarted, inProgress, pendingReview, completed, blocked }
