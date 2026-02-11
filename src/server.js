const app = require("./src/app");
const { initDB } = require("./src/models");

require("dotenv").config();

initDB();

app.listen(process.env.PORT, () => {
  console.log(`Servidor corriendo en puerto ${process.env.PORT}`);
});
