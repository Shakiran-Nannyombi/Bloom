import '../state/app_state.dart';

class LocalizedText {
  const LocalizedText(this.en, this.lg);
  final String en;
  final String lg;
  String of(AppLanguage language) =>
      language == AppLanguage.luganda ? lg : en;
}

class BloomModule {
  const BloomModule({
    required this.id,
    required this.title,
    required this.summary,
    required this.progress,
    required this.currentStep,
    required this.totalSteps,
    required this.facts,
    required this.anticipated,
    required this.starters,
    required this.talkingPoints,
  });

  final String id;
  final LocalizedText title;
  final LocalizedText summary;
  final int progress;
  final int currentStep;
  final int totalSteps;
  final List<FactCard> facts;
  final List<QaItem> anticipated;
  final List<LocalizedText> starters;
  final List<TalkingPoint> talkingPoints;
}

class FactCard {
  const FactCard({required this.title, required this.body});
  final LocalizedText title;
  final LocalizedText body;
}

class QaItem {
  const QaItem({required this.question, required this.answer});
  final LocalizedText question;
  final LocalizedText answer;
}

class TalkingPoint {
  const TalkingPoint({
    required this.title,
    required this.script,
    required this.tip,
    required this.visual,
  });

  final LocalizedText title;
  final LocalizedText script;
  final LocalizedText tip;
  final LocalizedText visual;
}

class Mentor {
  const Mentor({
    required this.name,
    required this.focus,
    required this.location,
  });
  final String name;
  final LocalizedText focus;
  final LocalizedText location;
}

