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
      backgroundColor: ColorManager.white,
      body: ListView.separated(
        padding: const EdgeInsets.all(12.0),
        itemBuilder: (context, index) => MonitorDetailsWidget(
          index: index,
        ),
        separatorBuilder: (_, __) => const SizedBox(
          height: 10.0,
        ),
        itemCount: 15,
      ),
    );
  }
}

class MonitorDetailsWidget extends StatelessWidget {
  const MonitorDetailsWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.dialog(
        DetailsDialog(),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: ColorManager.primary.withOpacity(.2),
            borderRadius: BorderRadius.circular(14.0)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100.0,
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  index.isEven
                      ? AssetsManager.insectIconIMG
                      : AssetsManager.plantGrassIconIMG,
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'This IS ${index}',
                  style: StylesManager.titleBoldTextStyle(size: 20.0),
                ),
                trailing: TextButton.icon(
                    onPressed: null,
                    label: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 14.0,
                    ),
                    icon: Text(
                      '${DateFormat.yMd().format(DateTime.now())}',
                      style: TextStyle(color: ColorManager.primary),
                    )),
                subtitle: Text(
                  'Here IS A Ma',
                  maxLines: 3,
                  style: StylesManager.titleNormalTextStyle(size: 16.0),
                ),
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
    super.key,
  });

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
                        'https://th.bing.com/th/id/OIP.ENKNxlxJIQMHc3d6lkUKFAHaFj?rs=1&pid=ImgDetMain',
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
                          'Inscet: Caterpillars',
                          style: TextStyle(
                              color: ColorManager.primary, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Plant type: Basil plant',
                          style: TextStyle(
                              color: ColorManager.primary, fontSize: 16.0),
                        ),
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
