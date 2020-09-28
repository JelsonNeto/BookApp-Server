"use strict";
/**autor : BookApp-Devs */
const leitor = use("App/Models/Leitor/Leitor"); //
const leitorModel = new leitor();
const crypto = require("crypto");
const toJson = use("App/Helpers/Json");
const jwt = require('jsonwebtoken');
const User = use("App/Models/Usuario/Usuario");
const userModel = new User();

class LeitorController {
  /**
   *
   * @param {*} param0
   */
  async Adicionar({ response, request }) {

    let errorResponse = toJson.generate(204, "error", "Error registering reader ", {})


    try {

      let { pkLeitor, nome, bi, endereco, telefone1, telefone2, email, senha, } = request.all(); //Obtendo os dados
      let password = crypto.createHash("md5").update(String(senha)).digest("hex"); //Encriptando as senhas
      let dados = [pkLeitor, nome, bi, endereco, telefone1, telefone2, email, password,]; //Criando o array com os dados  
  


       /*
      let userPhoneExist = await userModel.userPhoneExists(telefone1);
      let userEmailExist = await userModel.userEmailExists(email);

      console.log(userEmailExist)

      let { qtdPhone } = userPhoneExist[0][0];
      let { qtdEmail } = userEmailExist[0][0];

      console.log({   QTD: qtdPhone});


    
      if (qtdPhone > 0) {
        errorResponse.message = "Phone already exists"
        errorResponse.code = 202

        response.json(errorResponse);
      } 

      if (qtdEmail > 0) {
        errorResponse.message = "Email already exists"
        errorResponse.code = 203
        return response.json(errorResponse);
      }  */ 

      let result = await leitorModel.Adicionar(dados); //inserindo os dados

      if (result[0].affectedRows > 0) {

        let lastInserted = await leitorModel.getLastInserted();
        let user = lastInserted[0][0];

        console.log(user)

        let { idUsuario, tipoUsuario } = user;

        console.log(user)

        let token = await jwt.sign({ sub: idUsuario }, '1a72675f335798ca0005f056d1ae8b44', { expiresIn: '24h' }) //gera o token

        let successResponse = toJson.generate(201, "success", "Reader registered", { idUsuario, tipoUsuario, token })

        return response.status(201).json(successResponse);

      }

      return response.json(errorResponse);

    } catch (error) {

      console.log({ ERROR: error })
      errorResponse.message = "Server error"
      errorResponse.code = 500
      return response.json(errorResponse);
    }
  }


  async getReaderData({ response, request }) {

    let errorResponse = toJson.generate(204, "error", "Error getting reader  data", {})


    try {

      let {idUsuario} = request.body;
      let result = await leitorModel.getReaderData(idUsuario);
      let readerData = result[0];

     

      if (readerData.length > 0) {

        let successResponse = toJson.generate(201, "success", "Reader data found", readerData[0])
        return response.json(successResponse);

      } else {

        errorResponse.code = 205
        errorResponse.message = "Reader data not found "
        return response.json(errorResponse);

      }


    } catch (error) {
      console.log({ ERROR: error })
      errorResponse.code = 500
      errorResponse.message = "Server error "
      return response.status(500).json(errorResponse);

    }



  }

  async pesquisar({ params }) {
    let dados = [params.elemento]; //Criando o array com os dados
    let result = await leitorModel.pesquisar(dados); //inserindo os dados
    return result;
  }

  async ListarLeitores({ response, request }) {

    let errorResponse = toJson.generate(204, "error", "Error getting reader  data", {})
    try {

      let result = await leitorModel.ListarLeitores(); //inserindo os dados

      let successResponse = toJson.generate(201, "success", "Listing Readers",result[0])
      return response.json(successResponse);
      
    } catch (error) {

      console.log({ ERROR: error })
      errorResponse.code = 500
      errorResponse.message = "Server error "
      return response.status(500).json(errorResponse);
      
    }

    


  }
}

module.exports = LeitorController;
