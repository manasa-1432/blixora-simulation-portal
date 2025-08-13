import mysql.connector

def connect_to_database():
    return mysql.connector.connect(
        host="localhost",
        user="root",              # Replace with your MySQL username
        password="manasabhanu1432", # Replace with your MySQL password
        database="blixora"
    )
