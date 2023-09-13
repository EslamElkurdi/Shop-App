import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

