'use strict'
/**autor : BookApp-Devs */
const livraria = use('App/Models/Livraria/Livraria')
const livrariaModel = new livraria()
const crypto = require('crypto')
const toJson = use('App/Helpers/Json')
class LivrariaController {

/**
 * 
 * @param {*} param0 
 */
 async Adicionar({response, request}) {
     
   let {pkLivraria ,nome,nif,endereco,email,telefone1,telefone2,senha} = request.all() //Obtendo os dados
   let password = crypto.createHash('md5').update(String(senha)).digest("hex") //Encriptando as senhas
   let dados = [pkLivraria,nome,nif,endereco,email,telefone1,telefone2,password] //Criando o array com os dados
   let result = await livrariaModel.Adicionar(dados) //inserindo os dados
   let formatoJson  = toJson.Create(result)
   formatoJson.data = [pkLivraria,nome,nif,endereco,email,telefone1,telefone2]
    response.json(formatoJson)
 }

}

module.exports = LivrariaController
