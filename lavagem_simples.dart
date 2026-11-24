import 'servico.dart';

class LavagemSimples extends Servico {
  final bool incluiAspiracao;
  final String tipoShampoo;

  LavagemSimples({
    required super.idServico,
    required super.nome,
    required super.valorBase,
    required super.duracaoMinutos,
    required this.incluiAspiracao,
    required this.tipoShampoo,
  });

  // Regra de negócio: o preço sobe conforme o porte do veículo.
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
    final aspiracao = incluiAspiracao ? 'Sim' : 'Não';
    return '${super.toString()} | Lavagem Simples (Aspiração: $aspiracao, Shampoo: $tipoShampoo)';
  }
}
