import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vv_admin/features/dashboard/screens/dashboard_screen.dart';
import 'package:vv_admin/localization/language_constrants.dart';
import 'package:vv_admin/features/chat/controllers/chat_controller.dart';
import 'package:vv_admin/utill/color_resources.dart';
import 'package:vv_admin/utill/dimensions.dart';
import 'package:vv_admin/common/basewidgets/custom_app_bar_widget.dart';
import 'package:vv_admin/common/basewidgets/custom_loader_widget.dart';
import 'package:vv_admin/common/basewidgets/no_data_screen.dart';
import 'package:vv_admin/common/basewidgets/paginated_list_view_widget.dart';
import 'package:vv_admin/features/chat/widgets/chat_card_widget.dart';
import 'package:vv_admin/features/chat/widgets/chat_header_widget.dart';

class InboxScreen extends StatefulWidget {
  final bool isBackButtonExist;
  final bool fromNotification;
  final int initIndex;
  const InboxScreen({Key? key, this.isBackButtonExist = true, this.fromNotification = false, this.initIndex = 0}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final ScrollController _scrollController = ScrollController();

@override
  void initState() {
    if(widget.fromNotification) {
      Provider.of<ChatController>(context, listen: false).setUserTypeIndex(context, widget.initIndex, isUpdate: false);
    }

    Provider.of<ChatController>(context, listen: false).getChatList(context, 1);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        if(widget.fromNotification) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()));
        } else {
          Navigator.of(context).pop();
        }
        return;
      },
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        appBar: CustomAppBarWidget(
          title: getTranslated('inbox', context),
          onBackPressed: () {
            if(widget.fromNotification) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashboardScreen()));
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        body: Consumer<ChatController>(builder: (context, chatProvider, child) {

          return Column(children: [

            Container(padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall),
                child:  const ChatHeaderWidget()),

            chatProvider.chatModel != null? (chatProvider.chatModel!.chat != null && chatProvider.chatModel!.chat!.isNotEmpty)?
            Expanded(
              child:  RefreshIndicator(
                onRefresh: () async {
                  chatProvider.getChatList(context,1);
                },
                child: Scrollbar(child: SingleChildScrollView(controller: _scrollController,
                    child: Center(child: SizedBox(width: 1170,
                        child:  Padding(padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                          child: PaginatedListViewWidget(
                            reverse: false,
                            scrollController: _scrollController,
                            onPaginate: (int? offset) => chatProvider.getChatList(context,offset!, reload: false),
                            totalSize: chatProvider.chatModel!.totalSize,
                            offset: int.parse(chatProvider.chatModel!.offset!),
                            enabledPagination: chatProvider.chatModel == null,
                            itemView: ListView.builder(
                              itemCount: chatProvider.chatModel!.chat!.length,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return  ChatCardWidget(chat: chatProvider.chatModel!.chat![index]);
                              },
                            ),
                          ),
                        ))))),
              ),
            ) :const Expanded(child: NoDataScreen()): Expanded(child: CustomLoaderWidget(height: MediaQuery.of(context).size.height-500)),

          ]);
        },
        ),
      ),
    );
  }
}



