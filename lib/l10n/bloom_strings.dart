import '../state/app_state.dart';

class BloomStrings {
  const BloomStrings(this.language);

  final AppLanguage language;
  bool get _lg => language == AppLanguage.luganda;

  String get appName => 'Bloom';
  String get tagline =>
      _lg ? "Ebyokukozesa eby'abantu abeesigwa" : 'Toolkit for Trusted Adults';
  String get english => 'English';
  String get luganda => 'Luganda';
  String get teacherMode => _lg ? "Endabika y'omusomesa" : 'Teacher Mode';
  String get parentMode => _lg ? "Endabika y'omuzadde" : 'Parent Mode';
  String get enterMode => _lg ? 'Yingira' : 'Enter Mode';
  String get offlineReady =>
      _lg ? 'Byakakuuma nga tolina yintaneeti' : 'Offline Cache Ready';
  String get copyright => '© 2026 Bloom Uganda';

  String get teacherFeat1 =>
      _lg ? "Enteekateeka z'amasomo n'emizannyo" : 'Classroom lesson plans & activities';
  String get teacherFeat2 =>
      _lg ? 'AI ekuyamba ku bibuuzo ebinzibu' : 'AI Co-pilot for tough questions';
  String get teacherFeat3 =>
      _lg ? 'Okutwala abayizi eri abakulu' : 'Student referral workflows';
  String get parentFeat1 =>
      _lg ? 'Emisomo "Yiga nga tonnanyumya"' : '"Learn Before You Talk" modules';
  String get parentFeat2 =>
      _lg ? "Entegera z'okwogera ezikwatagana n'emyaka" : 'Age-appropriate conversation starters';
  String get parentFeat3 =>
      _lg ? "AI ey'okuyamba mu maka" : 'AI guide for everyday parenting scenarios';

  String teacherHello(String name) =>
      _lg ? 'Ki kati, Omusomesa $name 👋' : 'Hi, Teacher $name 👋';
  String parentHello(String name) =>
      _lg ? 'Ki kati, Omuzadde $name 👋' : 'Hi, Parent $name 👋';
  String get allSynced => _lg ? 'Data yonna ekuumiddwa' : 'All data synced';
  String get activeModule => _lg ? 'Essomo erikolebwa' : 'Active Module';
  String stepOf(int current, int total) =>
      _lg ? 'Ekyokulabirako $current ku $total' : 'Step $current of $total';
  String percentComplete(int value) =>
      _lg ? 'Kiwedde $value%' : '$value% Complete';
  String get resumeSession => _lg ? 'Weeyongere ku ssomo' : 'Resume Session';
  String get startSession => _lg ? 'Tandika essomo' : 'Start Session';
  String get askAi => _lg ? 'Buuza AI' : 'Ask AI Co-Pilot';
  String get referMentor => _lg ? 'Weereze eri omukulu' : 'Refer to Mentor';
  String get reportConcern => _lg ? 'Waako ekizibu' : 'Report Concern';
  String get startConversation => _lg ? 'Tandika okwogera' : 'Start Conversation';

  String get home => _lg ? 'Awaka' : 'Home';
  String get modules => _lg ? 'Emisomo' : 'Modules';
  String get aiAssist => _lg ? 'AI' : 'AI Assist';
  String get settings => _lg ? 'Enteekateeka' : 'Settings';

  String get learnBefore => _lg ? 'Yiga nga tonnanyumya' : 'Learn Before You Talk';
  String get learnIntro => _lg
      ? 'Weetegekere ebigambo ebyokulu nga tonnanyumya n\'omwana.'
      : 'Prepare yourself with key concepts before initiating this important conversation with youth.';
  String get whatToKnow => _lg ? "Eky'okumanya" : 'What to Know';
  String get commonQuestions => _lg ? 'Ebibuuzo ebyabulijjo' : 'Common Questions';
  String get conversationStarters =>
      _lg ? "Entegera z'okwogera" : 'Conversation Starters';
  String get anticipatedQuestions =>
      _lg ? "Ebibuuzo abavubuka bye bayinza okubuuza" : 'Anticipated Questions from Youth';
  String get markReviewed => _lg ? 'Kiraga nti okisomye' : 'Mark as Reviewed';
  String get markedReviewed => _lg ? 'Osomye essomo lino' : 'Marked as reviewed';

