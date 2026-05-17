USE detran;

SELECT 
    p.cpf,
    p.nome AS proprietario,
    v.placa,
    v.chassi,
    v.cor_predominante,
    v.ano_fabricacao,
    m.nome_modelo,
    c.nome_categoria
FROM proprietario p
INNER JOIN veiculo v 
    ON p.cpf = v.cpf_proprietario
INNER JOIN modelo m 
    ON v.codigo_modelo = m.codigo_modelo
INNER JOIN categoria c 
    ON v.codigo_categoria = c.codigo_categoria
WHERE p.cpf = '12345678901';

SELECT 
    cpf,
    nome,
    endereco,
    bairro,
    cidade,
    estado,
    sexo,
    data_nascimento,
    idade
FROM proprietario
WHERE nome LIKE '%Silva%';

SELECT 
    i.id_infracao,
    i.data_hora,
    v.placa,
    v.chassi,
    v.cor_predominante,
    m.nome_modelo,
    c.nome_categoria,
    ti.descricao AS tipo_infracao,
    ti.valor,
    i.velocidade_aferida,
    l.latitude,
    l.longitude,
    l.velocidade_permitida,
    a.matricula,
    a.nome AS agente_transito
FROM infracao i
INNER JOIN veiculo v 
    ON i.placa_veiculo = v.placa
INNER JOIN modelo m 
    ON v.codigo_modelo = m.codigo_modelo
INNER JOIN categoria c 
    ON v.codigo_categoria = c.codigo_categoria
INNER JOIN tipo_infracao ti 
    ON i.codigo_tipo = ti.codigo_tipo
INNER JOIN local_infracao l 
    ON i.latitude = l.latitude 
    AND i.longitude = l.longitude
INNER JOIN agente_transito a 
    ON i.matricula_agente = a.matricula
WHERE i.data_hora BETWEEN '2024-03-01 00:00:00' AND '2024-04-30 23:59:59';

SELECT 
    m.codigo_modelo,
    m.nome_modelo,
    COUNT(v.placa) AS quantidade_veiculos
FROM modelo m
INNER JOIN veiculo v 
    ON m.codigo_modelo = v.codigo_modelo
GROUP BY 
    m.codigo_modelo,
    m.nome_modelo
ORDER BY quantidade_veiculos DESC;