from flask import Blueprint, request, jsonify, make_response, current_app
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
    return ""

@owners.route('/allPets/<userID>', methods=['GET'])
def get_all_pets(userID):
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Pets WHERE owner_id = %s', (userID,))
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


@owners.route("/events", methods=['GET'])
def get_events():
    cursor = db.get_db().cursor()
    cursor.execute('''select event_id from Event''')
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(row)

    return jsonify(json_data)


@owners.route("/events/new", methods=['POST'])
def add_new_event():
    the_data = request.json
    current_app.logger.info(the_data)
    description = the_data['description']
    event_date = the_data['event_date']
    city = the_data['city']
    state = the_data['state']
    zip_code = the_data['zip']
    event_id = the_data['event_id']

    query = 'insert into Event (description, event_date, city, state, zip, event_id) values ("'
    query += description + '","'
    query += event_date + '","'
    query += city + '","'
    query += state + '","'
    query += zip_code + '","'
    query += str(event_id) + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success!"



@owners.route('/events/update', methods=['PUT'])
def update_event():
    the_data = request.json
    current_app.logger.info(the_data)
    description = the_data['description']
    event_date = the_data['event_date']
    city = the_data['city']
    state = the_data['state']
    zip_code = the_data['zip']
    event_id = the_data['event_id']

    query = 'UPDATE Event SET description = %s, event_date = %s, city = %s, state = %s, zip = %s WHERE event_id = %s'


    cursor = db.get_db().cursor()
    cursor.execute(query, (description, event_date, city, state, zip_code, event_id))
    db.get_db().commit()

    current_app.logger.info(cursor.rowcount, "record(s) affected")

    return "Success!"



@owners.route('/events/delete', methods=['DELETE'])
def delete_event():
    the_data = request.json
    current_app.logger.info(the_data)
    event_id = the_data['delete_event_id']
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    cursor.execute('DELETE FROM Event WHERE event_id = %s', (event_id))

    # commit the transaction to make the changes permanent
    db.get_db().commit()

    # return a success message
    return "Success!"
