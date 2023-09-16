import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/models/favorites/favorites_model.dart';

import '../../layout/cubit/cubit.dart';
import '../styles/colors.dart';

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefIcon,
  Function? Function()? onTapFunction,
  IconData? sufx,
  Function? Function(String? value)? onChange,
  bool secureText = false,
  Function? Function()? onTapSuff,
  String? Function(String?)? onSubmit
}) =>
    TextFormField(

      validator: validate,

      keyboardType: type,
      controller: controller,
      onTap: onTapFunction,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      obscureText: secureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefIcon,
        ),
        labelText: label,
        suffixIcon: sufx != null
            ? IconButton(
          icon: Icon(sufx),
          onPressed: onTapSuff,
        )
            : null,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function? function(),
  required String buttonName,
}) =>
  Container(
    width: width,
    child: MaterialButton(
    onPressed: function,
    child: Text(
    isUpperCase ? buttonName.toUpperCase() : buttonName,
    style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    ),
    decoration: BoxDecoration(
    borderRadius: BorderRadiusDirectional.circular(radius),
    color: background,
    ),
  );

Widget defaultTextButton({
required Function? function(),
required String text
})=> TextButton(
onPressed: function,
child: Text(
'${text.toUpperCase()}'
)
);

void showToast(String? message) {
  Fluttertoast.showToast(
    msg: message ?? "",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget buildListItem(model, context, {isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
              if(model?.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all( 3.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white
                    ),
                  ),
                ),
            ]
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.price.toString()}',
                    style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        color: defaultColor
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if( model?.discount != 0 && model?.discount != null)
                    Text(
                      '${model?.oldPrice.toString()}',
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                        ShopAppCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:  ShopAppCubit.get(context).favorites[model?.id] == true
                            ? defaultColor
                            : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  ),
);

