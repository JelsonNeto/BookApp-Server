"use strict";
/**
 * @author BookApp-Devs
 */

const jwt = require("jsonwebtoken");

const toJson = use('App/Helpers/Json')

class RotaAuntenticada {
  async handle({ request, response }, next) {

    let errorResponse = toJson.generate(400, "error", "Authorization error ", {})

    let authHeader = request.request.headers.authorization; //Obtem o cabeçalho da requisição

    if (!authHeader) {

      errorResponse.code = 401 
      errorResponse.message = "Auth Token is missing"
      return response.status(401).json(errorResponse);
    }

    const [, token] = authHeader.split(" ");

    try {
      let decoded = await jwt.verify(token, "1a72675f335798ca0005f056d1ae8b44"); //gera o token
      let { sub } = decoded;

      // console.log(decoded);

      request.user = {
        id: sub,
      };

      console.log("ID IN ROUTA AUTENTICADA " + request.user.id);

      return next();
    } catch (error) {

      console.log(error)

      errorResponse.code = 401 
      errorResponse.message = "Invalid JWT Auth Token"
      return response.status(401).json(errorResponse);
     
    }
  }
}

module.exports = RotaAuntenticada;
