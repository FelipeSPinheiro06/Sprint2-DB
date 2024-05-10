import cx_Oracle

# Estabelecendo conexão com o banco de dados Oracle
conn = cx_Oracle.connect('RM550244/060704@host:port/service_name')

try:
    # Chamada à procedure de inserção na tabela company
    cursor = conn.cursor()
    cursor.callproc('nome_da_procedure_insert_company')
    cursor.close()

    # Chamada à procedure de atualização do nome do usuário para 'Milton'
    cursor = conn.cursor()
    cursor.callproc('nome_da_procedure_update_user_name', [1, 'Milton'])
    cursor.close()

    # Chamada à procedure de exclusão de um registro na tabela "User" com ID 1
    cursor = conn.cursor()
    cursor.callproc('nome_da_procedure_delete_user', [1])
    cursor.close()

    # Chamada à procedure de inserção na tabela feedback
    cursor = conn.cursor()
    cursor.callproc('insert_feedback', [1, 'Alice', 'Positive', '2024-04-13', 'Amazon', 1, 2])
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