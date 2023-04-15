from flask import Blueprint, request, jsonify, make_response,current_app
import json
from src import db

borrowers = Blueprint('borrowers', __name__)

@borrowers.route('/pet', methods=['GET'])
def get_pet():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    # use cursor to query the database for a list of pet ids
    cursor.execute('SELECT pet_id FROM Pet;')

    # create an empty object
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(row)

    return jsonify(json_data)


@borrowers.route('/review', methods=['POST'])
def add_new_review():
    the_data = request.json
    current_app.logger.info(the_data)
    pet_id = the_data['pet_id']
    borrower_id = the_data['borrower_id']
    borrower_review = the_data['review']

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
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of borrower ids
    cursor.execute('SELECT borrower_id FROM BorrowerReview;')

    # create an empty object
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()
    # for each of the rows, zip the data elements together with
    # the column headers.
    for row in theData:
        json_data.append(row)

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