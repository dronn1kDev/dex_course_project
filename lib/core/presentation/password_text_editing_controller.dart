import 'package:dex_course_temp/core/presentation/app_text_field/app_text_editing_controller.dart';
import 'package:reactive_variables/reactive_variables.dart';

class PassTextEditingController extends AppTextEditingController {
  PassTextEditingController({super.text, bool isTextHidden = true})
      : isTextHidden = isTextHidden.rv;

  final Rv<bool> isTextHidden;

  void showPassword() => isTextHidden(false);
  void hidePassword() => isTextHidden(true);
}
