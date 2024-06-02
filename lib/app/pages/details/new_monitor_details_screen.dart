import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_plans/core/utils/assets_manager.dart';
import 'package:smart_plans/core/utils/color_manager.dart';
import 'package:smart_plans/core/utils/styles_manager.dart';

class NewMonitorDetailsScreen extends StatelessWidget {
  const NewMonitorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitor Details'),
      ),
      backgroundColor: ColorManager.fwhite,
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
            return ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                // تحويل العدد الصحيح إلى DateTime
                int timestamp = data['timestamp'];
                DateTime dateTime =
                    DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

                // تنسيق التاريخ
                String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

                return MonitorDetailsWidget(
                  image: data['url'],
                  text: data['class'],
                  timeStamp: formattedDate,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 10.0,
              ),
              itemCount: documents.length,
            );
          }),
    );
  }
}

class MonitorDetailsWidget extends StatelessWidget {
  const MonitorDetailsWidget({
    super.key,
    required this.image,
    required this.text,
    required this.timeStamp,
  });

  final String image;
  final String text;
  final String timeStamp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.dialog(
        DetailsDialog(
          image: image,
          text: text,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: ColorManager.drawerColor,
            borderRadius: BorderRadius.circular(14.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 60,
              height: 60.0,
              decoration: BoxDecoration(
                  color: ColorManager.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(6.0)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  text,
                  style: StylesManager.titleBoldTextStyle(size: 18.0),
                ),
                trailing: TextButton.icon(
                    onPressed: null,
                    label: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14.0,
                    ),
                    icon: Text(
                      timeStamp,
                      style: TextStyle(color: ColorManager.appBarColor),
                    )),
                // subtitle: Text(
                //   index.isEven ////////////////////////////////////////////////////////////
                //       ? 'Inscet: Caterpillars' // ${index}'
                //       : 'Disease: Fusarium wilt' // ${index}',
                //   ,
                //   maxLines: 3,
                //   style: StylesManager.titleNormalTextStyle(size: 16.0),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsDialog extends StatelessWidget {
  const DetailsDialog({
    super.key, required this.image, required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: Container(
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        image,
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: CircleAvatar(
                          backgroundColor: ColorManager.white,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close,
                                color: ColorManager.error,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                              color: ColorManager.primary, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        // Text(
                        //   'Plant type: Basil plant',
                        //   style: TextStyle(
                        //       color: ColorManager.primary, fontSize: 16.0),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
