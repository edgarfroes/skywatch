const http = require('http');
const fs = require('fs');
const url = require('url');

const server = http.createServer((req, res) => {
    if (req.method === 'GET' && req.url === '/v1/country') {
        fs.readFile('country.json', 'utf8', (err, data) => {
            if (err) {
                res.writeHead(404, { 'Content-Type': 'text/plain' });
                res.end();
            } else {
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(data);
            }
        });
    }
    else if (req.method === 'GET' && req.url.startsWith('/v1/forecast')) {
        const query = url.parse(req.url, true).query;
        const countryCode = query.countryCode;

        fs.readFile('forecast.json', 'utf8', (err, data) => {
            if (err) {
                res.writeHead(404, { 'Content-Type': 'text/plain' });
                res.end();
            } else {
                let forecasts = JSON.parse(data);

                if (countryCode) {
                    forecasts = forecasts.filter((forecast) => forecast.countryCode === countryCode);
                }

                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify(forecasts));
            }
        });
    } else if (req.method === 'POST' && req.url === '/v1/forecast') {
        let requestBody = '';
        req.on('data', (chunk) => {
            requestBody += chunk.toString();
        });

        req.on('end', () => {
            let newForecast = JSON.parse(requestBody);

            fs.readFile('forecast.json', 'utf8', (err, data) => {
                let existingData = [];
                if (!err) {
                    existingData = JSON.parse(data);
                }

                existingData.push(newForecast);

                fs.writeFile('forecast.json', JSON.stringify(existingData), (err) => {
                    if (err) {
                        res.writeHead(500, { 'Content-Type': 'text/plain' });
                        res.end();
                    } else {
                        res.writeHead(200, { 'Content-Type': 'text/plain' });
                        res.end();
                    }
                });
            });
        });
    } else {
        res.writeHead(404, { 'Content-Type': 'text/plain' });
        res.end();
    }
});

server.listen(8080, '192.168.1.14', () => {
    console.log('API running in http://192.168.1.14:8080');
});
