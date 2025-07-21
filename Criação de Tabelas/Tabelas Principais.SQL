-- ========================
-- SCRIPT: TABELAS PRINCIPAIS
-- Autor: Cássio Bressan Nunes
-- Data: 04/07/2025
-- ========================
-- Tabela de raças de cães.
CREATE TABLE breeds ( 
    breed_id INT AUTO_INCREMENT PRIMARY KEY,
    breed_name VARCHAR(100),
    country_of_origin VARCHAR(100),
    min_inch INT,
    max_inch INT,
    min_longevity INT,
    max_longevity INT
);
-- Tabela de cores do pelo.
CREATE TABLE fur_colors (
    fur_color_id INT AUTO_INCREMENT PRIMARY KEY,
    fur_color VARCHAR(100)
);
-- Tabela de cores dos olhos.
CREATE TABLE eye_colors (
	eye_color_id INT AUTO_INCREMENT PRIMARY KEY,
	eye_color VARCHAR(100)
);
-- Tabela de traços de comportamento.
CREATE TABLE character_traits (
	trait_id INT AUTO_INCREMENT PRIMARY KEY,
	trait VARCHAR(100)
);
-- Tabela de problemas de saúde.
CREATE TABLE health_problems ( 
	problem_id INT AUTO_INCREMENT PRIMARY KEY,
    problem VARCHAR(100)
);

-- ===== FIM DO SCRIPT =====