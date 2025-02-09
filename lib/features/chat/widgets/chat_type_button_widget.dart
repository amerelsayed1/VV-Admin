import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/chat/controllers/chat_controller.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/utill/styles.dart';


class ChatTypeButtonWidget extends StatelessWidget {
  final String? text;
  final int index;
  const ChatTypeButtonWidget({Key? key, required this.text, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: (){
        Provider.of<ChatController>(context, listen: false).setUserTypeIndex(context, index);
      },
      child: Consumer<ChatController>(builder: (context, chat,_) {
        return Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(text!, style:
            robotoRegular.copyWith(color: chat.userTypeIndex == index ?
            ColorResources.getPrimary(context) : ColorResources.getTextColor(context))),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),

            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
                width: chat.userTypeIndex == index ? 80 : 0,
                height: chat.userTypeIndex == index ? 2 : 2,
                )
          ],
        );
      },
      ),
    );
  }
}