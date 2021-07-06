
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import '../dummy_data.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,),
    );
  }

  Widget buildContainer(Widget child ) {

   bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var dw=MediaQuery.of(context).size.width;
    var dh=MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      height: isLandScape?dh*0.5:dh*0.25,
      width: isLandScape?(dw*0.5-30):dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;
    bool isLandScape=MediaQuery.of(context).orientation==Orientation.landscape;
    var liSteps=ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${(index + 1)}'),
            ),
            title: Text(
              selectedMeal.steps[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider()
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );
    var liIngredient= ListView.builder(
      padding: EdgeInsets.all(0),
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            selectedMeal.ingredients[index],
            style: TextStyle(
              color: useWhiteForeground(accentColor)
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('${selectedMeal.title}'),
              background: Hero(tag:mealId,
                child: InteractiveViewer(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/holder.png'),
                    image: NetworkImage(
                        selectedMeal.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ) ,
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([

            if(isLandScape)
              Row(children: [
                Column(
                  children: [
                    buildSectionTitle(context, 'Ingredients'),
                    buildContainer(liIngredient),

                  ],
                ),
                Column(
                  children: [
                    buildSectionTitle(context, 'Steps'),
                    buildContainer(liSteps),

                  ],
                )
              ],),
            if(!isLandScape) buildSectionTitle(context, 'Ingredients'),
            if(!isLandScape) buildContainer(liIngredient),
            if(!isLandScape) buildSectionTitle(context, 'Steps'),
            if(!isLandScape)  buildContainer(liSteps),

          ],
          ),
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Provider.of<MealProvider>(context, listen: true).isFavorite(mealId)
              ? Icons.star
              : Icons.star_border,
        ),
        onPressed: () => Provider.of<MealProvider>(context, listen: false)
            .toggleFavorite(mealId),
      ),
    );
  }
}

