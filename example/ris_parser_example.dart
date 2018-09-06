import 'package:ris_parser/ris_parser.dart';

main() {
  var risText = '''
TY  - JOUR
AU  - Shannon, Claude E.
PY  - 1948/07//
TI  - A Mathematical Theory of Communication
T2  - Bell System Technical Journal
SP  - 379
EP  - 423
VL  - 27
ER  - 
''';

  Iterable<RisRecord> records = parseRis(risText);
  print(records);
}
