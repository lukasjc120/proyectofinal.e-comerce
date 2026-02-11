const sequelize = require("../config/database");
const User = require("./User");

const initDB = async () => {
  try {
    await sequelize.authenticate();
    await sequelize.sync({ alter: true });
    console.log("Base de datos conectada");
  } catch (error) {
    console.error("Error DB:", error);
  }
};

module.exports = { initDB };
