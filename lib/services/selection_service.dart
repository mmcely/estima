import 'package:flutter/material.dart';

import '../core/utils/colors.dart';

/// Centralized service for managing dropdown data and selections
/// All dropdown options should be fetched from this service for consistency
class SelectionService {
  // ============================================================
  // SECTIONS-RELATED METHODS
  // ============================================================

  /// Get sample sections data
  static List<Map<String, dynamic>> getSectionsData() {
    return [
      {'id': '1', 'designation': 'Section One'},
      {'id': '2', 'designation': 'Section Two'},
      {'id': '3', 'designation': 'Section Three'},
    ];
  }

  // ============================================================
  // CATEGORIES-RELATED METHODS
  // ============================================================

  /// Get sample categories data
  static List<Map<String, dynamic>> getCategoriesData() {
    return [
      {'id': '1', 'designation': 'Category A', 'section': 'One'},
      {'id': '2', 'designation': 'Category B', 'section': 'One'},
      {'id': '3', 'designation': 'Category C', 'section': 'Two'},
      {'id': '4', 'designation': 'Category D', 'section': 'Two'},
      {'id': '5', 'designation': 'Category E', 'section': 'Three'},
    ];
  }

  // ============================================================
  // ELEMENTS-RELATED METHODS
  // ============================================================

  /// Get sample elements data
  static List<Map<String, dynamic>> getElementsData() {
    return [
      {
        'id': '1',
        'reference': 'REF-001',
        'designation': 'Element 1',
        'unit': 'piece',
        'price': 10000.0,
        'category': 'Category A',
        'section': 'One',
      },
      {
        'id': '2',
        'reference': 'REF-002',
        'designation': 'Element 2',
        'unit': 'piece',
        'price': 12000.0,
        'category': 'Category A',
        'section': 'One',
      },
      {
        'id': '3',
        'reference': 'REF-003',
        'designation': 'Element 3',
        'unit': 'piece',
        'price': 15000.0,
        'category': 'Category B',
        'section': 'One',
      },
      {
        'id': '4',
        'reference': 'REF-004',
        'designation': 'Element 4',
        'unit': 'piece',
        'price': 18000.0,
        'category': 'Category B',
        'section': 'One',
      },
      {
        'id': '5',
        'reference': 'REF-005',
        'designation': 'Element 5',
        'unit': 'piece',
        'price': 20000.0,
        'category': 'Category B',
        'section': 'One',
      },
      {
        'id': '6',
        'reference': 'REF-006',
        'designation': 'Element 6',
        'unit': 'piece',
        'price': 22000.0,
        'category': 'Category C',
        'section': 'Two',
      },
      {
        'id': '7',
        'reference': 'REF-007',
        'designation': 'Element 7',
        'unit': 'piece',
        'price': 25000.0,
        'category': 'Category D',
        'section': 'Two',
      },
      {
        'id': '8',
        'reference': 'REF-008',
        'designation': 'Element 8',
        'unit': 'piece',
        'price': 28000.0,
        'category': 'Category D',
        'section': 'Two',
      },
      {
        'id': '9',
        'reference': 'REF-009',
        'designation': 'Element 9',
        'unit': 'piece',
        'price': 30000.0,
        'category': 'Category E',
        'section': 'Three',
      },
      {
        'id': '10',
        'reference': 'REF-010',
        'designation': 'Element 10',
        'unit': 'piece',
        'price': 32000.0,
        'category': 'Category F',
        'section': 'Three',
      },
      {
        'id': '11',
        'reference': 'REF-011',
        'designation': 'Element 11',
        'unit': 'piece',
        'price': 35000.0,
        'category': 'Category F',
        'section': 'Three',
      },
    ];
  }

  // ============================================================
  // PROJECTS-RELATED METHODS
  // ============================================================

