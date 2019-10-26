from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt

db = SQLAlchemy()
bcrypt = Bcrypt()


class User(db.Model):

    __tablename__ = 'users'
    id = db.Column(db.Integer(), primary_key=True)
    api_key = db.Column(db.String(), unique=True)
    username = db.Column(db.String(15), nullable=False, unique=True)
    company = db.Column(db.String(), nullable=False)
    firstname = db.Column(db.String(), nullable=False)
    lastname = db.Column(db.String())
    email = db.Column(db.String(), nullable=False, unique=True)
    password = db.Column(db.String(), nullable=False)

    def __init__(self, api_key, username, company, firstname, lastname,
                 email, password,):
        self.api_key = api_key
        self.username = username
        self.company = company
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password

    def __repr__(self):
        return f'<id {self.id}>'

    def serialize(self):
        return{
            'id': self.id,
            'api_key': self.api_key,
            'username': self.username,
            'company': self.company,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'email': self.email,
            'password': self.password
        }


class Counter(db.Model):

    __tablename__ = 'counters'

    id = db.Column(db.Integer(), primary_key=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('users.id'))
    image = db.Column(db.String())
    value = db.Column(db.Integer())
    date = db.Column(db.DateTime())

    def __init__(self, user_id, image, value, date):
        self.user_id = user_id
        self.image = image
        self.value = value
        self.date = date

    def __repr__(self):
        return f'id {self.id}'

    def serialize(self):
        return {
            'user_id' : self.user_id,
            'id' : self.id,
            'image' : self.image,
            'value' : self.value,
            'date' : self.date,
        }