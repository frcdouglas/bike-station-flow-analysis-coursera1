SELECT -- Seleciona o tipo de usuário, a rota e métricas agregadas
  usertype, -- Tipo de usuário (Subscriber ou Customer)
  CONCAT(start_station_name, ' to ',end_station_name) AS route, -- Concatena o nome da estação de início com o nome da estação final
  COUNT(*) AS num_trips, -- Conta o número total de viagens para cada rota
  ROUND(AVG(CAST(tripduration AS INT64)/60),2) AS duration -- Calcula a duração média da viagem em minutos
  
FROM
  `bigquery-public-data.new_york_citibike.citibike_trips`-- Dataset público no BigQuery
  
WHERE 
  start_station_name != '' AND end_station_name != '' -- Garante que ambas as estações (início e fim) estão preenchidas
  
GROUP BY -- Agrupa por estação de início, estação final e tipo de usuário
  start_station_name,
  end_station_name,
  usertype
  
ORDER BY -- Ordena pelo número de viagens em ordem decrescente
  num_trips DESC
  
LIMIT 10 -- Limita o resultado às 10 rotas mais populares
