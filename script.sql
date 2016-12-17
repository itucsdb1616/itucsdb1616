CREATE TABLE USERS(
	ID SERIAL PRIMARY KEY,
	USERNAME VARCHAR(20) UNIQUE NOT NULL,
	PASSWORD VARCHAR(150),
	JDATE DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE USERPROFILE(
	ID INTEGER PRIMARY KEY REFERENCES USERS ON DELETE CASCADE,
	USERNAME VARCHAR(20) UNIQUE NOT NULL,
	NICKNAME VARCHAR(20) NOT NULL,
	TWEETS INTEGER DEFAULT 0,
	FOLLOWING INTEGER DEFAULT 0,
	FOLLOWERS INTEGER DEFAULT 0,
	LIKES INTEGER DEFAULT 0,
	BIO VARCHAR(100)
);

CREATE TABLE FOLLOWS(
	FOLLOWERID INTEGER REFERENCES USERS(ID) ON DELETE SET NULL,
	FOLLOWEDUSER INTEGER REFERENCES USERS(ID) ON DELETE SET NULL,
	PRIMARY KEY (FOLLOWERID, FOLLOWEDUSER)
);

CREATE TABLE TWEETS(
	TWEETID SERIAL PRIMARY KEY NOT NULL,
	USERID INTEGER REFERENCES USERS(ID) ON DELETE CASCADE,
	TITLE VARCHAR(20) NOT NULL,
	CONTEXT VARCHAR(140) NOT NULL,
	TWTIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	NUMBEROFLIKES INTEGER NOT NULL DEFAULT 0,
	NUMBEROFRTS INTEGER NOT NULL DEFAULT 0,
	isRT INTEGER DEFAULT 0,
	RTOwnerID INTEGER DEFAULT 1 REFERENCES USERPROFILE(ID) ON DELETE  CASCADE
);

CREATE TABLE SITECR(
	USERID INTEGER REFERENCES USERS(ID) ON DELETE CASCADE,
	CASH INTEGER NOT NULL DEFAULT 0,
	CARDHOLDER VARCHAR(40),
	CARDID INTEGER NOT NULL DEFAULT 0,
	CARDMON INTEGER NOT NULL DEFAULT 0,
	CARDYEAR INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE APPS(
	ID SERIAL PRIMARY KEY,
	APPNAME VARCHAR(30) NOT NULL,
	USERCOUNT INTEGER DEFAULT 0,
	ACTIVE BOOLEAN DEFAULT FALSE
);

CREATE TABLE APPUSERS(
	USERID INTEGER REFERENCES USERS(ID) ON DELETE CASCADE,
	APPID INTEGER REFERENCES APPS(ID) ON DELETE CASCADE,
	SUB_DATE DATE NOT NULL DEFAULT CURRENT_DATE,
	PRIMARY KEY (USERID, APPID)
);

CREATE TABLE GIFTS(
	ID SERIAL PRIMARY KEY,
	GIFTNAME VARCHAR(30) NOT NULL,
	DESCRIPTION VARCHAR(100)
);

CREATE TABLE SENTGIFTS(
	SENDER INTEGER REFERENCES USERS(ID) ON DELETE CASCADE,
	RECEIVER INTEGER REFERENCES USERS(ID) ON DELETE CASCADE,
	GIFTID INTEGER REFERENCES GIFTS(ID) ON DELETE CASCADE,
	S_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SENDER, RECEIVER, GIFTID)
);

CREATE TABLE TWEETLINK(
	TWEETLID SERIAL PRIMARY KEY NOT NULL,
	TWEETID INTEGER NOT NULL REFERENCES TWEETS(TWEETID),
	CONTEXTL VARCHAR(150) NOT NULL
);

CREATE TABLE MESSAGES(
	MESSAGEID SERIAL PRIMARY KEY,
	SENDERID INTEGER REFERENCES USERPROFILE (ID) ON DELETE SET NULL,
	RECIEVERID INTEGER REFERENCES USERPROFILE (ID) ON DELETE SET NULL,
	CONTENT VARCHAR(100) NOT NULL,
	SENT BOOLEAN DEFAULT FALSE,
	MTIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE MEDIA(
	PHOTOID SERIAL PRIMARY KEY,
	OWNERID INTEGER REFERENCES USERPROFILE (ID) ON DELETE SET NULL,
	DESCRIPTION VARCHAR (100),
	URL VARCHAR(500)
);

CREATE TABLE TAGS(
	TAGID SERIAL PRIMARY KEY,
	TAGEDPHOTOID INTEGER REFERENCES MEDIA (PHOTOID) ON DELETE CASCADE,
	TAGEDUSERID INTEGER REFERENCES USERPROFILE (ID) ON DELETE CASCADE
);

CREATE TABLE USERINFO(
	USERID INTEGER PRIMARY KEY NOT NULL REFERENCES USERS (ID) ON DELETE CASCADE,
	NAME VARCHAR(20) NOT NULL,
	SURNAME VARCHAR(20) NOT NULL,
	NICKNAME VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(25) NOT NULL,
	LANGUAGE VARCHAR(20) NOT NULL
);

CREATE TABLE LISTS(
	LISTID SERIAL PRIMARY KEY,
	SUBSCRIBERS INTEGER DEFAULT 0,
	MEMBERS INTEGER DEFAULT 0,
	NAME VARCHAR(30) NOT NULL,
	CREATORID INTEGER NOT NULL REFERENCES USERPROFILE (ID) ON DELETE CASCADE
);

CREATE TABLE LISTMEMBERS(
	LISTID INTEGER NOT NULL REFERENCES LISTS(LISTID) ON DELETE CASCADE,
	USERID INTEGER NOT NULL REFERENCES USERPROFILE(ID) ON DELETE CASCADE,
	USERTYPE VARCHAR(18) NOT NULL,
	PRIMARY KEY(LISTID,USERID,USERTYPE)
);

CREATE TABLE LIKES(
	USERID INTEGER NOT NULL REFERENCES USERPROFILE(ID) ON DELETE CASCADE,
	TWEETID INTEGER NOT NULL REFERENCES TWEETS(TWEETID) ON DELETE CASCADE,
	PRIMARY KEY(USERID,TWEETID),
	LikeTIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE POLLS(
	POLLID SERIAL PRIMARY KEY,
	CREATORID INTEGER NOT NULL REFERENCES USERPROFILE(ID) ON DELETE CASCADE,
	VOTENUMBER INTEGER NOT NULL DEFAULT 0,
	CHOICENUMBER INTEGER NOT NULL DEFAULT 0,
	POLLQUESTION VARCHAR(40) NOT NULL
);

CREATE TABLE CHOICES(
	CHOICEID SERIAL UNIQUE,
	POLLID INTEGER NOT NULL REFERENCES POLLS(POLLID) ON DELETE CASCADE,
	CONTENT VARCHAR(20) NOT NULL,
	NUMBEROFVOTES INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY (CHOICEID,POLLID,CONTENT)
);
CREATE TABLE VOTES(
	POLLID INTEGER NOT NULL REFERENCES POLLS(POLLID) ON DELETE CASCADE,
	CHOICEID INTEGER NOT NULL REFERENCES CHOICES(CHOICEID) ON DELETE CASCADE,
	USERID INTEGER NOT NULL REFERENCES USERPROFILE(ID) ON DELETE CASCADE,
	PRIMARY KEY(POLLID,CHOICEID,USERID)
);

CREATE TABLE NOTIFS(
    NOTIFID SERIAL PRIMARY KEY,
    USERID INTEGER NOT NULL REFERENCES USERS (ID) ON DELETE CASCADE,
    FOLLOWERID INTEGER NOT NULL,
    PERM INTEGER NOT NULL
   );

CREATE TABLE COLORINFO(
	COLORID SERIAL PRIMARY KEY,
	COLOR VARCHAR(30) NOT NULL
);

CREATE TABLE STYLEINFO(
	STYLEID SERIAL PRIMARY KEY,
	USERID INTEGER NOT NULL REFERENCES USERINFO(USERID) ON DELETE CASCADE,
	COLORID INTEGER NOT NULL REFERENCES COLORINFO ON DELETE CASCADE
);

INSERT INTO USERS (USERNAME, PASSWORD) VALUES(
	'admin',
	'$6$rounds=603422$ZgQRx3Mm/YuUaION$b/Vwzuno1Q7e1KPWehLbRdmvdf/Bjj5.4a.fvcz3TNCl.Rn2CLbQPCsGSIBarDYHMzq3jjN8KDLkBtKJzBclf0'
);

INSERT INTO USERPROFILE (ID, NICKNAME, USERNAME, BIO) VALUES(
	1,
	'admin',
	'admin',
	'Istanbul'
);

INSERT INTO TWEETS (USERID, TITLE, CONTEXT) VALUES(
	1,
	'Admin Tweet',
	'First Tweet By Admins'
);

INSERT INTO SITECR (USERID, CASH, CARDHOLDER, CARDID, CARDMON, CARDYEAR) VALUES(
	1,
	99,
	'Admin',
	12341234,
	08,
	2222
);

INSERT INTO MESSAGES(SENDERID,RECIEVERID, CONTENT) VALUES(
	1,
	1,
	'Good afternoon'
);

INSERT INTO USERINFO (USERID, NAME, SURNAME, NICKNAME, EMAIL, LANGUAGE) VALUES(
	1,
	'admin',
	'admin',
	'admin',
	'admin@inferno.com',
	'English'
);

INSERT INTO COLORINFO (COLORID, COLOR) VALUES(
	1,
	'#002633'
);

INSERT INTO STYLEINFO (STYLEID, USERID, COLORID) VALUES(
	1,
	1,
	1
);

CREATE INDEX FOLLOWER_INDEX ON FOLLOWS (FOLLOWERID);
