
import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import '../widget/main_drawer.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';
  final bool fromOnBoarding;

  const FiltersScreen({ this.fromOnBoarding=false});



  Widget buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
      BuildContext ctx,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      inactiveTrackColor:Provider.of<ThemeProvider>(ctx,listen: true).tm==ThemeMode.light
          ? null
     : Colors.black,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverAppBar(

            pinned: false,
            title: fromOnBoarding? null:Text('Your Filters'),
            backgroundColor: fromOnBoarding?Theme.of(context).canvasColor:Theme.of(context).primaryColor,
            elevation: fromOnBoarding?0 :5,
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,
              ),
            ),


                    buildSwitchListTile(
                     'Gluten-free',
                    'Only include gluten-free meals.',
                    currentFilters['gluten'],
                        (newValue) {

                      currentFilters['gluten'] = newValue;
                      Provider.of<MealProvider>(context, listen: false).setFilters();
                    },
                    context,
                  ),

                    buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals.',
                    currentFilters['lactose'],
                        (newValue) {

                      currentFilters['lactose'] = newValue;

                      Provider.of<MealProvider>(context, listen: false).setFilters();

                    },
                    context,
                  ),
                  buildSwitchListTile(
                    'Vegetarian',
                    'Only include vegetarian meals.',
                    currentFilters['vegetarian'],
                        (newValue) {

                      currentFilters['vegetarian'] = newValue;

                      Provider.of<MealProvider>(context, listen: false).setFilters();

                    }, context,
                  ),
                  buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals.',
                    currentFilters['vegan'],

                        (newValue) {

                      currentFilters['vegan'] = newValue;

                      Provider.of<MealProvider>(context, listen: false).setFilters();

                    }, context,
                  ),  SizedBox(height: fromOnBoarding? 80:0),
                ],
              ),
            ),


          ],


      ),
      drawer:fromOnBoarding?null: MainDrawer(),
    );
  }
}