  /// Get sample projects data
  static List<Map<String, dynamic>> getProjectsData() {
    return [
      {
        'id': '1',
        'name': 'Project One',
        'head': 'Jane Doe',
        'startDate': '2023-09-01',
        'endDate': '2023-12-15',
        'status': 'In Progress',
        'description':
            'Development of a new e-commerce platform with React and Node.js',
        'modules': ['Frontend', 'Backend', 'Database', 'Payment Integration'],
      },
      {
        'id': '2',
        'name': 'Project Two',
        'head': 'Jane Smith',
        'startDate': '2023-07-10',
        'endDate': '2023-10-30',
        'status': 'Completed',
        'description':
            'Mobile banking application with advanced security features',
        'modules': ['iOS App', 'Android App', 'Security Module', 'API Gateway'],
      },
      {
        'id': '3',
        'name': 'Project Three',
        'head': 'Robert Johnson',
        'startDate': '2023-11-01',
        'endDate': '2024-02-28',
        'status': 'Planned',
        'description':
            'AI-powered customer service chatbot for enterprise clients',
        'modules': [
          'NLP Engine',
          'Training Module',
          'Integration Layer',
          'Analytics',
        ],
      },
      {
        'id': '4',
        'name': 'Project Four',
        'head': 'John Williams',
        'startDate': '2023-08-15',
        'endDate': '2023-12-20',
        'status': 'In Progress',
        'description': 'Cloud migration project for financial services company',
        'modules': [
          'AWS Migration',
          'Data Transfer',
          'Security Setup',
          'Testing',
        ],
      },
      {
        'id': '5',
        'name': 'Project Five',
        'head': 'Sarah Brown',
        'startDate': '2023-06-01',
        'endDate': '2023-09-30',
        'status': 'Completed',
        'description': 'Development of a real-time analytics dashboard',
        'modules': ['Data Pipeline', 'Visualization', 'Reporting', 'Alerts'],
      },
      {
        'id': '6',
        'name': 'Project Six',
        'head': 'Michael Davis',
        'startDate': '2023-10-10',
        'endDate': '2024-01-31',
        'status': 'On Hold',
        'description': 'Inventory management system for retail chain',
        'modules': [
          'Stock Module',
          'Order Processing',
          'Supplier Management',
          'Reports',
        ],
      },
      {
        'id': '7',
        'name': 'Project Seven',
        'head': 'Emily Wilson',
        'startDate': '2023-12-01',
        'endDate': '2024-03-15',
        'status': 'Planned',
        'description': 'Employee wellness and productivity tracking platform',
        'modules': [
          'Health Metrics',
          'Activity Tracking',
          'Reports',
          'Notifications',
        ],
      },
      {
        'id': '8',
        'name': 'Project Eight',
        'head': 'David Miller',
        'startDate': '2023-09-20',
        'endDate': '2024-01-10',
        'status': 'In Progress',
        'description':
            'Supply chain optimization system with predictive analytics',
        'modules': [
          'Forecasting',
          'Route Optimization',
          'Inventory Control',
          'Supplier Portal',
        ],
      },
      {
        'id': '9',
        'name': 'Project Nine',
        'head': 'Lisa Taylor',
        'startDate': '2023-07-05',
        'endDate': '2023-11-15',
        'status': 'Completed',
        'description':
            'Digital transformation for legacy manufacturing systems',
        'modules': [
          'System Analysis',
          'Migration Planning',
          'Training',
          'Support',
        ],
      },
      {
        'id': '10',
        'name': 'Project Ten',
        'head': 'Thomas Anderson',
        'startDate': '2024-01-01',
        'endDate': '2024-04-30',
        'status': 'Planned',
        'description':
            'Development of a blockchain-based supply chain solution',
        'modules': [
          'Blockchain Core',
          'Smart Contracts',
          'Web Interface',
          'Mobile App',
        ],
      },
    ];
  }

  // ============================================================
  // MODULES-RELATED METHODS
  // ============================================================

