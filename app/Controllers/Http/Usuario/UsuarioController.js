'use strict'
/**autor : BookApp-Devs */
const Usuario = use('App/Models/Usuario/Usuario')
const UsuarioModel = new Usuario()
const toJson = use('App/Helpers/Json')
class UsuarioController {

/**
 * 
 * @param {*} param0 
 */
 
 async ListarUsuarios({response, request}) {
     
   let result = await UsuarioModel.ListarUsuarios() //inserindo os dados
  let formatoJson  = toJson.Create(result)
  response.json(formatoJson)
}
}

module.exports = UsuarioController
