import 'package:hive/hive.dart';
import 'package:marvel_app/feature/data/models/character_model.dart';

class CharacterModelAdapter extends TypeAdapter<CharacterModel> {
  @override
  final int typeId = 0;

  @override
  CharacterModel read(BinaryReader reader) {
    return CharacterModel(
      id: reader.readInt(),
      name: reader.readString(),
      description: reader.readString(),
      image: reader.readString(),
      url: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, CharacterModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.writeString(obj.url);
  }
}
