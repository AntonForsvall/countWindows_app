from flask_restful import Resource
from flask import request
from Model import db, User, Counter


class Counters(Resource):

    def post(self):
        header = request.headers['Authorization']
        json_data = request.get_json(force=True)

        if not header:
            return {'Message': 'No Api Key'}, 400

        else:
            user = User.query.filter_by(api_key=header).first()
            # project = Project.query.filter_by(user_id=user.id).first()
            if user:
                counter = Counter(
                    user_id=user.id,
                    project_id=json_data['project_id'],
                    image=json_data['image'],
                    value=json_data['value'],
                    date=json_data['date']
                )

                db.session.add(counter)
                db.session.commit()

                result = Counter.serialize(counter)
                return {"status": 'success', 'data': result}, 201
            else:
                return {"Messege": "No user with that api key"}, 400

    def get(self):
        result = []
        header = request.headers['Authorization']

        if not header:
            return {"Messege": "No api key!"}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                counters = Counter.query.filter_by(user_id=user.id).all()
                for counter in counters:
                    result.append(Counter.serialize(counter))

            return {"status": 'success', 'data': result}, 201


