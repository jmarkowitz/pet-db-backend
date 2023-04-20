from flask import Blueprint, request, jsonify, make_response, current_app

import json
from src import db

borrowers = Blueprint('borrowers', __name__)

# Borrower Preference

# Get all species from the DB
@borrowers.route("/species", methods=['GET'])
def get_species():
    query = '''
    SELECT DISTINCT species_id AS label, species_id AS value
    FROM BorrowerPetPreferences
    WHERE species_id is NOT NULL
    ORDER BY species_id
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all type from the DB
@borrowers.route("/type", methods=['GET'])
def get_type():
    query = '''
    SELECT DISTINCT type_id AS label, type_id AS value
    FROM BorrowerPetPreferences
    WHERE type_id is NOT NULL
    ORDER BY type_id
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    json_data = []
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all habit from the DB
@borrowers.route("/habit", methods=['GET'])
def get_habit():
    query = '''
    SELECT DISTINCT habit_id AS label, habit_id AS value
    FROM BorrowerPetPreferences
    WHERE habit_id is NOT NULL
    ORDER BY habit_id
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    json_data = []
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))


    return jsonify(json_data)

# Get all borrower from the DB
@borrowers.route("/borrower_idGet", methods=['GET'])
def get_idGet():
    query = '''
    SELECT DISTINCT borrower_id AS label, borrower_id AS value
    FROM BorrowerPetPreferences
    WHERE borrower_id is NOT NULL
    ORDER BY borrower_id
    '''
    cursor = db.get_db().cursor()
    cursor.execute(query)
    json_data = []
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Post new borrower_id
@borrowers.route('/borrower_id', methods=['POST'])
def add_new_borrowerid():
    the_data = request.json
    current_app.logger.info(the_data)
    borrower_species = the_data['species_id']
    borrower_type = the_data['type_id']
    borrower_habit = the_data['habit_id']
    borrower_id = the_data['borrower_id']


    query = 'insert into BorrowerPetPreferences (species_id, type_id, habit_id, borrower_id) values ("'
    query += str(borrower_species) + '","'
    query += str(borrower_type) + '","'
    query += str(borrower_habit) + '","'
    query += str(borrower_id) + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success!"

# Put new borrower_id
@borrowers.route('/borrower_idCopy', methods=['PUT'])
def add_new_borroweridCopy():
    the_data = request.json
    current_app.logger.info(the_data)
    borrower_species = the_data['species_idCopy']
    borrower_type = the_data['type_idCopy']
    borrower_habit = the_data['habit_idCopy']
    borrower_id = the_data['borrower_idCopy']

    query = 'UPDATE BorrowerPetPreferences SET species_id = %s, type_id = %s, habit_id = %s WHERE borrower_id = %s'


    cursor = db.get_db().cursor()
    cursor.execute(query, (borrower_species, borrower_type, borrower_habit, borrower_id))
    db.get_db().commit()

    current_app.logger.info(cursor.rowcount, "record(s) affected")

    return "Success!"

# Borrower Review

@borrowers.route('/pet', methods=['GET'])
def get_pet():
    query = '''
    SELECT DISTINCT pet_id AS label, pet_id AS value
    FROM Pet
    WHERE pet_id is NOT NULL
    ORDER BY pet_id
    '''
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute(query)

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@borrowers.route('/review', methods=['POST'])
def add_new_review():
    the_data = request.json
    current_app.logger.info(the_data)
    pet_id = the_data['pet_id']
    borrower_id = the_data['borrower_id']
    borrower_review = the_data['review']


    # current_app.logger.info(the_data)

    query = 'insert into BorrowerReview (review_text, pet_id, borrower_id) values ("'
    query += borrower_review + '","'
    query += str(pet_id) + '","'
    query += str(borrower_id) + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success!"

@borrowers.route('/borrower', methods=['GET'])
def get_borrower_from_review():
    query = '''
    SELECT DISTINCT borrower_id AS label, borrower_id AS value
    FROM BorrowerReview
    WHERE borrower_id is NOT NULL
    ORDER BY borrower_id
    '''
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute(query)

    # create an empty dictionary object to use in
    # putting column headers together with data
    json_data = []
    column_headers = [x[0] for x in cursor.description]

    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

@borrowers.route('/borrower_review', methods=['DELETE'])
def delete_borrower_review():
    the_data = request.json
    current_app.logger.info(the_data)
    pet_id = the_data['delete_pet_id']
    borrower_id = the_data['delete_borrower_id']
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to delete the corresponding entry in the BorrowerReview table
    cursor.execute('DELETE FROM BorrowerReview WHERE borrower_id = %s AND pet_id = %s', (borrower_id, pet_id))

    # commit the transaction to make the changes permanent
    db.get_db().commit()

    # return a success message
    return jsonify({'message': 'Borrower review deleted successfully.'})