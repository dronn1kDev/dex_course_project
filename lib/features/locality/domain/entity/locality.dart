import 'package:dex_course_temp/core/domain/intl/generated/l10n.dart';
import 'package:flutter/material.dart';

abstract class Locality {
  final String Function(BuildContext context) name;

  const Locality(this.name);
}

enum LocalityList implements Locality {
  rybnitsa(_rybnitsa),
  tiraspol(_tiraspol);

  const LocalityList(this.name);

  @override
  final String Function(BuildContext context) name;
}

String _tiraspol(BuildContext context) => S.of(context).tiraspol;

String _rybnitsa(BuildContext context) => S.of(context).rybnitsa;
