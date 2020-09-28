'use strict'
/**
 * @author Book-App Devs
 */
const livrosVenda = use('App/Models/Livos_Venda/LivrosVenda')
const toJson = use('App/Helpers/Json')
const livrosVendaModel = new livrosVenda()
class LivrosVendaController {

     async Adicionar({ request, response }) {

          let { pkLivrosVenda, fkLivro, nomeLivro, fkUsuario, usuario, preco } = request.all()
          let dados = [pkLivrosVenda, fkLivro, nomeLivro, fkUsuario, usuario, preco]
          let result = await livrosVendaModel.Adicionar(dados)
          let formatoJson = toJson.Create(result)
          response.json(formatoJson)
     }



     async Adicionar({ response, request }) {

          let errorResponse = toJson.generate(400, "error", "Could not  add selling book ", {})

          try {

               let { pkLivrosVenda, fkLivro, nomeLivro, fkUsuario, usuario, preco } = request.all()
               let dados = [pkLivrosVenda, fkLivro, nomeLivro, fkUsuario, usuario, preco]
               let result = await livrosVendaModel.Adicionar(dados)

               if (result[0].affectedRows > 0) {


                    let successResponse = toJson.generate(201, "success", "Library registered", { idUsuario, tipoUsuario, token })

                    return response.status(201).json(successResponse);

               }


               console.log(result[0]);
               return response.status(400).json(errorResponse);

          } catch (error) {

               console.log({ ERROR: error })
               return response.status(400).json(errorResponse);
          }

     }

     async ListarLivrosAVenda({ response, request }) {


          let errorResponse = toJson.generate(204, "error", "Error getting selling book  data", {})
          try {

               let result = await livrosVendaModel.ListarLivrosAVenda()

               let successResponse = toJson.generate(201, "success", "Listing selling books", result[0])
               return response.json(successResponse);

          } catch (error) {

               console.log({ ERROR: error })
               errorResponse.code = 500
               errorResponse.message = "Server error "
               return response.status(500).json(errorResponse);

          }
     }






}

module.exports = LivrosVendaController
