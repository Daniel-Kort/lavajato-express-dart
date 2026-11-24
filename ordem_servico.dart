import 'servico.dart';
import 'veiculo.dart';

class OrdemServico {
  final int numeroOS;
  final DateTime dataHora;
  final double valorFinal;
  final Veiculo veiculo;
  final Servico servico;

  // Atributos PRIVADOS (começam com "_"): só podem ser alterados por
  // métodos desta classe. Fora daqui só dá para LER, pelos getters abaixo.
  String _status;
  bool _pagamentoConfirmado;
  bool _estornoSimulado;

  OrdemServico({
    required this.numeroOS,
    required this.veiculo,
    required this.servico,
  })  : dataHora = DateTime.now(),
        // Polimorfismo: roda o calcularPreco da classe real do serviço.
        valorFinal = servico.calcularPreco(veiculo.porte),
        _status = 'Aguardando',
        _pagamentoConfirmado = false,
        _estornoSimulado = false;

  // Getters: leitura dos atributos privados.
  String get status => _status;
  bool get pagamentoConfirmado => _pagamentoConfirmado;
  bool get estornoSimulado => _estornoSimulado;

  String get situacaoPagamento {
    if (_estornoSimulado) return 'Estorno simulado';
    return _pagamentoConfirmado ? 'Confirmado' : 'Pendente';
  }

  String get valorFormatado {
    final valor = valorFinal.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ $valor';
  }

  String get dataFormatada {
    String dois(int n) => n.toString().padLeft(2, '0');
    return '${dois(dataHora.day)}/${dois(dataHora.month)}/${dataHora.year} '
        '${dois(dataHora.hour)}:${dois(dataHora.minute)}';
  }

  // ---- Regras de negócio ----
  // Cada método devolve true se a operação foi permitida
  // e false se a regra bloqueou.

  bool iniciar() {
    if (_status != 'Aguardando') return false;
    _status = 'Lavando';
    return true;
  }

  bool concluirServico() {
    if (_status != 'Lavando') return false;
    _status = 'Concluido';
    return true;
  }

  bool confirmarPagamento() {
    if (_status == 'Cancelada' || _status == 'Finalizada' || _pagamentoConfirmado) {
      return false;
    }
    _pagamentoConfirmado = true;
    return true;
  }

  // Só finaliza com serviço concluído E pagamento confirmado.
  bool finalizar() {
    if (_status != 'Concluido' || !_pagamentoConfirmado) return false;
    _status = 'Finalizada';
    return true;
  }

  // Só cancela antes de a lavagem começar.
  bool cancelar() {
    if (_status != 'Aguardando') return false;
    _status = 'Cancelada';
    if (_pagamentoConfirmado) {
      _estornoSimulado = true;
    }
    _pagamentoConfirmado = false;
    return true;
  }

  @override
  String toString() =>
      'OS: $numeroOS | Data: $dataFormatada | Status: $_status | '
      'Veículo: ${veiculo.placa} | Serviço: ${servico.nome} | '
      'Valor final: $valorFormatado | Pagamento: $situacaoPagamento';
}
