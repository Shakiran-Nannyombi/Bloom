import '../state/app_state.dart';

class AiReply {
  const AiReply({required this.text, this.isSafety = false});
  final String text;
  final bool isSafety;
}

AiReply replyAsBloomAi(String question, AppLanguage language) {
  final q = question.toLowerCase();
  final lg = language == AppLanguage.luganda;

  const safetyHits = [
    'abuse',
    'assault',
    'rape',
    'groom',
    'touch',
    'pregnant',
    'bleeding a lot',
    'suicide',
    'hit me',
    'okukozesa',
    'okukwata',
    'embuto',
  ];
  if (safetyHits.any(q.contains) &&
      (q.contains('hurt') ||
          q.contains('secret') ||
          q.contains('force') ||
          q.contains('rape') ||
          q.contains('abuse') ||
          q.contains('groom') ||
          q.contains('suicide') ||
          q.contains('pregnant') ||
          q.contains('okukozesa'))) {
    return AiReply(
      isSafety: true,
      text: lg
          ? 'Kino kya kwerinda, si kya Bloom AI kwekka.\n\n'
              '1. Wuliriza omwala mu kyama. Tumukkakasa nti takola kakyamu.\n'
              '2. Tokozesa ssimu ya Bloom okwogera naye butereevu.\n'
              '3. Kuba 116 (Uganda Child Helpline) oba omukugu.\n'
              '4. Wandiika ebyo bye walabye, so si ebyokwebuuza.\n\n'
              'Bloom eyamba ggwe okwogera; omwala ayanirizibwa abantu abatendeke.'
          : 'This needs more than a script. Bloom AI will not handle it alone.\n\n'
              '1. Listen to the girl in private. Tell her she is not in trouble.\n'
              '2. Do not put her on this chat — Bloom advises the adult, not the child.\n'
              '3. Call 116 (Uganda Child Helpline) or a trained counsellor.\n'
              '4. Write what you observed, not what you guess.\n\n'
              'Use Report Concern in the app to keep a private note, then escalate.',
    );
  }

  if (q.contains('luganda') || q.contains('local language') || q.contains('translate')) {
    return AiReply(
      text: lg
          ? 'Gezaako bino mu Luganda, mpola:\n\n'
              '“Omubiri gwo gukyukakyuka, era kiri kirungi.”\n'
              '“Period si kikyafu. Tujja kukuyamba.”\n'
              '“Bw\'otayagala kumbumbatirwa, gamba nedda.”\n\n'
              'Kozesa ebigambo ebyangu. Weewale eby\'ekisawo.'
          : 'Here is a calm Luganda start you can say out loud:\n\n'
              '“Omubiri gwo gukyukakyuka, era kiri kirungi.”\n'
              '(Your body is changing, and that is a good thing.)\n\n'
              '“Period si kikyafu. Tujja kukuyamba.”\n'
              '(A period is not dirt. We will help you.)\n\n'
              'Keep medical words out. Short sentences. Pause for questions.',
    );
  }

  if (q.contains('menstru') || q.contains('period') || q.contains('cycle') || q.contains('pad')) {
    return AiReply(
      text: lg
          ? 'Nnyonnyola mpola:\n\n'
              '“Omubiri gufulumya omusaayi omwezi ogumu. Kino kya kukula, si ndwadde.”\n'
              'Yogera ku pad, amazzi, n\'omuntu oweesigwa.\n'
              'Togamba nti kikyafu oba kikolimo.\n'
              'Bw\'oba mu kibiina, weewale okwoleka mubiri; kozesa kalenda ne pad.'
          : 'Explain menstruation simply:\n\n'
              '“Once a month the body lets out a little blood. This is growing up, not sickness.”\n'
              'Name a pad, soap and water, and a trusted adult.\n'
              'Do not say it is dirty or a curse.\n'
              'In class, skip graphic anatomy on the first pass — use a calendar and a pad.',
    );
  }

  if (q.contains('start') || q.contains('conversation') || q.contains('daughter') || q.contains('home')) {
    return AiReply(
      text: lg
          ? 'Tandika waka nga tewali kukiina:\n\n'
              '1. Londako ekiseera ekyompolola, si ng\'oli musunguwadde.\n'
              '2. Gamba: “Njagala tukwogere ku mubiri gwo. Osobola okubuuza kyonna.”\n'
              '3. Buuza ekibuuzo ekimu, oluvannyuma wuliriza.\n'
              '4. Bw\'atayagala, gamba nti oluggi luggule.\n\n'
              'Tokozesa ebigambo eby\'entiisa.'
          : 'Start the home conversation without a lecture:\n\n'
              '1. Pick a quiet moment, not a scolding.\n'
              '2. Say: “I want us to talk about your body. You can ask me anything.”\n'
              '3. Ask one question, then listen longer than you speak.\n'
              '4. If she is not ready, leave the door open.\n\n'
              'Avoid fear language. You are building trust, not a test.',
    );
  }

  if (q.contains('boundary') || q.contains('hug') || q.contains('touch') || q.contains('no')) {
    return AiReply(
      text: lg
          ? 'Yogera nti omubiri gwa ye:\n\n'
              '“Ososola ani akukwatako. Okwagala tekutegeeza nti kirina okukumbumbatirwa.”\n'
              'Muyigirize: “Nedda webale.” “Nkwebaza lekerawo.”\n'
              'Ekyama ekikulumya tekiba kya birthday — kiba kya kugamba omuntu oweesigwa.'
          : 'Teach that her body is hers:\n\n'
              '“You choose who touches you. Love does not mean you must hug.”\n'
              'Practice: “No thank you.” “Please stop.”\n'
              'A secret that hurts is not a birthday surprise — it is something to tell a trusted adult.',
    );
  }

  return AiReply(
    text: lg
        ? 'Bloom eyamba abakulu, si kudda mu kifo kyabwe.\n\n'
            'Gezaako:\n'
            '• “Nnyonnyola period mu kibiina ntya?”\n'
            '• “Ntandika okwogera ku mubiri ntya?”\n'
            '• “Mpadde ebigambo mu Luganda.”\n\n'
            'Bw\'oba olaba akabi, kuba 116 oba Report Concern.'
        : 'Bloom strengthens you — it does not replace you.\n\n'
            'Try a more specific ask, for example:\n'
            '• “How do I explain menstruation simply to my class?”\n'
            '• “How do I start a conversation about body safety?”\n'
            '• “How do I say this in Luganda?”\n\n'
            'If this is about harm or a secret that feels unsafe, use Report Concern or call 116.',
  );
}
