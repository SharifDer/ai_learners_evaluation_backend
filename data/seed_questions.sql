-- Seed Tracks
INSERT OR IGNORE INTO tracks (name, description) VALUES 
('ML', 'Machine Learning Engineer Track'),
('DS', 'Data Scientist Track');

-- ============================================
-- ML TRACK QUESTIONS (track_id = 1)
-- ============================================

-- FOUNDATIONS (Questions 1-10)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (1, 'Which best describes your Python experience?', 'Foundations', 1, 'beginner', 1);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(1, 'I''ve completed online courses/tutorials', 50, 1),
(1, 'I use Python daily for ML/data work', 100, 2),
(1, 'I''ve never written Python code', 0, 3),
(1, 'I''ve built 2-3 complete projects', 75, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (2, 'You''re merging branches and Git shows conflicts in 3 files. What do you do?', 'Foundations', 1, 'beginner', 2);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(2, 'Ask a senior developer for help immediately', 25, 1),
(2, 'Manually resolve conflicts, test, then commit', 100, 2),
(2, 'Delete my branch and start over', 0, 3),
(2, 'Use "accept all incoming" to overwrite', 50, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (3, 'Which describes your experience working with APIs?', 'Foundations', 1, 'beginner', 3);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(3, 'I''ve consumed external APIs in projects (authentication, parsing responses)', 75, 1),
(3, 'I understand REST concepts but haven''t implemented it', 50, 2),
(3, 'I''ve built APIs that others consumed', 100, 3),
(3, 'I''ve never worked with APIs', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (4, 'You deployed a model API. Users send malformed data that crashes it. What do you do?', 'Foundations', 1, 'intermediate', 4);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(4, 'Add input validation and return clear error messages', 100, 1),
(4, 'Ask users to fix their data first', 25, 2),
(4, 'Wrap everything in try-except and return "error"', 50, 3),
(4, 'This hasn''t happened to me yet', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (5, 'Your manager asks: "Is 87% accuracy good?" What''s your response?', 'Foundations', 1, 'intermediate', 5);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(5, '"Yes, that''s high accuracy"', 25, 1),
(5, '"I need to check the baseline and business context first"', 100, 2),
(5, '"We should aim for at least 90%"', 50, 3),
(5, '"I''m not sure how to answer that"', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (6, 'You built a model: 94% train accuracy, 68% test accuracy. What do you do next?', 'Foundations', 1, 'intermediate', 6);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(6, 'Get more training data to improve both', 50, 1),
(6, 'Simplify the model or add regularization', 100, 2),
(6, 'Retrain with different random seed', 40, 3),
(6, 'I haven''t faced this situation yet', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (7, 'You''re predicting house prices. One feature is "total_price_sold_for." What''s wrong?', 'Foundations', 1, 'intermediate', 7);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(7, 'Nothing, more features are better', 25, 1),
(7, 'This is the target variable, causes data leakage', 100, 2),
(7, 'It should be normalized first', 30, 3),
(7, 'I''m not sure what the issue is', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (8, 'Which describes your debugging approach?', 'Foundations', 1, 'beginner', 8);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(8, 'I Google error messages and try solutions', 50, 1),
(8, 'I read stack traces, use print statements, test hypotheses systematically', 75, 2),
(8, 'I ask for help on forums immediately', 25, 3),
(8, 'I use debuggers (pdb, IDE breakpoints) and logging', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (9, 'Which describes your experience with testing code?', 'Foundations', 1, 'beginner', 9);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(9, 'I manually test my code by running it', 50, 1),
(9, 'I''ve written unit tests for functions', 75, 2),
(9, 'I''ve never written formal tests', 0, 3),
(9, 'I''ve implemented both unit and integration tests', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (10, 'You built an accurate model but it takes 30 seconds per prediction. Stakeholder needs <1 second. What do you do?', 'Foundations', 1, 'intermediate', 10);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(10, 'Tell them it''s impossible without sacrificing accuracy', 25, 1),
(10, 'Investigate model simplification or optimization techniques', 100, 2),
(10, 'Buy better hardware for deployment', 50, 3),
(10, 'I haven''t dealt with this tradeoff yet', 0, 4);

-- APPLIED ML (Questions 11-20)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (11, 'Which describes your experience with real-world data?', 'Applied ML', 1, 'beginner', 11);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(11, 'I''ve only worked with clean tutorial datasets (Iris, MNIST, etc.)', 50, 1),
(11, 'I''ve cleaned messy data with missing values and inconsistencies', 75, 2),
(11, 'I''ve handled production data quality issues and edge cases', 100, 3),
(11, 'I''ve never worked with actual datasets', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (12, 'You notice labels are inconsistent - same input has different labels. What happened?', 'Applied ML', 1, 'intermediate', 12);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(12, 'Random labeling errors from annotators', 50, 1),
(12, 'I investigate the guidelines and discuss with labeling team', 100, 2),
(12, 'The model will learn despite noise', 0, 3),
(12, 'I filter out inconsistent examples', 40, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (13, 'Your deployed model was 80% accurate last month, now it''s 65%. What''s your first hypothesis?', 'Applied ML', 1, 'intermediate', 13);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(13, 'The model file got corrupted somehow', 25, 1),
(13, 'Input data distribution has changed over time', 100, 2),
(13, 'Need to retrain with more data', 50, 3),
(13, 'I haven''t monitored production models yet', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (14, 'Which describes your feature engineering experience?', 'Applied ML', 1, 'intermediate', 14);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(14, 'I use raw data columns as-is for models', 50, 1),
(14, 'I''ve created features based on domain knowledge', 75, 2),
(14, 'I''ve iterated on features using error analysis and validation performance', 100, 3),
(14, 'I''ve only worked with provided features', 25, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (15, 'Have you worked with highly imbalanced datasets in practice?', 'Applied ML', 1, 'intermediate', 15);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(15, 'Yes, I''ve tried resampling or class weights with mixed results', 75, 1),
(15, 'I''ve read about it but haven''t encountered it', 50, 2),
(15, 'Yes, I''ve handled it by changing evaluation metrics and thresholds', 100, 3),
(15, 'No, my datasets were balanced', 25, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (16, 'How do you choose between different models in practice?', 'Applied ML', 1, 'intermediate', 16);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(16, 'I pick what I''m comfortable with (usually random forest)', 50, 1),
(16, 'I try several and compare validation performance vs complexity', 100, 2),
(16, 'I always use the most advanced algorithm available', 25, 3),
(16, 'I haven''t made this decision on a real project', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (17, 'Your model suddenly predicts the same class for all inputs. What do you check first?', 'Applied ML', 1, 'intermediate', 17);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(17, 'Retrain from scratch with different parameters', 50, 1),
(17, 'Check if input data has changed or preprocessing broke', 100, 2),
(17, 'The model needs more training epochs', 25, 3),
(17, 'I''m not sure where to start debugging', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (18, 'You''ve tried everything but model is stuck at 75% accuracy. What''s your next move?', 'Applied ML', 1, 'intermediate', 18);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(18, 'Analyze errors systematically to find patterns', 100, 1),
(18, 'Try more complex algorithms with more parameters', 40, 2),
(18, 'This is probably the best possible performance', 25, 3),
(18, 'Collect more training data automatically', 60, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (19, 'Which describes your ML project approach?', 'Applied ML', 1, 'intermediate', 19);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(19, 'Build the best possible model from the start', 25, 1),
(19, 'I start with simple baseline, then iterate based on what''s failing', 100, 2),
(19, 'Try many algorithms and pick the best one', 50, 3),
(19, 'I haven''t completed an end-to-end ML project', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (20, 'Your notebook model works great. What''s needed to productionize it?', 'Applied ML', 1, 'advanced', 20);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(20, 'Just export the model file, it should work', 25, 1),
(20, 'Clean code, handle edge cases, add error handling, manage dependencies', 100, 2),
(20, 'Rewrite everything in a different language', 50, 3),
(20, 'I''ve never deployed a model to production', 0, 4);

-- OPERATIONAL ML (Questions 21-28)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (21, 'Which describes your experience building APIs?', 'Operational ML', 1, 'intermediate', 21);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(21, 'I''ve never built an API endpoint', 0, 1),
(21, 'I followed a tutorial to create basic endpoints', 50, 2),
(21, 'I''ve built APIs for projects with routing and validation', 75, 3),
(21, 'I''ve deployed production APIs with error handling and documentation', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (22, 'Which describes your experience with web frameworks (FastAPI/Flask/Django)?', 'Operational ML', 1, 'beginner', 22);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(22, 'I''ve completed a tutorial or course', 50, 1),
(22, 'I''ve never used web frameworks', 0, 2),
(22, 'I''ve built and deployed applications using them', 75, 3),
(22, 'I use them regularly for projects', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (23, 'Which describes your Docker experience?', 'Operational ML', 1, 'intermediate', 23);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(23, 'I''ve written Dockerfiles and managed containers for projects', 75, 1),
(23, 'I''ve never used Docker', 0, 2),
(23, 'I followed a tutorial and ran containers locally', 50, 3),
(23, 'I''ve debugged Docker-related issues in deployment', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (24, 'Which describes your experience with databases?', 'Operational ML', 1, 'beginner', 24);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(24, 'I''ve designed schemas and implemented CRUD operations', 100, 1),
(24, 'I save data to CSV/JSON files', 40, 2),
(24, 'I''ve never worked with databases', 0, 3),
(24, 'I''ve used databases with ORM or raw SQL queries', 75, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (25, 'How do you track different model versions in practice?', 'Operational ML', 1, 'intermediate', 25);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(25, 'I don''t track versions systematically yet', 0, 1),
(25, 'I manually rename model files with dates or v1, v2', 50, 2),
(25, 'I use tools like MLflow, DVC, or similar for tracking', 100, 3),
(25, 'I overwrite the old model file', 25, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (26, 'Have you monitored deployed models?', 'Operational ML', 1, 'advanced', 26);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(26, 'No, I haven''t deployed models to production', 0, 1),
(26, 'Yes, I track basic metrics like error rates', 75, 2),
(26, 'Yes, I monitor latency, errors, and data drift', 100, 3),
(26, 'I deployed but didn''t implement monitoring', 40, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (27, 'Which describes your approach to Python dependencies?', 'Operational ML', 1, 'beginner', 27);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(27, 'I don''t manage dependencies specifically', 0, 1),
(27, 'I use requirements.txt with version pins', 75, 2),
(27, 'I use poetry/conda with environments and lock files', 100, 3),
(27, 'I share my code and hope it works elsewhere', 25, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (28, 'Your model API works locally but fails in production. What do you do?', 'Operational ML', 1, 'intermediate', 28);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(28, 'I haven''t deployed to production yet', 0, 1),
(28, 'Check environment variables, dependencies, and logs', 100, 2),
(28, 'Restart the server and hope it works', 25, 3),
(28, 'Copy production data and reproduce locally', 80, 4);

-- ============================================
-- DS TRACK QUESTIONS (track_id = 2)
-- ============================================

-- FOUNDATIONS (Questions 29-38 - Same as ML Foundations)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (29, 'Which best describes your Python experience?', 'Foundations', 2, 'beginner', 1);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(29, 'I''ve completed online courses/tutorials', 50, 1),
(29, 'I use Python daily for ML/data work', 100, 2),
(29, 'I''ve never written Python code', 0, 3),
(29, 'I''ve built 2-3 complete projects', 75, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (30, 'You''re merging branches and Git shows conflicts in 3 files. What do you do?', 'Foundations', 2, 'beginner', 2);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(30, 'Ask a senior developer for help immediately', 25, 1),
(30, 'Manually resolve conflicts, test, then commit', 100, 2),
(30, 'Delete my branch and start over', 0, 3),
(30, 'Use "accept all incoming" to overwrite', 50, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (31, 'Which describes your experience working with APIs?', 'Foundations', 2, 'beginner', 3);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(31, 'I''ve consumed external APIs in projects (authentication, parsing responses)', 75, 1),
(31, 'I understand REST concepts but haven''t implemented it', 50, 2),
(31, 'I''ve built APIs that others consumed', 100, 3),
(31, 'I''ve never worked with APIs', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (32, 'You deployed a model API. Users send malformed data that crashes it. What do you do?', 'Foundations', 2, 'intermediate', 4);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(32, 'Add input validation and return clear error messages', 100, 1),
(32, 'Ask users to fix their data first', 25, 2),
(32, 'Wrap everything in try-except and return "error"', 50, 3),
(32, 'This hasn''t happened to me yet', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (33, 'Your manager asks: "Is 87% accuracy good?" What''s your response?', 'Foundations', 2, 'intermediate', 5);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(33, '"Yes, that''s high accuracy"', 25, 1),
(33, '"I need to check the baseline and business context first"', 100, 2),
(33, '"We should aim for at least 90%"', 50, 3),
(33, '"I''m not sure how to answer that"', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (34, 'You built a model: 94% train accuracy, 68% test accuracy. What do you do next?', 'Foundations', 2, 'intermediate', 6);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(34, 'Get more training data to improve both', 50, 1),
(34, 'Simplify the model or add regularization', 100, 2),
(34, 'Retrain with different random seed', 40, 3),
(34, 'I haven''t faced this situation yet', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (35, 'You''re predicting house prices. One feature is "total_price_sold_for." What''s wrong?', 'Foundations', 2, 'intermediate', 7);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(35, 'Nothing, more features are better', 25, 1),
(35, 'This is the target variable, causes data leakage', 100, 2),
(35, 'It should be normalized first', 30, 3),
(35, 'I''m not sure what the issue is', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (36, 'Which describes your debugging approach?', 'Foundations', 2, 'beginner', 8);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(36, 'I Google error messages and try solutions', 50, 1),
(36, 'I read stack traces, use print statements, test hypotheses systematically', 75, 2),
(36, 'I ask for help on forums immediately', 25, 3),
(36, 'I use debuggers (pdb, IDE breakpoints) and logging', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (37, 'Which describes your experience with testing code?', 'Foundations', 2, 'beginner', 9);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(37, 'I manually test my code by running it', 50, 1),
(37, 'I''ve written unit tests for functions', 75, 2),
(37, 'I''ve never written formal tests', 0, 3),
(37, 'I''ve implemented both unit and integration tests', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (38, 'You built an accurate model but it takes 30 seconds per prediction. Stakeholder needs <1 second. What do you do?', 'Foundations', 2, 'intermediate', 10);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(38, 'Tell them it''s impossible without sacrificing accuracy', 25, 1),
(38, 'Investigate model simplification or optimization techniques', 100, 2),
(38, 'Buy better hardware for deployment', 50, 3),
(38, 'I haven''t dealt with this tradeoff yet', 0, 4);

-- APPLIED ML for DS (Questions 39-48)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (39, 'Which describes how you approach new datasets?', 'Applied ML', 2, 'beginner', 11);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(39, 'I check summary stats, distributions, missing values systematically', 100, 1),
(39, 'I start visualizing and modeling immediately', 25, 2),
(39, 'I look at a few rows to understand structure', 50, 3),
(39, 'I''ve never analyzed a real dataset independently', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (40, 'You find 15% of dates formatted incorrectly (wrong format). What do you do?', 'Applied ML', 2, 'intermediate', 12);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(40, 'Remove those rows from analysis', 25, 1),
(40, 'Investigate the source and parse correctly', 100, 2),
(40, 'Leave them as-is and document it', 50, 3),
(40, 'I haven''t dealt with this type of issue', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (41, 'Which describes your experience with hypothesis testing?', 'Applied ML', 2, 'intermediate', 13);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(41, 'I understand the concepts but haven''t applied them', 50, 1),
(41, 'I''ve never done statistical testing', 0, 2),
(41, 'I''ve run A/B tests or used t-tests/chi-square tests', 75, 3),
(41, 'I''ve designed experiments and interpreted results carefully', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (42, 'Which describes your data visualization approach?', 'Applied ML', 2, 'beginner', 14);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(42, 'I use default charts from tools', 50, 1),
(42, 'I choose chart types based on data and message', 75, 2),
(42, 'I mostly use tables instead of charts', 25, 3),
(42, 'I''ve built interactive dashboards', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (43, 'You find suspicious values in a column. What do you do?', 'Applied ML', 2, 'intermediate', 15);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(43, 'Remove them automatically with IQR or z-score methods', 40, 1),
(43, 'Investigate the source, check if it''s errors or valid extremes', 100, 2),
(43, 'Keep them all to avoid bias', 50, 3),
(43, 'I haven''t encountered this scenario', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (44, 'Two features are highly correlated (0.9+). What do you do?', 'Applied ML', 2, 'intermediate', 16);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(44, 'Always remove one to avoid issues', 50, 1),
(44, 'Analyze based on model type and what I''m trying to achieve', 100, 2),
(44, 'Keep both, more information is better', 25, 3),
(44, 'I haven''t encountered this situation', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (45, 'You have 150 samples for analysis. Someone says "that''s not enough." How do you respond?', 'Applied ML', 2, 'intermediate', 17);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(45, 'Agree and stop the analysis', 25, 1),
(45, '"It depends on the complexity and what we''re trying to learn"', 100, 2),
(45, '"That''s plenty for any analysis"', 40, 3),
(45, 'I''m not sure how to evaluate this', 0, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (46, 'Your analysis shows pattern X, but you realize your data only covers urban areas. What''s the issue?', 'Applied ML', 2, 'intermediate', 18);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(46, 'No issue, findings are still valid', 0, 1),
(46, 'Results won''t generalize to rural areas, need to state limitations', 100, 2),
(46, 'Just need more urban data', 25, 3),
(46, 'I should have noticed this earlier', 50, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (47, 'Which describes your experience presenting findings?', 'Applied ML', 2, 'beginner', 19);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(47, 'I show stakeholders my code and explain technical details', 25, 1),
(47, 'I create reports focused on insights and actions, minimal jargon', 100, 2),
(47, 'I''ve never presented analysis to non-technical people', 0, 3),
(47, 'I share visualizations with brief explanations', 75, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (48, 'Which describes your SQL experience?', 'Applied ML', 2, 'beginner', 20);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(48, 'I can do basic SELECT queries', 50, 1),
(48, 'I''ve never used SQL', 0, 2),
(48, 'I write JOINs, aggregations, and window functions', 75, 3),
(48, 'I write complex analytical queries and understand optimization', 100, 4);

-- OPERATIONAL ML for DS (Questions 49-56)

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (49, 'Which describes your experience with automated workflows?', 'Operational ML', 2, 'intermediate', 21);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(49, 'I run analysis scripts manually when needed', 50, 1),
(49, 'I''ve never automated recurring work', 0, 2),
(49, 'I''ve scheduled scripts with cron jobs or similar', 75, 3),
(49, 'I''ve built pipelines with tools like Airflow for production', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (50, 'Which describes your experience with Tableau/Power BI/Looker?', 'Operational ML', 2, 'beginner', 22);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(50, 'I''ve explored them briefly or in tutorials', 50, 1),
(50, 'I''ve never used BI tools', 0, 2),
(50, 'I''ve created dashboards for stakeholders', 75, 3),
(50, 'I regularly build and maintain production dashboards', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (51, 'Which describes your experience with AWS/GCP/Azure?', 'Operational ML', 2, 'intermediate', 23);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(51, 'I''ve used basic services like storage or compute instances', 50, 1),
(51, 'I''ve never used cloud platforms', 0, 2),
(51, 'I''ve deployed complete data pipelines or applications to cloud', 75, 3),
(51, 'I manage cloud infrastructure for production systems', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (52, 'Which describes your experience pulling data from APIs?', 'Operational ML', 2, 'beginner', 24);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(52, 'I''ve successfully fetched data from APIs with authentication', 75, 1),
(52, 'I''ve never done this', 0, 2),
(52, 'I''ve tried but struggled with auth or rate limits', 40, 3),
(52, 'I regularly work with multiple APIs handling pagination and errors', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (53, 'How do you combine data from multiple related tables?', 'Operational ML', 2, 'beginner', 25);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(53, 'I export to CSV and merge in pandas/Excel', 50, 1),
(53, 'I write SQL JOINs directly', 75, 2),
(53, 'I don''t know how to combine tables', 0, 3),
(53, 'I write efficient JOINs and understand performance implications', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (54, 'Which describes how you version your analysis work?', 'Operational ML', 2, 'beginner', 26);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(54, 'I use Git with meaningful commits', 75, 1),
(54, 'I don''t track versions of my code', 0, 2),
(54, 'I save numbered copies manually (analysis_v1, analysis_v2)', 50, 3),
(54, 'I use Git with branching and collaboration workflows', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (55, 'How do you make your analysis reproducible?', 'Operational ML', 2, 'intermediate', 27);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(55, 'I share my Jupyter notebook file', 50, 1),
(55, 'I document dependencies (requirements.txt), environment, and setup steps', 75, 2),
(55, 'I''m not sure what''s needed for reproducibility', 0, 3),
(55, 'I write detailed READMEs and use virtual environments', 100, 4);

INSERT OR IGNORE INTO questions (id, text, category, track_id, difficulty, order_position) 
VALUES (56, 'You need to analyze production data. What''s your approach?', 'Operational ML', 2, 'intermediate', 28);

INSERT OR IGNORE INTO answer_options (question_id, option_text, score_weight, order_position) VALUES
(56, 'Query production database directly during work hours', 25, 1),
(56, 'I request a data export or use a read replica/warehouse', 100, 2),
(56, 'Wait for off-peak hours to query production', 60, 3),
(56, 'I haven''t worked with production databases', 0, 4);
