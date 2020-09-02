'use strict'
/** @type {typeof import('@adonisjs/lucid/src/Lucid/Model')} */
const Model = use('Model')
const database = use('Database') //== Usando a lib database

class Livro extends Model {

    Adicionar( dados ) {
      return  database
          .raw('call STP_LIVRO_INSERT_UPDATE(?,?,?,?,?,?,?,?,?,?,?)',dados) //Chamando a procedure
    }
  

    ListarLivros( ) {
        return  database
            .raw('SELECT livro.pkLivro,livro.titulo,livro.autor,livro.genero,livro.paginas,livro.preco,livro.publicacao,livro.paragrafo,livro.descricao,livro.imagem,livro.data_criacao,livro.data_modificacao,livro.fkUsuario FROM bookapp.livro limit 100;') ;
      }
}

module.exports = Livro
