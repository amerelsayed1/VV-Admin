
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vv_admin/utill/dimensions.dart';


class CustomLoaderWidget extends StatelessWidget {
  final double height;
  const CustomLoaderWidget({Key? key, this.height = 1200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox( height: height,
      child: Stack( children: [
          Align( alignment: Alignment.center,
            child: Container(
                height: 80,width: 80, decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),

                child: const Center(
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 50.0,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
