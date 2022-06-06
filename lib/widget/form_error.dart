import 'package:flutter/material.dart';

class FormErrorNumTel extends StatelessWidget {
  final List<String>? errors_num_tel;
  const FormErrorNumTel({
    Key? key,
    @required this.errors_num_tel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors_num_tel!.length, (index) => formErrorText(error: errors_num_tel![index])),
    );
  }

Text formErrorText({String? error}) {
    return Text(error!);
  }

}


class FormError extends StatelessWidget {
  final List<String>? errors;
  const FormError({
    Key? key,
    @required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors!.length, (index) => formErrorText(error: errors![index])),
    );
  }

Text formErrorText({String? error}) {
    return Text(error!);
  }

}

class FormErrorConformPwd extends StatelessWidget {
  final List<String>? errors_confirm_pwd;
  const FormErrorConformPwd({
    Key? key,
    @required this.errors_confirm_pwd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors_confirm_pwd!.length, (index) => formErrorText(error: errors_confirm_pwd![index])),
    );
  }

Text formErrorText({String? error}) {
    return Text(error!);
  }

}

