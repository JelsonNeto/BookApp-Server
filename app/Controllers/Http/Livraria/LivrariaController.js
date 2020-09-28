'use strict'
/**autor : BookApp-Devs */
const livraria = use('App/Models/Livraria/Livraria')
const livrariaModel = new livraria()
const crypto = require('crypto')
const toJson = use('App/Helpers/Json')
const jwt = require('jsonwebtoken')
const User = use("App/Models/Usuario/Usuario");
const userModel = new User();

class LivrariaController {

  /**
   * 
   * @param {*} param0 
   */
  async Adicionar({ response, request }) {

    let errorResponse = toJson.generate(400, "error", "Error registering Library ", {})

    try {

      let { pkLivraria, nome, nif, endereco, email, telefone1, telefone2, senha } = request.all() //Obtendo os dados
      let password = crypto.createHash('md5').update(String(senha)).digest("hex") //Encriptando as senhas
      let dados = [pkLivraria, nome, nif, endereco, email, telefone1, telefone2, password] //Criando o array com os dados
  
      
       

      let result = await livrariaModel.Adicionar(dados) //inserindo os dados

      if (result[0].affectedRows > 0) {

        let lastInserted = await livrariaModel.getLastInserted();
        let user = lastInserted[0][0];

        let { idUsuario, tipoUsuario } = user;

        let token = await jwt.sign({ sub: idUsuario }, '1a72675f335798ca0005f056d1ae8b44', { expiresIn: '24h' }) //gera o token

        let successResponse = toJson.generate(201, "success", "Library registered", { idUsuario,tipoUsuario, token })

        return response.status(201).json(successResponse);

      }


      console.log(result[0]);
      return response.status(400).json(errorResponse);

    } catch (error) {

      console.log({ ERROR: error })
      return response.status(400).json(errorResponse);
    }

  }

  async getLibraryData({ response, request }) {

    let errorResponse = toJson.generate(204, "error", "Error getting library data ", {})


    try {

      let {idUsuario} = request.body;
      let result = await livrariaModel.getLibraryData(idUsuario);
     
      let libraryData = result[0];

      if (libraryData.length > 0) {

        let successResponse = toJson.generate(201, "success", "Library data found", libraryData[0])
        return response.json(successResponse);
        
      } else {

        errorResponse.code = 205
        errorResponse.message = "Library data not found "
        return response.json(errorResponse);

      }


    } catch (error) {
      console.log({ ERROR: error })
      errorResponse.code = 500
      errorResponse.message = "Server error "
      return response.status(500).json(errorResponse);

    }



  }

  async ListarLivrarias({ response, request }) {

    console.log("ID USER GOT IN AUTH REQUEST  " + request.user.id);

    let errorResponse = toJson.generate(204, "error", "Error getting reader  data", {})
    try {

      let result = await livrariaModel.ListarLivrarias() 

      let successResponse = toJson.generate(201, "success", "Listing Libraries",result[0])
      return response.json(successResponse);
      
    } catch (error) {

      console.log({ ERROR: error })
      errorResponse.code = 500
      errorResponse.message = "Server error "
      return response.status(500).json(errorResponse);
      
    }


  }

}

module.exports = LivrariaController
