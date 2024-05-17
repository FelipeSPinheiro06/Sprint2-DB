import cx_Oracle
cx_Oracle.init_oracle_client(lib_dir=r"C:/oracle/instantclient_21_13")

# Estabelecendo conexão com o banco de dados Oracle
conn = cx_Oracle.connect(user = "RM550244", password = "060704", dsn = "oracle.fiap.com.br/orcl")

try:
    # Chamada à procedure de inserção na tabela company
    cursor = conn.cursor()
    cursor.callproc('insert_company')
    cursor.close()

    # Chamada à procedure de atualização do nome do usuário para 'Milton'
    cursor = conn.cursor()
    cursor.callproc('update_user_name', [1, 'Milton'])
    cursor.close()

    # Chamada à procedure de exclusão de um registro na tabela "User" com ID 1
    cursor = conn.cursor()
    cursor.callproc('delete_user', [1])
    cursor.close()

    # Chamada à procedure de inserção na tabela feedback
    cursor = conn.cursor()
    cursor.callproc('insert_feedback', [1, 'Alice', 'Positive', '2023-04-12', 'Amazon', 1, 2])
    cursor.close()

    # Chamada à procedure de exclusão de um registro na tabela feedback com ID 1
    cursor = conn.cursor()
    cursor.callproc('delete_feedback', [1])
    cursor.close()

    conn.commit()
    print("Todas as procedures foram chamadas com sucesso.")

except cx_Oracle.Error as error:
    print('Erro ao chamar as procedures:', error)

# Fechando a conexão com o banco de dados Oracle
conn.close()