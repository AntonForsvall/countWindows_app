from flask_restful import Resource
from flask import request
from Model import User, db


class Register(Resource):

    def get(self):
        users = User.query.all()
        users = users.dump(users).data
        return {"status": "success", "data": users}, 200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
            return{'message': 'No input data provided'}, 400
        # Validate and deserialize input
        json_data, errors = User.load(json_data)
        if errors:
            return errors, 422
        user = User.query.filter_by(name=json_data['username']).first()
        if user:
            return {'message': 'Username already exists'}, 400

        user = User(
            id=json_data['id'],
            api_key=json_data['api_key'],
            firstname=json_data['firsname'],
            lastname=json_data['lastname'],
            username=json_data['username'],
            email=json_data['email'],
            company=json_data['company'],
            password=json_data['password']

        )

        db.session.add(user)
        db.session.commit()

        result = User.dump(user).data
        return {"status": 'success', 'data': result}, 201
