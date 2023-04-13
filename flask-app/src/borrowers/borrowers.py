from flask import Blueprint, request, jsonify, make_response
import json
from src import db

borrowers = Blueprint('borrowers', __name__)