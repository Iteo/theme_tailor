import 'package:example/app_colors.dart';
import 'package:example/diagnosticable_lib.dart';

part 'ignore_example.tailor.dart';

// ignore_for_file: unused_field

@Tailor(generateStaticGetters: false)
class _$IgnoreExample {
  static List<Color> background = [AppColors.white, Colors.grey.shade900];

  @ignore
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @ignore
  static List<int> numbers = [1, 2, 3];
}
