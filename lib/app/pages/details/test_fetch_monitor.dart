

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/color_manager.dart';
import '../../widgets/gradient_container_widget.dart';

class TestMonitorScreen extends StatelessWidget {
  const TestMonitorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainerWidget(
      colors: ColorManager.gradientColors,
      child: Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('detections').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['class']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('File Name: ${data['fileName']}'),
                      Text('Timestamp: ${data['timestamp']}'),
                      Image.network(data['url']),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
