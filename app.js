const http = require('http');
const os = require('os');
const server = http.createServer((req, res) => {
  if (req.url === '/health') return res.end('OK');
  res.end(`Hello from SHA-LOCKED Ubuntu 24.04!\nHost: ${os.hostname()}\nBuild: ${process.env.BUILD_NUMBER}`);
});
server.listen(3001, () => console.log('App LIVE on port 3001'));
