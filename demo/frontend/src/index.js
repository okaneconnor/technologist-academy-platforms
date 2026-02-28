const express = require("express");
const axios = require("axios");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;
const BACKEND_URL = process.env.BACKEND_URL || "http://localhost:8000";

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.get("/", async (req, res) => {
  let services = [];
  let backendStatus = "disconnected";

  try {
    const response = await axios.get(`${BACKEND_URL}/api/services`, {
      timeout: 3000,
    });
    services = response.data;
    backendStatus = "connected";
  } catch {
    backendStatus = "disconnected";
  }

  res.render("index", { services, backendStatus });
});

app.get("/health", (req, res) => {
  res.json({
    status: "healthy",
    service: "frontend",
    timestamp: new Date().toISOString(),
  });
});

app.listen(PORT, () => {
  console.log(`Frontend running on http://localhost:${PORT}`);
  console.log(`Backend URL configured as: ${BACKEND_URL}`);
});
