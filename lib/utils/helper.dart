/*
 * Created by mahmud on Sun Mar 05 2023
 * Email mahmud120398@gmail.com
 * Copyright (c) 2023 mahmud
 * Description
 */

String? getFormErrorMessageByKey(
  Map<String, List<String>>? errors,
  String key,
) {
  final isErrorField = errors?.containsKey('email') ?? false;
  if (isErrorField) return errors?[key]?.first;
  return null;
}
