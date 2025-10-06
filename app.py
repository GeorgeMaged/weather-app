from flask import Flask, request, render_template_string, jsonify
import requests
import os

app = Flask(__name__)

# Get API key from environment variable
API_KEY = os.getenv("OPENWEATHER_API_KEY", "your_api_key_here")
BASE_URL = "http://api.openweathermap.org/data/2.5/weather"

# HTML template with Bootstrap styling
HTML_PAGE = """
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Weather Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center mb-4">🌦️ Weather Page</h2>
            <form method="GET" action="/" class="input-group mb-3">
                <input type="text" name="city" class="form-control" placeholder="Enter city" required>
                <button class="btn btn-primary" type="submit">Get Weather</button>
            </form>

            {% if error %}
                <div class="alert alert-danger">{{ error }}</div>
            {% endif %}

            {% if weather %}
                <div class="card shadow">
                    <div class="card-body text-center">
                        <h4 class="card-title">{{ weather.city }}</h4>
                        <h5 class="card-subtitle mb-2 text-muted">{{ weather.desc }}</h5>
                        <p class="display-4">{{ weather.temp }}°C</p>
                        <p class="mb-0">Humidity: {{ weather.humidity }}%</p>
                    </div>
                </div>
            {% endif %}
        </div>
    </div>
</div>
</body>
</html>
"""

def fetch_weather(city):
    """Fetch weather data from OpenWeatherMap API."""
    params = {"q": city, "appid": API_KEY, "units": "metric"}
    response = requests.get(BASE_URL, params=params)
    if response.status_code == 200:
        data = response.json()
        return {
            "city": data["name"],
            "temp": data["main"]["temp"],
            "humidity": data["main"]["humidity"],
            "desc": data["weather"][0]["description"].title()
        }
    else:
        return None

@app.route("/", methods=["GET"])
def home():
    city = request.args.get("city")
    if city:
        weather = fetch_weather(city)
        if weather:
            return render_template_string(HTML_PAGE, weather=weather, error=None)
        else:
            return render_template_string(HTML_PAGE, weather=None, error="City not found or invalid API key.")
    return render_template_string(HTML_PAGE, weather=None, error=None)

@app.route("/weather/<city>", methods=["GET"])
def api_weather(city):
    weather = fetch_weather(city)
    if weather:
        return jsonify(weather)
    else:
        return jsonify({"error": "City not found or invalid API key"}), 404

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

