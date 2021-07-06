import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';

import '../widget/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
class ThemeScreen extends StatelessWidget {

  static const routeName = '/themes';
final bool fromOnBoarding;

  const ThemeScreen({ this.fromOnBoarding=false});


  Widget buildRadioListTile(
      ThemeMode themeVal,
      String txt,
      IconData icon,
      BuildContext ctx,
      ) {
    return RadioListTile(
      secondary: Icon(icon, color: Theme.of(ctx).buttonColor),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx,listen: true).tm,
      onChanged: (newThemeVal)=>
      Provider.of<ThemeProvider>(ctx,listen: false).themeModeChange(newThemeVal),
      title: Text(txt),

    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;

    return Scaffold(
      appBar:fromOnBoarding?
          AppBar(backgroundColor: Theme.of(context).canvasColor,elevation: 0,)
      :AppBar(
        title: Text('Your Themes'),),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your themes selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(20),
                  child: Text('Choose your themes mode',
                  style: Theme.of(context).textTheme.headline6,
                ),),
                buildRadioListTile(ThemeMode.system,"System Default Theme",null, context),
                buildRadioListTile(ThemeMode.light,"Light Theme",Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark,"Dark Theme",Icons.nights_stay_outlined, context),
                buildListTile(context,"primary"),
                buildListTile(context,"accent"),
                SizedBox(height:fromOnBoarding? 80:0,),

              ],

            ),
          ),
        ],

      ),
      drawer:fromOnBoarding?null:MainDrawer(),


    );
  }
  ListTile  buildListTile(BuildContext context, txt ) {
    var primaryColor = Provider.of<ThemeProvider>(context, listen: true).primaryColor;
    var accentColor =Provider.of<ThemeProvider>(context,listen: true).accentColor;
    return ListTile(
      title: Text("choose your $txt color",
        style:Theme.of(context).textTheme.headline6 ,),
      trailing: CircleAvatar(
        backgroundColor: txt=="primary"?primaryColor:accentColor,
      ),
      onTap: (){
        showDialog(context: context,
            builder:(BuildContext ctx){
          return AlertDialog(
            elevation: 4,
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: txt =="primary"?
                Provider.of<ThemeProvider>(context, listen: true).primaryColor
                    :Provider.of<ThemeProvider>(context, listen: true).accentColor,
                onColorChanged: (newColor)=>
                Provider.of<ThemeProvider>(context, listen: false).onChanged(newColor, txt =="primary"?1 :2),
                colorPickerWidth: 300.0,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),

          );

            }
        );
      },
    );
  }
}
