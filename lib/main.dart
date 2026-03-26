import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PsychologyApp());
}

class PsychologyApp extends StatelessWidget {
  const PsychologyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experimento Lei da Igualação',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ModeSelectionScreen(),
    );
  }
}

// TELA DE SELEÇÃO DE MODO
class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Seleção de Modo"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Selecione o Modo do Experimento",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 60),
            _buildModeButton(
              context,
              label: "Modo Teste",
              description: "Para pesquisadores\n(Mostra painel de debug)",
              color: Colors.orange,
              isTestMode: true,
            ),
            const SizedBox(height: 40),
            _buildModeButton(
              context,
              label: "Modo Efetivo",
              description: "Aplicação efetiva\n(Sem informações debug)",
              color: Colors.green,
              isTestMode: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required String label,
    required String description,
    required Color color,
    required bool isTestMode,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InstructionsScreen(isTestMode: isTestMode),
          ),
        );
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TELA DE INSTRUÇÕES
class InstructionsScreen extends StatelessWidget {
  final bool isTestMode;

  const InstructionsScreen({super.key, required this.isTestMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Instruções do Experimento"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Como Ganhar Pontos",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            _buildInstructionCard(
              icon: Icons.touch_app,
              title: "Pressione os Botões",
              description:
                  "Existem dois botões na tela: BOTÃO 1 e BOTÃO 2.\n\nPressione qualquer um deles para ganhar pontos.",
            ),
            const SizedBox(height: 16),
            _buildInstructionCard(
              icon: Icons.star,
              title: "Ganhe Pontos",
              description:
                  "Cada vez que você pressiona um botão, você acumula cliques.\n\nAo atingir um número específico de cliques, você ganha 1 ponto!",
            ),
            const SizedBox(height: 16),
            _buildInstructionCard(
              icon: Icons.timer,
              title: "Duração do Experimento",
              description:
                  "O experimento dura 20 minutos no total.\n\nEle é dividido em 2 fases de 10 minutos cada.",
            ),
            const SizedBox(height: 16),
            _buildInstructionCard(
              icon: Icons.target,
              title: "Seu Objetivo",
              description:
                  "Ganhe o máximo de pontos possível durante o experimento.\n\nVocê pode escolher qualquer estratégia!",
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExperimentScreen(isTestMode: isTestMode),
                    ),
                  );
                },
                child: const Text(
                  "Iniciar Experimento",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.left(
          color: Colors.blue,
          width: 4,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExperimentScreen extends StatefulWidget {
  final bool isTestMode;

  const ExperimentScreen({super.key, this.isTestMode = false});

  @override
  State<ExperimentScreen> createState() => _ExperimentScreenState();
}

class _ExperimentScreenState extends State<ExperimentScreen> {
  // --- CONFIGURAÇÕES DO EXPERIMENTO ---
  static const int minutesPerPhase = 10;
  late DateTime startTime;
  bool isFinished = false;
  bool isPhaseTwo = false;
  Timer? _ticker;

  // --- ESTADO DO PARTICIPANTE ---
  int totalPoints = 0;
  String participantId = "PART_${Random().nextInt(9999)}";

  // --- LÓGICA DE CICLO VR (Reseta a cada ponto ganho) ---
  int currentClicksA = 0;
  int currentClicksB = 0;
  late int targetA;
  late int targetB;
  final Random _random = Random();

  // --- ACUMULADORES PARA O RESULTADO (VD e VI) ---
  int clicksA_F1 = 0, clicksB_F1 = 0, pointsA_F1 = 0, pointsB_F1 = 0;
  int clicksA_F2 = 0, clicksB_F2 = 0, pointsA_F2 = 0, pointsB_F2 = 0;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    _resetTargets();

    // Ticker de alta frequência para monitorar o tempo real e trocar fases
    _ticker = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => _updateState(),
    );
  }

  void _resetTargets() {
    // Fase 1: A(VR10), B(VR20) | Fase 2: A(VR20), B(VR10)
    targetA = _generateVR(isPhaseTwo ? 20 : 10);
    targetB = _generateVR(isPhaseTwo ? 10 : 20);
  }

  int _generateVR(int mean) => _random.nextInt(mean * 2 - 1) + 1;

  void _updateState() {
    final now = DateTime.now();
    final elapsed = now.difference(startTime);

    setState(() {
      if (elapsed.inMinutes < minutesPerPhase) {
        isPhaseTwo = false;
      } else if (elapsed.inMinutes < minutesPerPhase * 2) {
        if (!isPhaseTwo) {
          isPhaseTwo = true;
          currentClicksA = 0; // Reset técnico na virada de fase
          currentClicksB = 0;
          _resetTargets();
        }
      } else {
        isFinished = true;
        _ticker?.cancel();
      }
    });
  }

  void _handlePress(String button) {
    if (isFinished) return;

    setState(() {
      if (button == 'A') {
        // Incrementa estatística global da fase
        isPhaseTwo ? clicksA_F2++ : clicksA_F1++;
        // Incrementa contador do ciclo atual (para o próximo ponto)
        currentClicksA++;

        if (currentClicksA >= targetA) {
          totalPoints++;
          isPhaseTwo ? pointsA_F2++ : pointsA_F1++;
          currentClicksA = 0; // RESET DO CICLO
          targetA = _generateVR(isPhaseTwo ? 20 : 10);
        }
      } else {
        isPhaseTwo ? clicksB_F2++ : clicksB_F1++;
        currentClicksB++;

        if (currentClicksB >= targetB) {
          totalPoints++;
          isPhaseTwo ? pointsB_F2++ : pointsB_F1++;
          currentClicksB = 0; // RESET DO CICLO
          targetB = _generateVR(isPhaseTwo ? 10 : 20);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isFinished) return _buildResultsScreen();

    final now = DateTime.now();
    final elapsed = now.difference(startTime);
    final remaining = Duration(minutes: minutesPerPhase * 2) - elapsed;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "PONTOS: $totalPoints",
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildExperimentalButton("BOTÃO 1", () => _handlePress('A')),
                const SizedBox(width: 50),
                _buildExperimentalButton("BOTÃO 2", () => _handlePress('B')),
              ],
            ),
            // Monitor de monitoramento (Apenas em Modo Teste)
            if (widget.isTestMode) ...[
              const SizedBox(height: 100),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const Text(
                      "PAINEL DO PESQUISADOR (DEBUG)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Tempo Restante: ${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}",
                    ),
                    Text(
                      "Fase Atual: ${isPhaseTwo ? '2 (A:VR20, B:VR10)' : '1 (A:VR10, B:VR20)'}",
                    ),
                    Text(
                      "Alvos Atuais: A=$targetA ($currentClicksA), B=$targetB ($currentClicksB)",
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildExperimentalButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: 220,
      height: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados do Experimento"),
        backgroundColor: Colors.blueGrey[50],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID Participante: $participantId",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _resultTable(),
            const SizedBox(height: 40),
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Instrução para análise: Calcule a proporção de respostas (B1/B2) e a proporção de reforços (R1/R2) para cada fase para verificar a Lei da Igualação.",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultTable() {
    return Table(
      border: TableBorder.all(color: Colors.black54),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1.5),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.black12),
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Métrica",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Fase 1 (A:VR10, B:VR20)",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Fase 2 (A:VR20, B:VR10)",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        _row("Total de Cliques Botão A (B1)", clicksA_F1, clicksA_F2),
        _row("Total de Cliques Botão B (B2)", clicksB_F1, clicksB_F2),
        _row("Pontos Obtidos Botão A (R1)", pointsA_F1, pointsA_F2),
        _row("Pontos Obtidos Botão B (R2)", pointsB_F1, pointsB_F2),
      ],
    );
  }

  TableRow _row(String label, int f1, int f2) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(12), child: Text(label)),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(f1.toString(), textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(f2.toString(), textAlign: TextAlign.center),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
