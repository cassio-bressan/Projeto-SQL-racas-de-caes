### ❓Pergunta 1: Quais são as 3 doenças mais frequentes entre cães? 
**Consulta SQL utilizada:**
```sql
SELECT hp.problem,COUNT(hp.problem) AS problem_count
FROM health_problems hp
JOIN breed_hp ON breed_hp.problem_id = hp.problem_id
GROUP BY problem
ORDER BY problem_count DESC
LIMIT 3;
```
🧠 **Descoberta:** 

``As doenças mais comuns entre os cães são doenças relacionadas ao olhos, aos dentes e a pele.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 2: Quais problemas de saúde estão associados a raças que tendem a viver menos de 10 anos?
**Consulta SQL utilizada:**
```sql
WITH low_life_breeds AS(
SELECT breed_id, breed_name
FROM breeds
WHERE max_longevity <= 10
)
SELECT hp.problem, COUNT(problem) AS ocorrencias
FROM health_problems hp
JOIN breed_hp ON breed_hp.problem_id = hp.problem_id
JOIN low_life_breeds lfb ON lfb.breed_id = breed_hp.breed_id
GROUP BY hp.problem
ORDER BY ocorrencias DESC;
```
🧠 **Descoberta:** 

``As doenças mais associadas a raças com baixa expectativa de vida são: Displasia Coxofemoral, Câncer e Condições cardíacas diversas.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 3: Quantas raças existem por país?
**Consulta SQL utilizada:**
```sql
SELECT country_of_origin AS country, COUNT(breed_id) AS breed_count 
FROM breeds
GROUP BY country
ORDER BY breed_count DESC;
```
🧠 **Descoberta:**

``Ao analisar os dados, observou-se que o país com o maior número de raças caninas é a Inglaterra, com um total de 21 raças catalogadas. Em seguida, aparecem Alemanha (13 raças) e França (9 raças) como os países com maior diversidade canina``.

``Por outro lado, países como Holanda, Finlândia e África do Sul apresentam apenas 1 raça registrada cada, o que pode indicar menor diversidade ou menor reconhecimento internacional de suas raças.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 4: Quais países concentram raças com maior longevidade média?
**Consulta SQL utilizada:**
```sql
SELECT country_of_origin AS country, ROUND(AVG((min_longevity + max_longevity) / 2), 1) AS avg_longevity
FROM breeds
GROUP BY country
ORDER BY avg_longevity DESC;
```
🧠 **Descoberta:**

 ``O país que concentra as raças caninas com maior longevidade média é o México, com uma média de 14.8 anos entre suas raças.``

``Em seguida, aparecem cinco países empatados com uma longevidade média de 13.5 anos: Finlândia, Holanda, Tibet, Africa do Sul e Congo.``

``Esses dados sugerem que, embora o México lidere de forma isolada, há diversas raças longevas espalhadas por todos os continentes como Europa, Ásia e Africa.``


------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 5: Qual é o top 3 raças com a maior e menor longevidade?
**Consulta SQL utilizada:**
```sql
WITH longevity_ranking AS (
    SELECT 
        breed_name,
        max_longevity,
        DENSE_RANK() OVER (ORDER BY max_longevity DESC) AS rank_position
    FROM breeds
)
SELECT *
FROM longevity_ranking
WHERE rank_position <= 3;

WITH top_max_longevity AS (
    SELECT 
        breed_name,
        max_longevity AS longevity,
        'Maior Longevidade' AS tipo
    FROM breeds
    ORDER BY max_longevity DESC
    LIMIT 3
),
bottom_min_longevity AS (
    SELECT 
        breed_name,
        min_longevity AS longevity,
        'Menor Longevidade' AS tipo
    FROM breeds
    ORDER BY min_longevity ASC
    LIMIT 3
)

SELECT * 
FROM top_max_longevity

UNION ALL

SELECT * 
FROM bottom_min_longevity

ORDER BY tipo, longevity DESC;
```
🧠 **Descoberta:**

 ``A raça com a maior longevidade é o Chihuahua, com uma longevidade máxima de até 20 anos. Em seguida, aparecem o Cão de crista chinês(18 anos) e o Lulu da Pomerânia (16 anos) como as raças com maior expectativa de vida.``

 ``Por outro lado a raça com a menor longevidade é o Lébrel Irlândes, com uma longevidade mínima de 6 anos. Em seguida, aparecem o Pastor-alemão(7 anos) e o Bulldog(8 anos) como as raças com menor expectativa de vida.``

