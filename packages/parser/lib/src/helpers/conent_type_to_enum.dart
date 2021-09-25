/// * supported Content types
enum RequestContentType {
  xml,
  json,
  text,
  multiPartFormData,
  formEcoded,
}
// * convert the content type to Enum object
// ! throw exception if the content type is not supported
RequestContentType stringToContentType(List<String> string) {
  if (string.contains('multipart/form-data')) {
    return RequestContentType.multiPartFormData;
  }

  switch (string.first) {
    case 'application/xml':
      return RequestContentType.xml;
    case 'application/json':
      return RequestContentType.json;
    case 'text/plain':
      return RequestContentType.text;
    case 'application/x-www-form-urlencoded':
      return RequestContentType.formEcoded;
    default:
      // TODO :: throw palace exception
      throw '${string.first} is unsupported ';
  }
}
