import 'servico.dart';

class HigienizacaoDetalhada extends Servico {
  final String tipoCera;
  final bool aplicacaoOzonio;

  HigienizacaoDetalhada({
    required super.idServico,
    required super.nome,
    required super.valorBase,
    required super.duracaoMinutos,
    required this.tipoCera,
    required this.aplicacaoOzonio,
  });

  @override
  double calcularPreco(String porteVeiculo) {
    final porte = porteVeiculo.toLowerCase();
    double precoCalculado = valorBase;

    if (porte == 'médio' || porte == 'medio') {
      precoCalculado = valorBase + (valorBase * 0.10);
    } else if (porte == 'grande' || porte == 'suv') {
      precoCalculado = valorBase + (valorBase * 0.20);
    }

    return precoCalculado;
  }

  @override
  String toString() {
    final ozonio = aplicacaoOzonio ? 'Sim' : 'Não';
    return '${super.toString()} | Higienização Detalhada (Cera: $tipoCera, Ozônio: $ozonio)';
  }
}