final bloomModules = <BloomModule>[
  BloomModule(
    id: 'cycle',
    title: const LocalizedText(
      'Understanding Your Cycle',
      'Okutegeera Enkola yo',
    ),
    summary: const LocalizedText(
      'A simple classroom session on periods, pads, and asking for help without shame.',
      'Essomo eryangu ku nnaku z\'omwezi, pads, n\'okusaba obuyambi nga tewali nsonyi.',
    ),
    progress: 40,
    currentStep: 2,
    totalSteps: 5,
    facts: const [
      FactCard(
        title: LocalizedText('Definition', 'Makulu'),
        body: LocalizedText(
          'A menstrual cycle is the body’s monthly rhythm of preparing for a possible pregnancy. Bleeding is a healthy sign, not dirt or a curse.',
          'Enkola y\'omwezi mpulirizo ya mubiri. Okusaayiira kya bulamu, si kikyafu wadde ekikolimo.',
        ),
      ),
      FactCard(
        title: LocalizedText('Why it matters', 'Lwaki kikulu'),
        body: LocalizedText(
          'When adults explain this calmly, girls miss less school, know how to stay clean, and feel safe asking for a pad or pain help.',
          'Bwe tuba nyumya mpola, abawala tebakaasa masomo, bamanya okweyerinda, era batya kubuuza pad oba obuyambi ku bulumi.',
        ),
      ),
    ],
    anticipated: const [
      QaItem(
        question: LocalizedText(
          '"Does blood mean I am sick?"',
          '"Okusaayiira kitegeeza ndwadde?"',
        ),
        answer: LocalizedText(
          'No. Say: “This is your body growing up. It is normal. We can manage it together.”',
          'Nedda. Gamba: “Kuno kwekukula. Kya bulijjo. Tujja kukikola wamu.”',
        ),
      ),
      QaItem(
        question: LocalizedText(
          '"Can I still go to school?"',
          '"Nsobola okugenda ku ssomero?"',
        ),
        answer: LocalizedText(
          'Yes. School continues. Help her plan pads, a spare uniform, and a trusted adult at school.',
          'Yee. Ssomero ligenda mu maaso. Muyambe okuteekateeka pads, yunifoomu, n\'omuntu oweesigwa.',
        ),
      ),
    ],
    starters: const [
      LocalizedText(
        '“Your body is changing, and that is a good thing. We can talk about it whenever you want.”',
        '“Omubiri gwo gukyukakyuka, era kiri kirungi. Tusobola okwogera nga oyagala.”',
      ),
      LocalizedText(
        '“If you ever see blood in your pants, come to me. You are not in trouble.”',
        '“Bw\'olaba omusaayi mu bupiira, jangu gyendi. Tokola kakyamu.”',
      ),
    ],
    talkingPoints: const [
      TalkingPoint(
        title: LocalizedText('Start without shame', 'Tandika nga tewali nsonyi'),
        script: LocalizedText(
          'Say: “Today we talk about how girls’ bodies grow. Every body is different. There are no silly questions.” Write the words period and pad on the board.',
          'Gamba: “Leero twogera ku kukula kw\'abawala. Buli mubiri gwa njawulo. Tewali kibuuzo kikyamu.” Wandiika period ne pad ku kabalaza.',
        ),
        tip: LocalizedText(
          'Sit in a circle if you can. Keep your voice warm. Do not laugh if a learner uses a slang word — translate it kindly.',
          'Tudde mu kiwulukuto oba kisoboka. Loba eddoboozi. Toseka omuyizi bw\'akozesa ekigambo ky\'omu kyalo — kikyuse mpola.',
        ),
        visual: LocalizedText(
          'Simple drawing: a calendar with a few days circled, next to a pad. No graphic anatomy on the first point.',
          'Ekifaananyi: kalenda n\'ennaku ntono ezelingiriddwa, pad ku bbali. Teyoleka mubiri mu ngeri enzibu.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('What a period is', 'Period kye ki'),
        script: LocalizedText(
          'Say: “Once a month, the womb lining leaves the body as blood. This can last 3–7 days. It is not dirty. Soap, water, and a pad keep you comfortable.”',
          'Gamba: “Omwezi ogumu, omubiri gufulumya omusaayi. Kino kiyinza okumala ennaku 3–7. Si kikyafu. Ssabbuuni, amazzi, ne pad bibeezaamu obulamu.”',
        ),
        tip: LocalizedText(
          'Use a banana or folded cloth to show how a pad sits. Let learners ask before you add more detail.',
          'Kozesa oggonja oba olugoye okwoleka pad. Lesa abayizi babuuze nga tonateeka bungi.',
        ),
        visual: LocalizedText(
          'Chalk sketch of a pad, underwear, and a water jug. Label: change, wash, wrap, bin.',
          'Ekifaananyi kya pad, bupiira, n\'ensuwa. Wandika: kyusa, naziya, siba, suula.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('Pain and missing class', 'Obulumi n\'okusala ssomo'),
        script: LocalizedText(
          'Say: “Cramps can hurt. Rest, water, and a warm cloth help. If pain is very strong, tell a trusted adult. Missing class should not be the only option.”',
          'Gamba: “Olulumi luyinza okulumya. Wummulira, nywa amazzi, kozesa olugoye olwokyeyo. Obulumi obungi, gamba omuntu oweesigwa. Okusala ssomo si kyekka.”',
        ),
        tip: LocalizedText(
          'Name the school’s pad store or matron now, so girls know where to go today.',
          'Yogerera wano ew\'okufuna pad ku ssomero, abawala bamanye gye bagenda leero.',
        ),
        visual: LocalizedText(
          'Three icons: water, rest, trusted adult. Circle the adult icon.',
          'Bifaananyi bisatu: amazzi, okwefumitiriza, omuntu oweesigwa.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('Myths to drop', 'Obulimba obw\'okuleka'),
        script: LocalizedText(
          'Say: “A girl on her period can cook, sit with others, and go to prayers if she wants. Blood is not a curse. We do not isolate anyone.”',
          'Gamba: “Omuwala ali ku period asobola okufumba, okutuula n\'abalala, n\'okusaba. Omusaayi si kikolimo. Tetwawulamu muntu.”',
        ),
        tip: LocalizedText(
          'If a learner repeats a harmful myth, thank them for sharing, then replace it with the fact. Do not shame the home it came from.',
          'Omuyizi bw\'agamba obulimba, mwebaze, oluvannyuma wangeezemu amazima. Tonvuma maka ge.',
        ),
        visual: LocalizedText(
          'Two columns on the board: Myth / Fact. Fill one pair together as a class.',
          'Ennyiriri bbiri: Obulimba / Amazima. Mujjuze emu wamu.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('Who to tell', 'Ani gw\'ogamba'),
        script: LocalizedText(
          'Say: “If you need a pad, feel pain, or someone makes you uncomfortable about your body, tell a teacher, parent, or matron. You will not be in trouble.”',
          'Gamba: “Bw\'oba oyagala pad, obulumi, oba omuntu akuyisa obubi ku mubiri, gamba omusomesa, omuzadde, oba matron. Tokola kakyamu.”',
        ),
        tip: LocalizedText(
          'Leave the room open for private questions after class. Write the child helpline 116 on the board.',
          'Lesa ebbanga ly\'okubuuza mu kyama oluvannyuma. Wandiika essimu 116.',
        ),
        visual: LocalizedText(
          'Names of 2 trusted adults at this school + 116. Keep it visible after you leave.',
          'Amanya g\'abantu 2 abeesigwa ku ssomero + 116.',
        ),
      ),
    ],
  ),
  BloomModule(
    id: 'boundaries',
    title: const LocalizedText(
      'Body Autonomy & Boundaries',
      'Obuyinza ku mubiri n\'ensalo',
    ),
    summary: const LocalizedText(
      'Help adults explain that a girl is in charge of who touches her, and how to say no without shame.',
      'Yamba abakulu okunnyonnyola nti omuwala ye afuga ani amukwatako, n\'okugamba nedda nga tewali nsonyi.',
    ),
    progress: 0,
    currentStep: 1,
    totalSteps: 4,
    facts: const [
      FactCard(
        title: LocalizedText('Definition', 'Makulu'),
        body: LocalizedText(
          'Body autonomy means a person has the right to govern their own body. It teaches youth they are in charge of who touches them and how.',
          'Obuyinza ku mubiri kitegeeza nti omuntu ye afuga omubiri gwe. Abavubuka bamanya ani agwanyisa okubakwatako.',
        ),
      ),
      FactCard(
        title: LocalizedText('Why it matters', 'Lwaki kikulu'),
        body: LocalizedText(
          'Establishing boundaries early helps protect youth from abuse and empowers them to communicate discomfort confidently.',
          'Ensalo z\'okubanja ziyamba okukuma abavubuka era bazibuulira obulumi n\'obwegendereza.',
        ),
      ),
    ],
    anticipated: const [
      QaItem(
        question: LocalizedText(
          '"What if an adult I know wants to hug me?"',
          '"Naye omuntu gwe mmanyi bw\'ayagala okumbumbatira?"',
        ),
        answer: LocalizedText(
          'Guide them to understand they can say no even to family. Offer high-fives or waving if they prefer not to hug.',
          'Bategeezze nti basobola okugamba nedda ne eri ab\'omu maka. Bawe high-five oba okubuzaako omukono.',
        ),
      ),
      QaItem(
        question: LocalizedText(
          '"Is it rude to say no?"',
          '"Kikyamu okugamba nedda?"',
        ),
        answer: LocalizedText(
          'Reassure them that setting a boundary is never rude; it is a healthy way to respect their own comfort.',
          'Bakkakase nti okuteeka ensalo si kikyamu; kye kgeri ennungi ey\'okwewa ekitiibwa.',
        ),
      ),
    ],
    starters: const [
      LocalizedText(
        '“Your body belongs to you. You can say no to a hug, even from someone you love.”',
        '“Omubiri gwo gwo. Osobola okugamba nedda ku kumbumbatira, ne eri gw\'oyagala.”',
      ),
      LocalizedText(
        '“If a touch feels confusing or secret, tell me. I will listen.”',
        '“Okukwatibwako bwe kuba kwa kyeewuunyisa oba kya kyama, ngamba. Nja kuwuliriza.”',
      ),
    ],
    talkingPoints: const [
      TalkingPoint(
        title: LocalizedText('Your body, your rules', 'Omubiri gwo, mateeka go'),
        script: LocalizedText(
          'Say: “You decide who may hold your hand, hug you, or touch your hair. Love does not mean you must accept every touch.”',
          'Gamba: “Ggwe osalawo ani akwata omukono, akumbumbatira, oba akwatako enviiri. Okwagala tekitegeeza nti kirina okukwatibwako.”',
        ),
        tip: LocalizedText(
          'Model this: ask before a demonstration hug with a co-teacher, then thank them for the yes or no.',
          'Laga: saba olukusa nga tonnageza okumbumbatira omusomesa munno.',
        ),
        visual: LocalizedText(
          'A simple outline of a person with a green circle (ok) and a red circle (private).',
          'Ekifaananyi ky\'omuntu n\'enkulungo eya kilagala (kikirizibwa) n\'emyufu (ekyama).',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('Secrets vs surprises', 'Ekyama n\'ekyewuunyisa'),
        script: LocalizedText(
          'Say: “A birthday surprise is fun and ends. A secret that makes your stomach hurt, or that someone says ‘don’t tell’, is not safe. Bring it to a trusted adult.”',
          'Gamba: “Ekyewuunyisa kya birthday kirungi. Ekyama ekikulumya olubuto, oba ‘togamba muntu’, si kya kwerinda. Kitwale eri omuntu oweesigwa.”',
        ),
        tip: LocalizedText(
          'Never force a girl to name a person in front of the class. Offer a private follow-up.',
          'Tojja kumulagira ayanjule erinnya mu kibiina. Muwemu ebbanga lya kyama.',
        ),
        visual: LocalizedText(
          'Two boxes: Surprise (cake) vs Unsafe secret (closed door).',
          'Ebokisi bbiri: Ekyewuunyisa vs ekyama ekitali kya kwerinda.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('How to say no', 'Engeri y\'okugamba nedda'),
        script: LocalizedText(
          'Practice together: “No thank you.” “I don’t want a hug.” “Please stop.” Strong voice, clear words, then go to a trusted adult.',
          'Muzanye: “Nedda webale.” “Saagala kumbumbatirwa.” “Nkwebaza lekerawo.” Eddoboozi erya maanyi, oluvannyuma genda eri omuntu oweesigwa.',
        ),
        tip: LocalizedText(
          'Let volunteers role-play with a co-teacher, not with another child as the ‘unsafe adult’.',
          'Abayizi bazanne n\'omusomesa, so si omwana omulala ng\'omuntu omutali musafe.',
        ),
        visual: LocalizedText(
          'Three short phrases on the board, large enough to copy into books.',
          'Emisolo esatu ku kabalaza, abayizi bagiwandiike.',
        ),
      ),
      TalkingPoint(
        title: LocalizedText('Who listens', 'Ani awuliriza'),
        script: LocalizedText(
          'Say: “If someone does not stop, you still did the right thing. Tell a teacher, parent, or call 116. Adults should protect you, not blame you.”',
          'Gamba: “Omuntu bw\'atalekera, ggwe wakola ekituufu. Gamba omusomesa, omuzadde, oba 116. Abakulu bakulinde, si kukumanya.”',
        ),
        tip: LocalizedText(
          'If a disclosure starts, stop the lesson, thank her, move to a private space, and follow the report pathway. Do not investigate in class.',
          'Bw\'atandika okwogera ku bikolimo, yyamiriza essomo, mwebaze, mugende mu kifo kya kyama. Tonnoonyereza mu kibiina.',
        ),
        visual: LocalizedText(
          'Helpline 116 and two named adults. Remind: Bloom advises you, not the girl on a phone.',
          'Essimu 116 n\'abantu 2. Bloom eyamba ggwe, si omwana ku ssimu.',
        ),
      ),
    ],
  ),
  BloomModule(
    id: 'help',
    title: const LocalizedText('How to Ask for Help', 'Engeri y\'okusaba obuyambi'),
    summary: const LocalizedText(
      'Scripts for naming a trusted adult, using 116, and what to do if the first adult does not listen.',
      'Ebyokwogera ku kulonda omuntu oweesigwa, 116, n\'ekikolebwa omuntu asooka bw\'atawuliriza.',
    ),
    progress: 0,
    currentStep: 1,
    totalSteps: 3,
    facts: const [
      FactCard(
        title: LocalizedText('Definition', 'Makulu'),
        body: LocalizedText(
          'Asking for help is a skill. Girls should know more than one adult, and that they will not be punished for speaking.',
          'Okusaba obuyambi kya kugunjula. Abawala bamanya abantu abasukka mu omu, era tebalina kubonerezebwa.',
        ),
      ),
    ],
    anticipated: const [
      QaItem(
        question: LocalizedText(
          '"What if they do not believe me?"',
          '"Bw\'obatakkiriza?"',
        ),
        answer: LocalizedText(
          'Tell her to try a second adult, a mentor, or 116. Her job is to tell; the adult’s job is to act.',
          'Gamba agezeeko omuntu owookubiri, omukulu, oba 116. Ye yanja; omuntu omukulu akole.',
        ),
      ),
    ],
    starters: const [
      LocalizedText(
        '“Who are two adults you could tell if you felt unsafe?”',
        '“Bantu bameka abeesigwa be wasobola okugamba nga toli musafe?”',
      ),
    ],
    talkingPoints: const [
      TalkingPoint(
        title: LocalizedText('Name two adults', 'Yogera abantu babiri'),
        script: LocalizedText(
          'Ask each learner (privately if needed) to name two trusted adults — at home and at school.',
          'Buli muyizi ayanjule abantu babiri — ewaka ne ku ssomero.',
        ),
        tip: LocalizedText(
          'Do not force sharing out loud. Collect names on paper if that feels safer.',
          'Tobakakasa bayoge mu lulwe. Bayinza okuwandiika.',
        ),
        visual: LocalizedText(
          'A tree with two branches: home / school.',
          'Omuti n\'amatabi abiri: awaka / ssomero.',
        ),
      ),
    ],
  ),
];

BloomModule moduleById(String id) =>
    bloomModules.firstWhere((m) => m.id == id, orElse: () => bloomModules.first);

const mentors = [
  Mentor(
    name: 'Aisha N.',
    focus: LocalizedText('Periods & school confidence', 'Ennaku z\'omwezi n\'obuvumu ku ssomero'),
    location: LocalizedText('Mbarara — near-peer mentor', 'Mbarara — omukulu ow\'emikwano'),
  ),
  Mentor(
    name: 'Joan K.',
    focus: LocalizedText('Boundaries & body safety', 'Ensalo n\'okwerinda omubiri'),
    location: LocalizedText('Mbarara — trained mentor', 'Mbarara — omukulu omutendeke'),
  ),
  Mentor(
    name: 'Mercy T.',
    focus: LocalizedText('Home conversations for guardians', 'Okunyumya mu maka'),
    location: LocalizedText('Community outreach', 'Okutambula mu kitundu'),
  ),
];
