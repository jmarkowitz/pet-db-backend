from flask import Blueprint, request, jsonify, make_response
import json
from src import db

owners = Blueprint('owners', __name__)