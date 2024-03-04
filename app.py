from flask import Flask, render_template, request
from pyswip import Prolog

app = Flask(__name__)

# Initialize Prolog engine
prolog = Prolog()
prolog.consult("cancer.pl")

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/diagnose', methods=['POST'])
def diagnose():
    print("Received POST request to /diagnose")
    try:
        symptoms = request.form.getlist('symptoms')
        diagnoses = request.form.getlist('diagnoses')
        print("Symptoms:", symptoms)
        print("Diagnoses:", diagnoses)
        
        query_string = "has_breast_cancer([{}], [{}]).".format(','.join(map(str, symptoms)), ','.join(map(str, diagnoses)))
        print("Query:", query_string)

        # Query Prolog with the constructed query string
        has_breast_cancer = list(prolog.query(query_string))

        print("Has breast cancer:", has_breast_cancer)

        if has_breast_cancer:
            result = 'You have breast cancer.'
        else:
            result = 'You do not have breast cancer.'
            
        return result
    except Exception as e:
        # Log the exception
        print("An error occurred:", e)
        # Return an error message to the user
        return "An error occurred while processing your request."

@app.errorhandler(Exception)
def handle_exception(error):
    # Log the exception
    print("An error occurred:", error)
    # Return an error response
    return "An error occurred while processing your request.", 500

# Disable favicon handling
@app.route('/favicon.ico')
def favicon():
    return app.send_static_file('favicon.ico')

if __name__ == '__main__':
    app.run(debug=True)
