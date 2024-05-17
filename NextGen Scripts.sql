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
    is_satisfied    CHAR(1),
    aged            CHAR(1),
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


-- 11. Criar uma tabela para armazenar o dicionário de sentimentos
CREATE TABLE dicionario_sentimentos (
    id_sentimento   NUMBER PRIMARY KEY,
    palavra_chave   VARCHAR2(100),
    peso            NUMBER -- Peso 1 para sentimento positivo e -1 para sentimento negativo
);

-- Criando a sequence e inserindo 5 registros na tabela dicionario_sentimentos
CREATE SEQUENCE seq_dicionario
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;
    
    
-- 12. Inserir alguns dados no dicionário de sentimentos
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'pessimo', -1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'ruim', -1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'medio', 1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'bom', 1);
INSERT INTO dicionario_sentimentos (id_sentimento, palavra_chave, peso) VALUES (seq_dicionario.nextval, 'excelente', 1);


-- 13. Criar uma tabela para armazenar as frases a serem analisadas
CREATE TABLE frases (
    id_frase    NUMBER PRIMARY KEY,
    frase       VARCHAR2(500)
);


-- Criando a sequence e inserindo 5 registros na tabela frases
CREATE SEQUENCE seq_frases
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 10000
    NOCYCLE;


-- 14. Inserir algumas frases na tabela de frases
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi muito bom e rápido.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'A comida estava ruim e o atendimento foi péssimo.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi mediano, nada a acrescentar.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi péssimo.');
INSERT INTO frases (id_frase, frase) VALUES (seq_frases.nextval, 'O serviço foi excelente, estão de parabéns.');




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
        

-- Sprint 2


-- Criar duas funções para validar a entrada de dados

-- Primeira função: Função para validar se o atributo peso do dicionario_sentimentos é 1 ou -1

CREATE OR REPLACE FUNCTION check_peso_number (p_number IN NUMBER) 
RETURN BOOLEAN IS
BEGIN
    IF p_number = 1 OR p_number = -1 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;


-- Segunda função: Verificar se a data de registro está no passado

CREATE OR REPLACE FUNCTION check_registration_date ( rg_date IN DATE)
RETURN BOOLEAN IS
BEGIN
    IF rg_date < CURRENT_DATE THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;


-- Criar Procedures de INSERT/UPDATE/DELETE


-- Procedure que insere um registro na tabela company

CREATE OR REPLACE PROCEDURE insert_company IS
BEGIN
    INSERT INTO company (id_company, nm_company, registration_dt_company, num_feedbacks_company, branch)
    VALUES (101, 'ABC Company', SYSDATE, 100, 'Branch A');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Dados inseridos com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir dados: ' || SQLERRM);
END insert_company;
/


-- Procedure para inserir um registro na tabela feedback

CREATE OR REPLACE PROCEDURE insert_feedback(
    p_id_feedback IN INTEGER,
    p_nm_user IN VARCHAR2,
    p_feeling IN VARCHAR2,
    p_dt_feedback IN DATE,
    p_company IN VARCHAR2,
    p_user_id_user IN INTEGER,
    p_company_id_company IN INTEGER
) AS
BEGIN
    INSERT INTO feedback (id_feedback, nm_user, feeling, dt_feedback, company, user_id_user, company_id_company)
    VALUES (p_id_feedback, p_nm_user, p_feeling, p_dt_feedback, p_company, p_user_id_user, p_company_id_company);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Registro inserido na tabela feedback com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir registro na tabela feedback: ' || SQLERRM);
END;
/



-- Procedure que muda o nome do usuário do ID 1 para Milton

CREATE OR REPLACE PROCEDURE update_user_name (
    p_id_user IN INTEGER,
    p_new_name IN VARCHAR2
) AS
BEGIN
    UPDATE "User"
    SET name = p_new_name
    WHERE id_user = p_id_user;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Nome do usuário atualizado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar o nome do usuário: ' || SQLERRM);
