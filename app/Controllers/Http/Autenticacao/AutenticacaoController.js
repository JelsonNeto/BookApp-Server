'use strict'
/**
 * @author BookApp-Devs
 */
const crypto = require('crypto')
const jwt = require('jsonwebtoken')
const autenticacao = use('App/Models/Autenticacao/Autenticacao')
const autenticacaoModel = new autenticacao()
class AutenticacaoController {

   async Login({request,response}){
        
        let {telefone , senha} = request.all()
        let password  = crypto.createHash('md5').update(String(senha)).digest("hex")
        let dados = [ telefone,password]
        let result = await autenticacaoModel.UsuarioExistente(dados)
        if( result.length ) { //Usuario encontrado
            try {
                let token = await jwt.sign({data:result[0]} , 'secret',{expiresIn:'1h'}) //gera o token
                response.send({"token":token})
            } catch (error) {
                response.send({"erro":"erro ao gerar o token"})
            }
           
        }else {
             response.send(404) //usuario não encontrado
        } 
    }

}

module.exports = AutenticacaoController
