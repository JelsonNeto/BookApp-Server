'use strict'
/**autor : BookApp-Devs */
const leitor = use('App/Models/Leitor/Leitor') //
const leitorModel = new leitor()
const crypto = require('crypto')
const toJson = use('App/Helpers/Json')

class LeitorController {
       
    /**
     * 
     * @param {*} param0 
     */
     async Adicionar({response, request}) {
       let {pkLeitor,nome,bi,endereco,telefone1,telefone2,email,senha,foto} = request.all() //Obtendo os dados
       let password = crypto.createHash('md5').update(String(senha)).digest("hex") //Encriptando as senhas
       let dados = [pkLeitor,nome,bi,endereco,telefone1,telefone2,email,password,foto] //Criando o array com os dados
       let result = await leitorModel.Adicionar(dados) //inserindo os dados
       let formatoJson  = toJson.Create(result)
       response.json(formatoJson)
     }

     async pesquisar({params}) {
      let dados = [params.elemento] //Criando o array com os dados
      let result = await leitorModel.pesquisar(dados) //inserindo os dados
      return result
    }

    async ListarLeitores({response, request}) {
     
      let result = await leitorModel.ListarLeitores() //inserindo os dados
     let formatoJson  = toJson.Create(result)
     response.json(formatoJson)
   }
    
    }
    
module.exports = LeitorController
