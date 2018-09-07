import 'dart:convert';

Iterable<RisRecord> parseRis(String risText, {bool strict = true}) sync* {
  var lines = LineSplitter.split(risText);

  List<RisEntry> entries = [];
  for (var line in lines) {
    if (!strict) line = line.trim();

    // skip empty lines even in strict mode,
    // as empty lines are in sample: https://gist.github.com/adam3smith/4105816
    if (line.isEmpty) continue;

    var entry = _parseLine(line);

    if (strict) {
      if (entry == null || entry.isIncomplete) throw "Malformed line: '$line'";

      if (!entry.isStartEntry && entries.isEmpty)
        throw "Missing record start on line: '$line'";

      if (entry.isStartEntry && entries.isNotEmpty)
        throw "Unfinished record on line: '$line'";
    } else {
      if (entry == null) continue;
    }

    entries.add(entry);

    if (entry.isEndEntry) {
      yield new RisRecord(new List.unmodifiable(entries));
      entries = [];
    }
  }

  if (entries.isNotEmpty) {
    if (strict) {
      throw 'Unfinished record on line: ${lines.last}';
    } else {
      yield new RisRecord(new List.unmodifiable(entries));
    }
  }
}

RisEntry _parseLine(String line) {
  Iterable<Match> matches = _risLine.allMatches(line);
  return (matches.length == 1)
      ? new RisEntry(matches.first.group(1), matches.last.group(2))
      : null;
}

RegExp _risLine = new RegExp('^([A-Z][A-Z0-9]) *- *(.*)');

class RisRecord {
  final Iterable<RisEntry> entries;

  RisRecord(this.entries);

  @override
  String toString() {
    return 'RisRecord{entries: $entries}';
  }

}

class RisEntry {
  final String tag;

  final String field;

  RisEntry(this.tag, this.field);

  bool get tagHasMeaning => risTags.containsKey(tag);

  String get tagMeaning => risTags[tag];

  bool get isFieldAbbreviated => risAbbreviations.containsKey(field);

  String get expandedField =>
      field != null ? risAbbreviations[field] ?? field : null;

  bool get isStartEntry => tag == "TY";

  bool get isEndEntry => tag == "ER" && field == null || field.isEmpty;

  bool get isIncomplete => tag == null || field == null;

  @override
  String toString() {
    return 'RisEntry{tag: $tag, field: $field}';
  }

}

const Map<String, String> risTags = const {
  "TY": "Type of reference",
  "A1": "First Author",
  "A2": "Secondary Author",
  "A3": "Tertiary Author",
  "A4": "Subsidiary Author",
  "AB": "Abstract",
  "AD": "Author Address",
  "AN": "Accession Number",
  "AU": "Author",
  "AV": "Location in Archives",
  "BT": "???",
  "C1": "Custom 1",
  "C2": "Custom 2",
  "C3": "Custom 3",
  "C4": "Custom 4",
  "C5": "Custom 5",
  "C6": "Custom 6",
  "C7": "Custom 7",
  "C8": "Custom 8",
  "CA": "Caption",
  "CN": "Call Number",
  "CP": "???",
  "CT": "Title of unpublished reference",
  "CY": "Place Published",
  "DA": "Date",
  "DB": "Name of Database",
  "DO": "DOI",
  "DP": "Database Provider",
  "ED": "Editor",
  "EP": "End Page",
  "ET": "Edition",
  "ID": "Reference ID",
  "IS": "Issue number",
  "J1": "Periodical name",
  "J2": "Alternate Title",
  "JA": "Periodical name",
  "JF": "Journal/Periodical name",
  "JO": "Journal/Periodical name",
  "KW": "Keywords",
  "L1": "Link to PDF",
  "L2": "Link to Full",
  "L3": "Related Records",
  "L4": "Image(s)",
  "LA": "Language",
  "LB": "Label",
  "LK": "Website Link",
  "M1": "Number",
  "M2": "Miscellaneous 2",
  "M3": "Type of Work",
  "N1": "Notes",
  "N2": "Abstract",
  "NV": "Number of Volumes",
  "OP": "Original Publication",
  "PB": "Publisher",
  "PP": "Publishing Place",
  "PY": "Publication year",
  "RI": "Reviewed Item",
  "RN": "Research Notes",
  "RP": "Reprint Edition",
  "SE": "Section",
  "SN": "ISBN/ISSN",
  "SP": "Start Page",
  "ST": "Short Title",
  "T1": "Primary Title",
  "T2": "Secondary Title",
  "T3": "Tertiary Title",
  "TA": "Translated Author",
  "TI": "Title",
  "TT": "Translated Title",
  "U1": "User definable 1",
  "U2": "User definable 2",
  "U3": "User definable 3",
  "U4": "User definable 4",
  "U5": "User definable 5",
  "UR": "URL",
  "VL": "Volume number",
  "VO": "Published Standard number",
  "Y1": "Primary Date",
  "Y2": "Access Date",
  "ER": "End of Reference",
};

const Map<String, String> risAbbreviations = const {
  "ABST": "Abstract",
  "ADVS": "Audiovisual material",
  "AGGR": "Aggregated Database",
  "ANCIENT": "Ancient Text",
  "ART": "Art Work",
  "BILL": "Bill",
  "BLOG": "Blog",
  "BOOK": "Whole book",
  "CASE": "Case",
  "CHAP": "Book chapter",
  "CHART": "Chart",
  "CLSWK": "Classical Work",
  "COMP": "Computer program",
  "CONF": "Conference proceeding",
  "CPAPER": "Conference paper",
  "CTLG": "Catalog",
  "DATA": "Data file",
  "DBASE": "Online Database",
  "DICT": "Dictionary",
  "EBOOK": "Electronic Book",
  "ECHAP": "Electronic Book Section",
  "EDBOOK": "Edited Book",
  "EJOUR": "Electronic Article",
  "ELEC": "Web Page",
  "ENCYC": "Encyclopedia",
  "EQUA": "Equation",
  "FIGURE": "Figure",
  "GEN": "Generic",
  "GOVDOC": "Government Document",
  "GRANT": "Grant",
  "HEAR": "Hearing",
  "ICOMM": "Internet Communication",
  "INPR": "In Press",
  "JFULL": "Journal (full)",
  "JOUR": "Journal",
  "LEGAL": "Legal Rule or Regulation",
  "MANSCPT": "Manuscript",
  "MAP": "Map",
  "MGZN": "Magazine article",
  "MPCT": "Motion picture",
  "MULTI": "Online Multimedia",
  "MUSIC": "Music score",
  "NEWS": "Newspaper",
  "PAMP": "Pamphlet",
  "PAT": "Patent",
  "PCOMM": "Personal communication",
  "RPRT": "Report",
  "SER": "Serial publication",
  "SLIDE": "Slide",
  "SOUND": "Sound recording",
  "STAND": "Standard",
  "STAT": "Statute",
  "THES": "Thesis/Dissertation",
  "UNPB": "Unpublished work",
  "VIDEO": "Video recording",
};