``Esses dados sugerem que, cães de pequeno porte tendem a possuir uma expectativa de vida consideravelmente maior que cães de grande porte.``

💡 **Curiosidade:** 

``Raças com focinho achatado (como Bulldog e Pug), resultado de cruzamentos seletivos voltados à estética, costumam ter expectativa de vida menor e uma série de problemas de saúde específicos, especialmente respiratórios.``


------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 6: Qual é a cor mais comum de olhos? E qual é a mais rara?
**Consulta SQL utilizada:**
```sql
SELECT ec.eye_color, COUNT(ec.eye_color) AS color_count
FROM eye_colors ec
JOIN breed_eye_color bec ON bec.eye_color_id = ec.eye_color_id
JOIN breeds ON breeds.breed_id = bec.breed_id
GROUP BY eye_color;
```
🧠 **Descoberta:**

``A cor de olhos castanha é a mais comum entre as raças caninas, apresentando variações que vão do tom claro ao escuro. Por outro lado, a cor cinza aparece como a mais rara no conjunto de dados. No entanto, ela está associada exclusivamente à raça Weimaraner, onde essa coloração é uma característica típica da raça. Considerando esse fator isolado, o azul pode ser considerado a cor de olhos mais raramente encontrada entre os cães de forma geral.``.

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 7: Quais cores de pelagem são mais comuns em cães? Quais as mais raras? A que raça pertencem as mais raras?
**Consulta SQL utilizada:**
```sql
SELECT fcs.fur_color, COUNT(fcs.fur_color) AS fur_color_count
FROM fur_colors fcs
JOIN breed_fur_color bfd ON bfd.fur_color_id = fcs.fur_color_id
JOIN breeds ON breeds.breed_id = bfd.breed_id
GROUP BY fur_color
ORDER BY fur_color_count DESC
LIMIT 1;
-- ========================
WITH rare_fur_colors AS(
    SELECT fcs.fur_color_id, fcs.fur_color
    FROM fur_colors fcs
    JOIN breed_fur_color bfd ON bfd.fur_color_id = fcs.fur_color_id
    GROUP BY fcs.fur_color_id, fcs.fur_color
    HAVING COUNT(*) = 1
)
SELECT rfc.fur_color, b.breed_name
FROM rare_fur_colors rfc
JOIN breed_fur_color bfd ON bfd.fur_color_id = rfc.fur_color_id
JOIN breeds b ON b.breed_id = bfd.breed_id
ORDER BY rfc.fur_color;
```
🧠 **Descoberta:**

``A cor de pelagem preta é a mais comum entre as raças caninas. Por outro lado, há 15 raças com cores de pelagem únicas nas quais eu destaco a pelagem prateada associada a raça Weimaraner, a pelagem chocolate associada a labradores e a pelagem azul merle associada a raça pastor-australiano.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 8: Quais traços de personalidade são mais comuns em raças pequenas (com altura máxima até 10 polegadas)?
**Consulta SQL utilizada:**
```sql
SELECT ct.trait, COUNT(ct.trait) AS trait_count
FROM character_traits ct
JOIN breed_traits bt ON bt.trait_id = ct.trait_id
JOIN breeds ON breeds.breed_id = bt.breed_id
WHERE breeds.max_inch <= 10
GROUP BY ct.trait
ORDER BY trait_count DESC
LIMIT 5;
```
🧠 **Descoberta:**

