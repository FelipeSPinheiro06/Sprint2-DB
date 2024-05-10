-- Dropando as tabelas caso forem existentes
DROP TABLE FEEDBACK;
DROP TABLE COMPANY;
DROP TABLE "User";

-- Dropando as sequences caso forem existentes
DROP SEQUENCE seq_feedback;
DROP SEQUENCE seq_company;
DROP SEQUENCE seq_user;

-- 1. Criando a tabela "User"
CREATE TABLE "User" (
    id_user         INTEGER NOT NULL,
    name            VARCHAR2(60) NOT NULL,
    registration_dt DATE NOT NULL,
    is_satisfied    NUMBER NOT NULL,
    aged            NUMBER NOT NULL,
    time_of_service INTEGER NOT NULL,
    exit_forecast   DATE
);

-- 2. Adicionando a chave primária
ALTER TABLE "User" ADD CONSTRAINT user_pk PRIMARY KEY ( id_user );

-- 3. Criando a sequence e os 5 registros da tabela "User"
CREATE SEQUENCE seq_user
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;



INSERT INTO "User" (id_user, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_user.nextval, 'André', '01-01-2022', 0, 0, 18, '01-04-2023');
INSERT INTO "User" (id_user, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_user.nextval, 'Eduardo', '04-03-1990', 1, 1, 45, '08-10-2028');
INSERT INTO "User" (id_user, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_user.nextval, 'Felipe', '08-09-1985', 0, 1, 45, '02-12-2025');
INSERT INTO "User" (id_user, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_user.nextval, 'Guilherme', '05-11-2015', 1, 1, 45, '10-08-2024');
INSERT INTO "User" (id_user, name, registration_dt, is_satisfied, aged, time_of_service, exit_forecast) VALUES (seq_user.nextval, 'Matheus', '03-04-2023', 1, 1, 45, '04-01-2028');



-- 4. Criando a tabela company
CREATE TABLE company (
    id_company              INTEGER NOT NULL,
    nm_company              VARCHAR2(70) NOT NULL,
    registration_dt_company DATE,
    num_feedbacks_company   INTEGER NOT NULL,
    branch                  VARCHAR2(15) NOT NULL
);

-- 5. Adicionando a chave primária
ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( id_company );


-- 6. Criando a sequence e inserindo 5 registros nessa tabela
CREATE SEQUENCE seq_company
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;

INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Microsoft', '08-09-1985', 2, 'Omni CRM');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Amazon', '17-01-1990', 1, 'Trade');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Apple', '25-04-1983', 1, 'Omni CRM');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Samsung', '10-10-1986', 2, 'AI');
INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch) VALUES (seq_company.nextval, 'Xiaomi', '05-11-2001', 0, 'Mkt Suite');



-- 7. Criando a tabela feedback
CREATE TABLE feedback (
    id_feedback        INTEGER NOT NULL,
    nm_user            VARCHAR2(50) NOT NULL,
    feeling            VARCHAR2(20) NOT NULL,
    dt_feedback        DATE,
    company            VARCHAR2(70) NOT NULL,
    user_id_user       INTEGER NOT NULL,
    company_id_company INTEGER NOT NULL
);

-- 8. Adicionando a chave primária
ALTER TABLE feedback ADD CONSTRAINT feedback_pk PRIMARY KEY ( id_feedback );

-- 9. Adicionando as duas chaves estrangeiras
ALTER TABLE feedback
    ADD CONSTRAINT feedback_company_fk FOREIGN KEY ( company_id_company )
        REFERENCES company ( id_company );

ALTER TABLE feedback
    ADD CONSTRAINT feedback_user_fk FOREIGN KEY ( user_id_user )
        REFERENCES "User" ( id_user );
        
        
-- 10. Criando a sequence e inserindo 5 registros na tabela feedback
CREATE SEQUENCE seq_feedback
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;

INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company) VALUES (seq_feedback.nextval, 'André', 'Terrible', '15-03-2022', 'Microsoft', 1, 1);
INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company) VALUES (seq_feedback.nextval, 'Eduardo', 'Good', '07-09-1996', 'Amazon', 2, 2);
INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company) VALUES (seq_feedback.nextval, 'Felipe', 'Awesome', '09-09-2015', 'Apple', 3, 3);
INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company) VALUES (seq_feedback.nextval, 'Guilherme', 'Regular', '12-06-2023', 'Samsung', 4, 4);
INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company) VALUES (seq_feedback.nextval, 'Matheus', 'Awesome', '03-02-2024', 'Samsung', 5, 4);



-- Criação dos Blocos Anônimos




-- Bloco anônimo 1 com as 3 consultas:
--      Consulta 1: Número de feedbacks por empresa
--      Consulta 2: Número de feedbacks dos usuários satisfeitos
--      Consulta 3: Tempo médio de feedback por empresa
SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_feedback_summary IS
        SELECT c.nm_company, COUNT(f.id_feedback) AS num_feedbacks
        FROM company c
        LEFT JOIN feedback f ON c.id_company = f.company_id_company
        GROUP BY c.nm_company
        ORDER BY COUNT(f.id_feedback) DESC;

    CURSOR c_satisfied_users IS
        SELECT u.name AS user_name, COUNT(f.id_feedback) AS num_feedbacks
        FROM "User" u
        LEFT JOIN feedback f ON u.id_user = f.user_id_user
        WHERE u.is_satisfied = 1
        GROUP BY u.name
        ORDER BY COUNT(f.id_feedback) DESC;

    v_avg_feedback_time VARCHAR2(50); -- Declaração da variável para armazenar a média de tempo de feedback

