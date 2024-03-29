from flask_restful import Resource
from flask import request
from Model import User, bcrypt
import random
import string


class Signin(Resource):

    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]

        if not header:
            result = self.company_and_password_signin(json_data)
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                result = User.serialize(user)
            else:
                result = self.company_and_password_signin(json_data)

        return {"status": 'success', 'data': result}, 201

    def company_and_password_signin(self, json_data):
        if not json_data:
            return {'message': 'No input data provided'}, 400

        user = User.query.filter_by(company=json_data['company']).first()
        if not user:
            return {'message': 'Company does not exist'}, 400

        if not bcrypt.check_password_hash(user.password, json_data['password']):
            return {'message': 'Password incorrect'}, 400

        return User.serialize(user)

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
