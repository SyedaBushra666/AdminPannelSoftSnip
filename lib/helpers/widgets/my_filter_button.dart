import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/theme/theme_customizer.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_button.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';



class MyFilterButton extends StatelessWidget {
  const MyFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(5.0),
      child: MyButton.medium(
              padding: EdgeInsets.fromLTRB(20, 4, 20,5),
              onPressed: (){
                 ThemeCustomizer.openRightBar(true);
              },
              
              backgroundColor: Colors.blue,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText("Filters",fontSize: 16,color: Colors.white,), // shows PDT / AWST
                  
                ],
              ),
            ),
    );
    


}
}