BEGIN
    -- Consulta 1: Número de feedbacks por empresa
    DBMS_OUTPUT.PUT_LINE('Número de feedbacks por empresa:');
    FOR feedback_row IN c_feedback_summary LOOP
        DBMS_OUTPUT.PUT_LINE('Empresa: ' || feedback_row.nm_company || ', Número de Feedbacks: ' || feedback_row.num_feedbacks);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- Consulta 2: Número de feedbacks dos usuários satisfeitos
    DBMS_OUTPUT.PUT_LINE('Número de feedbacks dos usuários satisfeitos:');
    FOR user_row IN c_satisfied_users LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || user_row.user_name || ', Número de Feedbacks: ' || user_row.num_feedbacks);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- Consulta 3: Tempo médio de feedback por empresa
    DBMS_OUTPUT.PUT_LINE('Tempo médio de feedback por empresa:');
    FOR avg_time_row IN (SELECT c.nm_company, AVG(TRUNC(MONTHS_BETWEEN(f.dt_feedback, u.registration_dt))) AS avg_feedback_time
                         FROM company c
                         INNER JOIN feedback f ON c.id_company = f.company_id_company
                         INNER JOIN "User" u ON f.user_id_user = u.id_user
                         GROUP BY c.nm_company
                         ORDER BY AVG(TRUNC(MONTHS_BETWEEN(f.dt_feedback, u.registration_dt))) DESC) LOOP
        v_avg_feedback_time := TO_CHAR(avg_time_row.avg_feedback_time, '9999990.99'); -- Converte a média de tempo de feedback para uma string formatada
        DBMS_OUTPUT.PUT_LINE('Empresa: ' || avg_time_row.nm_company || ', Tempo médio de Feedback (meses): ' || v_avg_feedback_time);
    END LOOP;
END;



-- Bloco Anônimo 2 com mais 3 consultas:
--      Consulta 1: Conta o número de feedbacks recebidos por cada usuário.
--      Consulta 2: Conta o número de feedbacks recebidos por empresa e sentimento, permitindo identificar os sentimentos predominantes em cada empresa.
--      Consulta 3: Conta o número de usuários satisfeitos por empresa, fornecendo uma visão geral da satisfação dos usuários em relação a cada empresa.

DECLARE
    -- Consulta 1: Número de feedbacks por usuário
    CURSOR c_feedbacks_per_user IS
        SELECT u.name AS user_name, COUNT(f.id_feedback) AS num_feedbacks
        FROM "User" u
        LEFT JOIN feedback f ON u.id_user = f.user_id_user
        GROUP BY u.name
        ORDER BY COUNT(f.id_feedback) DESC;

    -- Consulta 2: Número de feedbacks por empresa e sentimento
    CURSOR c_feedbacks_per_company_feeling IS
        SELECT c.nm_company, f.feeling, COUNT(f.id_feedback) AS num_feedbacks
        FROM company c
        LEFT JOIN feedback f ON c.id_company = f.company_id_company
        GROUP BY c.nm_company, f.feeling
        ORDER BY c.nm_company, COUNT(f.id_feedback) DESC;

    -- Consulta 3: Número de usuários satisfeitos por empresa
    CURSOR c_satisfied_users_per_company IS
        SELECT c.nm_company, COUNT(u.id_user) AS num_satisfied_users
        FROM company c
        INNER JOIN "User" u ON c.id_company = u.id_user
        WHERE u.is_satisfied = 1
        GROUP BY c.nm_company
        ORDER BY COUNT(u.id_user) DESC;
BEGIN
    -- Consulta 1: Número de feedbacks por usuário
    DBMS_OUTPUT.PUT_LINE('Número de feedbacks por usuário:');
    FOR feedback_user_row IN c_feedbacks_per_user LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || feedback_user_row.user_name || ', Número de Feedbacks: ' || feedback_user_row.num_feedbacks);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- Consulta 2: Número de feedbacks por empresa e sentimento
    DBMS_OUTPUT.PUT_LINE('Número de feedbacks por empresa e sentimento:');
    FOR feedback_company_row IN c_feedbacks_per_company_feeling LOOP
        DBMS_OUTPUT.PUT_LINE('Empresa: ' || feedback_company_row.nm_company || ', Sentimento: ' || feedback_company_row.feeling || ', Número de Feedbacks: ' || feedback_company_row.num_feedbacks);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    -- Consulta 3: Número de usuários satisfeitos por empresa
    DBMS_OUTPUT.PUT_LINE('Número de usuários satisfeitos por empresa:');
    FOR satisfied_users_row IN c_satisfied_users_per_company LOOP
        DBMS_OUTPUT.PUT_LINE('Empresa: ' || satisfied_users_row.nm_company || ', Número de Usuários Satisfeitos: ' || satisfied_users_row.num_satisfied_users);
    END LOOP;
END;
        
        
        
        