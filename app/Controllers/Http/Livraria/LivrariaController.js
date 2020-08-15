'use strict'
const livraria = use('App/Models/Livraria/Livraria') //
const livrariaModel = new livraria()
class LivrariaController {

 async Adicionar({response}) {
    let dados = [0, 'Jelson Neto','012912','Teste','jelsonneto94@gmail.com' , '941926369','','1234']
    let result = await livrariaModel.Adicionar(dados)
    
    response.json(result)
 }

}

module.exports = LivrariaController
