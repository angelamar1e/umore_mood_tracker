import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:umore_mood_tracker/features/mood_entry/models/mood.dart';

final Map<String, Mood> moodTypes = {
  'crying': Mood(
    image: FileImage(File('lib/shared/assets/images/crying_face.png')),
    description: "I can't take this!",
  ),
  'angry': Mood(
    image: FileImage(File('lib/shared/assets/images/angry_face.png')),
    description: "I'm frustrated",
  ),
  'sad': Mood(
    image: FileImage(File('lib/shared/assets/images/sad_face.png')),
    description: "Meh",
  ),
  'neutral': Mood(
    image: FileImage(File('lib/shared/assets/images/neutral_face.png')),
    description: "I'm not okay",
  ),
  'happy': Mood(
    image: FileImage(File('lib/shared/assets/images/happy_face.png')),
    description: "I'm feeling good!",
  ),
};