  /// Get sample modules data
  static List<Map<String, dynamic>> getModulesData() {
    return [
      {
        'id': '1',
        'name': 'Frontend Development',
        'project': 'Project One',
        'responsible': 'Alice Johnson',
        'startDate': '2023-09-15',
        'endDate': '2023-11-15',
        'status': 'In Progress',
        'description': 'React-based user interface development',
        'tasksCount': 8,
      },
      {
        'id': '2',
        'name': 'Backend API',
        'project': 'Project One',
        'responsible': 'Bob Smith',
        'startDate': '2023-10-01',
        'endDate': '2023-12-01',
        'status': 'Planned',
        'description': 'Node.js REST API development',
        'tasksCount': 6,
      },
      {
        'id': '3',
        'name': 'Database Design',
        'project': 'Project One',
        'responsible': 'Carol Davis',
        'startDate': '2023-09-01',
        'endDate': '2023-10-15',
        'status': 'Completed',
        'description': 'PostgreSQL database schema and optimization',
        'tasksCount': 5,
      },
      {
        'id': '4',
        'name': 'iOS App',
        'project': 'Project Two',
        'responsible': 'David Wilson',
        'startDate': '2023-07-20',
        'endDate': '2023-09-30',
        'status': 'Completed',
        'description': 'Swift iOS mobile banking application',
        'tasksCount': 10,
      },
      {
        'id': '5',
        'name': 'Android App',
        'project': 'Project Two',
        'responsible': 'Eva Brown',
        'startDate': '2023-07-25',
        'endDate': '2023-10-10',
        'status': 'Completed',
        'description': 'Kotlin Android mobile banking application',
        'tasksCount': 9,
      },
      {
        'id': '6',
        'name': 'Security Module',
        'project': 'Project Two',
        'responsible': 'Frank Miller',
        'startDate': '2023-08-15',
        'endDate': '2023-10-25',
        'status': 'In Progress',
        'description': 'Advanced security features implementation',
        'tasksCount': 7,
      },
      {
        'id': '7',
        'name': 'NLP Engine',
        'project': 'Project Three',
        'responsible': 'Grace Taylor',
        'startDate': '2023-11-10',
        'endDate': '2024-01-31',
        'status': 'Planned',
        'description': 'Natural Language Processing engine development',
        'tasksCount': 12,
      },
      {
        'id': '8',
        'name': 'AWS Migration',
        'project': 'Project Four',
        'responsible': 'Henry Clark',
        'startDate': '2023-09-01',
        'endDate': '2023-11-15',
        'status': 'In Progress',
        'description': 'Cloud infrastructure migration to AWS',
        'tasksCount': 15,
      },
      {
        'id': '9',
        'name': 'Data Pipeline',
        'project': 'Project Five',
        'responsible': 'Irene Lewis',
        'startDate': '2023-06-15',
        'endDate': '2023-08-31',
        'status': 'Completed',
        'description': 'Real-time data processing pipeline',
        'tasksCount': 8,
      },
      {
        'id': '10',
        'name': 'Stock Module',
        'project': 'Project Six',
        'responsible': 'Jack Walker',
        'startDate': '2023-10-20',
        'endDate': '2023-12-31',
        'status': 'On Hold',
        'description': 'Inventory stock management system',
        'tasksCount': 6,
      },
      {
        'id': '11',
        'name': 'Health Metrics',
        'project': 'Project Seven',
        'responsible': 'Karen Hall',
        'startDate': '2023-12-10',
        'endDate': '2024-02-28',
        'status': 'Planned',
        'description': 'Employee health tracking metrics',
        'tasksCount': 5,
      },
      {
        'id': '12',
        'name': 'Forecasting',
        'project': 'Project Eight',
        'responsible': 'Leo Allen',
        'startDate': '2023-10-01',
        'endDate': '2023-12-15',
        'status': 'In Progress',
        'description': 'Predictive analytics for supply chain',
        'tasksCount': 9,
      },
      {
        'id': '13',
        'name': 'System Analysis',
        'project': 'Project Nine',
        'responsible': 'Mia Young',
        'startDate': '2023-07-15',
        'endDate': '2023-09-15',
        'status': 'Completed',
        'description': 'Legacy system analysis and assessment',
        'tasksCount': 7,
      },
      {
        'id': '14',
        'name': 'Blockchain Core',
        'project': 'Project Ten',
        'responsible': 'Noah King',
        'startDate': '2024-01-15',
        'endDate': '2024-03-31',
        'status': 'Planned',
        'description': 'Core blockchain implementation',
        'tasksCount': 11,
      },
    ];
  }

  // ============================================================
  // TASKS-RELATED METHODS
  // ============================================================

