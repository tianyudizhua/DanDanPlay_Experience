// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HUDMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HUDMessage _$HUDMessageFromJson(Map<String, dynamic> json) {
  return HUDMessage(
      style: _$enumDecodeNullable(_$HUDMessageStyleEnumMap, json['style']),
      text: json['text'] as String,
      progress: (json['progress'] as num)?.toDouble(),
      isDismiss: json['isDismiss'] as bool,
      key: json['key'] as String);
}

Map<String, dynamic> _$HUDMessageToJson(HUDMessage instance) =>
    <String, dynamic>{
      'style': _$HUDMessageStyleEnumMap[instance.style],
      'text': instance.text,
      'progress': instance.progress,
      'isDismiss': instance.isDismiss,
      'key': instance.key
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$HUDMessageStyleEnumMap = <HUDMessageStyle, dynamic>{
  HUDMessageStyle.tips: 'tips',
  HUDMessageStyle.progress: 'progress'
};
