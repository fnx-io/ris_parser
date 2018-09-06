import 'package:ris_parser/ris_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Ris parser tests', () {
    test('Parse ris sample 1', () {
      var risText = '''
TY  - JOUR
T1  - Decomposing passenger transport futures: Comparing results of global integrated assessment models
A1  - Edelenbosch, O.Y.
A1  - McCollum, D.L.
A1  - van Vuuren, D.P.
A1  - Bertram, C.
A1  - Carrara, S.
A1  - Daly, H.
A1  - Fujimori, S.
A1  - Kitous, A.
A1  - Kyle, P.
A1  - Ó Broin, E.
A1  - Karkatsoulis, P.
A1  - Sano, F.
Y1  - 2017/08//
PB  - Pergamon
JF  - Transportation Research Part D: Transport and Environment
VL  - 55
SP  - 281
EP  - 293
DO  - 10.1016/J.TRD.2016.07.003
UR  - https://www.sciencedirect.com/science/article/pii/S1361920916301304
L1  - file:///C:/Users/vojta/AppData/Local/Mendeley Ltd./Mendeley Desktop/Downloaded/Edelenbosch et al. - 2017 - Decomposing passenger transport futures Comparing results of global integrated assessment models.pdf
N2  - The transport sector is growing fast in terms of energy use and accompanying greenhouse gas emissions. Integrated assessment models (IAMs) are used widely to analyze energy system transitions over a decadal time frame to help inform and evaluating international climate policy. As part of this, IAMs also explore pathways of decarbonizing the transport sector. This study quantifies the contribution of changes in activity growth, modal structure, energy intensity and fuel mix to the projected passenger transport carbon emission pathways. The Laspeyres index decomposition method is used to compare results across models and scenarios, and against historical transport trends. Broadly-speaking the models show similar trends, projecting continuous transport activity growth, reduced energy intensity and in some cases modal shift to carbon-intensive modes - similar to those observed historically in a business-as-usual scenario. In policy-induced mitigation scenarios further enhancements of energy efficiency and fuel switching is seen, showing a clear break with historical trends. Reduced activity growth and modal shift (towards less carbon-intensive modes) only have a limited contribution to emission reduction. Measures that could induce such changes could possibly complement the aggressive, technology switch required in the current scenarios to reach internationally agreed climate targets.
ER  -
TY  - JOUR
T1  - Detailed assessment of global transport-energy models’ structures and projections
A1  - Yeh, Sonia
A1  - Mishra, Gouri Shankar
A1  - Fulton, Lew
A1  - Kyle, Page
A1  - McCollum, David L.
A1  - Miller, Joshua
A1  - Cazzola, Pierpaolo
A1  - Teter, Jacob
Y1  - 2017/08//
PB  - Pergamon
JF  - Transportation Research Part D: Transport and Environment
VL  - 55
SP  - 294
EP  - 309
DO  - 10.1016/J.TRD.2016.11.001
UR  - https://www.sciencedirect.com/science/article/pii/S1361920916301651
L1  - file:///C:/Users/vojta/AppData/Local/Mendeley Ltd./Mendeley Desktop/Downloaded/Yeh et al. - 2017 - Detailed assessment of global transport-energy models’ structures and projections.pdf
N2  - This paper focuses on comparing the frameworks and projections from four global transportation models with considerable technology details. We analyze and compare the modeling frameworks, underlying data, assumptions, intermediate parameters, and projections to identify the sources of divergence or consistency, as well as key knowledge gaps. We find that there are significant differences in the base-year data and key parameters for future projections, especially for developing countries. These include passenger and freight activity, mode shares, vehicle ownership rates, and energy consumption by mode, particularly for shipping, aviation and trucking. This may be due in part to a lack of previous efforts to do such consistency-checking and “bench-marking.” We find that the four models differ in terms of the relative roles of various mitigation strategies to achieve a 2°C/450ppm target: the economics-based integrated assessment models favor the use of low carbon fuels as the primary mitigation option followed by efficiency improvements, whereas transport-only and expert-based models favor efficiency improvements of vehicles followed by mode shifts. We offer recommendations for future modeling improvements focusing on (1) reducing data gaps; (2) translating the findings from this study into relevant policy implications such as gaps of current policy goals, additional policy targets needed, regional vs. global reductions; (3) modeling strata of demographic groups to improve understanding of vehicle ownership levels, travel behavior, and urban vs. rural considerations; and (4) conducting coordinated efforts in aligning historical data, and comparing input assumptions and results of policy analysis and modeling insights.
ER  -
''';

      Iterable<RisRecord> parsed = parseRis(risText);

      expect(parsed, hasLength(2));

      var authors =
          parsed.first.entries.where((RisEntry entry) => entry.tag == "A1");
      expect(authors, hasLength(12));
      expect(
          authors.map((RisEntry entry) => entry.field), contains("Kitous, A."));

      RisEntry publisher = parsed.first.entries
          .firstWhere((RisEntry entry) => entry.tag == "PB");
      expect(publisher.field, equals("Pergamon"));
      expect(publisher.tagHasMeaning, isTrue);
      expect(publisher.tagMeaning, equals("Publisher"));

      RisEntry secondStart = parsed.last.entries
          .firstWhere((RisEntry entry) => entry.isStartEntry);
      expect(secondStart.tagHasMeaning, isTrue);
      expect(secondStart.tagMeaning, equals("Type of reference"));
      expect(secondStart.isFieldAbbreviated, isTrue);
      expect(secondStart.expandedField, equals("Journal"));
    });

    test('Parse ris sample 2', () {
      var risText = '''
TY  - JOUR
TI  - Unions, Norms, and the Rise in U.S. Wage Inequality
AU  - Western, Bruce
AU  - Rosenfeld, Jake
T2  - American Sociological Review
AB  - From 1973 to 2007, private sector union membership in the United States declined from 34 to 8 percent for men and from 16 to 6 percent for women. During this period, inequality in hourly wages increased by over 40 percent. We report a decomposition, relating rising inequality to the union wage distribution’s shrinking weight. We argue that unions helped institutionalize norms of equity, reducing the dispersion of nonunion wages in highly unionized regions and industries. Accounting for unions’ effect on union and nonunion wages suggests that the decline of organized labor explains a fifth to a third of the growth in inequality—an effect comparable to the growing stratification of wages by education.
DA  - 2011///
PY  - 2011
DO  - 10.1177/0003122411414817
DP  - Highwire 2.0
VL  - 76
IS  - 4
SP  - 513
EP  - 537
UR  - http://asr.sagepub.com/content/76/4/513.abstract
Y2  - 2011/08/05/17:47:05
L1  - http://asr.sagepub.com.turing.library.northwestern.edu/content/76/4/513.full.pdf
ER  -

TY  - BOOK
TI  - Fluctuating Fortunes: The Political Power of Business in America
AU  - Vogel, David
CN  - JK467 .V64 1989
CY  - New York
DA  - 1988///
PY  - 1988
DP  - nucat.library.northwestern.edu Library Catalog
PB  - Basic Books
SN  - 046502470X
ST  - Fluctuating Fortunes
ER  -

TY  - CHAP
TI  - The American labour movement and the resurgence in union organizing
AU  - Bronfenbrenner, Kate
T2  - Trade Union Renewal and Organizing: A Comparative Study of Trade Union Movements in Five Countries
A2  - Fairbrother, Peter
A2  - Yates, Charlotte
CY  - London
DA  - 2003///
PY  - 2003
DP  - Google Scholar
SP  - 32
EP  - 50
PB  - Continuum
UR  - http://socserv2.socsci.mcmaster.ca/fun/bron1.pdf
Y2  - 2012/07/27/09:48:44
L1  - http://socserv2.socsci.mcmaster.ca/fun/bron1.pdf
ER  -
''';

      Iterable<RisRecord> parsed = parseRis(risText);

      expect(parsed, hasLength(3));

      var title = parsed.first.entries
          .firstWhere((RisEntry entry) => entry.tag == "TI");
      expect(title.field, contains('Wage Inequality'));

      RisEntry thirdStart = parsed
          .elementAt(2)
          .entries
          .firstWhere((RisEntry entry) => entry.isStartEntry);
      expect(thirdStart.tagHasMeaning, isTrue);
      expect(thirdStart.tagMeaning, equals("Type of reference"));
      expect(thirdStart.isFieldAbbreviated, isTrue);
      expect(thirdStart.expandedField, equals("Book chapter"));
    });

    test('Unfinished record', () {
      var unfinished = '''
TY  - JOUR
''';
      expect(
          () => parseRis(unfinished), throwsA(contains("Unfinished record")));
    });

    test('Missing record start', () {
      var withoutStart = '''
T1  - Decomposing passenger transport futures: Comparing results of global integrated assessment models
''';
      expect(() => parseRis(withoutStart),
          throwsA(contains("Missing record start")));
    });

    test('Malformed line', () {
      var malformedLine = '''
TY  - JOUR
bleble bez pomlcky
ER  -
''';
      expect(
          () => parseRis(malformedLine), throwsA(contains("Malformed line")));
    });

    test('Forgiving option', () {
      var text = '''
                    bleble bez pomlcky
                    PB  - Pergamon                    
                  ''';

      Iterable<RisRecord> parsed = parseRis(text, strict: false);

      expect(parsed, hasLength(1));

      RisEntry publisher = parsed.first.entries
          .firstWhere((RisEntry entry) => entry.tag == "PB");
      expect(publisher.field, equals("Pergamon"));
    });
  });
}
