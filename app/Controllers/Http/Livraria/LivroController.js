'use strict'
/**autor : BookApp-Devs */
const livro = use('App/Models/Livraria/Livro')
const livroModel = new livro()
const toJson = use('App/Helpers/Json')
class LivroController {

/**
 * 
 * @param {*} param0 
 */
 async Adicionar({response, request}) {


     
   let {pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem,fkUsuario} = request.all() //Obtendo os dados
   let dados = [pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem,fkUsuario] //Criando o array com os dados
   let result = await livroModel.Adicionar(dados) //inserindo os dados
   let formatoJson  = toJson.Create(result)
   response.json(formatoJson)
 }




 async Adicionar({ response, request }) {

  let errorResponse = toJson.generate(400, "error", "Error registering Book ", {})

  try 
  {


    let fkUsuario = request.user.id

    let {pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem} = request.all() //Obtendo os dados
    let dados = [pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem,fkUsuario] //Criando o array com os dados
    let result = await livroModel.Adicionar(dados) //inserindo os dados

    if (result[0].affectedRows > 0) {

      let successResponse = toJson.generate(201, "success", "Book registered", {  })
      return response.status(201).json(successResponse);

    }


    console.log(result[0]);
    return response.status(400).json(errorResponse);

  } catch (error) {

    console.log({ ERROR: error })
    return response.status(400).json(errorResponse);
  }

}
 




async ListarLivros({ response, request }) {

  let fkUsuario = request.user.id

  let errorResponse = toJson.generate(204, "error", "Error getting books ", {})
  try {

    let result = await livroModel.ListarLivros(fkUsuario) 

    let successResponse = toJson.generate(201, "success", "Listing books",result[0])
    return response.json(successResponse);
    
  } catch (error) {

    console.log({ ERROR: error })
    errorResponse.code = 500
    errorResponse.message = "Server error "
    return response.status(500).json(errorResponse);
    
  }


}





}

module.exports = LivroController
