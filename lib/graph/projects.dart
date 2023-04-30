import 'package:classes/graph.dart';

class Project {
  final int capacity;
  final String label;

  Project(this.capacity, this.label);

  @override
  String toString() {
    return 'Project $label';
  }
}

class Student {
  final List<Project> acceptableProjects;
  final String label;

  Student(this.acceptableProjects, this.label);
  
  @override
  String toString() {
    return 'Student $label';
  }
}


Map<Student, Project> recoverMap(Set<Edge<Student, Project>> edges) {
  final map = <Student, Project>{};
  for (var edge in edges) {
    map[edge.source.entry] = edge.range.entry;
  }

  return map;
}

// Problem 1: We have students with project preferences, and projects with quotas.
Map<Student, Project> problem1(List<Student> students, List<Project> projects) {
  final leftVertices = students.map((student) => LeftVertex<Student, Project>(student)).toList();
  // left vertices are the students
  BipartileGraph<Student, Project> bipartileGraph = BipartileGraph(leftVertices);

  // right vertices are the projects, counted with multiplicity.
  final rightVertices = <RightVertex<Student, Project>>[];

  for (var i = 0; i < projects.length; i++) {
    final project = projects[i];
    final relevantVertices = leftVertices.where(
      (vertex) => vertex.entry.acceptableProjects.contains(project)
    );

    // find the subset of students who find this project acceptable and ensure there's an edge between them!
    for (var j = 0; j < project.capacity; j++) {
      final rightVertex = RightVertex<Student, Project>(project);
      rightVertices.add(rightVertex);
      for (final leftVertex in relevantVertices) {
        leftVertex.addUndirectedEdge(rightVertex);
      }
    }
  }

  return recoverMap(bipartileGraph.match());
}

void main(List<String> args) {
  final projectA = Project(2, "A");
  final projectB = Project(2, "B");
  final projectC = Project(2, "C");
  final projects = [projectA, projectB, projectC];

  final student1 = Student([projectA, projectC], "1");
  final student2 = Student([projectB], "2");
  final student3 = Student([projectB], "3");
  final student4 = Student([projectB], "4");
  final student5 = Student([projectA, projectB, projectC], "5");
  final students = [student1, student2, student3, student4, student5];

  print(problem1(students, projects));
}

// Problem 2:
// We have students with project preferences, and projects with upper and lower quotas.


// Problem 3:
// We have students with project preferences, projects with quotas, and a subset of the projects have a quota

class Lecturer {
  final Project project;

  final int minQuota;
  final int maxQuota;

  Lecturer(this.project, this.maxQuota, [this.minQuota = 0]);
}

// Problem 4:
// We have students with project preferences, projects <-> lecturers, and quotas for both projects and lecturers


// Problem 5:
// We have students with project preferences, projects <-> lecturers, and quotas for both projects and lecturers, along with a lower quota for lecturers
