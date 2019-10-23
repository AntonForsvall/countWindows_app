from flask_restful import Resource
from flask import request
import random
import string
from Model import User, db, bcrypt


class Register(Resource):

    def get(self):
        users = User.query.all()
        user_list = []
        for i in range(0, len(users)):
            user_list.append(users[i].serialize())
        return {"status": str(user_list)}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return{'message': 'No input data provided'}, 400
        # Validate and deserialize input
        # json_data, errors = User.load(json_data)
        # if errors:
        #     return errors, 422
        username = User.query.filter_by(username=json_data['username']).first()
        if username:
            return {'message': 'Username already exists'}, 400

        email = User.query.filter_by(email=json_data['email']).first()
        if email:
            return {'message': 'Emailadress already exists'}, 400

        api_key = self.generate_key()
        hashed_password = bcrypt.generate_password_hash(json_data['password'])

        user = User(
            api_key=api_key,
            firstname=json_data['firstname'],
            lastname=json_data['lastname'],
            username=json_data['username'],
            email=json_data['email'],
            company=json_data['company'],
            password=hashed_password

        )

        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)
        return {"status": 'success', 'data': result}, 201

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))