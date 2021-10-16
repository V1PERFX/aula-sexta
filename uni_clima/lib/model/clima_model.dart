class ClimaModel {
  final double temperatura;
  final double tempMin;
  final double temMax;
  final double sensacaoTermica;
  final String decricao;
  final String icone;
  final String umidade;
  final int visibilidade;
  final int pressao;

  ClimaModel(this.temperatura, this.tempMin, this.temMax, this.sensacaoTermica,
      this.decricao, this.icone, this.umidade, this.visibilidade, this.pressao);
}