  /// Get sample tasks data
  static List<Map<String, dynamic>> getTasksData() {
    return [
      {
        'id': '1',
        'title': 'UI Component Design',
        'module': 'Frontend Development',
        'project': 'Project One',
        'assignedTo': 'Alice Johnson',
        'startDate': '2023-09-15',
        'endDate': '2023-10-01',
        'status': 'Completed',
        'progress': 100,
        'priority': 'Medium',
        'description': 'Design React components for user interface',
      },
      {
        'id': '2',
        'title': 'API Endpoints',
        'module': 'Backend API',
        'project': 'Project One',
        'assignedTo': 'Bob Smith',
        'startDate': '2023-10-05',
        'endDate': '2023-10-20',
        'status': 'In Progress',
        'progress': 60,
        'priority': 'High',
        'description': 'Implement REST API endpoints',
      },
      {
        'id': '3',
        'title': 'Database Schema',
        'module': 'Database Design',
        'project': 'Project One',
        'assignedTo': 'Carol Davis',
        'startDate': '2023-09-01',
        'endDate': '2023-09-15',
        'status': 'Completed',
        'progress': 100,
        'priority': 'Medium',
        'description': 'Design and create database schema',
      },
      {
        'id': '4',
        'title': 'Login Screen',
        'module': 'iOS App',
        'project': 'Project Two',
        'assignedTo': 'David Wilson',
        'startDate': '2023-07-20',
        'endDate': '2023-08-05',
        'status': 'Completed',
        'progress': 100,
        'priority': 'High',
        'description': 'Implement user login screen',
      },
      {
        'id': '5',
        'title': 'Biometric Auth',
        'module': 'Security Module',
        'project': 'Project Two',
        'assignedTo': 'Frank Miller',
        'startDate': '2023-08-20',
        'endDate': '2023-09-10',
        'status': 'In Progress',
        'progress': 40,
        'priority': 'High',
        'description': 'Implement biometric authentication',
      },
      {
        'id': '6',
        'title': 'NLP Model Training',
        'module': 'NLP Engine',
        'project': 'Project Three',
        'assignedTo': 'Grace Taylor',
        'startDate': '2023-11-15',
        'endDate': '2023-12-15',
        'status': 'Planned',
        'progress': 0,
        'priority': 'Medium',
        'description': 'Train natural language processing model',
      },
      {
        'id': '7',
        'title': 'EC2 Instance Setup',
        'module': 'AWS Migration',
        'project': 'Project Four',
        'assignedTo': 'Henry Clark',
        'startDate': '2023-09-05',
        'endDate': '2023-09-20',
        'status': 'Completed',
        'progress': 100,
        'priority': 'High',
        'description': 'Setup AWS EC2 instances',
      },
      {
        'id': '8',
        'title': 'Data Ingestion',
        'module': 'Data Pipeline',
        'project': 'Project Five',
        'assignedTo': 'Irene Lewis',
        'startDate': '2023-06-20',
        'endDate': '2023-07-10',
        'status': 'Completed',
        'progress': 100,
        'priority': 'Medium',
        'description': 'Implement data ingestion pipeline',
      },
      {
        'id': '9',
        'title': 'Inventory API',
        'module': 'Stock Module',
        'project': 'Project Six',
        'assignedTo': 'Jack Walker',
        'startDate': '2023-10-25',
        'endDate': '2023-11-10',
        'status': 'On Hold',
        'progress': 30,
        'priority': 'Medium',
        'description': 'Create inventory management API',
      },
      {
        'id': '10',
        'title': 'Health Dashboard',
        'module': 'Health Metrics',
        'project': 'Project Seven',
        'assignedTo': 'Karen Hall',
        'startDate': '2023-12-15',
        'endDate': '2024-01-15',
        'status': 'Planned',
        'progress': 0,
        'priority': 'Low',
        'description': 'Design health metrics dashboard',
      },
      {
        'id': '11',
        'title': 'Demand Forecasting',
        'module': 'Forecasting',
        'project': 'Project Eight',
        'assignedTo': 'Leo Allen',
        'startDate': '2023-10-10',
        'endDate': '2023-11-10',
        'status': 'In Progress',
        'progress': 70,
        'priority': 'High',
        'description': 'Implement demand forecasting algorithm',
      },
      {
        'id': '12',
        'title': 'System Audit',
        'module': 'System Analysis',
        'project': 'Project Nine',
        'assignedTo': 'Mia Young',
        'startDate': '2023-07-20',
        'endDate': '2023-08-05',
        'status': 'Completed',
        'progress': 100,
        'priority': 'Medium',
        'description': 'Conduct legacy system audit',
      },
      {
        'id': '13',
        'title': 'Smart Contracts',
        'module': 'Blockchain Core',
        'project': 'Project Ten',
        'assignedTo': 'Noah King',
        'startDate': '2024-01-20',
        'endDate': '2024-02-28',
        'status': 'Planned',
        'progress': 0,
        'priority': 'High',
        'description': 'Develop blockchain smart contracts',
      },
      {
        'id': '14',
        'title': 'Payment Integration',
        'module': 'Frontend Development',
        'project': 'Project One',
        'assignedTo': 'Alice Johnson',
        'startDate': '2023-10-20',
        'endDate': '2023-11-05',
        'status': 'Planned',
        'progress': 0,
        'priority': 'Medium',
        'description': 'Integrate payment gateway',
      },
      {
        'id': '15',
        'title': 'Performance Optimization',
        'module': 'Database Design',
        'project': 'Project One',
        'assignedTo': 'Carol Davis',
        'startDate': '2023-09-20',
        'endDate': '2023-10-05',
        'status': 'Completed',
        'progress': 100,
        'priority': 'Medium',
        'description': 'Optimize database queries and indexes',
      },
    ];
  }

