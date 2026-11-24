class Cliente {
  final String cpf;
  final String nome;

  // O "?" depois do tipo significa que o valor PODE ser nulo.
  // Aqui o telefone virou opcional (no Java era obrigatório).
  final String? telefone;

  Cliente({
    required this.cpf,
    required this.nome,
    this.telefone,
  });

  // "??" usa o valor da direita quando o da esquerda é nulo.
  String get contato => telefone ?? 'Sem telefone';

  @override
  String toString() => 'Cliente: $nome | CPF: $cpf | Tel: $contato';
}
