from flask import Blueprint, request, jsonify, make_response
import json
from src import db

owners = Blueprint('owners', __name__)

@owners.route('/petTypes', methods=['GET'])
def get_pet_types():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT species_name FROM PetSpecies')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@owners.route('/petSpecificBreeds', methods=['GET'])
def get_pet_breeds(speciesID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT breed_name FROM PetBreeds WHERE species_id = %s', (speciesID,))
