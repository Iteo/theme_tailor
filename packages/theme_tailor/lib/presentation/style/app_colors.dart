import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


abstract class AppColors {
const AppColors({
  required this.additional1,required this.additional1opacity10,required this.additional2,required this.additional3,required this.additional4,required this.additional4opacity10,required this.additional5,required this.additional5opacity10,required this.additional6,required this.additional6opacity10,required this.additional7,required this.additional7opacity10,required this.additional8,required this.additional8opacity10,required this.additional9,required this.additional9opacity10,required this.background,required this.background50,required this.border,required this.border50,required this.buttonTypo,required this.carrefour100,required this.carrefour30,required this.element,required this.error,required this.erroropacity10,required this.makro100,required this.makro30,required this.makroAdditional,required this.overlay,required this.primary,required this.primaryButtonClicked,required this.primaryButtonClickedopacity10,required this.subtypo,required this.tile,required this.typo,
  required this.systemUiOverlayStyle,
});


 // additional
final Color additional1;
final Color additional1opacity10;
final Color additional2;
final Color additional3;
final Color additional4;
final Color additional4opacity10;
final Color additional5;
final Color additional5opacity10;
final Color additional6;
final Color additional6opacity10;
final Color additional7;
final Color additional7opacity10;
final Color additional8;
final Color additional8opacity10;
final Color additional9;
final Color additional9opacity10;

 // elements
final Color background;
final Color background50;
final Color border;
final Color border50;
final Color buttonTypo;
final Color element;
final Color subtypo;
final Color tile;
final Color typo;

 // carrefour
final Color carrefour100;
final Color carrefour30;

 // universal
final Color error;
final Color erroropacity10;
final Color overlay;
final Color primary;
final Color primaryButtonClicked;
final Color primaryButtonClickedopacity10;

 // makro
final Color makro100;
final Color makro30;
final Color makroAdditional;


// System
final SystemUiOverlayStyle systemUiOverlayStyle;


Map<String, Map<String, Color>> get allColors => {
"additional": additionalColors,
"elements": elementsColors,
"carrefour": carrefourColors,
"universal": universalColors,
"makro": makroColors,
};

Map<String, Color> get additionalColors => {
"additional 1 (100)": additional1,
"additional 1 (10)": additional1opacity10,
"additional 2 (100)": additional2,
"additional 3 (100)": additional3,
"additional 4 (100)": additional4,
"additional 4 (10)": additional4opacity10,
"additional 5 (100)": additional5,
"additional 5 (10)": additional5opacity10,
"additional 6 (100)": additional6,
"additional 6 (10)": additional6opacity10,
"additional 7 (100)": additional7,
"additional 7 (10)": additional7opacity10,
"additional 8 (100)": additional8,
"additional 8 (10)": additional8opacity10,
"additional 9 (100)": additional9,
"additional 9 (10)": additional9opacity10,
};

Map<String, Color> get elementsColors => {
"background": background,
"background 50": background50,
"border": border,
"border 50": border50,
"button typo": buttonTypo,
"element": element,
"subtypo": subtypo,
"tile": tile,
"typo": typo,
};

Map<String, Color> get carrefourColors => {
"carrefour-100": carrefour100,
"carrefour-30": carrefour30,
};

Map<String, Color> get universalColors => {
"error (100)": error,
"error (10)": erroropacity10,
"overlay": overlay,
"primary": primary,
"primary button clicked (100)": primaryButtonClicked,
"primary button clicked (10)": primaryButtonClickedopacity10,
};

Map<String, Color> get makroColors => {
"makro-100": makro100,
"makro-30": makro30,
"makro additional": makroAdditional,
};

  }

class LightAppColors extends AppColors {
  const LightAppColors()
      : super(
        additional1: const Color(0xFF98C93C),additional1opacity10: const Color(0x1A98C93C),additional2: const Color(0xFFEC0677),additional3: const Color(0xFF70AE09),additional4: const Color(0xFFF0771F),additional4opacity10: const Color(0x1AF0771F),additional5: const Color(0xFF55B8D8),additional5opacity10: const Color(0x1A55B8D8),additional6: const Color(0xFF25B422),additional6opacity10: const Color(0x1A25B422),additional7: const Color(0xFF5591D8),additional7opacity10: const Color(0x1A5591D8),additional8: const Color(0xFFAE55D8),additional8opacity10: const Color(0x1AAE55D8),additional9: const Color(0xFF22B490),additional9opacity10: const Color(0x1A22B490),background: const Color(0xFFF2F2F2),background50: const Color(0x80F2F2F2),border: const Color(0xFFDADADA),border50: const Color(0x80DADADA),buttonTypo: const Color(0xFF404041),carrefour100: const Color(0xFF314FB9),carrefour30: const Color(0xFF8497D8),element: const Color(0xFFFFFFFF),error: const Color(0xFFEF404A),erroropacity10: const Color(0x1AEF404A),makro100: const Color(0xFF072386),makro30: const Color(0xFFB8C1DF),makroAdditional: const Color(0xFF173C7B),overlay: const Color(0x73000000),primary: const Color(0xFFFFCD00),primaryButtonClicked: const Color(0xFFF6B409),primaryButtonClickedopacity10: const Color(0x1AF6B409),subtypo: const Color(0xFF929497),tile: const Color(0xFFFFFFFF),typo: const Color(0xFF404041),
        systemUiOverlayStyle: SystemUiOverlayStyle.dark,
        );
}

class DarkAppColors extends AppColors {
  const DarkAppColors()
      : super(
          additional1: const Color(0xFF98C93C),additional1opacity10: const Color(0x1A98C93C),additional2: const Color(0xFFEC0677),additional3: const Color(0xFF70AE09),additional4: const Color(0xFFF0771F),additional4opacity10: const Color(0x1AF0771F),additional5: const Color(0xFF55B8D8),additional5opacity10: const Color(0x1A55B8D8),additional6: const Color(0xFF25B422),additional6opacity10: const Color(0x1A25B422),additional7: const Color(0xFF5591D8),additional7opacity10: const Color(0x1A5591D8),additional8: const Color(0xFFAE55D8),additional8opacity10: const Color(0x1AAE55D8),additional9: const Color(0xFF22B490),additional9opacity10: const Color(0x1A22B490),background: const Color(0xFF000000),background50: const Color(0x80000000),border: const Color(0xFF595959),border50: const Color(0x80595959),buttonTypo: const Color(0xFF404041),carrefour100: const Color(0xFF314FB9),carrefour30: const Color(0xFF8497D8),element: const Color(0xFFFFFFFF),error: const Color(0xFFEF404A),erroropacity10: const Color(0x1AEF404A),makro100: const Color(0xFF072386),makro30: const Color(0xFF7C8ABC),makroAdditional: const Color(0xFF173C7B),overlay: const Color(0x73000000),primary: const Color(0xFFFFCD00),primaryButtonClicked: const Color(0x1AF6B409),primaryButtonClickedopacity10: const Color(0x1AF6B409),subtypo: const Color(0xFF929497),tile: const Color(0xFF262628),typo: const Color(0xFFF2F2F2),
          systemUiOverlayStyle: SystemUiOverlayStyle.light,
        );

}
