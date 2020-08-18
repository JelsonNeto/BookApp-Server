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
     
   let {pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem,idUsuario,fkLivraria} = request.all() //Obtendo os dados
   let dados = [pkLivro,titulo,autor,genero,paginas,preco,publicacao,paragrafo,descricao,imagem,idUsuario,fkLivraria] //Criando o array com os dados
   console.log(dados);
   let result = await livroModel.Adicionar(dados) //inserindo os dados
   let formatoJson  = toJson.Create(result)
    response.json(formatoJson)
 }

}

module.exports = LivroController
