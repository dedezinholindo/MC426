import sqlite3


class DatabaseManager:
    '''
    Singleton pattern class used to manage database access.
    '''

    _instance = None  # used to define Singleton pattern.

    def __init__(self) -> None:

        self._db_path = 'press2safe.db'
        self.conn = sqlite3.connect(self._db_path, check_same_thread=False)
        self.cursor = self.conn.cursor()

    def __new__(cls):
        '''
        Implements the Singleton pattern.
        '''
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __del__(self):
        
        self.conn.close()
