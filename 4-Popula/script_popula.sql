INSERT INTO proprietario 
(cpf, nome, endereco, bairro, cidade, estado, sexo, data_nascimento, idade)
VALUES
('12345678901', 'Carlos Henrique Silva', 'Rua das Palmeiras, 120', 'Centro', 'Brasília', 'DF', 'M', '1985-04-12', 39),
('23456789012', 'Mariana Alves Souza', 'Avenida Brasil, 450', 'Asa Norte', 'Brasília', 'DF', 'F', '1992-08-23', 32),
('34567890123', 'Roberto Lima Costa', 'Rua Goiás, 88', 'Taguatinga', 'Brasília', 'DF', 'M', '1978-11-05', 46),
('45678901234', 'Fernanda Martins Rocha', 'Quadra 15, Casa 30', 'Ceilândia', 'Brasília', 'DF', 'F', '1999-02-17', 25),
('56789012345', 'João Pedro Fernandes', 'Rua Minas Gerais, 210', 'Guará', 'Brasília', 'DF', 'M', '2001-06-30', 23);

INSERT INTO telefone_proprietario 
(cpf_proprietario, numero)
VALUES
('12345678901', '61999990001'),
('23456789012', '61999990002'),
('34567890123', '61999990003'),
('45678901234', '61999990004'),
('56789012345', '61999990005');

INSERT INTO modelo 
(codigo_modelo, nome_modelo)
VALUES
('100001', 'GOL MI'),
('100002', 'GOL 1.8'),
('100003', 'UNO CS'),
('100004', 'COROLLA XEI'),
('100005', 'HB20 COMFORT');

INSERT INTO categoria 
(codigo_categoria, nome_categoria)
VALUES
('01', 'AUTOMÓVEL'),
('02', 'MOTOCICLETA'),
('03', 'CAMINHÃO'),
('04', 'ÔNIBUS'),
('05', 'CAMINHONETE');

INSERT INTO veiculo 
(placa, chassi, cor_predominante, ano_fabricacao, cpf_proprietario, codigo_modelo, codigo_categoria)
VALUES
('ABC1234', '9BWZZZ377VT004251', 'PRATA', 2010, '12345678901', '100001', '01'),
('DEF5678', '8AFZZZ54ATJ123456', 'PRETO', 2015, '23456789012', '100002', '01'),
('GHI9012', '9BD14600003012345', 'BRANCO', 2008, '34567890123', '100003', '01'),
('JKL3456', '9BRBLWHE7F0123456', 'CINZA', 2020, '45678901234', '100004', '01'),
('MNO7890', '9BHBG51DBNP123456', 'VERMELHO', 2022, '56789012345', '100005', '01');

INSERT INTO tipo_infracao 
(codigo_tipo, descricao, valor)
VALUES
(1, 'AVANÇO DE SINAL VERMELHO', 293.47),
(2, 'PARADA SOBRE A FAIXA DE PEDESTRES', 195.23),
(3, 'EXCESSO DE VELOCIDADE', 130.16),
(4, 'ESTACIONAMENTO EM LOCAL PROIBIDO', 88.38),
(5, 'USO DE CELULAR AO VOLANTE', 293.47);

INSERT INTO local_infracao 
(latitude, longitude, velocidade_permitida)
VALUES
(-15.793889, -47.882778, 60),
(-15.780148, -47.929169, 80),
(-15.837222, -48.021111, 60),
(-15.765000, -47.871944, 50),
(-15.823056, -47.921389, 70);

INSERT INTO agente_transito 
(matricula, nome, data_contratacao, tempo_servico_meses)
VALUES
(1001, 'Paulo Sérgio Almeida', '2015-03-10', 118),
(1002, 'Ana Clara Mendes', '2018-07-21', 78),
(1003, 'Ricardo Gomes Pereira', '2020-01-15', 60),
(1004, 'Luciana Ferreira Dias', '2012-11-05', 146),
(1005, 'Marcos Vinícius Torres', '2021-09-30', 39);

INSERT INTO infracao 
(placa_veiculo, data_hora, codigo_tipo, latitude, longitude, velocidade_aferida, matricula_agente)
VALUES
('ABC1234', '2024-03-10 08:30:00', 1, -15.793889, -47.882778, NULL, 1001),
('DEF5678', '2024-03-12 14:45:00', 3, -15.780148, -47.929169, 95, 1002),
('GHI9012', '2024-04-02 09:15:00', 2, -15.837222, -48.021111, NULL, 1003),
('JKL3456', '2024-04-15 17:20:00', 5, -15.765000, -47.871944, NULL, 1004),
('MNO7890', '2024-05-01 11:10:00', 4, -15.823056, -47.921389, NULL, 1005);