import "package:flutter/material.dart";

class MaterialThemeVr {
  final TextTheme textTheme;

  const MaterialThemeVr(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
     // primary: Color(4288823040),
      primary: Color(0xFFDD5C0C),
      surfaceTint: Color(4288823040),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294933561),
      onPrimaryContainer: Color(4281142272),
      secondary: Color(4287123510),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294950820),
      onSecondaryContainer: Color(4284296727),
      tertiary: Color(4286600707),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294954373),
      onTertiaryContainer: Color(4283972096),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294965494),
      onSurface: Color(4280686610),
      onSurfaceVariant: Color(4284105014),
      outline: Color(4287525220),
      outlineVariant: Color(4293050289),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282199334),
      inversePrimary: Color(4294948245),
      primaryFixed: Color(4294958028),
      onPrimaryFixed: Color(4281667584),
      primaryFixedDim: Color(4294948245),
      onPrimaryFixedVariant: Color(4286328320),
      secondaryFixed: Color(4294958029),
      onSecondaryFixed: Color(4281732864),
      secondaryFixedDim: Color(4294948246),
      onSecondaryFixedVariant: Color(4285282593),
      tertiaryFixed: Color(4294958513),
      onTertiaryFixed: Color(4280883200),
      tertiaryFixedDim: Color(4294360422),
      onTertiaryFixedVariant: Color(4284628992),
      surfaceDim: Color(4293907914),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294961633),
      surfaceContainerHigh: Color(4294894552),
      surfaceContainerHighest: Color(4294499794),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4285868800),
      surfaceTint: Color(4288823040),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4291186432),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4284953886),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4288832842),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4284234752),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4288310301),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965494),
      onSurface: Color(4280686610),
      onSurfaceVariant: Color(4283841843),
      outline: Color(4285815117),
      outlineVariant: Color(4287788136),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282199334),
      inversePrimary: Color(4294948245),
      primaryFixed: Color(4291186432),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4288560384),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4288832842),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4286926388),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4288310301),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4286403584),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293907914),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294961633),
      surfaceContainerHigh: Color(4294894552),
      surfaceContainerHighest: Color(4294499794),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282389504),
      surfaceTint: Color(4288823040),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285868800),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282258947),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284953886),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281409024),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284234752),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965494),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4281540374),
      outline: Color(4283841843),
      outlineVariant: Color(4283841843),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4282199334),
      inversePrimary: Color(4294961118),
      primaryFixed: Color(4285868800),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283505664),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284953886),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283179018),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284234752),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282329088),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293907914),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963692),
      surfaceContainer: Color(4294961633),
      surfaceContainerHigh: Color(4294894552),
      surfaceContainerHighest: Color(4294499794),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294948245),
      surfaceTint: Color(4294948245),
      onPrimary: Color(4283899392),
      primaryContainer: Color(4294206208),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294961118),
      onSecondary: Color(4283507725),
      secondaryContainer: Color(4294619537),
      onSecondaryContainer: Color(4283639311),
      tertiary: Color(4294964200),
      onTertiary: Color(4282657536),
      tertiaryContainer: Color(4294689130),
      onTertiaryContainer: Color(4283446272),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4280094730),
      onSurface: Color(4294499794),
      onSurfaceVariant: Color(4293050289),
      outline: Color(4289301117),
      outlineVariant: Color(4284105014),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294499794),
      inversePrimary: Color(4288823040),
      primaryFixed: Color(4294958028),
      onPrimaryFixed: Color(4281667584),
      primaryFixedDim: Color(4294948245),
      onPrimaryFixedVariant: Color(4286328320),
      secondaryFixed: Color(4294958029),
      onSecondaryFixed: Color(4281732864),
      secondaryFixedDim: Color(4294948246),
      onSecondaryFixedVariant: Color(4285282593),
      tertiaryFixed: Color(4294958513),
      onTertiaryFixed: Color(4280883200),
      tertiaryFixedDim: Color(4294360422),
      onTertiaryFixedVariant: Color(4284628992),
      surfaceDim: Color(4280094730),
      surfaceBright: Color(4282791214),
      surfaceContainerLowest: Color(4279700230),
      surfaceContainerLow: Color(4280686610),
      surfaceContainer: Color(4281015318),
      surfaceContainerHigh: Color(4281738784),
      surfaceContainerHighest: Color(4282528042),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294949790),
      surfaceTint: Color(4294948245),
      onPrimary: Color(4281142272),
      primaryContainer: Color(4294206208),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294961118),
      onSecondary: Color(4283507725),
      secondaryContainer: Color(4294619537),
      onSecondaryContainer: Color(4279763968),
      tertiary: Color(4294964200),
      onTertiary: Color(4282657536),
      tertiaryContainer: Color(4294689130),
      onTertiaryContainer: Color(4280423424),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4280094730),
      onSurface: Color(4294965752),
      onSurfaceVariant: Color(4293378997),
      outline: Color(4290616462),
      outlineVariant: Color(4288380272),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294499794),
      inversePrimary: Color(4286459648),
      primaryFixed: Color(4294958028),
      onPrimaryFixed: Color(4280616960),
      primaryFixedDim: Color(4294948245),
      onPrimaryFixedVariant: Color(4284555776),
      secondaryFixed: Color(4294958029),
      onSecondaryFixed: Color(4280616960),
      secondaryFixedDim: Color(4294948246),
      onSecondaryFixedVariant: Color(4283967762),
      tertiaryFixed: Color(4294958513),
      onTertiaryFixed: Color(4279963392),
      tertiaryFixedDim: Color(4294360422),
      onTertiaryFixedVariant: Color(4283183360),
      surfaceDim: Color(4280094730),
      surfaceBright: Color(4282791214),
      surfaceContainerLowest: Color(4279700230),
      surfaceContainerLow: Color(4280686610),
      surfaceContainer: Color(4281015318),
      surfaceContainerHigh: Color(4281738784),
      surfaceContainerHighest: Color(4282528042),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294965752),
      surfaceTint: Color(4294948245),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294949790),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294965752),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4294949790),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966007),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4294689130),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4280094730),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294965752),
      outline: Color(4293378997),
      outlineVariant: Color(4293378997),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294499794),
      inversePrimary: Color(4283243008),
      primaryFixed: Color(4294959573),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294949790),
      onPrimaryFixedVariant: Color(4281142272),
      secondaryFixed: Color(4294959573),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4294949790),
      onSecondaryFixedVariant: Color(4281142272),
      tertiaryFixed: Color(4294960062),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4294623594),
      onTertiaryFixedVariant: Color(4280423168),
      surfaceDim: Color(4280094730),
      surfaceBright: Color(4282791214),
      surfaceContainerLowest: Color(4279700230),
      surfaceContainerLow: Color(4280686610),
      surfaceContainer: Color(4281015318),
      surfaceContainerHigh: Color(4281738784),
      surfaceContainerHighest: Color(4282528042),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );

  /// orege
  static const orege = ExtendedColor(
    seed: Color(4294153063),
    value: Color(4294153063),
    light: ColorFamily(
      color: Color(4287973667),
      onColor: Color(4294967295),
      colorContainer: Color(4294876272),
      onColorContainer: Color(4283177216),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4287973667),
      onColor: Color(4294967295),
      colorContainer: Color(4294876272),
      onColorContainer: Color(4283177216),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4287973667),
      onColor: Color(4294967295),
      colorContainer: Color(4294876272),
      onColorContainer: Color(4283177216),
    ),
    dark: ColorFamily(
      color: Color(4294951076),
      onColor: Color(4283964928),
      colorContainer: Color(4293627233),
      onColorContainer: Color(4281536000),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294951076),
      onColor: Color(4283964928),
      colorContainer: Color(4293627233),
      onColorContainer: Color(4281536000),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294951076),
      onColor: Color(4283964928),
      colorContainer: Color(4293627233),
      onColorContainer: Color(4281536000),
    ),
  );

  /// yello
  static const yello = ExtendedColor(
    seed: Color(4294952302),
    value: Color(4294952302),
    light: ColorFamily(
      color: Color(4286600707),
      onColor: Color(4294967295),
      colorContainer: Color(4294954373),
      onColorContainer: Color(4283972096),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4286600707),
      onColor: Color(4294967295),
      colorContainer: Color(4294954373),
      onColorContainer: Color(4283972096),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4286600707),
      onColor: Color(4294967295),
      colorContainer: Color(4294954373),
      onColorContainer: Color(4283972096),
    ),
    dark: ColorFamily(
      color: Color(4294964200),
      onColor: Color(4282657536),
      colorContainer: Color(4294689130),
      onColorContainer: Color(4283446272),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294964200),
      onColor: Color(4282657536),
      colorContainer: Color(4294689130),
      onColorContainer: Color(4283446272),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294964200),
      onColor: Color(4282657536),
      colorContainer: Color(4294689130),
      onColorContainer: Color(4283446272),
    ),
  );

  /// red
  static const red = ExtendedColor(
    seed: Color(4292557363),
    value: Color(4292557363),
    light: ColorFamily(
      color: Color(4288875025),
      onColor: Color(4294967295),
      colorContainer: Color(4292360241),
      onColorContainer: Color(4294967295),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(4288875025),
      onColor: Color(4294967295),
      colorContainer: Color(4292360241),
      onColorContainer: Color(4294967295),
    ),
    lightHighContrast: ColorFamily(
      color: Color(4288875025),
      onColor: Color(4294967295),
      colorContainer: Color(4292360241),
      onColorContainer: Color(4294967295),
    ),
    dark: ColorFamily(
      color: Color(4294948011),
      onColor: Color(4285071365),
      colorContainer: Color(4291768876),
      onColorContainer: Color(4294967295),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(4294948011),
      onColor: Color(4285071365),
      colorContainer: Color(4291768876),
      onColorContainer: Color(4294967295),
    ),
    darkHighContrast: ColorFamily(
      color: Color(4294948011),
      onColor: Color(4285071365),
      colorContainer: Color(4291768876),
      onColorContainer: Color(4294967295),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    orege,
    yello,
    red,
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}