END;
/
       
        

-- Procedure que deleta um registro da tabela "User" com ID 1

CREATE OR REPLACE PROCEDURE delete_user (
    p_id_user IN INTEGER
) AS
BEGIN
    DELETE FROM "User"
    WHERE id_user = p_id_user;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Usuário excluído com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir usuário: ' || SQLERRM);
END;
/


-- Procedure para deletar um registro na tabela feedback com base no ID do feedback
CREATE OR REPLACE PROCEDURE delete_feedback(
    p_id_feedback IN INTEGER
) AS
BEGIN
    DELETE FROM feedback
    WHERE id_feedback = p_id_feedback;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Registro deletado da tabela feedback com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar registro da tabela feedback: ' || SQLERRM);
END;
/


-- Procedure que percorre os registros da tabela "User" e da tabela "feedback" utilizando um cursor, fazendo um join entre elas. 
--    Para cada registro encontrado, ela busca o nome da empresa correspondente na tabela "company".

CREATE OR REPLACE PROCEDURE procedure_com_cursor IS
    -- Declaração de variáveis
    v_id_user "User".id_user%TYPE;
    v_name "User".name%TYPE;
    v_registration_dt "User".registration_dt%TYPE;
    v_is_satisfied "User".is_satisfied%TYPE;
    v_company_id feedback.company_id_company%TYPE;
    v_company_name company.nm_company%TYPE;
BEGIN
    -- Cursor para percorrer os registros das tabelas "User" e "feedback"
    FOR user_feedback_rec IN (
        SELECT u.id_user, u.name, u.registration_dt, u.is_satisfied, f.company_id_company
        FROM "User" u
        INNER JOIN feedback f ON u.id_user = f.user_id_user
    ) LOOP
        -- Atribuindo valores do cursor às variáveis
        v_id_user := user_feedback_rec.id_user;
        v_name := user_feedback_rec.name;
        v_registration_dt := user_feedback_rec.registration_dt;
        v_is_satisfied := user_feedback_rec.is_satisfied;
        v_company_id := user_feedback_rec.company_id_company;
        
        -- Buscando o nome da empresa com base no ID da empresa
        SELECT nm_company INTO v_company_name
        FROM company
        WHERE id_company = v_company_id;
        
        -- Exibindo os dados
        DBMS_OUTPUT.PUT_LINE('ID do Usuário: ' || v_id_user);
        DBMS_OUTPUT.PUT_LINE('Nome do Usuário: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Data de Registro: ' || TO_CHAR(v_registration_dt, 'DD/MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Está Satisfeito? ' || CASE WHEN v_is_satisfied = 1 THEN 'Sim' ELSE 'Não' END);
        DBMS_OUTPUT.PUT_LINE('Nome da Empresa: ' || v_company_name);
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao executar a procedure: ' || SQLERRM);
END;
/


-- Procedure que gera um relatório contendo o número total de feedbacks recebidos por cada empresa, ordenado pelo número de feedbacks em ordem decrescente.
-- É utilizado join, group by, order by, count e desc, além das regras de negócio

CREATE OR REPLACE PROCEDURE relatorio_feedbacks_por_empresa IS
BEGIN
    -- Cursor para recuperar o número total de feedbacks por empresa
    FOR feedback_rec IN (
        SELECT c.nm_company, COUNT(f.id_feedback) AS total_feedbacks
        FROM company c
        INNER JOIN feedback f ON c.id_company = f.company_id_company
        GROUP BY c.nm_company
        ORDER BY COUNT(f.id_feedback) DESC
    ) LOOP
        -- Exibir apenas as empresas que receberam pelo menos um feedback
        IF feedback_rec.total_feedbacks > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Empresa: ' || feedback_rec.nm_company);
            DBMS_OUTPUT.PUT_LINE('Total de Feedbacks: ' || feedback_rec.total_feedbacks);
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar o relatório: ' || SQLERRM);
END;
/

