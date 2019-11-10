from flask_restful import Resource
from flask import request
from Model import db, User, Project


class Projects(Resource):

    def post(self):
        header = request.headers['Authorization']
        json_data = request.get_json(force=True)

        if not header:
            return {'Message': 'No Api Key'}, 400

        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                project = Project(
                    user_id=user.id,
                    project_name=json_data['project_name'],
                    date=json_data['date']
                )

                db.session.add(project)
                db.session.commit()

                result = Project.serialize(project)
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
                projects = Project.query.filter_by(user_id=user.id).all()
                for project in projects:
                    result.append(Project.serialize(project))

            return {"status": 'success', 'data': result}, 201

    def delete(self):
        header = request.headers['Authorization']
        json_data = request.get_json(force=True)

        if not header:
            return {'Message': 'No Api Key'}, 400

        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                project = Project.query.filter_by(id=json_data['id']).first()

                db.session.delete(project)
                db.session.commit()

                result = Project.serialize(project)
                return {"status": 'success', 'data': result}, 201
            else:
                return {"Messege": "No user with that api key"}, 400
