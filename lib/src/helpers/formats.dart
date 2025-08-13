// Importa la librería intl para formateo de fechas.
import 'package:intl/intl.dart';

/// Formatea una fecha según el patrón y el locale especificado.
/// Ejemplo: dateTimeFormat('d MMM y', date) -> '13 ago 2025'
String dateTimeFormat(String pattern, DateTime? date, {String locale = 'es'}) {
  if (date == null) return '';
  try {
    final df = DateFormat(pattern, locale);
    return df.format(date);
  } catch (_) {
    // Si el patrón falla, retorna la fecha en formato ISO.
    return date.toIso8601String();
  }
}

/// Formatea una fecha en formato simple 'd MMM y' por defecto.
/// Ejemplo: formatDate(date) -> '13 ago 2025'
String formatDate(DateTime? date, {String locale = 'es'}) {
  if (date == null) return '';
  try {
    final df = DateFormat('d MMM y', locale);
    return df.format(date);
  } catch (_) {
    // Si el formateo falla, retorna la fecha en formato ISO.
    return date.toIso8601String();
  }
}
