from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy

ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):

    __tablename__ = 'users'
    id = db.Column(db.String, primary_key=True, unique=True)
    api_key = db.Column(db.String, unique=True)
    username = db.Column(db.String(15), nullable=False, unique=True)
    company = db.Column(db.String, nullable=False)
    firstname = db.Column(db.String, nullable=False)
    lastname = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False, unique=True)
    password = db.Column(db.String, nullable=False)

    def __init__(self, id, api_key, username, company, firstname, lastname,
                 email, password,):
        self.id = id
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