  // ============================================================
  // CHAT-RELATED METHODS
  // ============================================================

  /// Get all available chats
  static List<Map<String, dynamic>> getChats() {
    return [
      {
        'id': 'project_1',
        'type': 'project',
        'title': 'Project One',
        'lastMessage': 'Meeting tomorrow at 2 PM',
        'unreadCount': 2,
        'memberCount': 5,
        'timestamp': '10:30 AM',
      },
      {
        'id': 'project_2',
        'type': 'project',
        'title': 'Project Two',
        'lastMessage': 'API documentation updated',
        'unreadCount': 0,
        'memberCount': 3,
        'timestamp': 'Yesterday',
      },
      {
        'id': 'direct_1',
        'type': 'direct',
        'title': 'Jane Doe',
        'lastMessage': 'Can you review my PR?',
        'unreadCount': 1,
        'memberCount': 2,
        'timestamp': '2:45 PM',
      },
    ];
  }

  /// Get chat messages for a specific chat
  static List<Map<String, dynamic>> getChatMessages(String chatId) {
    if (chatId.startsWith('project_')) {
      return [
        {
          'id': '1',
          'sender': 'Jane Doe',
          'senderId': '1',
          'message': 'Bonjour à tous, comment avance le projet ?',
          'time': '10:30',
          'isMe': false,
        },
        {
          'id': '2',
          'sender': 'Moi',
          'senderId': '0',
          'message': 'Tout va bien, le module frontend est à 80%',
          'time': '10:35',
          'isMe': true,
        },
        {
          'id': '3',
          'sender': 'Robert Johnson',
          'senderId': '2',
          'message': 'J\'ai terminé l\'API pour l\'authentification',
          'time': '11:00',
          'isMe': false,
        },
      ];
    } else {
      return [
        {
          'id': '1',
          'sender': 'Jane Doe',
          'senderId': '1',
          'message': 'Bonjour, pouvez-vous revoir mon PR ?',
          'time': '14:30',
          'isMe': false,
        },
        {
          'id': '2',
          'sender': 'Moi',
          'senderId': '0',
          'message': 'Oui, je le regarde cet après-midi',
          'time': '14:45',
          'isMe': true,
        },
      ];
    }
  }

  /// Get team members for a project
  static List<Map<String, dynamic>> getProjectTeamMembers(String projectId) {
    return [
      {
        'id': '1',
        'name': 'Jane Doe',
        'role': 'Chef de projet',
        'image': '',
        'isOnline': true,
      },
      {
        'id': '2',
        'name': 'John Smith',
        'role': 'Développeur Frontend',
        'image': '',
        'isOnline': false,
      },
      {
        'id': '3',
        'name': 'Robert Johnson',
        'role': 'Développeur Backend',
        'image': '',
        'isOnline': true,
      },
    ];
  }

  /// Get project chat info
  static Map<String, dynamic> getProjectChatInfo(String projectId) {
    final projects = getProjectsData();
    final project = projects.firstWhere(
      (p) => p['id'] == projectId,
      orElse: () => projects.first,
    );

    return {
      'projectId': projectId,
      'projectTitle': project['name'],
      'projectHead': project['head'],
      'totalMembers': 5,
    };
  }

  // ============================================================
  // USER-RELATED METHODS
  // ============================================================

  /// Get sample users data
  static List<Map<String, dynamic>> getUsers() {
    return [
      {
        'id': '1',
        'name': 'Jane Doe',
        'email': 'john.doe@example.com',
        'role': 'Administrator',
        'service': 'IT Department',
        'status': 'Active',
        'created': '15/01/2024',
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'email': 'jane.smith@example.com',
        'role': 'Project Manager',
        'service': 'Human Resources',
        'status': 'Active',
        'created': '10/02/2024',
      },
      {
        'id': '3',
        'name': 'Bob Johnson',
        'email': 'bob.johnson@example.com',
        'role': 'Member',
        'service': 'Finance',
        'status': 'Active',
        'created': '05/03/2024',
      },
      {
        'id': '4',
        'name': 'Alice Brown',
        'email': 'alice.brown@example.com',
        'role': 'Member',
        'service': 'Marketing',
        'status': 'Inactive',
        'created': '20/03/2024',
      },
      {
        'id': '5',
        'name': 'Charlie Wilson',
        'email': 'charlie.wilson@example.com',
        'role': 'Project Manager',
        'service': 'Operations',
        'status': 'Active',
        'created': '25/03/2024',
      },
    ];
  }

