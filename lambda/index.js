const https = require('https');

const API_KEY = process.env.WEATHER_API_KEY;
console.log("API Key loaded:", API_KEY ? "***hidden***" : "Not Set");

const BASE_URL = 'api.openweathermap.org';
const UNITS = 'metric';

exports.handler = async (event) => {
  try {
    const params = event.queryStringParameters || {};

    let url;
    if (params.city) {
      url = `/data/2.5/weather?q=${encodeURIComponent(params.city)}&appid=${API_KEY}&units=${UNITS}`;
    } else if (params.lat && params.lon) {
      url = `/data/2.5/weather?lat=${params.lat}&lon=${params.lon}&appid=${API_KEY}&units=${UNITS}`;
    } else {
      return response(400, { error: "Missing city or coordinates" });
    }

    console.log("Fetching current weather from:", url);

    const current = await fetchFromOpenWeather(url);

    const forecastUrl = url.replace('/weather', '/forecast');
    console.log("Fetching forecast from:", forecastUrl);

    const forecast = await fetchFromOpenWeather(forecastUrl);

    return response(200, { current, forecast });
  } catch (err) {
    console.error("Lambda Error:", err.message || err);
    return response(500, { error: "Failed to fetch weather data" });
  }
};

function fetchFromOpenWeather(path) {
  const options = {
    hostname: BASE_URL,
    path,
    method: 'GET'
  };

  return new Promise((resolve, reject) => {
    const req = https.request(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const json = JSON.parse(data);
          resolve(json);
        } catch (e) {
          console.error("JSON Parse Error:", e.message);
          reject(new Error("Invalid JSON from OpenWeather"));
        }
      });
    });

    req.on('error', (err) => {
      console.error("HTTPS request error:", err.message);
      reject(err);
    });

    req.end();
  });
}

function response(statusCode, body) {
  return {
    statusCode,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json"
    },
    body: JSON.stringify(body)
  };
}
