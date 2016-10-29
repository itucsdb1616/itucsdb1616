CREATE TABLE TWEETS(
	TWEETID SERIAL PRIMARY KEY NOT NULL,
	USERID INT NOT NULL,
	TITLE CHAR(20) NOT NULL,
	CONTEXT CHAR(140) NOT NULL
);

INSERT INTO TWEETS (USERID, TITLE, CONTEXT) VALUES(
	1,
	'Admin Tweets',
	'First Tweet By Adminssss'
);

CREATE TABLE LISTS(
	LISTID SERIAL PRIMARY KEY,
	SUBSCRIBERS INTEGER DEFAULT 0,
	MEMBERS INTEGER DEFAULT 0,
	NAME VARCHAR(40) NOT NULL,
	CREATORID INTEGER NOT NULL
	);

INSERT INTO LISTS (NAME,CREATORID) VALUES(
	'First List',
	1);