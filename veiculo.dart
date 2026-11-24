import 'cliente.dart';

class Veiculo {
  final String placa;
  final String modelo;
  final String porte; // "Pequeno", "Medio" ou "Grande"
  final Cliente dono;

  Veiculo({
    required this.placa,
    required this.modelo,
    required this.porte,
    required this.dono,
  });

  @override
  String toString() =>
      'Veículo: $modelo ($porte) | Placa: $placa | Dono: ${dono.nome}';
}