``De acordo com os dados, os traços de personalidade mais comuns em cães de pequeno porte de até 10 polegadas são: 	Enérgico, Temperamento estável, Elevada inteligência, Brincalhão e Afetuoso.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 9: Quais raças possuem mais de 3 cores de pelo e mais de 3 traços de personalidade?
**Consulta SQL utilizada:**
```sql
-- CTE 1: Agrupando os raças com mais de 3 cores de pelo
WITH colors AS (
	SELECT b.breed_id, b.breed_name, COUNT(fc.fur_color) AS color_count
	FROM breeds b
	JOIN breed_fur_color bfc ON bfc.breed_id = b.breed_id
	JOIN fur_colors fc ON fc.fur_color_id = bfc.fur_color_id
	GROUP BY breed_id, breed_name
	HAVING color_count > 3
),
-- CTE 2: Agrupando os raças com mais de 3 traços de personalidade
traits AS ( 
	SELECT b.breed_id, b.breed_name, COUNT(ct.trait) AS trait_count
    FROM breeds b
    JOIN breed_traits bt ON bt.breed_id = b.breed_id
    JOIN character_traits ct ON ct.trait_id = bt.trait_id
    GROUP BY breed_id, breed_name
    HAVING trait_count > 3
)
SELECT 
    c.breed_name, 
    c.color_count, 
    t.trait_count
FROM colors c
JOIN traits t ON c.breed_id = t.breed_id;
```
🧠 **Descoberta:**

``Ao analisar os dados foram encontradas 11 raças de cães que possuem grande variedade de pelagem e traços de personalidade. São elas:  Chihuahua, Basset, Dogue Alemão, Galgo Inglês, Setter Inglês, Spaniel Anão, Beagle e todas as variações da raça Poodle.``

------------------------------------------------------------------------------------------------------------------------------------
### ❓Pergunta 10: Quais raças compartilham exatamente os mesmos traços e problemas de saúde?
**Consulta SQL utilizada:**
```sql
-- CTE 1: Agrupando os traços por raça
WITH trait_signatures AS (
    SELECT
        bt.breed_id,
        GROUP_CONCAT(DISTINCT ct.trait ORDER BY ct.trait SEPARATOR ', ') AS trait_signature
    FROM breed_traits bt
    JOIN character_traits ct ON ct.trait_id = bt.trait_id
    GROUP BY bt.breed_id
),

-- CTE 2: Agrupando os problemas de saúde por raça
health_signatures AS (
    SELECT
        bh.breed_id,
        GROUP_CONCAT(DISTINCT hp.problem ORDER BY hp.problem SEPARATOR ', ') AS problem_signature
    FROM breed_hp bh
    JOIN health_problems hp ON hp.problem_id = bh.problem_id
    GROUP BY bh.breed_id
),

-- CTE 3: Juntando as duas assinaturas
breed_profiles AS (
    SELECT
        b.breed_id,
        b.breed_name,
        ts.trait_signature,
        hs.problem_signature
    FROM breeds b
    LEFT JOIN trait_signatures ts ON b.breed_id = ts.breed_id
    LEFT JOIN health_signatures hs ON b.breed_id = hs.breed_id
)

-- Consulta final: Agrupando pelas assinaturas e mostrando raças com perfis iguais
SELECT
    trait_signature,
    problem_signature,
    GROUP_CONCAT(breed_name ORDER BY breed_name SEPARATOR ', ') AS breeds_with_same_profile,
    COUNT(*) AS total_raças
FROM breed_profiles
GROUP BY trait_signature, problem_signature
HAVING COUNT(*) > 1
ORDER BY total_raças DESC;
```
🧠 **Descoberta:**

``A partir da análise cruzada entre os traços de personalidade e os problemas de saúde das raças, foi identificado que 32 raças compartilham exatamente os mesmos conjuntos de traços comportamentais e problemas de saúde.``

``Esse resultado destaca padrões comuns de criação ou seleção genética entre diferentes raças, muitas vezes refletindo funções ou perfis similares (como cães de guarda, companhia ou pastoreio).``

``Devido à quantidade de raças encontradas, a lista completa está disponível no próprio repositório em formato .csv ou .sql, caso o leitor deseje explorar em detalhes.``

------------------------------------------------------------------------------------------------------------------------------------








