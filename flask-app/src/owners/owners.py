from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

owners = Blueprint('owners', __name__)




@owners.route('/petTypes', methods=['GET'])
def get_pet_types():
    query = 'SELECT species_name AS label, species_id AS value FROM PetSpecies'
    cursor = db.get_db().cursor()
    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@owners.route('/allPets/<speciesID>', methods=['GET'])
def get_all_pets(speciesID):
    query = '''
    SELECT breed_name, first_name, last_name, user_id
FROM PetOwner
         JOIN (SELECT pet_id, user_id, species_id, species_name, breed_name, breed_id
               FROM OwnerPets
                        JOIN (SELECT species_id, pet_id, species_name, breed_name, breed_id
                              FROM Pet
                                       JOIN (SELECT species_name, PS.species_id, breed_name, breed_id
                                             FROM PetBreed
                                                      JOIN PetSpecies PS on PetBreed.species_id = PS.species_id
                                             WHERE PS.species_id = %s) as petType using (species_id)) as allPetBreeds
                             using (pet_id)) as userPets using (user_id)
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query, speciesID)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@owners.route('/allUsers', methods=['GET'])
def get_all_users():
    query = '''
    SELECT user_id as value, user_id as label
    FROM PetOwner
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@owners.route("/addFriend", methods=['POST'])
def add_new_friend():
    the_data = request.json
    current_app.logger.info(the_data)
    userID = the_data['user_ID']
    friendID = the_data['friend_ID']

    query = 'insert into OwnerFriends (user_id, friend_user_id) values ("'
    query += userID + '","'
    query += friendID + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success!"

@owners.route("/events", methods=['GET'])
def get_events():
    query = '''
    SELECT event_id as ID, description as Description, event_date as Date, city as City
    FROM Event
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

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

    description = the_data['description_update']
    event_date = the_data['event_date_update']
    city = the_data['city_update']
    state = the_data['state_update']
    zip_code = the_data['zip_update']
    event_id = the_data['event_id_update']

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

