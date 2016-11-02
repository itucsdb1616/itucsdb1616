from flask_login import current_user
import psycopg2 as dbapi2
from flask import current_app, request
from flask_login import current_user

class Twitlist:
    def __init__(self):
        self.twit = {}

    def add_twit(self, twit):
        connection = dbapi2.connect(current_app.config['dsn'])
        cursor = connection.cursor()
        cursor.execute("""SELECT ID FROM USERS WHERE USERNAME=%s""", (current_user.username,))
        userid=cursor.fetchone()
        cursor.execute("""INSERT INTO TWEETS (USERID, TITLE, CONTEXT)    VALUES    (%s, %s, %s)""", (userid, twit.title, twit.context))
        connection.commit()
        connection.close()

    def delete_twit(self, twitid):
        connection = dbapi2.connect(current_app.config['dsn'])
        cursor = connection.cursor()
        cursor.execute("""DELETE FROM TWEETS WHERE TWEETID=%s""", twitid)
        connection.commit()
        connection.close()

    def update_twit(self, twitid, twit):
        connection = dbapi2.connect(current_app.config['dsn'])
        cursor = connection.cursor()
        cursor.execute("""UPDATE TWEETS SET TITLE=%s, CONTEXT=v%s WHERE TWEETID=%s""", (twit.title, twit.contex, twitid))
        connection.commit()
        connection.close()

    def get_twit(self, twitid):
        connection = dbapi2.connect(current_app.config['dsn'])
        cursor = connection.cursor()
        cursor.execute("""SELECT ID FROM USERS WHERE USERNAME=%s""", (current_user.username,))
        userid=cursor.fetchone()
        twit=cursor.execute("""SELECT TITLE, CONTEXT, TWITID FROM TWEETS WHERE USERID=%s""", [userid])
        print (twit)
        connection.commit()
        connection.close()
        return twit

    def get_twit(self):
        connection = dbapi2.connect(current_app.config['dsn'])
        cursor = connection.cursor()
        cursor.execute("""SELECT ID FROM USERS WHERE USERNAME=%s""", (current_user.username,))
        userid=cursor.fetchone()
        twit=cursor.execute("""SELECT TITLE, CONTEXT, TWEETID FROM TWEETS WHERE USERID=%s""", [userid])
        print (twit)
        connection.commit()
        connection.close()
        return twit