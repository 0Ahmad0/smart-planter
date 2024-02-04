import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/widgets/add_plant_item_list.dart';
import '/core/utils/app_string.dart';
import '/core/utils/values_manager.dart';

import '../controller/provider/plant_provider.dart';
import '../widgets/add_plant_item_grid.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addPlant),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
              icon: Icon(isGrid ? Icons.grid_view_rounded : Icons.menu))
        ],
      ),
      body: isGrid
          ? GridView.builder(
        itemCount: context.read<PlanetModelProvider>().planetModelsApi.planetModels.length,
              padding: const EdgeInsets.all(AppPadding.p10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
                  crossAxisSpacing: AppSize.s10,
                  mainAxisSpacing: AppSize.s10),
              itemBuilder: (context, index) => AddPlantItemGrid(planetModel: context.read<PlanetModelProvider>().planetModelsApi.planetModels[index],),
            )
          : ListView.builder(
        itemCount:   context.read<PlanetModelProvider>().planetModelsApi.planetModels.length,
              padding: const EdgeInsets.all(AppPadding.p10),
              itemBuilder: (context, index) => AddPlantItemList(planetModel: context.read<PlanetModelProvider>().planetModelsApi.planetModels[index],),
            ),
    );
  }
}
