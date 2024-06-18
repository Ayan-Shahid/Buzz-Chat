import 'package:buzzchat/components/screens/attachment/document/browse/list_item.dart';

import 'package:flutter/material.dart';

final List<DocumentDataModel> documents = [
  DocumentDataModel(
      name: "Project Proposal",
      size: 128,
      type: DocumentType.doc,
      date: DateTime.now().subtract(Duration(days: 10))),
  DocumentDataModel(
      name: "Research Paper",
      size: 256,
      type: DocumentType.pdf,
      date: DateTime.now().subtract(Duration(days: 20))),
  DocumentDataModel(
      name: "Course Syllabus",
      size: 64,
      type: DocumentType.docx,
      date: DateTime.now().subtract(Duration(days: 30))),
  DocumentDataModel(
      name: "Meeting Notes",
      size: 16,
      type: DocumentType.txt,
      date: DateTime.now().subtract(Duration(days: 5))),
  DocumentDataModel(
      name: "Final Examination",
      size: 128,
      type: DocumentType.pdf,
      date: DateTime.now().subtract(Duration(days: 45))),
  DocumentDataModel(
      name: "Lecture Slides",
      size: 192,
      type: DocumentType.ppt,
      date: DateTime.now().subtract(Duration(days: 15))),
  DocumentDataModel(
      name: "Lab Manual",
      size: 80,
      type: DocumentType.pdf,
      date: DateTime.now().subtract(Duration(days: 25))),
  DocumentDataModel(
      name: "Assignment 1",
      size: 40,
      type: DocumentType.docx,
      date: DateTime.now().subtract(Duration(days: 7))),
  DocumentDataModel(
      name: "Assignment 2",
      size: 44,
      type: DocumentType.docx,
      date: DateTime.now().subtract(Duration(days: 7))),
];

class DocumentList extends StatelessWidget {
  const DocumentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            documents.length, (index) => ListItem(data: documents[index])));
  }
}
