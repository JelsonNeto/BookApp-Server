'use strict'
/**
 * @author Book-App Devs
 */
const livrosVenda = use('App/Models/Livos_Venda/LivrosVenda')
const toJson = use('App/Helpers/Json')
const livrosVendaModel = new livrosVenda()
class LivrosVendaController {

   async Adicionar({request,response}) {
       
         let {pkLivrosVenda,fkLivro,nomeLivro,fkUsuario,usuario,preco} = request.all()
         let dados = [pkLivrosVenda,fkLivro,nomeLivro,fkUsuario,usuario,preco]
         let result = await livrosVendaModel.Adicionar(dados)
         let formatoJson  = toJson.Create(result)
         response.json(formatoJson)
    }
}

module.exports = LivrosVendaController
