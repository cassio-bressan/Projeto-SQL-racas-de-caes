-- ========================
-- SCRIPT: TABELAS INTERMEDIÁRIAS
-- Autor: Cássio Bressan Nunes
-- Data: 07/07/2025
-- ========================
-- Tabela intermediária para relacionar raças com cores dos olhos.
CREATE TABLE breed_eye_color (
    breed_id INT,
    eye_color_id INT,
    PRIMARY KEY (breed_id, eye_color_id),
    FOREIGN KEY (breed_id) REFERENCES breeds(breed_id),
    FOREIGN KEY (eye_color_id) REFERENCES eye_colors(eye_color_id)
);
-- Tabela intermediária para relacionar raças com cores da pelagem.
CREATE TABLE breed_fur_color (
	breed_id INT,
	fur_color_id INT, 
    PRIMARY KEY (breed_id,fur_color_id),
    FOREIGN KEY (breed_id) REFERENCES breeds(breed_id),
    FOREIGN KEY (fur_color_id) REFERENCES fur_colors(fur_color_id)
);
-- Tabela intermediária para relacionar raças com traços de comportamento.
CREATE TABLE breed_traits (
	breed_id INT, 
    trait_id INT, 
    PRIMARY KEY (breed_id,trait_id),
    FOREIGN KEY (breed_id) REFERENCES breeds(breed_id),
    FOREIGN KEY (trait_id) REFERENCES character_traits(trait_id)
);
-- Tabela intermediária para relacionar raças com problemas de saúde.
CREATE TABLE breed_hp (
	breed_id INT, 
	problem_id INT,
    PRIMARY KEY (breed_id,problem_id),
    FOREIGN KEY (breed_id) REFERENCES breeds(breed_id),
    FOREIGN KEY (problem_id) REFERENCES health_problems(problem_id)
);

-- ===== FIM DO SCRIPT =====