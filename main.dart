import 'package:flutter/material.dart';

import 'models/cliente.dart';
import 'models/higienizacao_detalhada.dart';
import 'models/lavagem_simples.dart';
import 'models/ordem_servico.dart';
import 'models/veiculo.dart';

void main() {
  runApp(const LavaExpressApp());
}

class LavaExpressApp extends StatelessWidget {
  const LavaExpressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LavaJato Express',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const TelaOrdens(),
    );
  }
}

class TelaOrdens extends StatelessWidget {
  const TelaOrdens({super.key});

  // Cria objetos das classes do sistema (clientes, veículos, serviços)
  // e 5 ordens de serviço em estados diferentes.
  List<OrdemServico> _criarOrdens() {
    final ana = Cliente(cpf: '111.222.333-44', nome: 'Ana Souza', telefone: '(28) 99999-1111');
    final bruno = Cliente(cpf: '222.333.444-55', nome: 'Bruno Lima'); // sem telefone
    final carla = Cliente(cpf: '333.444.555-66', nome: 'Carla Mendes', telefone: '(28) 98888-2222');

    final gol = Veiculo(placa: 'ABC1D23', modelo: 'Gol', porte: 'Pequeno', dono: ana);
    final civic = Veiculo(placa: 'EFG4H56', modelo: 'Civic', porte: 'Medio', dono: bruno);
    final hilux = Veiculo(placa: 'IJK7L89', modelo: 'Hilux', porte: 'Grande', dono: carla);
    final hb20 = Veiculo(placa: 'MNO0P12', modelo: 'HB20', porte: 'Pequeno', dono: ana);
    final compass = Veiculo(placa: 'QRS3T45', modelo: 'Compass', porte: 'Grande', dono: bruno);

    final lavagem = LavagemSimples(
      idServico: 1,
      nome: 'Lavagem Simples',
      valorBase: 50.0,
      duracaoMinutos: 30,
      incluiAspiracao: true,
      tipoShampoo: 'Neutro',
    );
    final completa = LavagemSimples(
      idServico: 2,
      nome: 'Lavagem Completa',
      valorBase: 80.0,
      duracaoMinutos: 45,
      incluiAspiracao: true,
      tipoShampoo: 'Automotivo',
    );
    final higienizacao = HigienizacaoDetalhada(
      idServico: 3,
      nome: 'Higienização Detalhada',
      valorBase: 120.0,
      duracaoMinutos: 90,
      tipoCera: 'Carnaúba',
      aplicacaoOzonio: true,
    );

    final os1 = OrdemServico(numeroOS: 1, veiculo: gol, servico: lavagem);
    final os2 = OrdemServico(numeroOS: 2, veiculo: civic, servico: higienizacao);
    final os3 = OrdemServico(numeroOS: 3, veiculo: hilux, servico: completa);
    final os4 = OrdemServico(numeroOS: 4, veiculo: hb20, servico: lavagem);
    final os5 = OrdemServico(numeroOS: 5, veiculo: compass, servico: higienizacao);

    // Usando as regras de negócio para deixar cada OS num estado diferente.
    os2.iniciar(); // Lavando

    os3.iniciar();
    os3.concluirServico();
    os3.confirmarPagamento(); // Concluido e já pago

    os4.iniciar();
    os4.concluirServico();
    os4.confirmarPagamento();
    os4.finalizar(); // Finalizada

    os5.confirmarPagamento();
    os5.cancelar(); // Cancelada com estorno simulado

    return [os1, os2, os3, os4, os5];
  }

  Color _corDoStatus(String status) {
    switch (status) {
      case 'Aguardando':
        return Colors.orange;
      case 'Lavando':
        return Colors.blue;
      case 'Concluido':
        return Colors.teal;
      case 'Finalizada':
        return Colors.green;
      case 'Cancelada':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordens = _criarOrdens();

    return Scaffold(
      appBar: AppBar(
        title: const Text('LavaJato Express'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: ordens.length,
        itemBuilder: (context, index) {
          final os = ordens[index];

          return Card(
            child: ListTile(
              isThreeLine: true,
              leading: CircleAvatar(
                backgroundColor: _corDoStatus(os.status),
                foregroundColor: Colors.white,
                child: Text('${os.numeroOS}'),
              ),
              title: Text('${os.veiculo.modelo} • ${os.veiculo.placa}'),
              subtitle: Text(
                'Serviço: ${os.servico.nome}\n'
                'Cliente: ${os.veiculo.dono.nome}\n'
                'Status: ${os.status} | Pagamento: ${os.situacaoPagamento}',
              ),
              trailing: Text(
                os.valorFormatado,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
