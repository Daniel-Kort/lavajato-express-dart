// Classe abstrata: não dá para criar um "Servico" direto, só os filhos
// (LavagemSimples e HigienizacaoDetalhada).
abstract class Servico {
  // No Java esses atributos eram "protected". No Dart, o "_" torna o
  // atributo privado ao ARQUIVO, então os filhos (em outros arquivos)
  // não conseguiriam usar. Por isso ficam públicos e final.
  final int idServico;
  final String nome;
  final double valorBase;
  final int duracaoMinutos;

  Servico({
    required this.idServico,
    required this.nome,
    required this.valorBase,
    required this.duracaoMinutos,
  });

  // Método abstrato: cada filho é obrigado a escrever o seu.
  double calcularPreco(String porteVeiculo);

  @override
  String toString() =>
      'ID: $idServico | Serviço: $nome | Valor Base: R\$ ${valorBase.toStringAsFixed(2)}';
}
