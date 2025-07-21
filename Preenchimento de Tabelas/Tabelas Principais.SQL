-- ========================
-- SCRIPT: PREENCHIMENTO DAS TABELAS PRINCIPAIS (MANUAL)
-- Autor: Cássio Bressan Nunes
-- Data: 07/07/2025
-- ========================
INSERT INTO breeds (
    breed_name,
    country_of_origin,
    min_inch,
    max_inch,
    min_longevity,
    max_longevity
)
SELECT
    breed,
    country_of_origin,
    CAST(SUBSTRING_INDEX(height_inch, '-', 1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(height_inch, '-', -1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(longevity_yrs, '-', 1) AS UNSIGNED),
    CAST(SUBSTRING_INDEX(longevity_yrs, '-', -1) AS UNSIGNED)
FROM racas_caes;

INSERT INTO fur_colors(fur_color) VALUES
('Black'),
('Yellow'),
('Chocolate'),
('Tan'),
('White'),
('Red'),
('Brown'),
('Apricot'),
('Lemon'),
('Fawn'),
('Brindle'),
('Golden'),
('Orange'),
('Sable'),
('Harlequin'),
('Grey'),
('Blue'),
('Cream'),
('Silver'),
('Mahogany'),
('Light Wheaten'),
('Liver'),
('Pink'),
('Blenheim'),
('Wheaten'),
('Black & Tan'),
('Black & White'),
('Blue & Tan'),
('Salt & Pepper'),
('Blue Merle'),
('Stag Red'),
('Sesame'),
('Merle');

INSERT INTO eye_colors(eye_color) VALUES
('Brown'),
('Blue'),
('Grey');

INSERT INTO health_problems(problem) VALUES
('Hip Dysplasia'),
('Obesity'),
('Ear Infections'),
('Elbow Dysplasia'),
('Pancreatitis'),
('Skin allergies'),
('Respiratory Problems'),
('Breathing Problems'), 
('Epilepsy'),
('Bladder Stones'),
('Dental Problems'),
('Eye Problems'), 
('Cancer'),
('Heart Conditions'),
('Skin Allergies'),
('Hereditary Myopathy'),
('Intervertebral Disc Disease'),
('Diabetes');

INSERT INTO character_traits(trait) VALUES
('Friendly'),
('Loyal'),
('Intelligent'),
('Energetic'),
('Good-Natured'),
('Intelligent'),
('Protective'),
('Confident'),
('Trainable'),
('Calm'),
('Gentle'),
('Brave'),
('Active'),
('Affectionate'),
('Hypoallergenic'),
('Curious'),
('Sensitive'),
('Playful'),
('Kind'),
('Social'),
('Charming'),
('Strong'),
('Independent'),
('Patient'),
('Athletic');

-- ===== FIM DO SCRIPT =====
