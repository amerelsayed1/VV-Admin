import 'package:flutter/material.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';

class IconWithTextRowWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final bool bold;
  const IconWithTextRowWidget({Key? key,  required this.text, required this.icon, this.iconColor, this.textColor,  this.bold = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: iconColor ?? Theme.of(context).primaryColor.withValues(alpha:.30)),
         const SizedBox(width: Dimensions.paddingSizeSmall,),

        Expanded(
          child: Text(text, maxLines: 2, overflow : TextOverflow.ellipsis,
               style: bold? titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault) : titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color)),
        ),
      ],
    );
  }
}
