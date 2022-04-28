def tr_logger(client_id, dollar_balance):
    import psycopg2
    connection = None
    try:
        connection = psycopg2.connect(user='postgres',
                                      password='123',
                                      host='127.0.0.1',
                                      port='5432',
                                      database='postgres')
        connection.autocommit = False
        cursor = connection.cursor()
        insert_q = '''insert into transactions (client_id,balance_change) values (%s,%s)'''
        for i in range(len(client_id)):
            cursor.execute(insert_q, (client_id.pop(0), dollar_balance.pop(0)))
            connection.commit()
        print('очередь транзакций успешно обновлена')
    except (Exception, psycopg2.DatabaseError) as error:
        print('ошбика в транзакции. отмена транзакции', error)
        connection.rollback()
    if connection:
        cursor.close()
        connection.close()
        print('соединение с postgresql закрыто')


def transaction_worker():
    import psycopg2

    try:
        connection = psycopg2.connect(user='postgres',
                                      password='123',
                                      host='127.0.0.1',
                                      port='5432',
                                      database='postgres')

        connection.autocommit = False
        cursor = connection.cursor()
        que = '''select client_id, balance_change,transaction_id from transactions where approved is NULL'''
        cursor.execute(que)
        buffer = cursor.fetchall()
        query_balance = """update balance set dollar_balance = %s where client_id =%s"""
        query_transac = """update transactions set transaction_time =current_timestamp, approved=%s  where 
        transaction_id = %s """
        for i in range(0, len(buffer)):
            approved = False
            query = '''select dollar_balance from balance where client_id = %s'''
            cursor.execute(query, (buffer[i][0],))
            current_balance = cursor.fetchone()
            if buffer[i][1] == 0:
                pass
            if buffer[i][1] < 0:
                if current_balance[0] >= abs(buffer[i][1]):
                    new_balance = float(current_balance[0] + buffer[i][1])
                    cursor.execute(query_balance, (new_balance, buffer[i][0],))
                    approved = True
                    cursor.execute(query_transac, (approved, buffer[i][2]))
                    connection.commit()

                if current_balance[0] < abs(buffer[i][1]):
                    cursor.execute(query_transac, (approved, buffer[i][2]))
                    connection.commit()
            else:
                new_balance = float(current_balance[0] + buffer[i][1])
                cursor.execute(query_balance, (new_balance, buffer[i][0],))
                approved = True
                cursor.execute(query_transac, (approved, buffer[i][2]))
                connection.commit()

        print('все транзакции проведены')
    except (Exception, psycopg2.DatabaseError) as error:
        print('ошбика в транзакции. отмена транзакции', error)
        connection.rollback()
    if connection:
        cursor.close()
        connection.close()
        print('соединение с postgresql закрыто')


print(tr_logger([1, 1, 1, 1, 2, 2, 2], [1000, -2000, 1000, -2000, 3000, -5000, 1000]))
print(transaction_worker())
