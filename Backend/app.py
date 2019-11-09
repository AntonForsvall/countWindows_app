from flask import Blueprint
from flask_restful import Api
from resources.Register import Register
from resources.Signin import Signin
from resources.Project import Projects
from resources.counter import Counters

api_bp = Blueprint('api', __name__)
api = Api(api_bp)


# Routes
api.add_resource(Register, '/register')

api.add_resource(Signin, '/signin')

api.add_resource(Projects, '/project')

api.add_resource(Counters, '/counter')
