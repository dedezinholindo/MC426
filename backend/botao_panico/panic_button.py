from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/panic_button', methods=['POST'])
def panic_button():
    if request.method != 'POST':
        return jsonify({"error": "Method Not Allowed. Please use POST method."}), 405

    try:
        user_id = request.json.get('id')

        if user_id is None:
            return jsonify({"error": "Missing 'id' in the request body."}), 400

        # Perform any additional actions here, such as sending notifications to the application
        # Post in the app that the user X pressed the panic button
        print(f"The user with the id {user_id} pressed the PANIC BUTTON!!")  # example

        # Return a response to the user
        return jsonify({"message": "Panic button activated. Police number: 190."})
    except ValueError:
        return jsonify({"error": "Invalid JSON in the request body."}), 400

if __name__ == '__main__':
    app.run(debug=True)
