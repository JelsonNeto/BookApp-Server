"use strict";
/**
 * @author BookApp-Devs
 */
const crypto = require("crypto");
const jwt = require("jsonwebtoken");
const toJson = use("App/Helpers/Json");
const autenticacao = use("App/Models/Autenticacao/Autenticacao");
const autenticacaoModel = new autenticacao();

const livraria = use("App/Models/Livraria/Livraria");
const livrariaModel = new livraria();
const leitor = use("App/Models/Leitor/Leitor");
const leitorModel = new leitor();

class AutenticacaoController {
  async Login({ request, response }) {
    let errorResponse = toJson.generate(
      204,
      "error",
      "Error trying to login ",
      {}
    );

    try {

      let { telefone, senha } = request.all();

      let password = crypto
        .createHash("md5")
        .update(String(senha))
        .digest("hex");

      let dados = [telefone, password];
      
      let result = await autenticacaoModel.UsuarioExistente(dados);

      if (result.length) {
        //Usuario encontrado
        let resultUser;
        let { idUsuario, tipoUsuario,status_ } = result[0];

        if (tipoUsuario == 1) {
          resultUser = await leitorModel.getLibraryData(idUsuario);
        } else {
          resultUser = await livrariaModel.getLibraryData(idUsuario);
        }
     

        if (resultUser[0].length == 0) {
          console.log(resultUser[0]);
          errorResponse.message = "User Data not found";
          errorResponse.code = 205;
          return response.json(errorResponse);
        }

        let userData = resultUser[0];
          

        let token = await jwt.sign(
          { sub: idUsuario },
          "1a72675f335798ca0005f056d1ae8b44",
          { expiresIn: "24h" }
        ); //gera o token

        let successResponse = toJson.generate(202, "success", "User logged ", {user:userData[0],token});

        response.status(202).json(successResponse);
      } else {
        console.log(result);
        errorResponse.message = "User not found";
        errorResponse.code = 205;
        return response.json(errorResponse);
      }
    } catch (error) {
      console.log({ Error: error });
      errorResponse.message = "Erro ao gerar o token";
      errorResponse.code = 206;
      response.status(401).json();
    }
  }
}

module.exports = AutenticacaoController;
