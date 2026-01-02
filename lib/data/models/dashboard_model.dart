import 'project_model.dart';

class DashboardStats {
  final int totalProjects;
  final int activeProjects;
  final int totalUsers;
  final int tasksThisWeek;
  final double totalBudget;
  final double spentBudget;
  final List<ProjectStatusCount> projectStatusCounts;
  final List<MonthlyCost> monthlyCosts;

  DashboardStats({
    required this.totalProjects,
    required this.activeProjects,
    required this.totalUsers,
    required this.tasksThisWeek,
    required this.totalBudget,
    required this.spentBudget,
    required this.projectStatusCounts,
    required this.monthlyCosts,
  });
}

class ProjectStatusCount {
  final ProjectStatus status;
  final int count;

  ProjectStatusCount({required this.status, required this.count});
}

class MonthlyCost {
  final String month;
  final double estimated;
  final double actual;

  MonthlyCost({
    required this.month,
    required this.estimated,
    required this.actual,
  });
}

class ChartData {
  final String month;
  final double value;

  ChartData(this.month, this.value);
}