  String get talkingPoint => _lg ? "Eky'okwogera" : 'Talking Point';
  String get teacherTip => _lg ? "Amagezi g'omusomesa" : 'Teacher Tip';
  String get parentTip => _lg ? "Amagezi g'omuzadde" : 'Parent Tip';
  String get visualAid => _lg ? "Ekifaananyi eky'okulabirako" : 'Visual Aid Reference';
  String get previousPoint => _lg ? 'Ekyasooka' : 'Previous Point';
  String get nextPoint => _lg ? 'Ekyaddako' : 'Next Point';
  String get askTips =>
      _lg ? "Saba amagezi g'okusomesa..." : 'Ask for teaching tips...';
  String get askParentTips =>
      _lg ? "Saba amagezi g'okwogera..." : 'Ask for conversation tips...';

  String get aiTitle => 'AI Co-Pilot';
  String get bloomAi => 'Bloom AI';
  String get aiDisclaimer => _lg
      ? 'Bloom AI eyamba abantu abeesigwa. Temuyamba omwana butereevu.'
      : 'Bloom AI supports trusted adults. It never speaks directly to the girl.';
  String get suggested => _lg ? 'Gezaako obuuza:' : 'Try asking:';

  String get switchRole => _lg ? 'Kyuusa endabika' : 'Switch role';
  String get languageLabel => _lg ? 'Olulimi' : 'Language';
  String get aboutBloom => _lg ? 'Ku Bloom' : 'About Bloom';
  String get aboutBody => _lg
      ? 'Bloom eyamba abazadde, abasomesa n\'abakulembeze okuyiga, okwogera, n\'okulagirira abawala mu kaseera k\'okukula n\'okwerinda.'
      : 'Bloom helps parents, teachers, and community leaders learn, talk, and guide girls through puberty and safety.';
  String get learnTalkGuide => 'Learn · Talk · Guide · Support';

  String get mentorsTitle => _lg ? 'Abakulu abalondeddwa' : 'Vetted near-peer mentors';
  String get mentorsBody => _lg
      ? 'Twalira omwala eri omukulu alina okutendekebwa, nga tewali kuyisaamu nnyo.'
      : 'Connect a girl to a trained near-peer mentor for ongoing 1-on-1 guidance.';
  String get connect => _lg ? 'Gatta' : 'Connect';
  String get connected => _lg
      ? 'Okusaba kutuusiddwa. Omukulu agenda kukwatagana naawe.'
      : 'Referral sent. A mentor will follow up with you privately.';

  String get reportTitle => _lg ? 'Waako ekizibu' : 'Report a safety concern';
  String get reportBody => _lg
      ? 'Ebizibu ebyamaanyi tebigenda mu Bloom AI zokka. Tukwatagana n\'abakugu n\'essimu ey\'obuyambi.'
      : 'Serious safety concerns are not handled by Bloom AI alone. Route them to counsellors and approved hotlines.';
  String get helpline => _lg ? 'Essimu y\'abaana mu Uganda: 116' : 'Uganda Child Helpline: 116';
  String get concernHint =>
      _lg ? 'Nnamba ku kyo kye walabye (tokozesa erinnya ly\'omwana)...' : 'Describe what you observed (do not include the girl’s name)...';
  String get submitReport => _lg ? 'Weereza' : 'Submit privately';
  String get reportSent => _lg
      ? 'Ekiwandiiko kikuumiddwa. Fuba okukozesa essimu 116 oba omukugu.'
      : 'Saved privately. Please also call 116 or a trained counsellor.';

  String get modulesIntroTeacher => _lg
      ? 'Masomo agategekeddwa. Yiga, weetegekere, oluvannyuma osomese.'
      : 'Ready-made lessons. Learn, prepare, then teach.';
  String get modulesIntroParent => _lg
      ? 'Yiga wekka nga tonnanyumya n\'omwana wo.'
      : 'Learn privately before you talk with your child.';
}
