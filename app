import prediction_stock_prices
from flask import Flask
from flask import render_template
from flask import redirect
from flask import request
from flask import url_for

app = Flask(__name__)


@app.route('/', methods=['POST', 'GET'])
def index():
    if request.method == "POST":
        company = request.form['company']
        start_training_date = request.form['start_training_date']
        end_training_date = request.form['end_training_date']
        start_testing_date = request.form['start_testing_date']
        prediction_days = int(request.form['prediction_days'])
        number_of_neurons_of_first_layer = int(request.form['number_of_neurons_of_first_layer'])
        number_of_neurons_of_second_layer = int(request.form['number_of_neurons_of_second_layer'])
        number_of_neurons_of_third_layer = int(request.form['number_of_neurons_of_third_layer'])
        number_of_neurons_of_fourth_layer = int(request.form['number_of_neurons_of_fourth_layer'])
        number_of_epochs = int(request.form['number_of_epochs'])
        batch_size = int(request.form['batch_size'])
        resource = 'yahoo'

        prediction_stock_prices.makePredictionOfStockPrices(company, resource, start_training_date,
                                                            end_training_date, start_testing_date,
                                                            prediction_days,
                                                            number_of_neurons_of_first_layer,
                                                            number_of_neurons_of_second_layer,
                                                            number_of_neurons_of_third_layer,
                                                            number_of_neurons_of_fourth_layer,
                                                            number_of_epochs, batch_size)
        return redirect('/result')
    else:
        return render_template('index.html')


@app.route('/result')
def result():
    return render_template('result.html')


if __name__ == '__main__':
    app.debug = True
    app.run()