  /// Filter users based on search query
  static List<Map<String, dynamic>> filterUsers({
    String? searchQuery,
    String? statusFilter,
  }) {
    List<Map<String, dynamic>> users = getUsers();

    // Apply search filter
    if (searchQuery != null && searchQuery.isNotEmpty) {
      users = users.where((user) {
        return user['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            user['email'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            user['role'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            user['service'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Apply status filter
    if (statusFilter != null && statusFilter != 'All') {
      users = users.where((user) => user['status'] == statusFilter).toList();
    }

    return users;
  }

  /// Get user status options
  static List<String> getUserStatuses() {
    return ['Select the status', 'Active', 'Inactive'];
  }

  /// Get user roles options
  static List<String> getUserRoles() {
    return [
      'Select the role',
      'Administrator',
      'Project Manager',
      'Member',
      'Senior Developer',
      'Junior Developer',
      'UI/UX Designer',
      'QA Engineer',
      'DevOps Engineer',
      'Business Analyst',
    ];
  }

  /// Get services for user dropdown
  static List<String> getUserServices() {
    return [
      'Select the service',
      'IT Department',
      'Human Resources',
      'Finance',
      'Marketing',
      'Operations',
      'Sales',
      'Customer Support',
      'Research & Development',
      'Legal',
      'Procurement',
    ];
  }

  // ============================================================
  // CORE DATA STORAGE (Using only provided data)
  // ============================================================

  /// Master data source - only contains data you provided
  static final Map<String, dynamic> _data = {
    // Project-related data
    'projects': {
      'One': {
        'name': 'Project One',
        'head': 'Jane Doe',
        'modules': ['Module A', 'Module B', 'Module C'],
      },
      'Two': {
        'name': 'Project Two',
        'head': 'Jane Smith',
        'modules': ['Module D', 'Module E'],
      },
      'Three': {
        'name': 'Project Three',
        'head': 'Robert Johnson',
        'modules': ['Module F', 'Module G', 'Module H'],
      },
    },

    // Module-related data
    'modules': {
      'Module A': {
        'tasks': ['Task 1', 'Task 2'],
        'status': 'In Progress',
      },
      'Module B': {
        'tasks': ['Task 3', 'Task 4', 'Task 5'],
        'status': 'Planned',
      },
      'Module C': {
        'tasks': ['Task 6'],
        'status': 'Completed',
      },
      'Module D': {
        'tasks': ['Task 7', 'Task 8'],
        'status': 'In Progress',
      },
      'Module E': {
        'tasks': ['Task 9'],
        'status': 'On Hold',
      },
      'Module F': {
        'tasks': ['Task 10', 'Task 11'],
        'status': 'Planned',
      },
      'Module G': {
        'tasks': ['Task 12'],
        'status': 'Completed',
      },
      'Module H': {
        'tasks': ['Task 13', 'Task 14', 'Task 15'],
        'status': 'In Progress',
      },
    },

    // Section-related data
    'sections': {
      'One': {
        'categories': ['Category A', 'Category B'],
      },
      'Two': {
        'categories': ['Category C', 'Category D', 'Category E'],
      },
      'Three': {
        'categories': ['Category F'],
      },
    },

    // Category-related data
    'categories': {
      'Category A': {
        'elements': ['Element 1', 'Element 2'],
        'price': 10000.0,
      },
      'Category B': {
        'elements': ['Element 3', 'Element 4', 'Element 5'],
        'price': 15000.0,
      },
      'Category C': {
        'elements': ['Element 6'],
        'price': 20000.0,
      },
      'Category D': {
        'elements': ['Element 7', 'Element 8'],
        'price': 25000.0,
      },
      'Category E': {
        'elements': ['Element 9'],
        'price': 30000.0,
      },
      'Category F': {
        'elements': ['Element 10', 'Element 11'],
        'price': 35000.0,
      },
    },

    // Element data
    'elements': {
      'Element 1': {'price': 10000.0, 'unit': 'piece'},
      'Element 2': {'price': 12000.0, 'unit': 'piece'},
      'Element 3': {'price': 15000.0, 'unit': 'piece'},
      'Element 4': {'price': 18000.0, 'unit': 'piece'},
      'Element 5': {'price': 20000.0, 'unit': 'piece'},
      'Element 6': {'price': 22000.0, 'unit': 'piece'},
      'Element 7': {'price': 25000.0, 'unit': 'piece'},
      'Element 8': {'price': 28000.0, 'unit': 'piece'},
      'Element 9': {'price': 30000.0, 'unit': 'piece'},
      'Element 10': {'price': 32000.0, 'unit': 'piece'},
      'Element 11': {'price': 35000.0, 'unit': 'piece'},
    },

    // Simple lists
    'heads': ['John Doe', 'Jane Smith', 'Robert Johnson'],

    // Status options
    'statuses': {
      'project': ['Planned', 'In Progress', 'Completed', 'On Hold'],
      'module': ['Planned', 'In Progress', 'Completed', 'On Hold'],
      'task': ['En attente', 'En cours', 'Terminé'],
    },
  };

  // ============================================================
  // PROJECT-RELATED METHODS
  // ============================================================

  /// Get list of all projects with "Select" option
  static List<String> getProjects() {
    return ['Select the project', ..._data['projects'].keys.toList()];
  }

  /// Get project head for a specific project
  static String getProjectHead(String project) {
    return _data['projects'][project]?['head'] ?? '';
  }

  /// Get modules for a project
  static List<String> getModulesForProject(String project) {
    if (project == 'Select the project') return ['Select the module'];
    final modules = _data['projects'][project]?['modules'] ?? [];
    return ['Select the module', ...modules];
  }

  // ============================================================
  // MODULE-RELATED METHODS
  // ============================================================

  /// Get tasks for a module
  static List<String> getTasksForModule(String module) {
    if (module == 'Select the module') return ['Select the task'];
    final tasks = _data['modules'][module]?['tasks'] ?? [];
    return ['Select the task', ...tasks];
  }

  // ============================================================
  // RESOURCE-RELATED METHODS
  // ============================================================

  /// Get list of all sections
  static List<String> getSections() {
    return ['Select the section', ..._data['sections'].keys.toList()];
  }

  /// Get categories for a section
  static List<String> getCategoriesForSection(String section) {
    if (section == 'Select the section') return ['Select the category'];
    final categories = _data['sections'][section]?['categories'] ?? [];
    return ['Select the category', ...categories];
  }

  /// Get elements for a category
  static List<String> getElementsForCategory(String category) {
    if (category == 'Select the category') return ['Select the element'];
    final elements = _data['categories'][category]?['elements'] ?? [];
    return ['Select the element', ...elements];
  }

  /// Get price for an element
  static double getPriceForElement(String element) {
    return _data['elements'][element]?['price'] ?? 0.0;
  }

  /// Get unit for an element
  static String getElementUnit(String element) {
    return _data['elements'][element]?['unit'] ?? 'piece';
  }

  // ============================================================
  // SIMPLE LISTS (No Dependencies)
  // ============================================================

  /// Get list of project heads
  static List<String> getHeads() {
    return ['Select the head of project', ..._data['heads']];
  }

  /// Get project status options
  static List<String> getProjectStatuses() {
    return ['Select the status of project', ..._data['statuses']['project']];
  }

  /// Get module status options
  static List<String> getModuleStatuses() {
    return ['Select the status of module', ..._data['statuses']['module']];
  }

  /// Get task status options
  static List<String> getTaskStatuses() {
    return ['Select the status of task', ..._data['statuses']['task']];
  }

  // ============================================================
  // SERVICE-RELATED METHODS (Using only provided service data)
  // ============================================================

  /// Get status options for services (using generic statuses)
  static List<String> getServiceStatuses() {
    // Using project statuses as default for services (as per your data)
    return ['Select the status', ..._data['statuses']['project']];
  }

  /// Get sample services data - ONLY with fields from your data
  static List<Map<String, dynamic>> getServices() {
    return [
      {
        'id': '1',
        'title': 'IT Department',
        'status': 'Active',
        'created': '15/01/2024',
      },
      {
        'id': '2',
        'title': 'Human Resources',
        'status': 'Active',
        'created': '10/02/2024',
      },
      {
        'id': '3',
        'title': 'Finance',
        'status': 'Active',
        'created': '05/03/2024',
      },
      {
        'id': '4',
        'title': 'Marketing',
        'status': 'Inactive',
        'created': '20/03/2024',
      },
      {
        'id': '5',
        'title': 'Operations',
        'status': 'Active',
        'created': '25/03/2024',
      },
    ];
  }

  /// Filter services - simple version with only provided fields
  static List<Map<String, dynamic>> filterServices({
    String? searchQuery,
    String? statusFilter,
  }) {
    List<Map<String, dynamic>> services = getServices();

    // Apply search filter (only on title - that's all we have)
    if (searchQuery != null && searchQuery.isNotEmpty) {
      services = services.where((service) {
        return service['title'].toLowerCase().contains(
          searchQuery.toLowerCase(),
        );
      }).toList();
    }

    // Apply status filter
    if (statusFilter != null && statusFilter != 'All') {
      services = services
          .where((service) => service['status'] == statusFilter)
          .toList();
    }

    return services;
  }

  // ============================================================
  // ROLE-RELATED METHODS (Using only provided role data)
  // ============================================================

  /// Get role status options (using generic statuses)
  static List<String> getRoleStatuses() {
    // Using project statuses as default for roles (as per your data)
    return ['Select the status', ..._data['statuses']['project']];
  }

  /// Get sample roles data - ONLY with fields from your data
  static List<Map<String, dynamic>> getRoles() {
    return [
      {'id': '1', 'title': 'CEO', 'priority': 1, 'created': '15/01/2024'},
      {'id': '2', 'title': 'CTO', 'priority': 2, 'created': '10/02/2024'},
      {
        'id': '3',
        'title': 'Project Manager',
        'priority': 3,
        'created': '05/03/2024',
      },
      {'id': '4', 'title': 'Team Lead', 'priority': 4, 'created': '20/03/2024'},
      {
        'id': '5',
        'title': 'Senior Developer',
        'priority': 5,
        'created': '25/03/2024',
      },
    ];
  }

  /// Filter roles - simple version with only provided fields
  static List<Map<String, dynamic>> filterRoles({
    String? searchQuery,
    String? statusFilter,
  }) {
    List<Map<String, dynamic>> roles = getRoles();

    // Apply search filter (only on title - that's all we have)
    if (searchQuery != null && searchQuery.isNotEmpty) {
      roles = roles.where((role) {
        return role['title'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return roles;
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================

  Color getRoleColor(String role) {
    switch (role) {
      case 'Administrator':
        return AppColors.googleRed;
      case 'Project Manager':
        return AppColors.warning;
      case 'Member':
        return AppColors.primary;
      default:
        return AppColors.darkerGrey;
    }
  }

  /// Get color based on status (visual helper)
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
      case 'En cours':
      case 'In Progress':
        return AppColors.projectInProgress;
      case 'Inactive':
      case 'En attente':
      case 'Planned':
        return AppColors.projectPlanning;
      case 'Completed':
      case 'Terminé':
        return AppColors.projectCompleted;
      case 'On Hold':
        return AppColors.projectOnHold;
      default:
        return AppColors.darkGrey;
    }
  }

  /// Get color based on priority (visual helper)
  static Color getPriorityColor(int priority) {
    if (priority == 1) return AppColors.error;
    if (priority == 2) return AppColors.warning;
    if (priority == 3) return AppColors.projectOnHold;
    if (priority <= 5) return AppColors.success;
    return AppColors.primaryLight;
  }

  Color getServiceColor(String title) {
    final hash = title.hashCode;
    final colors = [
      AppColors.primaryLight,
      AppColors.success,
      AppColors.warning,
      AppColors.accent,
      AppColors.projectPlanning,
      AppColors.projectInProgress,
    ];
    return colors[hash % colors.length];
  }

  /// Get random color for UI elements (visual helper)
  static Color getRandomColor(String text) {
    final colors = [
      AppColors.primaryLight,
      AppColors.success,
      AppColors.warning,
      AppColors.accent,
      AppColors.projectPlanning,
      AppColors.projectInProgress,
    ];
    return colors[text.hashCode % colors.length];
  }

  static getProgressColor(double progress) {
    if (progress < 30) return AppColors.error;
    if (progress < 70) return AppColors.warning;
    return AppColors.success;
  }

  static Color getPriorityTaskColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.darkGrey;
    }
  }
}
