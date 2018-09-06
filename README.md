Dart parser for [RIS text format](https://en.wikipedia.org/wiki/RIS_(file_format)).

## Usage

A simple usage example:

```dart
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
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/fnx-io/ris_parser/issues

#### Credentials

Inspired by [A very simple RIS file parser](https://gist.github.com/sobolevnrm/412763ebae5424a92d3239898b615e2a)
