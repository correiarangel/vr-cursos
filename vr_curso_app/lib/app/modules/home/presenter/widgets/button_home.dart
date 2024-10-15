import 'package:flutter/material.dart';
import 'package:vr_curso_app/app/modules/home/presenter/widgets/container_for_button.dart';

class ButtonMainHome extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const ButtonMainHome({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 16, right: 4, top: 16),
        child: InkWell(
          onTap: onTap,
          child: ContainerForButton(
              inputs: InputContainer(
            text: text,
            icon: icon,
            height: 132,
            width: 132,
          )),
        ));
  }
}
